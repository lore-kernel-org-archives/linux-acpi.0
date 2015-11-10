From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 3/7] ACPICA: Debugger: Fix runtime stub issues of ACPI_DEBUGGER_EXEC using different stub mechanism
Date: Tue, 10 Nov 2015 16:21:56 +0800
Message-ID: <163f459f4d60c02cc6a009185dc1a1254628af79.1447143067.git.lv.zheng@intel.com>
References: <cover.1446790780.git.lv.zheng@intel.com> <cover.1447143067.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447143067.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The ACPI_DEBUGGER_EXEC is a problem now when the debugger code is compiled
but runtime disabled. They actually will get executed in this situation.
Although such executions are harmless if we can correctly make
acpi_db_single_step() a runtime stub, users may still do not want to see the
debugger print messages logged into OSPMs' kernel logs when a debugger
driver is not loaded to enable the debugger during runtime.

This patch fixes this issue by introducing new stub mechanism instead of
ACPI_DEBUGGER_EXEC. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acdebug.h   |   34 ++++++++++++++++++++++++----------
 drivers/acpi/acpica/acmacros.h  |   11 -----------
 drivers/acpi/acpica/dbdisply.c  |   12 ++++++++++++
 drivers/acpi/acpica/dbxface.c   |   30 ++++++++++++++++++++++++++++++
 drivers/acpi/acpica/dscontrol.c |   10 ++--------
 drivers/acpi/acpica/dsutils.c   |   16 ++++++++--------
 drivers/acpi/acpica/dswexec.c   |   16 +++++++---------
 include/acpi/acpixf.h           |   23 +++++++++++++++++++++++
 8 files changed, 106 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 86474d8..dcaa15d 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -80,9 +80,15 @@ struct acpi_db_execute_walk {
 /*
  * dbxface - external debugger interfaces
  */
-acpi_status
-acpi_db_single_step(struct acpi_walk_state *walk_state,
-		    union acpi_parse_object *op, u32 op_type);
+ACPI_DBR_DEPENDENT_RETURN_OK(acpi_status
+			     acpi_db_single_step(struct acpi_walk_state
+						 *walk_state,
+						 union acpi_parse_object *op,
+						 u32 op_type))
+ ACPI_DBR_DEPENDENT_RETURN_VOID(void
+				acpi_db_signal_break_point(struct
+							   acpi_walk_state
+							   *walk_state))
 
 /*
  * dbcmds - debug commands and output routines
@@ -182,11 +188,15 @@ void acpi_db_display_method_info(union acpi_parse_object *op);
 
 void acpi_db_decode_and_display_object(char *target, char *output_type);
 
-void
-acpi_db_display_result_object(union acpi_operand_object *obj_desc,
-			      struct acpi_walk_state *walk_state);
+ACPI_DBR_DEPENDENT_RETURN_VOID(void
+			       acpi_db_display_result_object(union
+							     acpi_operand_object
+							     *obj_desc,
+							     struct
+							     acpi_walk_state
+							     *walk_state))
 
-acpi_status acpi_db_display_all_methods(char *display_count_arg);
+ acpi_status acpi_db_display_all_methods(char *display_count_arg);
 
 void acpi_db_display_arguments(void);
 
@@ -198,9 +208,13 @@ void acpi_db_display_calling_tree(void);
 
 void acpi_db_display_object_type(char *object_arg);
 
-void
-acpi_db_display_argument_object(union acpi_operand_object *obj_desc,
-				struct acpi_walk_state *walk_state);
+ACPI_DBR_DEPENDENT_RETURN_VOID(void
+			       acpi_db_display_argument_object(union
+							       acpi_operand_object
+							       *obj_desc,
+							       struct
+							       acpi_walk_state
+							       *walk_state))
 
 /*
  * dbexec - debugger control method execution
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index e85366c..bad5bca 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -401,17 +401,6 @@
 #endif
 
 /*
- * Some code only gets executed when the debugger is built in.
- * Note that this is entirely independent of whether the
- * DEBUG_PRINT stuff (set by ACPI_DEBUG_OUTPUT) is on, or not.
- */
-#ifdef ACPI_DEBUGGER
-#define ACPI_DEBUGGER_EXEC(a)           a
-#else
-#define ACPI_DEBUGGER_EXEC(a)
-#endif
-
-/*
  * Macros used for ACPICA utilities only
  */
 
diff --git a/drivers/acpi/acpica/dbdisply.c b/drivers/acpi/acpica/dbdisply.c
index 672977e..c42ce8a 100644
--- a/drivers/acpi/acpica/dbdisply.c
+++ b/drivers/acpi/acpica/dbdisply.c
@@ -679,6 +679,12 @@ acpi_db_display_result_object(union acpi_operand_object *obj_desc,
 			      struct acpi_walk_state *walk_state)
 {
 
+#ifndef ACPI_APPLICATION
+	if (acpi_gbl_db_thread_id != acpi_os_get_thread_id()) {
+		return;
+	}
+#endif
+
 	/* Only display if single stepping */
 
 	if (!acpi_gbl_cm_single_step) {
@@ -708,6 +714,12 @@ acpi_db_display_argument_object(union acpi_operand_object *obj_desc,
 				struct acpi_walk_state *walk_state)
 {
 
+#ifndef ACPI_APPLICATION
+	if (acpi_gbl_db_thread_id != acpi_os_get_thread_id()) {
+		return;
+	}
+#endif
+
 	if (!acpi_gbl_cm_single_step) {
 		return;
 	}
diff --git a/drivers/acpi/acpica/dbxface.c b/drivers/acpi/acpica/dbxface.c
index d95e91f..d7ff58e 100644
--- a/drivers/acpi/acpica/dbxface.c
+++ b/drivers/acpi/acpica/dbxface.c
@@ -119,6 +119,36 @@ error_exit:
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_db_signal_break_point
+ *
+ * PARAMETERS:  walk_state      - Current walk
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Called for AML_BREAK_POINT_OP
+ *
+ ******************************************************************************/
+
+void acpi_db_signal_break_point(struct acpi_walk_state *walk_state)
+{
+
+#ifndef ACPI_APPLICATION
+	if (acpi_gbl_db_thread_id != acpi_os_get_thread_id()) {
+		return;
+	}
+#endif
+
+	/*
+	 * Set the single-step flag. This will cause the debugger (if present)
+	 * to break to the console within the AML debugger at the start of the
+	 * next AML instruction.
+	 */
+	acpi_gbl_cm_single_step = TRUE;
+	acpi_os_printf("**break** Executed AML BreakPoint opcode\n");
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_db_single_step
  *
  * PARAMETERS:  walk_state      - Current walk
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 435fc16..06a6f7f 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -47,6 +47,7 @@
 #include "amlcode.h"
 #include "acdispat.h"
 #include "acinterp.h"
+#include "acdebug.h"
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dscontrol")
@@ -348,14 +349,7 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 
 	case AML_BREAK_POINT_OP:
 
-		/*
-		 * Set the single-step flag. This will cause the debugger (if present)
-		 * to break to the console within the AML debugger at the start of the
-		 * next AML instruction.
-		 */
-		ACPI_DEBUGGER_EXEC(acpi_gbl_cm_single_step = TRUE);
-		ACPI_DEBUGGER_EXEC(acpi_os_printf
-				   ("**break** Executed AML BreakPoint opcode\n"));
+		acpi_db_signal_break_point(walk_state);
 
 		/* Call to the OSL in case OS wants a piece of the action */
 
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index ebc577b..e4293a8 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -605,8 +605,8 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
-		ACPI_DEBUGGER_EXEC(acpi_db_display_argument_object
-				   (obj_desc, walk_state));
+
+		acpi_db_display_argument_object(obj_desc, walk_state);
 	} else {
 		/* Check for null name case */
 
@@ -638,10 +638,11 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 					  "Argument previously created, already stacked\n"));
 
-			ACPI_DEBUGGER_EXEC(acpi_db_display_argument_object
-					   (walk_state->
-					    operands[walk_state->num_operands -
-						     1], walk_state));
+			acpi_db_display_argument_object(walk_state->
+							operands[walk_state->
+								 num_operands -
+								 1],
+							walk_state);
 
 			/*
 			 * Use value that was already previously returned
@@ -685,8 +686,7 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 			return_ACPI_STATUS(status);
 		}
 
-		ACPI_DEBUGGER_EXEC(acpi_db_display_argument_object
-				   (obj_desc, walk_state));
+		acpi_db_display_argument_object(obj_desc, walk_state);
 	}
 
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index df54d46..9cc5761 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -178,8 +178,7 @@ cleanup:
 
 	/* Break to debugger to display result */
 
-	ACPI_DEBUGGER_EXEC(acpi_db_display_result_object
-			   (local_obj_desc, walk_state));
+	acpi_db_display_result_object(local_obj_desc, walk_state);
 
 	/*
 	 * Delete the predicate result object (we know that
@@ -386,11 +385,10 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 
 	/* Call debugger for single step support (DEBUG build only) */
 
-	ACPI_DEBUGGER_EXEC(status =
-			   acpi_db_single_step(walk_state, op, op_class));
-	ACPI_DEBUGGER_EXEC(if (ACPI_FAILURE(status)) {
-			   return_ACPI_STATUS(status);}
-	) ;
+	status = acpi_db_single_step(walk_state, op, op_class);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
 	/* Decode the Opcode Class */
 
@@ -728,8 +726,8 @@ cleanup:
 
 		/* Break to debugger to display result */
 
-		ACPI_DEBUGGER_EXEC(acpi_db_display_result_object
-				   (walk_state->result_obj, walk_state));
+		acpi_db_display_result_object(walk_state->result_obj,
+					      walk_state);
 
 		/*
 		 * Delete the result op if and only if:
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 95ebae3..5dfab9c 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -375,6 +375,29 @@ ACPI_GLOBAL(u8, acpi_gbl_system_awake_and_running);
 
 #endif				/* ACPI_APPLICATION */
 
+/*
+ * Debugger prototypes
+ *
+ * All interfaces used by debugger will be configured
+ * out of the ACPICA build unless the ACPI_DEBUGGER
+ * flag is defined.
+ */
+#ifdef ACPI_DEBUGGER
+#define ACPI_DBR_DEPENDENT_RETURN_OK(prototype) \
+	ACPI_EXTERNAL_RETURN_OK(prototype)
+
+#define ACPI_DBR_DEPENDENT_RETURN_VOID(prototype) \
+	ACPI_EXTERNAL_RETURN_VOID(prototype)
+
+#else
+#define ACPI_DBR_DEPENDENT_RETURN_OK(prototype) \
+	static ACPI_INLINE prototype {return(AE_OK);}
+
+#define ACPI_DBR_DEPENDENT_RETURN_VOID(prototype) \
+	static ACPI_INLINE prototype {return;}
+
+#endif				/* ACPI_DEBUGGER */
+
 /*****************************************************************************
  *
  * ACPICA public interface prototypes
-- 
1.7.10
