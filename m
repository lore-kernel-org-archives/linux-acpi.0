From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/73] ACPICA: New interfaces for table event handlers
Date: Sat, 12 Apr 2008 00:25:02 -0400
Message-ID: <fee12c5bdb8680bbf211ee42bd553b6f058127ae.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:45175 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752959AbYDLE2G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:06 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Designed and implemented new external interfaces to install and
remove handlers for ACPI table-related events. Current events that
are defined are LOAD and UNLOAD. These interfaces allow the host to
track ACPI tables as they are dynamically loaded and unloaded. See
AcpiInstallTableHandler and AcpiRemoveTableHandler. (Lin Ming
and Bob Moore)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconfig.c  |   29 ++++++++++++-
 drivers/acpi/tables/tbxface.c     |   89 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/utilities/utglobal.c |    3 +-
 include/acpi/acdisasm.h           |    4 +-
 include/acpi/acglobal.h           |    2 +
 include/acpi/acpixf.h             |    5 ++
 include/acpi/actypes.h            |   11 +++++
 7 files changed, 139 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index 25802f3..009aef5 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -234,6 +234,13 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 			   table->oem_table_id));
 	}
 
+	/* Invoke table handler if present */
+
+	if (acpi_gbl_table_handler) {
+		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_LOAD, table,
+					     acpi_gbl_table_handler_context);
+	}
+
 	*return_desc = ddb_handle;
 	return_ACPI_STATUS(status);
 }
@@ -352,6 +359,14 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(status);
 	}
 
+	/* Invoke table handler if present */
+
+	if (acpi_gbl_table_handler) {
+		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_LOAD,
+					     table_desc.pointer,
+					     acpi_gbl_table_handler_context);
+	}
+
       cleanup:
 	if (ACPI_FAILURE(status)) {
 		acpi_tb_delete_table(&table_desc);
@@ -376,6 +391,7 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 	acpi_status status = AE_OK;
 	union acpi_operand_object *table_desc = ddb_handle;
 	acpi_native_uint table_index;
+	struct acpi_table_header *table;
 
 	ACPI_FUNCTION_TRACE(ex_unload_table);
 
@@ -395,6 +411,17 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 
 	table_index = (acpi_native_uint) table_desc->reference.object;
 
+	/* Invoke table handler if present */
+
+	if (acpi_gbl_table_handler) {
+		status = acpi_get_table_by_index(table_index, &table);
+		if (ACPI_SUCCESS(status)) {
+			(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_UNLOAD,
+						     table,
+						     acpi_gbl_table_handler_context);
+		}
+	}
+
 	/*
 	 * Delete the entire namespace under this table Node
 	 * (Offset contains the table_id)
@@ -407,5 +434,5 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 	/* Delete the table descriptor (ddb_handle) */
 
 	acpi_ut_remove_reference(table_desc);
-	return_ACPI_STATUS(status);
+	return_ACPI_STATUS(AE_OK);
 }
