From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v3 1/5] ACPICA: Tables: Cleanup table handler invokers
Date: Thu, 18 May 2017 17:57:21 +0800
Message-ID: <213b7c8aad7f7e2d626e108ee8dcc43de30c4dfa.1495100623.git.lv.zheng@intel.com>
References: <20170227093432.3308-1-hdegoede@redhat.com> <cover.1495100623.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:18781 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752978AbdERJ5Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 May 2017 05:57:25 -0400
In-Reply-To: <cover.1495100623.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org

Recently, we allows the table mutex to be held in both early and late stage
APIs. This patch further cleans up the related code to reduce redundant
code related to acpi_gbl_table_handler. Lv Zheng.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/actables.h |  2 ++
 drivers/acpi/acpica/tbdata.c   | 43 ++++++++++++++++++++++++++++--------------
 drivers/acpi/acpica/tbinstal.c |  8 ++------
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index c8da453..89ed31b 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -132,6 +132,8 @@ acpi_tb_install_and_load_table(acpi_physical_address address,
 
 acpi_status acpi_tb_unload_table(u32 table_index);
 
+void acpi_tb_notify_table(u32 event, void *table);
+
 void acpi_tb_terminate(void);
 
 acpi_status acpi_tb_delete_namespace_by_owner(u32 table_index);
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 27c5c27..42ea044 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -818,13 +818,9 @@ acpi_tb_load_table(u32 table_index, struct acpi_namespace_node *parent_node)
 		acpi_ev_update_gpes(owner_id);
 	}
 
-	/* Invoke table handler if present */
-
-	if (acpi_gbl_table_handler) {
-		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_LOAD, table,
-					     acpi_gbl_table_handler_context);
-	}
+	/* Invoke table handler */
 
+	acpi_tb_notify_table(ACPI_TABLE_EVENT_LOAD, table);
 	return_ACPI_STATUS(status);
 }
 
@@ -892,15 +888,11 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
-	/* Invoke table handler if present */
+	/* Invoke table handler */
 
-	if (acpi_gbl_table_handler) {
-		status = acpi_get_table_by_index(table_index, &table);
-		if (ACPI_SUCCESS(status)) {
-			(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_UNLOAD,
-						     table,
-						     acpi_gbl_table_handler_context);
-		}
+	status = acpi_get_table_by_index(table_index, &table);
+	if (ACPI_SUCCESS(status)) {
+		acpi_tb_notify_table(ACPI_TABLE_EVENT_UNLOAD, table);
 	}
 
 	/* Delete the portion of the namespace owned by this table */
@@ -914,3 +906,26 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 	acpi_tb_set_table_loaded_flag(table_index, FALSE);
 	return_ACPI_STATUS(status);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_notify_table
+ *
+ * PARAMETERS:  event               - Table event
+ *              table               - Validated table pointer
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Notify a table event to the users.
+ *
+ ******************************************************************************/
+
+void acpi_tb_notify_table(u32 event, void *table)
+{
+	/* Invoke table handler if present */
+
+	if (acpi_gbl_table_handler) {
+		(void)acpi_gbl_table_handler(event, table,
+					     acpi_gbl_table_handler_context);
+	}
+}
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 4620f3c..ee74515 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -306,14 +306,10 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 	acpi_tb_install_table_with_override(&new_table_desc, override,
 					    table_index);
 
-	/* Invoke table handler if present */
+	/* Invoke table handler */
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-	if (acpi_gbl_table_handler) {
-		(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_INSTALL,
-					     new_table_desc.pointer,
-					     acpi_gbl_table_handler_context);
-	}
+	acpi_tb_notify_table(ACPI_TABLE_EVENT_INSTALL, new_table_desc.pointer);
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
 unlock_and_exit:
-- 
2.7.4

