From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/6] ACPICA: Fix compiler warnings for casting issues (only some compilers)
Date: Wed, 17 Jul 2013 09:48:58 +0800
Message-ID: <1369da73aabd14acee745793ff328d3925811f42.1374025121.git.lv.zheng@intel.com>
References: <cover.1374025121.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46494 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab3GQBtI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jul 2013 21:49:08 -0400
In-Reply-To: <cover.1374025121.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Jung-uk Kim <jkim@FreeBSD.org>

From: Jung-uk Kim <jkim@FreeBSD.org>

Fixes compiler warnings from GCC 4.2 and perhaps other compilers.
Jung-uk Kim <jkim@FreeBSD.org>

Signed-off-by: Jung-uk Kim <jkim@FreeBSD.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exdump.c   |    6 +++---
 drivers/acpi/acpica/nsxfname.c |    4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index c740f24..4d046fa 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -338,6 +338,7 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 {
 	u8 *target;
 	char *name;
+	const char *reference_name;
 	u8 count;
 
 	if (!info) {
@@ -426,10 +427,9 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 
 		case ACPI_EXD_REFERENCE:
 
+			reference_name = acpi_ut_get_reference_name(obj_desc);
 			acpi_ex_out_string("Class Name",
-					   ACPI_CAST_PTR(char,
-							 acpi_ut_get_reference_name
-							 (obj_desc)));
+					   ACPI_CAST_PTR(char, reference_name));
 			acpi_ex_dump_reference_obj(obj_desc);
 			break;
 
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 21a2ef3..83c1644 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -158,6 +158,7 @@ acpi_get_name(acpi_handle handle, u32 name_type, struct acpi_buffer * buffer)
 {
 	acpi_status status;
 	struct acpi_namespace_node *node;
+	char *node_name;
 
 	/* Parameter validation */
 
@@ -202,7 +203,8 @@ acpi_get_name(acpi_handle handle, u32 name_type, struct acpi_buffer * buffer)
 
 	/* Just copy the ACPI name from the Node and zero terminate it */
 
-	ACPI_MOVE_NAME(buffer->pointer, acpi_ut_get_node_name(node));
+	node_name = acpi_ut_get_node_name(node);
+	ACPI_MOVE_NAME(buffer->pointer, node_name);
 	((char *)buffer->pointer)[ACPI_NAME_SIZE] = 0;
 	status = AE_OK;
 
-- 
1.7.10