diff --git a/drivers/acpi/tables/tbxface.c b/drivers/acpi/tables/tbxface.c
index a9e3331..5f22715 100644
--- a/drivers/acpi/tables/tbxface.c
+++ b/drivers/acpi/tables/tbxface.c
@@ -635,6 +635,95 @@ acpi_status acpi_load_tables(void)
 ACPI_EXPORT_SYMBOL(acpi_load_tables)
 
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_install_table_handler
+ *
+ * PARAMETERS:  Handler         - Table event handler
+ *              Context         - Value passed to the handler on each event
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install table event handler
+ *
+ ******************************************************************************/
+acpi_status
+acpi_install_table_handler(acpi_tbl_handler handler, void *context)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_install_table_handler);
+
+	if (!handler) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Don't allow more than one handler */
+
+	if (acpi_gbl_table_handler) {
+		status = AE_ALREADY_EXISTS;
+		goto cleanup;
+	}
+
+	/* Install the handler */
+
+	acpi_gbl_table_handler = handler;
+	acpi_gbl_table_handler_context = context;
+
+      cleanup:
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_install_table_handler)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_remove_table_handler
+ *
+ * PARAMETERS:  Handler         - Table event handler that was installed
+ *                                previously.
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Remove table event handler
+ *
+ ******************************************************************************/
+acpi_status acpi_remove_table_handler(acpi_tbl_handler handler)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_remove_table_handler);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Make sure that the installed handler is the same */
+
+	if (!handler || handler != acpi_gbl_table_handler) {
+		status = AE_BAD_PARAMETER;
+		goto cleanup;
+	}
+
+	/* Remove the handler */
+
+	acpi_gbl_table_handler = NULL;
+
+      cleanup:
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_remove_table_handler)
+
+
 static int __init acpi_no_auto_ssdt_setup(char *s) {
 
         printk(KERN_NOTICE "ACPI: SSDT auto-load disabled\n");
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 630c9a2..4442543 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -675,12 +675,13 @@ void acpi_ut_init_globals(void)
 	acpi_gbl_gpe_fadt_blocks[0] = NULL;
 	acpi_gbl_gpe_fadt_blocks[1] = NULL;
 
-	/* Global notify handlers */
+	/* Global handlers */
 
 	acpi_gbl_system_notify.handler = NULL;
 	acpi_gbl_device_notify.handler = NULL;
 	acpi_gbl_exception_handler = NULL;
 	acpi_gbl_init_handler = NULL;
+	acpi_gbl_table_handler = NULL;
 
 	/* Global Lock support */
 
diff --git a/include/acpi/acdisasm.h b/include/acpi/acdisasm.h
index 75c354f..67d152e 100644
--- a/include/acpi/acdisasm.h
+++ b/include/acpi/acdisasm.h
@@ -104,12 +104,12 @@ typedef const struct acpi_dmtable_info {
 #define ACPI_DMT_SIG                    27
 
 typedef
-void (*ACPI_TABLE_HANDLER) (struct acpi_table_header * table);
+void (*acpi_dmtable_handler) (struct acpi_table_header * table);
 
 struct acpi_dmtable_data {
 	char *signature;
 	struct acpi_dmtable_info *table_info;
-	ACPI_TABLE_HANDLER table_handler;
+	acpi_dmtable_handler table_handler;
 	char *name;
 };
 
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 44e718e..8624686 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -217,6 +217,8 @@ ACPI_EXTERN struct acpi_object_notify_handler acpi_gbl_device_notify;
 ACPI_EXTERN struct acpi_object_notify_handler acpi_gbl_system_notify;
 ACPI_EXTERN acpi_exception_handler acpi_gbl_exception_handler;
 ACPI_EXTERN acpi_init_handler acpi_gbl_init_handler;
+ACPI_EXTERN acpi_tbl_handler acpi_gbl_table_handler;
+ACPI_EXTERN void *acpi_gbl_table_handler_context;
 ACPI_EXTERN struct acpi_walk_state *acpi_gbl_breakpoint_walk;
 
 /* Owner ID support */
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d970f7f..c92acda 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -119,6 +119,11 @@ acpi_status
 acpi_get_table_by_index(acpi_native_uint table_index,
 			struct acpi_table_header **out_table);
 
+acpi_status
+acpi_install_table_handler(acpi_tbl_handler handler, void *context);
+
+acpi_status acpi_remove_table_handler(acpi_tbl_handler handler);
+
 /*
  * Namespace and name interfaces
  */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 6182b57..766178c 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -730,6 +730,12 @@ struct acpi_system_info {
 	u32 debug_layer;
 };
 
+/* Table Event Types */
+
+#define ACPI_TABLE_EVENT_LOAD           0x0
+#define ACPI_TABLE_EVENT_UNLOAD         0x1
+#define ACPI_NUM_TABLE_EVENTS           2
+
 /*
  * Types specific to the OS service interfaces
  */
@@ -759,6 +765,11 @@ acpi_status(*acpi_exception_handler) (acpi_status aml_status,
 				      u16 opcode,
 				      u32 aml_offset, void *context);
 
+/* Table Event handler (Load, load_table etc) and types */
+
+typedef
+acpi_status(*acpi_tbl_handler) (u32 event, void *table, void *context);
+
 /* Address Spaces (For Operation Regions) */
 
 typedef
-- 
1.5.5.29.g7134

