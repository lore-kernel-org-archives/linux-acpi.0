From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v5 1/5] ACPICA: Tables: Fix "UNLOAD" code path lock issues
Date: Fri, 23 Sep 2016 11:26:35 +0800
Message-ID: <f6987190ef74e4788d1884fb9586e677d13625c2.1474600034.git.lv.zheng@intel.com>
References: <0e65135af51d94db0410c7059f3bc3a2300fc3b5> <cover.1474600034.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1474600034.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 39227380f5b99c51b897a3ffedd88508aa26789b

The previous lock fixes didn't cover "Unload" opcode and table unload APIs,
this patch fixes lock issues in the "Unload" code path. BZ 1325, Lv Zheng.

Link: https://github.com/acpica/acpica/commit/39227380
Link: https://bugs.acpica.org/show_bug.cgi?id=1325
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exconfig.c |   23 +++++++++++++++++++----
 drivers/acpi/acpica/tbdata.c   |    7 +------
 drivers/acpi/acpica/tbxfload.c |    9 ++++++---
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 421836a..718428b 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -532,10 +532,17 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 
 	table_index = table_desc->reference.value;
 
+	/*
+	 * Release the interpreter lock so that the table lock won't have
+	 * strict order requirement against it.
+	 */
+	acpi_ex_exit_interpreter();
+
 	/* Ensure the table is still loaded */
 
 	if (!acpi_tb_is_table_loaded(table_index)) {
-		return_ACPI_STATUS(AE_NOT_EXIST);
+		status = AE_NOT_EXIST;
+		goto lock_and_exit;
 	}
 
 	/* Invoke table handler if present */
@@ -553,16 +560,24 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 
 	status = acpi_tb_delete_namespace_by_owner(table_index);
 	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		goto lock_and_exit;
 	}
 
 	(void)acpi_tb_release_owner_id(table_index);
 	acpi_tb_set_table_loaded_flag(table_index, FALSE);
 
+lock_and_exit:
+
+	/* Re-acquire the interpreter lock */
+
+	acpi_ex_enter_interpreter();
+
 	/*
 	 * Invalidate the handle. We do this because the handle may be stored
 	 * in a named object and may not be actually deleted until much later.
 	 */
-	ddb_handle->common.flags &= ~AOPOBJ_DATA_VALID;
-	return_ACPI_STATUS(AE_OK);
+	if (ACPI_SUCCESS(status)) {
+		ddb_handle->common.flags &= ~AOPOBJ_DATA_VALID;
+	}
+	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 7e93fd6..d9ca8c2 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -614,17 +614,12 @@ acpi_status acpi_tb_delete_namespace_by_owner(u32 table_index)
 	 * lock may block, and also since the execution of a namespace walk
 	 * must be allowed to use the interpreter.
 	 */
-	(void)acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
 	status = acpi_ut_acquire_write_lock(&acpi_gbl_namespace_rw_lock);
-
-	acpi_ns_delete_namespace_by_owner(owner_id);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
-
+	acpi_ns_delete_namespace_by_owner(owner_id);
 	acpi_ut_release_write_lock(&acpi_gbl_namespace_rw_lock);
-
-	status = acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 870ad64..5569f63 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -378,9 +378,9 @@ acpi_status acpi_unload_parent_table(acpi_handle object)
 		return_ACPI_STATUS(AE_TYPE);
 	}
 
-	/* Must acquire the interpreter lock during this operation */
+	/* Must acquire the table lock during this operation */
 
-	status = acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
+	status = acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -407,8 +407,10 @@ acpi_status acpi_unload_parent_table(acpi_handle object)
 
 		/* Ensure the table is actually loaded */
 
+		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 		if (!acpi_tb_is_table_loaded(i)) {
 			status = AE_NOT_EXIST;
+			(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 			break;
 		}
 
@@ -434,10 +436,11 @@ acpi_status acpi_unload_parent_table(acpi_handle object)
 
 		status = acpi_tb_release_owner_id(i);
 		acpi_tb_set_table_loaded_flag(i, FALSE);
+		(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 		break;
 	}
 
-	(void)acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	return_ACPI_STATUS(status);
 }
 
-- 
1.7.10
