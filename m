From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/13] ACPICA: Debugger: Fix "quit/exit" command by cleaning up user commands termination logic
Date: Thu, 15 Oct 2015 10:08:41 +0800
Message-ID: <cff3d9f3d5b15967782f2898e780cf47867863cf.1444874756.git.lv.zheng@intel.com>
References: <cover.1444874756.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444874756.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 0dd68e16274cd38224aa4781eddc57dc2cbaa108

The quit/exit commands shouldn't invoke acpi_terminate_debugger() and
acpi_terminate() right in the user command loop, because when the debugger
exits, the kernel ACPI subsystem shouldn't be terminated (acpi_terminate())
and the debugger should only be terminated by its users
(acpi_terminate_debugger()) rather than being terminated itself. Leaving such
invocations causes kernel panic when the debugger is shipped in the Linux
kernel.

This patch fixes this issue. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/0dd68e16
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    3 ++-
 drivers/acpi/acpica/dbinput.c  |   16 ++++------------
 drivers/acpi/acpica/dbxface.c  |   20 ++++++++++++++++++++
 drivers/acpi/acpica/utinit.c   |    2 --
 drivers/acpi/acpica/utxface.c  |    4 ----
 5 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 593de41..d82249c 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -324,7 +324,6 @@ ACPI_GLOBAL(struct acpi_external_file *, acpi_gbl_external_file_list);
 
 #ifdef ACPI_DEBUGGER
 
-ACPI_INIT_GLOBAL(u8, acpi_gbl_db_terminate_threads, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_abort_method, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_method_executing, FALSE);
 
@@ -336,6 +335,8 @@ ACPI_GLOBAL(char *, acpi_gbl_db_filename);
 ACPI_GLOBAL(u32, acpi_gbl_db_debug_level);
 ACPI_GLOBAL(u32, acpi_gbl_db_console_debug_level);
 ACPI_GLOBAL(struct acpi_namespace_node *, acpi_gbl_db_scope_node);
+ACPI_GLOBAL(u8, acpi_gbl_db_terminate_loop);
+ACPI_GLOBAL(u8, acpi_gbl_db_threads_terminated);
 
 ACPI_GLOBAL(char *, acpi_gbl_db_args[ACPI_DEBUGGER_MAX_ARGS]);
 ACPI_GLOBAL(acpi_object_type, acpi_gbl_db_arg_types[ACPI_DEBUGGER_MAX_ARGS]);
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 7f1b6ec..f8cddd6 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -694,7 +694,7 @@ acpi_db_command_dispatch(char *input_buffer,
 
 	/* If acpi_terminate has been called, terminate this thread */
 
-	if (acpi_gbl_db_terminate_threads) {
+	if (acpi_gbl_db_terminate_loop) {
 		return (AE_CTRL_TERMINATE);
 	}
 
@@ -1116,7 +1116,7 @@ acpi_db_command_dispatch(char *input_buffer,
 #ifdef ACPI_APPLICATION
 		acpi_db_close_debug_file();
 #endif
-		acpi_gbl_db_terminate_threads = TRUE;
+		acpi_gbl_db_terminate_loop = TRUE;
 		return (AE_CTRL_TERMINATE);
 
 	case CMD_NOT_FOUND:
@@ -1166,6 +1166,7 @@ void ACPI_SYSTEM_XFACE acpi_db_execute_thread(void *context)
 
 		acpi_os_release_mutex(acpi_gbl_db_command_complete);
 	}
+	acpi_gbl_db_threads_terminated = TRUE;
 }
 
 /*******************************************************************************
@@ -1212,7 +1213,7 @@ acpi_status acpi_db_user_commands(char prompt, union acpi_parse_object *op)
 
 	/* TBD: [Restructure] Need a separate command line buffer for step mode */
 
-	while (!acpi_gbl_db_terminate_threads) {
+	while (!acpi_gbl_db_terminate_loop) {
 
 		/* Force output to console until a command is entered */
 
@@ -1261,14 +1262,5 @@ acpi_status acpi_db_user_commands(char prompt, union acpi_parse_object *op)
 		}
 	}
 
-	/* Shut down the debugger */
-
-	acpi_terminate_debugger();
-
-	/*
-	 * Only this thread (the original thread) should actually terminate the
-	 * subsystem, because all the semaphores are deleted during termination
-	 */
-	status = acpi_terminate();
 	return (status);
 }
diff --git a/drivers/acpi/acpica/dbxface.c b/drivers/acpi/acpica/dbxface.c
index 26023bd..bef5f4e 100644
--- a/drivers/acpi/acpica/dbxface.c
+++ b/drivers/acpi/acpica/dbxface.c
@@ -401,6 +401,10 @@ acpi_status acpi_initialize_debugger(void)
 	acpi_gbl_db_scope_buf[1] = 0;
 	acpi_gbl_db_scope_node = acpi_gbl_root_node;
 
+	/* Initialize user commands loop */
+
+	acpi_gbl_db_terminate_loop = FALSE;
+
 	/*
 	 * If configured for multi-thread support, the debug executor runs in
 	 * a separate thread so that the front end can be in another address
@@ -426,11 +430,13 @@ acpi_status acpi_initialize_debugger(void)
 
 		/* Create the debug execution thread to execute commands */
 
+		acpi_gbl_db_threads_terminated = FALSE;
 		status = acpi_os_execute(OSL_DEBUGGER_THREAD,
 					 acpi_db_execute_thread, NULL);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Could not start debugger thread"));
+			acpi_gbl_db_threads_terminated = TRUE;
 			return_ACPI_STATUS(status);
 		}
 	}
@@ -454,6 +460,20 @@ ACPI_EXPORT_SYMBOL(acpi_initialize_debugger)
 void acpi_terminate_debugger(void)
 {
 
+	/* Terminate the AML Debugger */
+
+	acpi_gbl_db_terminate_loop = TRUE;
+
+	if (acpi_gbl_debugger_configuration & DEBUGGER_MULTI_THREADED) {
+		acpi_os_release_mutex(acpi_gbl_db_command_ready);
+
+		/* Wait the AML Debugger threads */
+
+		while (!acpi_gbl_db_threads_terminated) {
+			acpi_os_sleep(100);
+		}
+	}
+
 	if (acpi_gbl_db_buffer) {
 		acpi_os_free(acpi_gbl_db_buffer);
 		acpi_gbl_db_buffer = NULL;
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 28ab3a1..d8699df 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -241,8 +241,6 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_disable_mem_tracking = FALSE;
 #endif
 
-	ACPI_DEBUGGER_EXEC(acpi_gbl_db_terminate_threads = FALSE);
-
 	return_ACPI_STATUS(AE_OK);
 }
 
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 4f33281..f183daf 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -80,10 +80,6 @@ acpi_status __init acpi_terminate(void)
 	acpi_gbl_startup_flags = 0;
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Shutting down ACPI Subsystem\n"));
 
-	/* Terminate the AML Debugger if present */
-
-	ACPI_DEBUGGER_EXEC(acpi_gbl_db_terminate_threads = TRUE);
-
 	/* Shutdown and free all resources */
 
 	acpi_ut_subsystem_shutdown();
-- 
1.7.10
