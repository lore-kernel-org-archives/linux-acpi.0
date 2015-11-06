From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v2 2/5] ACPICA: Debugger: Convert some mechanisms to OSPM specific
Date: Fri,  6 Nov 2015 14:47:04 +0800
Message-ID: <c6cb3263255db1996b72c4ee85905ec2c2682d9d.1446790780.git.lv.zheng@intel.com>
References: <8c1016ca8a570ba7c7a1c9f0f88d73cd83cea490> <cover.1446790780.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446790780.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The following mechanisms are OSPM specific:
1. Redirect output destination to console: no file redirection will be
   needed by an in-kernel debugger, there is even no file can be accessed
   when the debugger is running in the kernel mode.
2. Output command prompts: programs other than acpiexec can have different
   prompt characters and the prompt characters may be implemented as a
   special character sequence to form a char device IO protocol.
3. Command ready/complete handshake: OSPM debugger may wait more conditions
   to implement OSPM specific semantics (for example, FIFO full/empty
   conditions for O_NONBLOCK or IO open/close conditions).
Leaving such OSPM specific stuffs in the ACPICA debugger core blocks
Linux debugger IO driver implementation.

Several new OSL APIs are provided by this patch:
1. acpi_os_initialize_command_signals: initialize command handshake mechanism
   or any other OSPM specific stuffs.
2. acpi_os_terminate_command_signals: reversal of
   acpi_os_initialize_command_signals.
3. acpi_os_wait_command_ready: putting debugger task into wait state when a
   command is not ready. OSPMs can terminate command loop by returning
   AE_CTRL_TERMINATE from this API. Normally, wait_event() or
   wait_for_multiple_object() may be used to implement this API.
4. acpi_os_notify_command_complete: putting user task into running state when a
   command has been completed. OSPMs can terminate command loop by
   returning AE_CTRL_TERMINATE from this API. Normally, wake_up() or
   set_event() may be used to implement this API.
This patch also converts current command signaling implementation into a
generic debugger layer (osgendbg.c) to be used by the existing OSPMs or
acpiexec, in return, Linux can have chance to implement its own command
handshake mechanism. This patch also implements acpiexec batch mode in a
multi-threading mode comaptible style as a demo (this can be confirmed by
configuring acpiexec into DEBUGGER_MULTI_THREADED mode where the batch mode
is still working). Lv Zheng.

Note that the OSPM specific command handshake mechanism is required by
Linux kernel because:
1. Linux kernel trends to use wait queue to synchronize two threads, using
   mutexes to achieve that will cause false "dead lock" warnings.
2. The command handshake mechanism implemented by ACPICA is implemented in
   this way because of a design issue in debugger IO streaming. Debugger IO
   outputs are simply cached using a giant buffer, this should be tuned by
   Linux in the future.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acdebug.h     |    2 +-
 drivers/acpi/acpica/acglobal.h    |    5 --
 drivers/acpi/acpica/dbinput.c     |   97 ++++++++-----------------------------
 drivers/acpi/acpica/dbxface.c     |   63 +++++++-----------------
 drivers/acpi/acpica/utmutex.c     |   17 -------
 include/acpi/acpiosxf.h           |   18 ++++++-
 include/acpi/acpixf.h             |   11 +++++
 include/acpi/platform/aclinux.h   |    4 ++
 include/acpi/platform/aclinuxex.h |   19 ++++++++
 9 files changed, 89 insertions(+), 147 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index c928ba4..86474d8 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -257,7 +257,7 @@ acpi_db_command_dispatch(char *input_buffer,
 
 void ACPI_SYSTEM_XFACE acpi_db_execute_thread(void *context);
 
-acpi_status acpi_db_user_commands(char prompt, union acpi_parse_object *op);
+acpi_status acpi_db_user_commands(void);
 
 char *acpi_db_get_next_token(char *string,
 			     char **next, acpi_object_type * return_type);
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index faa9760..3977134 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -326,7 +326,6 @@ ACPI_GLOBAL(struct acpi_external_file *, acpi_gbl_external_file_list);
 #ifdef ACPI_DEBUGGER
 
 ACPI_INIT_GLOBAL(u8, acpi_gbl_abort_method, FALSE);
-ACPI_INIT_GLOBAL(u8, acpi_gbl_method_executing, FALSE);
 ACPI_INIT_GLOBAL(acpi_thread_id, acpi_gbl_db_thread_id, ACPI_INVALID_THREAD_ID);
 
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_no_ini_methods);
@@ -345,7 +344,6 @@ ACPI_GLOBAL(acpi_object_type, acpi_gbl_db_arg_types[ACPI_DEBUGGER_MAX_ARGS]);
 
 /* These buffers should all be the same size */
 
