From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 11/14] ACPICA: Debugger: Add thread ID support so that single step mode can only apply to the debugger thread
Date: Mon, 19 Oct 2015 10:25:50 +0800
Message-ID: <36305e3a27770c01ccc407a6f6ddd527a3be81f9.1445221165.git.lv.zheng@intel.com>
References: <8c1016ca8a570ba7c7a1c9f0f88d73cd83cea490> <cover.1445221164.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1445221164.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

When the debugger is running in the kernel mode, acpi_db_single_step() may
also be invoked by the kernel runtime code path but the single stepping
command prompt may be erronously logged as the kernel logs and runtime code
path cannot proceed.

This patch fixes this issue by adding acpi_gbl_db_thread_id for the debugger
thread and preventing acpi_db_single_step() to be invoked from other threads.

It is not suitable to add acpi_thread_id parameter for acpi_os_execute() as
the function may be implemented as work queue on some hosts. So it is
better to let the hosts invoke acpi_set_debugger_thread_id(). Currently
acpiexec is not configured as DEBUGGER_MULTI_THREADED, but we can do this.
When we do this, it is better to invoke acpi_set_debugger_thread_id() in
acpi_os_execute() when the execution type is OSL_DEBUGGER_MAIN_THREAD. The
support should look like:
  create_thread(&tid);
  if (type == OSL_DEBUGGER_MAIN_THREAD)
      acpi_set_debugger_thread_id(tid);
  resume_thread(tid);
Similarly, semop() may be used for pthread implementation. But this patch
simply skips debugger thread ID check for application instead of
introducing such complications as there is no need to skip
acpi_db_single_step() for an application debugger - acpiexec.

Note that the debugger thread ID can also be used by acpi_os_printf() to
filter out debugger output. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    1 +
 drivers/acpi/acpica/aclocal.h  |    8 ++++++++
 drivers/acpi/acpica/dbexec.c   |    3 ++-
 drivers/acpi/acpica/dbxface.c  |   28 +++++++++++++++++++++++++++-
 include/acpi/acpiosxf.h        |    3 ++-
 include/acpi/acpixf.h          |    2 ++
 6 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index d82249c..fdef15f 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -326,6 +326,7 @@ ACPI_GLOBAL(struct acpi_external_file *, acpi_gbl_external_file_list);
 
 ACPI_INIT_GLOBAL(u8, acpi_gbl_abort_method, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_method_executing, FALSE);
+ACPI_INIT_GLOBAL(acpi_thread_id, acpi_gbl_db_thread_id, ACPI_INVALID_THREAD_ID);
 
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_no_ini_methods);
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_no_region_support);
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 4e41b43..e1dd784 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -109,6 +109,14 @@ struct acpi_rw_lock {
 
 #define ACPI_MUTEX_NOT_ACQUIRED         (acpi_thread_id) 0
 
+/* This Thread ID means an invalid thread ID */
+
+#ifdef ACPI_OS_INVALID_THREAD_ID
+#define ACPI_INVALID_THREAD_ID          ACPI_OS_INVALID_THREAD_ID
+#else
+#define ACPI_INVALID_THREAD_ID          ((acpi_thread_id) 0xFFFFFFFF)
+#endif
+
 /* Table for the global mutexes */
 
 struct acpi_mutex_info {
diff --git a/drivers/acpi/acpica/dbexec.c b/drivers/acpi/acpica/dbexec.c
index 8eef298..258e615 100644
--- a/drivers/acpi/acpica/dbexec.c
+++ b/drivers/acpi/acpica/dbexec.c
@@ -725,7 +725,8 @@ acpi_db_create_execution_threads(char *num_threads_arg,
 
 	for (i = 0; i < (num_threads); i++) {
 		status =
-		    acpi_os_execute(OSL_DEBUGGER_THREAD, acpi_db_method_thread,
+		    acpi_os_execute(OSL_DEBUGGER_EXEC_THREAD,
+				    acpi_db_method_thread,
 				    &acpi_gbl_db_method_info);
 		if (ACPI_FAILURE(status)) {
 			break;
diff --git a/drivers/acpi/acpica/dbxface.c b/drivers/acpi/acpica/dbxface.c
index bef5f4e..342298a 100644
--- a/drivers/acpi/acpica/dbxface.c
+++ b/drivers/acpi/acpica/dbxface.c
@@ -164,6 +164,12 @@ acpi_db_single_step(struct acpi_walk_state * walk_state,
 
 	ACPI_FUNCTION_ENTRY();
 
+#ifndef ACPI_APPLICATION
+	if (acpi_gbl_db_thread_id != acpi_os_get_thread_id()) {
+		return (AE_OK);
+	}
+#endif
+
 	/* Check the abort flag */
 
 	if (acpi_gbl_abort_method) {
@@ -431,7 +437,7 @@ acpi_status acpi_initialize_debugger(void)
 		/* Create the debug execution thread to execute commands */
 
 		acpi_gbl_db_threads_terminated = FALSE;
-		status = acpi_os_execute(OSL_DEBUGGER_THREAD,
+		status = acpi_os_execute(OSL_DEBUGGER_MAIN_THREAD,
 					 acpi_db_execute_thread, NULL);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
@@ -439,6 +445,8 @@ acpi_status acpi_initialize_debugger(void)
 			acpi_gbl_db_threads_terminated = TRUE;
 			return_ACPI_STATUS(status);
 		}
+	} else {
+		acpi_gbl_db_thread_id = acpi_os_get_thread_id();
 	}
 
 	return_ACPI_STATUS(AE_OK);
@@ -485,3 +493,21 @@ void acpi_terminate_debugger(void)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_terminate_debugger)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_set_debugger_thread_id
+ *
+ * PARAMETERS:  thread_id       - Debugger thread ID
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Set debugger thread ID
+ *
+ ******************************************************************************/
+void acpi_set_debugger_thread_id(acpi_thread_id thread_id)
+{
+	acpi_gbl_db_thread_id = thread_id;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_set_debugger_thread_id)
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index a54ad1c..fbc2baf 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -55,7 +55,8 @@ typedef enum {
 	OSL_GLOBAL_LOCK_HANDLER,
 	OSL_NOTIFY_HANDLER,
 	OSL_GPE_HANDLER,
-	OSL_DEBUGGER_THREAD,
+	OSL_DEBUGGER_MAIN_THREAD,
+	OSL_DEBUGGER_EXEC_THREAD,
 	OSL_EC_POLL_HANDLER,
 	OSL_EC_BURST_HANDLER
 } acpi_execute_type;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c33eeab..f837adf 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -939,4 +939,6 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 					       void **data,
 					       void (*callback)(void *)))
 
+void acpi_set_debugger_thread_id(acpi_thread_id thread_id);
+
 #endif				/* __ACXFACE_H__ */
-- 
1.7.10
