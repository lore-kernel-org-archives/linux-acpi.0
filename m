From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/18] ACPICA: Remove global option to serialize all control methods.
Date: Wed, 26 Feb 2014 10:32:01 +0800
Message-ID: <f4430f273bf4ffa845e8ac9c5703c2ffa1516863.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37335 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbaBZCcS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:32:18 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

With the addition of the auto-serialization feature, this option
is obsolete and is completely removed. Lv Zheng.

This patch also updates acpi_serialize kernel parameter using the
new auto-serialization feature - acpi_gbl_auto_serialize_methods.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=52191
Signed-off: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/kernel-parameters.txt |   10 ++++-
 drivers/acpi/acpica/acglobal.h      |    8 ----
 drivers/acpi/acpica/acinterp.h      |    4 --
 drivers/acpi/acpica/exsystem.c      |   12 +++---
 drivers/acpi/acpica/exutils.c       |   80 +++++------------------------------
 drivers/acpi/osl.c                  |   18 ++++++--
 include/acpi/acpixf.h               |    1 -
 7 files changed, 39 insertions(+), 94 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index bf0fda0..3ca3167 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -306,7 +306,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
 
-	acpi_serialize	[HW,ACPI] force serialization of AML methods
+	acpi_serialize=	[HW,ACPI] configure auto-serialization of AML methods
+			Format: { on | off }
+			on -- enable auto-serialization of AML methods
+			off -- disable auto-serialization of AML methods
+			AML control methods that contain the opcodes to create
+			named objects will be marked as "Serialized" by the
+			auto-serialization feature.
+			This feature is enabled by default.
+			This option allows to turn on/off the feature.
 
 	acpi_skip_timer_override [HW,ACPI]
 			Recognize and ignore IRQ0/pin2 Interrupt Override.
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 7da6573..71b7e5f 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -96,14 +96,6 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_interpreter_slack, FALSE);
 u8 ACPI_INIT_GLOBAL(acpi_gbl_auto_serialize_methods, TRUE);
 
 /*
- * Automatically serialize ALL control methods? Default is FALSE, meaning
- * to use the Serialized/not_serialized method flags on a per method basis.
- * Only change this if the ASL code is poorly written and cannot handle
- * reentrancy even though methods are marked "NotSerialized".
- */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_all_methods_serialized, FALSE);
-
-/*
  * Create the predefined _OSI method in the namespace? Default is TRUE
  * because ACPI CA is fully compatible with other ACPI implementations.
  * Changing this will revert ACPI CA (and machine ASL) to pre-OSI behavior.
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 277f4d0..a1d4be9 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -456,10 +456,6 @@ void acpi_ex_enter_interpreter(void);
 
 void acpi_ex_exit_interpreter(void);
 
-void acpi_ex_reacquire_interpreter(void);
-
-void acpi_ex_relinquish_interpreter(void);
-
 u8 acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc);
 
 void acpi_ex_acquire_global_lock(u32 rule);
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index 841caed..f7da641 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -77,7 +77,7 @@ acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
 
 		/* We must wait, so unlock the interpreter */
 
-		acpi_ex_relinquish_interpreter();
+		acpi_ex_exit_interpreter();
 
 		status = acpi_os_wait_semaphore(semaphore, 1, timeout);
 
@@ -87,7 +87,7 @@ acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
 
 		/* Reacquire the interpreter */
 
-		acpi_ex_reacquire_interpreter();
+		acpi_ex_enter_interpreter();
 	}
 
 	return_ACPI_STATUS(status);
@@ -123,7 +123,7 @@ acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
 
 		/* We must wait, so unlock the interpreter */
 
-		acpi_ex_relinquish_interpreter();
+		acpi_ex_exit_interpreter();
 
 		status = acpi_os_acquire_mutex(mutex, timeout);
 
@@ -133,7 +133,7 @@ acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
 
 		/* Reacquire the interpreter */
 
-		acpi_ex_reacquire_interpreter();
+		acpi_ex_enter_interpreter();
 	}
 
 	return_ACPI_STATUS(status);
@@ -198,7 +198,7 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long)
 
 	/* Since this thread will sleep, we must release the interpreter */
 
-	acpi_ex_relinquish_interpreter();
+	acpi_ex_exit_interpreter();
 
 	/*
 	 * For compatibility with other ACPI implementations and to prevent
@@ -212,7 +212,7 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long)
 
 	/* And now we must get the interpreter again */
 