-ACPI_GLOBAL(char, acpi_gbl_db_line_buf[ACPI_DB_LINE_BUFFER_SIZE]);
 ACPI_GLOBAL(char, acpi_gbl_db_parsed_buf[ACPI_DB_LINE_BUFFER_SIZE]);
 ACPI_GLOBAL(char, acpi_gbl_db_scope_buf[ACPI_DB_LINE_BUFFER_SIZE]);
 ACPI_GLOBAL(char, acpi_gbl_db_debug_filename[ACPI_DB_LINE_BUFFER_SIZE]);
@@ -360,9 +358,6 @@ ACPI_GLOBAL(u16, acpi_gbl_node_type_count_misc);
 ACPI_GLOBAL(u32, acpi_gbl_num_nodes);
 ACPI_GLOBAL(u32, acpi_gbl_num_objects);
 
-ACPI_GLOBAL(acpi_mutex, acpi_gbl_db_command_ready);
-ACPI_GLOBAL(acpi_mutex, acpi_gbl_db_command_complete);
-
 #endif				/* ACPI_DEBUGGER */
 
 /*****************************************************************************
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index fe93f67..2bf8e6b 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -53,8 +53,6 @@ static u32 acpi_db_get_line(char *input_buffer);
 
 static u32 acpi_db_match_command(char *user_command);
 
-static void acpi_db_single_thread(void);
-
 static void acpi_db_display_command_info(char *command, u8 display_all);
 
 static void acpi_db_display_help(char *command);
@@ -1149,55 +1147,16 @@ acpi_db_command_dispatch(char *input_buffer,
 
 void ACPI_SYSTEM_XFACE acpi_db_execute_thread(void *context)
 {
-	acpi_status status = AE_OK;
-	acpi_status Mstatus;
-
-	while (status != AE_CTRL_TERMINATE && !acpi_gbl_db_terminate_loop) {
-		acpi_gbl_method_executing = FALSE;
-		acpi_gbl_step_to_next_call = FALSE;
-
-		Mstatus = acpi_os_acquire_mutex(acpi_gbl_db_command_ready,
-						ACPI_WAIT_FOREVER);
-		if (ACPI_FAILURE(Mstatus)) {
-			return;
-		}
-
-		status =
-		    acpi_db_command_dispatch(acpi_gbl_db_line_buf, NULL, NULL);
 
-		acpi_os_release_mutex(acpi_gbl_db_command_complete);
-	}
+	(void)acpi_db_user_commands();
 	acpi_gbl_db_threads_terminated = TRUE;
 }
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_db_single_thread
- *
- * PARAMETERS:  None
- *
- * RETURN:      None
- *
- * DESCRIPTION: Debugger execute thread. Waits for a command line, then
- *              simply dispatches it.
- *
- ******************************************************************************/
-
-static void acpi_db_single_thread(void)
-{
-
-	acpi_gbl_method_executing = FALSE;
-	acpi_gbl_step_to_next_call = FALSE;
-
-	(void)acpi_db_command_dispatch(acpi_gbl_db_line_buf, NULL, NULL);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_db_user_commands
  *
- * PARAMETERS:  prompt              - User prompt (depends on mode)
- *              op                  - Current executing parse op
+ * PARAMETERS:  None
  *
  * RETURN:      None
  *
@@ -1206,7 +1165,7 @@ static void acpi_db_single_thread(void)
  *
  ******************************************************************************/
 
-acpi_status acpi_db_user_commands(char prompt, union acpi_parse_object *op)
+acpi_status acpi_db_user_commands(void)
 {
 	acpi_status status = AE_OK;
 
@@ -1216,49 +1175,31 @@ acpi_status acpi_db_user_commands(char prompt, union acpi_parse_object *op)
 
 	while (!acpi_gbl_db_terminate_loop) {
 
-		/* Force output to console until a command is entered */
-
-		acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
-
-		/* Different prompt if method is executing */
-
-		if (!acpi_gbl_method_executing) {
-			acpi_os_printf("%1c ", ACPI_DEBUGGER_COMMAND_PROMPT);
-		} else {
-			acpi_os_printf("%1c ", ACPI_DEBUGGER_EXECUTE_PROMPT);
-		}
-
-		/* Get the user input line */
+		/* Wait the readiness of the command */
 
-		status = acpi_os_get_line(acpi_gbl_db_line_buf,
-					  ACPI_DB_LINE_BUFFER_SIZE, NULL);
+		status = acpi_os_wait_command_ready();
 		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status,
-					"While parsing command line"));
-			return (status);
+			break;
 		}
 
