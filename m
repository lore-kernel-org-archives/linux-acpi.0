From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/11] ACPICA: Tables: Add acpi_tb_unload_table()
Date: Wed, 30 Nov 2016 15:21:26 +0800
Message-ID: <ab2412d78f77a64c3754e7a54550114d052add22.1480490191.git.lv.zheng@intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33613 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756680AbcK3HVr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Nov 2016 02:21:47 -0500
In-Reply-To: <cover.1480490191.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 80e24663b212daac0c32767fdbd8a46892292f1f

This patch introduces acpi_tb_unload_table() to eliminate redundant code from
acpi_ex_unload_table() and acpi_unload_parent_table().

No functional change. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/80e24663
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/actables.h |    2 ++
 drivers/acpi/acpica/exconfig.c |   35 +----------------------------
 drivers/acpi/acpica/tbdata.c   |   48 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/tbxfload.c |   31 +-------------------------
 4 files changed, 52 insertions(+), 64 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 1850005..7dd527f 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -130,6 +130,8 @@
 acpi_tb_install_and_load_table(acpi_physical_address address,
 			       u8 flags, u8 override, u32 *table_index);
 
+acpi_status acpi_tb_unload_table(u32 table_index);
+
 void acpi_tb_terminate(void);
 
 acpi_status acpi_tb_delete_namespace_by_owner(u32 table_index);
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 8b8d620..c32c782 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -499,7 +499,6 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 	acpi_status status = AE_OK;
 	union acpi_operand_object *table_desc = ddb_handle;
 	u32 table_index;
-	struct acpi_table_header *table;
 
 	ACPI_FUNCTION_TRACE(ex_unload_table);
 
@@ -536,39 +535,7 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 	 * strict order requirement against it.
 	 */
 	acpi_ex_exit_interpreter();
-
-	/* Ensure the table is still loaded */
-
-	if (!acpi_tb_is_table_loaded(table_index)) {
-		status = AE_NOT_EXIST;
-		goto lock_and_exit;
-	}
-
-	/* Invoke table handler if present */
-
-	if (acpi_gbl_table_handler) {
-		status = acpi_get_table_by_index(table_index, &table);
-		if (ACPI_SUCCESS(status)) {
-			(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_UNLOAD,
-						     table,
-						     acpi_gbl_table_handler_context);
-		}
-	}
-
-	/* Delete the portion of the namespace owned by this table */
-
-	status = acpi_tb_delete_namespace_by_owner(table_index);
-	if (ACPI_FAILURE(status)) {
-		goto lock_and_exit;
-	}
-
-	(void)acpi_tb_release_owner_id(table_index);
-	acpi_tb_set_table_loaded_flag(table_index, FALSE);
-
-lock_and_exit:
-
-	/* Re-acquire the interpreter lock */
-
+	status = acpi_tb_unload_table(table_index);
 	acpi_ex_enter_interpreter();
 
 	/*
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 4cbfa30..82b0b57 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -871,3 +871,51 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded)
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	return_ACPI_STATUS(status);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_unload_table
+ *
+ * PARAMETERS:  table_index             - Table index
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Unload an ACPI table
+ *
+ ******************************************************************************/
+
+acpi_status acpi_tb_unload_table(u32 table_index)
+{
+	acpi_status status = AE_OK;
+	struct acpi_table_header *table;
+
+	ACPI_FUNCTION_TRACE(tb_unload_table);
+
+	/* Ensure the table is still loaded */
+
+	if (!acpi_tb_is_table_loaded(table_index)) {
+		return_ACPI_STATUS(AE_NOT_EXIST);
+	}
+
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
+	/* Delete the portion of the namespace owned by this table */
+
+	status = acpi_tb_delete_namespace_by_owner(table_index);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	(void)acpi_tb_release_owner_id(table_index);
+	acpi_tb_set_table_loaded_flag(table_index, FALSE);
+	return_ACPI_STATUS(status);
+}
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 77de33b..82019c0 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -408,37 +408,8 @@ acpi_status acpi_unload_parent_table(acpi_handle object)
 			break;
 		}
 
-		/* Ensure the table is actually loaded */
-
 		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-		if (!acpi_tb_is_table_loaded(i)) {
-			status = AE_NOT_EXIST;
-			(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-			break;
-		}
-
-		/* Invoke table handler if present */
-
-		if (acpi_gbl_table_handler) {
-			(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_UNLOAD,
-						     acpi_gbl_root_table_list.
-						     tables[i].pointer,
-						     acpi_gbl_table_handler_context);
-		}
-
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
-
-		status = acpi_tb_release_owner_id(i);
-		acpi_tb_set_table_loaded_flag(i, FALSE);
+		status = acpi_tb_unload_table(i);
 		(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 		break;
 	}
-- 
1.7.10