-	acpi_ex_reacquire_interpreter();
+	acpi_ex_enter_interpreter();
 	return (AE_OK);
 }
 
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 5b16c54..d9d72df 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -100,37 +100,6 @@ void acpi_ex_enter_interpreter(void)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ex_reacquire_interpreter
- *
- * PARAMETERS:  None
- *
- * RETURN:      None
- *
- * DESCRIPTION: Reacquire the interpreter execution region from within the
- *              interpreter code. Failure to enter the interpreter region is a
- *              fatal system error. Used in conjunction with
- *              relinquish_interpreter
- *
- ******************************************************************************/
-
-void acpi_ex_reacquire_interpreter(void)
-{
-	ACPI_FUNCTION_TRACE(ex_reacquire_interpreter);
-
-	/*
-	 * If the global serialized flag is set, do not release the interpreter,
-	 * since it was not actually released by acpi_ex_relinquish_interpreter.
-	 * This forces the interpreter to be single threaded.
-	 */
-	if (!acpi_gbl_all_methods_serialized) {
-		acpi_ex_enter_interpreter();
-	}
-
-	return_VOID;
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ex_exit_interpreter
  *
  * PARAMETERS:  None
@@ -139,7 +108,16 @@ void acpi_ex_reacquire_interpreter(void)
  *
  * DESCRIPTION: Exit the interpreter execution region. This is the top level
  *              routine used to exit the interpreter when all processing has
- *              been completed.
+ *              been completed, or when the method blocks.
+ *
+ * Cases where the interpreter is unlocked internally:
+ *      1) Method will be blocked on a Sleep() AML opcode
+ *      2) Method will be blocked on an Acquire() AML opcode
+ *      3) Method will be blocked on a Wait() AML opcode
+ *      4) Method will be blocked to acquire the global lock
+ *      5) Method will be blocked waiting to execute a serialized control
+ *          method that is currently executing
+ *      6) About to invoke a user-installed opregion handler
  *
  ******************************************************************************/
 
@@ -160,44 +138,6 @@ void acpi_ex_exit_interpreter(void)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ex_relinquish_interpreter
- *
- * PARAMETERS:  None
- *
- * RETURN:      None
- *
- * DESCRIPTION: Exit the interpreter execution region, from within the
- *              interpreter - before attempting an operation that will possibly
- *              block the running thread.
- *
- * Cases where the interpreter is unlocked internally
- *      1) Method to be blocked on a Sleep() AML opcode
- *      2) Method to be blocked on an Acquire() AML opcode
- *      3) Method to be blocked on a Wait() AML opcode
- *      4) Method to be blocked to acquire the global lock
- *      5) Method to be blocked waiting to execute a serialized control method
- *          that is currently executing
- *      6) About to invoke a user-installed opregion handler
- *
- ******************************************************************************/
-
-void acpi_ex_relinquish_interpreter(void)
-{
-	ACPI_FUNCTION_TRACE(ex_relinquish_interpreter);
-
-	/*
-	 * If the global serialized flag is set, do not release the interpreter.
-	 * This forces the interpreter to be single threaded.
-	 */
-	if (!acpi_gbl_all_methods_serialized) {
-		acpi_ex_exit_interpreter();
-	}
-
-	return_VOID;
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ex_truncate_for32bit_table
  *
  * PARAMETERS:  obj_desc        - Object to be truncated
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 0d7b714..a35928f 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1539,17 +1539,27 @@ static int __init osi_setup(char *str)
 
 __setup("acpi_osi=", osi_setup);
 
-/* enable serialization to combat AE_ALREADY_EXISTS errors */
+/*
+ * Configure the auto-serialization of named objects creation methods.
+ *
+ * This feature is enabled by default.  It marks the AML control methods
+ * that contain the opcodes to create named objects as "Serialized".
+ */
 static int __init acpi_serialize_setup(char *str)
 {
-	printk(KERN_INFO PREFIX "serialize enabled\n");
 
-	acpi_gbl_all_methods_serialized = TRUE;
+	if (str && !strcmp("on", str)) {
+		acpi_gbl_auto_serialize_methods = TRUE;
+		pr_info("ACPI: auto-serialization enabled\n");
+	} else if (str && !strcmp("off", str)) {
+		acpi_gbl_auto_serialize_methods = FALSE;
+		pr_info("ACPI: auto-serialization disabled\n");
+	}
 
 	return 1;
 }
 
-__setup("acpi_serialize", acpi_serialize_setup);
+__setup("acpi_serialize=", acpi_serialize_setup);
 
 /* Check of resource interference between native drivers and ACPI
  * OperationRegions (SystemIO and System Memory only).
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 3587768..02c85cd 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -74,7 +74,6 @@ extern u32 acpi_dbg_layer;
 /* ACPICA runtime options */
 
 extern u8 acpi_gbl_auto_serialize_methods;
-extern u8 acpi_gbl_all_methods_serialized;
 extern u8 acpi_gbl_copy_dsdt_locally;
 extern u8 acpi_gbl_create_osi_method;
 extern u8 acpi_gbl_disable_auto_repair;
-- 
1.7.10

