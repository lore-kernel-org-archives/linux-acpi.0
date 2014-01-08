From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/21] ACPICA: Disassembler: Improve pathname support for emitted External() statements.
Date: Wed,  8 Jan 2014 13:43:18 +0800
Message-ID: <48b483dcb33429413c2eb2b906cac4775117256b.1387505702.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38945 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbaAHFni (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:43:38 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Linux kernel behaviour is not affected as the structure changes and the
new invocations are only used by compiler and disassembler which are
not shipped in the kernel currently.

This change adds full pathname support for external names that have been
resolved internally by the inclusion of additional ACPI tables (via the
iASL -e option). Without this change, the disassembler can emit multiple
externals for the same object, or it become confused when the Scope()
operator is used on an external object.

Reported-by: Michael Tsirkin <mst@redhat.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    9 +++++----
 drivers/acpi/acpica/dsfield.c |    2 +-
 drivers/acpi/acpica/dswload.c |    4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 53ed1a8..d95ca54 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1038,15 +1038,16 @@ struct acpi_external_list {
 	struct acpi_external_list *next;
 	u32 value;
 	u16 length;
+	u16 flags;
 	u8 type;
-	u8 flags;
-	u8 resolved;
-	u8 emitted;
 };
 
 /* Values for Flags field above */
 
-#define ACPI_IPATH_ALLOCATED    0x01
+#define ACPI_EXT_RESOLVED_REFERENCE         0x01	/* Object was resolved during cross ref */
+#define ACPI_EXT_ORIGIN_FROM_FILE           0x02	/* External came from a file */
+#define ACPI_EXT_INTERNAL_PATH_ALLOCATED    0x04	/* Deallocate internal path on completion */
+#define ACPI_EXT_EXTERNAL_EMITTED           0x08	/* External() statement has been emitted */
 
 struct acpi_external_file {
 	char *path;
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index 2d4c073..e7a57c5 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -105,7 +105,7 @@ acpi_ds_create_external_region(acpi_status lookup_status,
 	 * operation_region not found. Generate an External for it, and
 	 * insert the name into the namespace.
 	 */
-	acpi_dm_add_to_external_list(op, path, ACPI_TYPE_REGION, 0);
+	acpi_dm_add_op_to_external_list(op, path, ACPI_TYPE_REGION, 0, 0);
 	status = acpi_ns_lookup(walk_state->scope_info, path, ACPI_TYPE_REGION,
 				ACPI_IMODE_LOAD_PASS1, ACPI_NS_SEARCH_PARENT,
 				walk_state, node);
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 95e681a..2dbe109 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -181,8 +181,8 @@ acpi_ds_load1_begin_op(struct acpi_walk_state * walk_state,
 			 * Target of Scope() not found. Generate an External for it, and
 			 * insert the name into the namespace.
 			 */
-			acpi_dm_add_to_external_list(op, path, ACPI_TYPE_DEVICE,
-						     0);
+			acpi_dm_add_op_to_external_list(op, path,
+							ACPI_TYPE_DEVICE, 0, 0);
 			status =
 			    acpi_ns_lookup(walk_state->scope_info, path,
 					   object_type, ACPI_IMODE_LOAD_PASS1,
-- 
1.7.10