-		/* Check for single or multithreaded debug */
+		/* Just call to the command line interpreter */
 
-		if (acpi_gbl_debugger_configuration & DEBUGGER_MULTI_THREADED) {
-			/*
-			 * Signal the debug thread that we have a command to execute,
-			 * and wait for the command to complete.
-			 */
-			acpi_os_release_mutex(acpi_gbl_db_command_ready);
+		acpi_gbl_method_executing = FALSE;
+		acpi_gbl_step_to_next_call = FALSE;
 
-			status =
-			    acpi_os_acquire_mutex(acpi_gbl_db_command_complete,
-						  ACPI_WAIT_FOREVER);
-			if (ACPI_FAILURE(status)) {
-				return (status);
-			}
-		} else {
-			/* Just call to the command line interpreter */
+		(void)acpi_db_command_dispatch(acpi_gbl_db_line_buf, NULL,
+					       NULL);
+
+		/* Notify the completion of the command */
 
-			acpi_db_single_thread();
+		status = acpi_os_notify_command_complete();
+		if (ACPI_FAILURE(status)) {
+			break;
 		}
 	}
 
+	if (ACPI_FAILURE(status) && status != AE_CTRL_TERMINATE) {
+		ACPI_EXCEPTION((AE_INFO, status, "While parsing command line"));
+	}
 	return (status);
 }
