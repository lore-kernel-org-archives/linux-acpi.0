From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 8/8] ACPICA: Tables: Add acpi_unload_table() to unload definition block tables
Date: Thu, 24 Mar 2016 16:31:16 +0800
Message-ID: <4d8a500166f75c592624d3f913edc4db3fd491eb.1458808078.git.lv.zheng@intel.com>
References: <cover.1458808078.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2587 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbcCXIbR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Mar 2016 04:31:17 -0400
In-Reply-To: <cover.1458808078.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch adds acpi_unload_table() API and adds parameter in
acpi_load_table() to be used for the new acpi_unload_table() API.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbfileio.c    |    2 +-
 drivers/acpi/acpica/tbxfload.c    |   97 ++++++++++++++++++++++++++-----------
 drivers/pci/hotplug/sgi_hotplug.c |    2 +-
 include/acpi/acpixf.h             |    4 +-
 4 files changed, 75 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.c
index 4832879..283565c 100644
--- a/drivers/acpi/acpica/dbfileio.c
+++ b/drivers/acpi/acpica/dbfileio.c
@@ -138,7 +138,7 @@ acpi_status acpi_db_load_tables(struct acpi_new_table_desc *list_head)
 	while (table_list_head) {
 		table = table_list_head->table;
 
-		status = acpi_load_table(table);
+		status = acpi_load_table(table, NULL);
 		if (ACPI_FAILURE(status)) {
 			if (status == AE_ALREADY_EXISTS) {
 				acpi_os_printf
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index a4475f3..042afb7 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -335,6 +335,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_uninstall_table)
  *
  * PARAMETERS:  table               - Pointer to a buffer containing the ACPI
  *                                    table to be loaded.
+ *              out_table_index     - Where the table index is returned
  *
  * RETURN:      Status
  *
@@ -345,7 +346,8 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_uninstall_table)
  *              to ensure that the table is not deleted or unmapped.
  *
  ******************************************************************************/
-acpi_status acpi_load_table(struct acpi_table_header *table)
+acpi_status
+acpi_load_table(struct acpi_table_header *table, u32 *out_table_index)
 {
 	acpi_status status;
 	u32 table_index;
@@ -354,6 +356,9 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 
 	/* Parameter validation */
 
+	if (out_table_index) {
+		*out_table_index = ACPI_INVALID_TABLE_INDEX;
+	}
 	if (!table) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
@@ -400,6 +405,9 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 	}
 
 unlock_and_exit:
+	if (out_table_index && ACPI_SUCCESS(status)) {
+		*out_table_index = table_index;
+	}
 	(void)acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
 	return_ACPI_STATUS(status);
 }
@@ -476,40 +484,75 @@ acpi_status acpi_unload_parent_table(acpi_handle object)
 			break;
 		}
 
-		/* Ensure the table is actually loaded */
+		(void)acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
+		status = acpi_unload_table(i);
+		(void)acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
+		break;
+	}
 
-		if (!acpi_tb_is_table_loaded(i)) {
-			status = AE_NOT_EXIST;
-			break;
-		}
+	(void)acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
+	return_ACPI_STATUS(status);
+}
 
-		/* Invoke table handler if present */
+ACPI_EXPORT_SYMBOL(acpi_unload_parent_table)
 
-		if (acpi_gbl_table_handler) {
-			(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_UNLOAD,
-						     acpi_gbl_root_table_list.
-						     tables[i].pointer,
-						     acpi_gbl_table_handler_context);
-		}
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_unload_table
+ *
+ * PARAMETERS:  table_index         - The table index
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Unload a definition block table.
+ *
+ ******************************************************************************/
+acpi_status acpi_unload_table(u32 table_index)
+{
+	acpi_status status;
 
-		/*
-		 * Delete all namespace objects owned by this table. Note that
-		 * these objects can appear anywhere in the namespace by virtue
-		 * of the AML "Scope" operator. Thus, we need to track ownership
-		 * by an ID, not simply a position within the hierarchy.
-		 */
-		status = acpi_tb_delete_namespace_by_owner(i);
-		if (ACPI_FAILURE(status)) {
-			break;
-		}
+	ACPI_FUNCTION_TRACE(acpi_unload_table);
 
-		status = acpi_tb_release_owner_id(i);
-		acpi_tb_set_table_loaded_flag(i, FALSE);
-		break;
+	/* Must acquire the interpreter lock during this operation */
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Ensure the table is actually loaded */
+
+	if (!acpi_tb_is_table_loaded(table_index)) {
+		status = AE_NOT_EXIST;
+		goto error_exit;
 	}
 
+	/* Invoke table handler if present */
+
+	if (acpi_gbl_table_handler) {
+		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_UNLOAD,
+					     acpi_gbl_root_table_list.
+					     tables[table_index].pointer,
+					     acpi_gbl_table_handler_context);
+	}
+
+	/*
+	 * Delete all namespace objects owned by this table. Note that
+	 * these objects can appear anywhere in the namespace by virtue
+	 * of the AML "Scope" operator. Thus, we need to track ownership
+	 * by an ID, not simply a position within the hierarchy.
+	 */
+	status = acpi_tb_delete_namespace_by_owner(table_index);
+	if (ACPI_FAILURE(status)) {
+		goto error_exit;
+	}
+
+	status = acpi_tb_release_owner_id(table_index);
+	acpi_tb_set_table_loaded_flag(table_index, FALSE);
+
+error_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
 	return_ACPI_STATUS(status);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_unload_parent_table)
+ACPI_EXPORT_SYMBOL(acpi_unload_table)
diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
index 339bce0..57d627d 100644
--- a/drivers/pci/hotplug/sgi_hotplug.c
+++ b/drivers/pci/hotplug/sgi_hotplug.c
@@ -355,7 +355,7 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 	if (SN_ACPI_BASE_SUPPORT() && ssdt) {
 		acpi_status ret;
 
-		ret = acpi_load_table((struct acpi_table_header *)ssdt);
+		ret = acpi_load_table((struct acpi_table_header *)ssdt, NULL);
 		if (ACPI_FAILURE(ret)) {
 			printk(KERN_ERR "%s: acpi_load_table failed (0x%x)\n",
 			       __func__, ret);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e41a99c..bb2d69b 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -474,7 +474,9 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init
 ACPI_EXTERNAL_RETURN_VOID(void acpi_uninstall_table(u32 table_index))
 
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			    acpi_load_table(struct acpi_table_header *table))
+			    acpi_load_table(struct acpi_table_header *table,
+					    u32 *out_table_index))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status acpi_unload_table(u32 table_inde))
 
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_unload_parent_table(acpi_handle object))
-- 
1.7.10

