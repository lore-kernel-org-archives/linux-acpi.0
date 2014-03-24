From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/5] ACPICA: Remove global option to serialize all control methods.
Date: Mon, 24 Mar 2014 14:48:45 +0800
Message-ID: <4934942b049d3757db1d6bbbf9206b9191208cd2.1395638745.git.lv.zheng@intel.com>
References: <cover.1395638745.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61113 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbaCXGtQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Mar 2014 02:49:16 -0400
In-Reply-To: <cover.1395638745.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

According to the reports, the "acpi_serialize" mechanism is broken as:
A. The parallel method calls can still happen when the interpreter lock is
   released under the following conditions:
   1. External callbacks are invoked, for example, by the region handlers,
      the exception handlers, etc.;
   2. Module level execution is performed when Load/LoadTable opcodes are
      executed, and
   3. The _REG control methods are invoked to complete the region
      registrations.
B. For the following situations, the interpreter lock need to be released
   even for a serialized method while currently, the lock-releasing
   operation is marked as a no-op by
   acpi_ex_relinquish/reacquire_interpreter() when this mechanism is
   enabled:
   1. Wait opcode is executed,
   2. Acquire opcode is executed, and
   3. Sleep opcode is executed.

This patch removes this mechanism and the internal
acpi_ex_relinquish/reacquire_interpreter() APIs.  Lv Zheng.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=52191
Signed-off: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/kernel-parameters.txt |    2 -
 drivers/acpi/acpica/acglobal.h      |    8 ----
 drivers/acpi/acpica/acinterp.h      |    4 --
 drivers/acpi/acpica/exsystem.c      |   12 +++---
 drivers/acpi/acpica/exutils.c       |   80 +++++------------------------------
 drivers/acpi/osl.c                  |   12 ------
 include/acpi/acpixf.h               |    1 -
 7 files changed, 16 insertions(+), 103 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index bf0fda0..3eae32f 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -306,8 +306,6 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
 
-	acpi_serialize	[HW,ACPI] force serialization of AML methods
-
 	acpi_skip_timer_override [HW,ACPI]
 			Recognize and ignore IRQ0/pin2 Interrupt Override.
 			For broken nForce2 BIOS resulting in XT-PIC timer.
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 8f40bb9..767556c 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -93,14 +93,6 @@
 ACPI_INIT_GLOBAL(u8, acpi_gbl_enable_interpreter_slack, FALSE);
 
 /*
- * Automatically serialize ALL control methods? Default is FALSE, meaning
- * to use the Serialized/not_serialized method flags on a per method basis.
- * Only change this if the ASL code is poorly written and cannot handle
- * reentrancy even though methods are marked "NotSerialized".
- */
-ACPI_INIT_GLOBAL(u8, acpi_gbl_all_methods_serialized, FALSE);
-
-/*
  * Create the predefined _OSI method in the namespace? Default is TRUE
  * because ACPI CA is fully compatible with other ACPI implementations.
  * Changing this will revert ACPI CA (and machine ASL) to pre-OSI behavior.
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index c542677..b01f71c 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -458,10 +458,6 @@ void acpi_ex_enter_interpreter(void);
 
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
index 821134b..5a16cc6 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1537,18 +1537,6 @@ static int __init osi_setup(char *str)
 
 __setup("acpi_osi=", osi_setup);
 
-/* enable serialization to combat AE_ALREADY_EXISTS errors */
-static int __init acpi_serialize_setup(char *str)
-{
-	printk(KERN_INFO PREFIX "serialize enabled\n");
-
-	acpi_gbl_all_methods_serialized = TRUE;
-
-	return 1;
-}
-
-__setup("acpi_serialize", acpi_serialize_setup);
-
 /* Check of resource interference between native drivers and ACPI
  * OperationRegions (SystemIO and System Memory only).
  * IO ports and memory declared in ACPI might be used by the ACPI subsystem
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index b0b01b1..5c2a82a 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -71,7 +71,6 @@ extern u32 acpi_dbg_layer;
 
 /* ACPICA runtime options */
 
-extern u8 acpi_gbl_all_methods_serialized;
 extern u8 acpi_gbl_copy_dsdt_locally;
 extern u8 acpi_gbl_create_osi_method;
 extern u8 acpi_gbl_disable_auto_repair;
-- 
1.7.10