diff --git a/drivers/acpi/acpica/dbxface.c b/drivers/acpi/acpica/dbxface.c
index 342298a..d95e91f 100644
--- a/drivers/acpi/acpica/dbxface.c
+++ b/drivers/acpi/acpica/dbxface.c
@@ -85,46 +85,21 @@ acpi_db_start_command(struct acpi_walk_state *walk_state,
 
 	acpi_gbl_method_executing = TRUE;
 	status = AE_CTRL_TRUE;
-	while (status == AE_CTRL_TRUE) {
-		if (acpi_gbl_debugger_configuration == DEBUGGER_MULTI_THREADED) {
-
-			/* Handshake with the front-end that gets user command lines */
-
-			acpi_os_release_mutex(acpi_gbl_db_command_complete);
-
-			status =
-			    acpi_os_acquire_mutex(acpi_gbl_db_command_ready,
-						  ACPI_WAIT_FOREVER);
-			if (ACPI_FAILURE(status)) {
-				return (status);
-			}
-		} else {
-			/* Single threaded, we must get a command line ourselves */
 
-			/* Force output to console until a command is entered */
-
-			acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+	while (status == AE_CTRL_TRUE) {
 
-			/* Different prompt if method is executing */
+		/* Notify the completion of the command */
 
-			if (!acpi_gbl_method_executing) {
-				acpi_os_printf("%1c ",
-					       ACPI_DEBUGGER_COMMAND_PROMPT);
-			} else {
-				acpi_os_printf("%1c ",
-					       ACPI_DEBUGGER_EXECUTE_PROMPT);
-			}
+		status = acpi_os_notify_command_complete();
+		if (ACPI_FAILURE(status)) {
+			goto error_exit;
+		}
 
-			/* Get the user input line */
+		/* Wait the readiness of the command */
 
-			status = acpi_os_get_line(acpi_gbl_db_line_buf,
-						  ACPI_DB_LINE_BUFFER_SIZE,
-						  NULL);
-			if (ACPI_FAILURE(status)) {
-				ACPI_EXCEPTION((AE_INFO, status,
-						"While parsing command line"));
-				return (status);
-			}
+		status = acpi_os_wait_command_ready();
+		if (ACPI_FAILURE(status)) {
+			goto error_exit;
 		}
 
 		status =
@@ -134,6 +109,11 @@ acpi_db_start_command(struct acpi_walk_state *walk_state,
 
 	/* acpi_ut_acquire_mutex (ACPI_MTX_NAMESPACE); */
 
+error_exit:
+	if (ACPI_FAILURE(status) && status != AE_CTRL_TERMINATE) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"While parsing/handling command line"));
+	}
 	return (status);
 }
 
@@ -420,15 +400,7 @@ acpi_status acpi_initialize_debugger(void)
 
 		/* These were created with one unit, grab it */
 
-		status = acpi_os_acquire_mutex(acpi_gbl_db_command_complete,
-					       ACPI_WAIT_FOREVER);
-		if (ACPI_FAILURE(status)) {
-			acpi_os_printf("Could not get debugger mutex\n");
-			return_ACPI_STATUS(status);
-		}
-
-		status = acpi_os_acquire_mutex(acpi_gbl_db_command_ready,
-					       ACPI_WAIT_FOREVER);
+		status = acpi_os_initialize_command_signals();
 		if (ACPI_FAILURE(status)) {
 			acpi_os_printf("Could not get debugger mutex\n");
 			return_ACPI_STATUS(status);
@@ -473,13 +445,14 @@ void acpi_terminate_debugger(void)
 	acpi_gbl_db_terminate_loop = TRUE;
 
 	if (acpi_gbl_debugger_configuration & DEBUGGER_MULTI_THREADED) {
-		acpi_os_release_mutex(acpi_gbl_db_command_ready);
 
 		/* Wait the AML Debugger threads */
 
 		while (!acpi_gbl_db_threads_terminated) {
 			acpi_os_sleep(100);
 		}
+
+		acpi_os_terminate_command_signals();
 	}
 
 	if (acpi_gbl_db_buffer) {
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index ce406e3..ea0c207 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -111,17 +111,6 @@ acpi_status acpi_ut_mutex_initialize(void)
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
-#ifdef ACPI_DEBUGGER
-
-	/* Debugger Support */
-
-	status = acpi_os_create_mutex(&acpi_gbl_db_command_ready);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	status = acpi_os_create_mutex(&acpi_gbl_db_command_complete);
-#endif
 
 	return_ACPI_STATUS(status);
 }
@@ -162,12 +151,6 @@ void acpi_ut_mutex_terminate(void)
 	/* Delete the reader/writer lock */
 
 	acpi_ut_delete_rw_lock(&acpi_gbl_namespace_rw_lock);
-
-#ifdef ACPI_DEBUGGER
-	acpi_os_delete_mutex(acpi_gbl_db_command_ready);
-	acpi_os_delete_mutex(acpi_gbl_db_command_complete);
-#endif
-
 	return_VOID;
 }
 
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index fbc2baf..0d824a2 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -349,12 +349,28 @@ void acpi_os_redirect_output(void *destination);
 #endif
 
 /*
- * Debug input
+ * Debug IO
  */
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_line
 acpi_status acpi_os_get_line(char *buffer, u32 buffer_length, u32 *bytes_read);
 #endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_initialize_command_signals
+acpi_status acpi_os_initialize_command_signals(void);
+#endif
+
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_terminate_command_signals
+void acpi_os_terminate_command_signals(void);
+#endif
+
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_wait_command_ready
+acpi_status acpi_os_wait_command_ready(void);
+#endif
+
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_notify_command_complete
+acpi_status acpi_os_notify_command_complete(void);
+#endif
+
 /*
  * Obtain ACPI table(s)
  */
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 3aaaa86..95ebae3 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -264,6 +264,15 @@ ACPI_INIT_GLOBAL(u32, acpi_dbg_level, ACPI_DEBUG_DEFAULT);
 ACPI_INIT_GLOBAL(u32, acpi_dbg_layer, 0);
 
 /*
+ * Debugger command handshake globals. Host OSes need to access these
+ * variables to implement their own command handshake mechanism.
+ */
+#ifdef ACPI_DEBUGGER
+ACPI_INIT_GLOBAL(u8, acpi_gbl_method_executing, FALSE);
+ACPI_GLOBAL(char, acpi_gbl_db_line_buf[ACPI_DB_LINE_BUFFER_SIZE]);
+#endif
+
+/*
  * Other miscellaneous globals
  */
 ACPI_GLOBAL(struct acpi_table_fadt, acpi_gbl_FADT);
@@ -929,6 +938,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 					       void **data,
 					       void (*callback)(void *)))
 
+void acpi_run_debugger(char *batch_buffer);
+
 void acpi_set_debugger_thread_id(acpi_thread_id thread_id);
 
 #endif				/* __ACXFACE_H__ */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 323e5da..69dbae6 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -150,6 +150,10 @@
  */
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_readable
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_writable
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_initialize_command_signals
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_terminate_command_signals
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_wait_command_ready
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_notify_command_complete
 
 /*
  * OSL interfaces used by utilities
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index fd6d70f..673fdf4 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -129,6 +129,25 @@ static inline u8 acpi_os_readable(void *pointer, acpi_size length)
 	return TRUE;
 }
 
+static inline acpi_status acpi_os_initialize_command_signals(void)
+{
+	return AE_OK;
+}
+
+static inline void acpi_os_terminate_command_signals(void)
+{
+}
+
+static inline acpi_status acpi_os_wait_command_ready(void)
+{
+	return AE_ERROR;
+}
+
+static inline acpi_status acpi_os_notify_command_complete(void)
+{
+	return AE_ERROR;
+}
+
 /*
  * OSL interfaces added by Linux
  */
-- 
1.7.10
