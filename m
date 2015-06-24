From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 17/28] ACPICA: Namespace: Change namespace override to avoid node deletion.
Date: Wed, 24 Jun 2015 11:04:40 +0800
Message-ID: <e9736235fea7e1abe2f5be27e6f9ef8eddebda30.1435114811.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435114811.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41940 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964780AbbFXDEp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2015 23:04:45 -0400
In-Reply-To: <cover.1435114811.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit c0ce529e1fbb8ec47d2522a3aa10f3ab77e16e41

There is no reference counting implemented for struct acpi_namespace_node, so it
is currently not removable during runtime.
This patch changes the namespace override code to keep the old
struct acpi_namespace_node undeleted so that the override mechanism can happen
during runtime. Bob Moore.

Link: https://github.com/acpica/acpica/commit/c0ce529e
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nssearch.c |   23 +++++++++++++++++++----
 include/acpi/acpixf.h          |    5 +++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index 47fbe5b..d739040 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -331,13 +331,28 @@ acpi_ns_search_and_enter(u32 target_name,
 
 			/*
 			 * If the namespace override feature is enabled for this node,
-			 * delete any existing node. This can only happen during the
-			 * boot stage, thus it is safe to remove the node here.
+			 * delete any existing attached sub-object and make the node
+			 * look like a new node that is owned by the override table.
 			 */
 			if (flags & ACPI_NS_OVERRIDE_IF_FOUND) {
+				ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
+						  "Namespace override: %4.4s pass %u type %X Owner %X\n",
+						  ACPI_CAST_PTR(char,
+								&target_name),
+						  interpreter_mode,
+						  (*return_node)->type,
+						  walk_state->owner_id));
+
 				acpi_ns_delete_children(*return_node);
-				acpi_ns_remove_node(*return_node);
-				*return_node = ACPI_ENTRY_NOT_FOUND;
+				if (acpi_gbl_runtime_namespace_override) {
+					acpi_ut_remove_reference((*return_node)->object);
+					(*return_node)->object = NULL;
+					(*return_node)->owner_id =
+					    walk_state->owner_id;
+				} else {
+					acpi_ns_remove_node(*return_node);
+					*return_node = ACPI_ENTRY_NOT_FOUND;
+				}
 			}
 
 			/* Return an error if we don't expect to find the object */
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 00daa3c..33b4675 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -229,6 +229,11 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_disable_auto_repair, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_disable_ssdt_table_install, FALSE);
 
 /*
+ * Optionally enable runtime namespace override.
+ */
+ACPI_INIT_GLOBAL(u8, acpi_gbl_runtime_namespace_override, TRUE);
+
+/*
  * We keep track of the latest version of Windows that has been requested by
  * the BIOS. ACPI 5.0.
  */
-- 
1.7.10

