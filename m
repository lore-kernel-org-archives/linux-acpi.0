From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] ACPI: delete _GTS/_BFS support
Date: Thu, 26 Jul 2012 20:34:49 -0400
Message-ID: <655f19856d9697f20ebd5db9b05b3789277701a0.1343349012.git.len.brown@intel.com>
References: <1343349289-31179-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64504 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab2G0AfD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jul 2012 20:35:03 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so2252729vbb.19
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jul 2012 17:35:02 -0700 (PDT)
In-Reply-To: <1343349289-31179-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b435faf9f7f1d5b39c65fb4531875c970f1cc6f0.1343349012.git.len.brown@intel.com>
References: <b435faf9f7f1d5b39c65fb4531875c970f1cc6f0.1343349012.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, x86@kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

_GTS and _BFS were added to the suspend/resume flow
in the ACPI 2.0 specification.

Linux dutifully implemented _GTS and _BFS.
We discovered that it was rarely seen in systems
in the field.  Further, some of those systems had
AML so bogus that it could never work -- proof that
no other operating system supports _GTS and _BFS.
So we made _GTS and _BFS optional via modparam,
and disabled them by default.

But we've had to complicate some code to keep
this support in the kernel, as these methods are defined
to be evaluated very close to sleep entry and exit.
Indeed, no other AML is ever evaluated with interrupts off.

We have submitted a proposal for _GTS and _BFS
to be officially removed from the ACPI specification
on the next revision.  Here we remove it from Linux.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/achware.h   | 12 +++----
 drivers/acpi/acpica/hwesleep.c  | 19 ++---------
 drivers/acpi/acpica/hwsleep.c   | 20 ++---------
 drivers/acpi/acpica/hwxfsleep.c | 22 ++++++-------
 drivers/acpi/sleep.c            | 73 +++++------------------------------------
 include/acpi/acpixf.h           |  4 +--
 include/acpi/actypes.h          |  2 +-
 7 files changed, 34 insertions(+), 118 deletions(-)

diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 5ccb99a..5de4ec7 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -83,22 +83,22 @@ acpi_status acpi_hw_clear_acpi_status(void);
 /*
  * hwsleep - sleep/wake support (Legacy sleep registers)
  */
-acpi_status acpi_hw_legacy_sleep(u8 sleep_state, u8 flags);
+acpi_status acpi_hw_legacy_sleep(u8 sleep_state);
 
-acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state, u8 flags);
+acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state);
 
-acpi_status acpi_hw_legacy_wake(u8 sleep_state, u8 flags);
+acpi_status acpi_hw_legacy_wake(u8 sleep_state);
 
 /*
  * hwesleep - sleep/wake support (Extended FADT-V5 sleep registers)
  */
 void acpi_hw_execute_sleep_method(char *method_name, u32 integer_argument);
 
-acpi_status acpi_hw_extended_sleep(u8 sleep_state, u8 flags);
+acpi_status acpi_hw_extended_sleep(u8 sleep_state);
 
-acpi_status acpi_hw_extended_wake_prep(u8 sleep_state, u8 flags);
+acpi_status acpi_hw_extended_wake_prep(u8 sleep_state);
 
-acpi_status acpi_hw_extended_wake(u8 sleep_state, u8 flags);
+acpi_status acpi_hw_extended_wake(u8 sleep_state);
 
 /*
  * hwvalid - Port I/O with validation
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index 48518da..94996f9 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -90,7 +90,6 @@ void acpi_hw_execute_sleep_method(char *method_pathname, u32 integer_argument)
  * FUNCTION:    acpi_hw_extended_sleep
  *
  * PARAMETERS:  sleep_state         - Which sleep state to enter
- *              flags               - ACPI_EXECUTE_GTS to run optional method
  *
  * RETURN:      Status
  *
@@ -100,7 +99,7 @@ void acpi_hw_execute_sleep_method(char *method_pathname, u32 integer_argument)
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_extended_sleep(u8 sleep_state, u8 flags)
+acpi_status acpi_hw_extended_sleep(u8 sleep_state)
 {
 	acpi_status status;
 	u8 sleep_type_value;
@@ -125,12 +124,6 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state, u8 flags)
 
 	acpi_gbl_system_awake_and_running = FALSE;
 
-	/* Optionally execute _GTS (Going To Sleep) */
-
-	if (flags & ACPI_EXECUTE_GTS) {
-		acpi_hw_execute_sleep_method(METHOD_PATHNAME__GTS, sleep_state);
-	}
-
 	/* Flush caches, as per ACPI specification */
 
 	ACPI_FLUSH_CPU_CACHE();
@@ -172,7 +165,6 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state, u8 flags)
  * FUNCTION:    acpi_hw_extended_wake_prep
  *
  * PARAMETERS:  sleep_state         - Which sleep state we just exited
- *              flags               - ACPI_EXECUTE_BFS to run optional method
  *
  * RETURN:      Status
  *
@@ -181,7 +173,7 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state, u8 flags)
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_extended_wake_prep(u8 sleep_state, u8 flags)
+acpi_status acpi_hw_extended_wake_prep(u8 sleep_state)
 {
 	acpi_status status;
 	u8 sleep_type_value;
@@ -200,11 +192,6 @@ acpi_status acpi_hw_extended_wake_prep(u8 sleep_state, u8 flags)
 				 &acpi_gbl_FADT.sleep_control);
 	}
 
-	/* Optionally execute _BFS (Back From Sleep) */
-
-	if (flags & ACPI_EXECUTE_BFS) {
-		acpi_hw_execute_sleep_method(METHOD_PATHNAME__BFS, sleep_state);
-	}
 	return_ACPI_STATUS(AE_OK);
 }
 
@@ -222,7 +209,7 @@ acpi_status acpi_hw_extended_wake_prep(u8 sleep_state, u8 flags)
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_extended_wake(u8 sleep_state, u8 flags)
+acpi_status acpi_hw_extended_wake(u8 sleep_state)
 {
 	ACPI_FUNCTION_TRACE(hw_extended_wake);
 
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 9960fe9..3fddde0 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -56,7 +56,6 @@ ACPI_MODULE_NAME("hwsleep")
  * FUNCTION:    acpi_hw_legacy_sleep
  *
  * PARAMETERS:  sleep_state         - Which sleep state to enter
- *              flags               - ACPI_EXECUTE_GTS to run optional method
  *
  * RETURN:      Status
  *
@@ -64,7 +63,7 @@ ACPI_MODULE_NAME("hwsleep")
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
-acpi_status acpi_hw_legacy_sleep(u8 sleep_state, u8 flags)
+acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
 {
 	struct acpi_bit_register_info *sleep_type_reg_info;
 	struct acpi_bit_register_info *sleep_enable_reg_info;
@@ -110,12 +109,6 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state, u8 flags)
 		return_ACPI_STATUS(status);
 	}
 
-	/* Optionally execute _GTS (Going To Sleep) */
-
-	if (flags & ACPI_EXECUTE_GTS) {
-		acpi_hw_execute_sleep_method(METHOD_PATHNAME__GTS, sleep_state);
-	}
-
 	/* Get current value of PM1A control */
 
 	status = acpi_hw_register_read(ACPI_REGISTER_PM1_CONTROL,
@@ -214,7 +207,6 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state, u8 flags)
  * FUNCTION:    acpi_hw_legacy_wake_prep
  *
  * PARAMETERS:  sleep_state         - Which sleep state we just exited
- *              flags               - ACPI_EXECUTE_BFS to run optional method
  *
  * RETURN:      Status
  *
@@ -224,7 +216,7 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state, u8 flags)
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state, u8 flags)
+acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state)
 {
 	acpi_status status;
 	struct acpi_bit_register_info *sleep_type_reg_info;
@@ -275,11 +267,6 @@ acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state, u8 flags)
 		}
 	}
 
-	/* Optionally execute _BFS (Back From Sleep) */
-
-	if (flags & ACPI_EXECUTE_BFS) {
-		acpi_hw_execute_sleep_method(METHOD_PATHNAME__BFS, sleep_state);
-	}
 	return_ACPI_STATUS(status);
 }
 
@@ -288,7 +275,6 @@ acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state, u8 flags)
  * FUNCTION:    acpi_hw_legacy_wake
  *
  * PARAMETERS:  sleep_state         - Which sleep state we just exited
- *              flags               - Reserved, set to zero
  *
  * RETURN:      Status
  *
@@ -297,7 +283,7 @@ acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state, u8 flags)
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_legacy_wake(u8 sleep_state, u8 flags)
+acpi_status acpi_hw_legacy_wake(u8 sleep_state)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index f8684bf..1f165a7 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -50,7 +50,7 @@ ACPI_MODULE_NAME("hwxfsleep")
 
 /* Local prototypes */
 static acpi_status
-acpi_hw_sleep_dispatch(u8 sleep_state, u8 flags, u32 function_id);
+acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id);
 
 /*
  * Dispatch table used to efficiently branch to the various sleep
@@ -235,7 +235,7 @@ ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios)
  *
  ******************************************************************************/
 static acpi_status
-acpi_hw_sleep_dispatch(u8 sleep_state, u8 flags, u32 function_id)
+acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id)
 {
 	acpi_status status;
 	struct acpi_sleep_functions *sleep_functions =
@@ -248,11 +248,11 @@ acpi_hw_sleep_dispatch(u8 sleep_state, u8 flags, u32 function_id)
 	 * use the extended sleep registers
 	 */
 	if (acpi_gbl_reduced_hardware || acpi_gbl_FADT.sleep_control.address) {
-		status = sleep_functions->extended_function(sleep_state, flags);
+		status = sleep_functions->extended_function(sleep_state);
 	} else {
 		/* Legacy sleep */
 
-		status = sleep_functions->legacy_function(sleep_state, flags);
+		status = sleep_functions->legacy_function(sleep_state);
 	}
 
 	return (status);
@@ -262,7 +262,7 @@ acpi_hw_sleep_dispatch(u8 sleep_state, u8 flags, u32 function_id)
 	 * For the case where reduced-hardware-only code is being generated,
 	 * we know that only the extended sleep registers are available
 	 */
-	status = sleep_functions->extended_function(sleep_state, flags);
+	status = sleep_functions->extended_function(sleep_state);
 	return (status);
 
 #endif				/* !ACPI_REDUCED_HARDWARE */
@@ -349,7 +349,6 @@ ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_prep)
  * FUNCTION:    acpi_enter_sleep_state
  *
  * PARAMETERS:  sleep_state         - Which sleep state to enter
- *              flags               - ACPI_EXECUTE_GTS to run optional method
  *
  * RETURN:      Status
  *
@@ -357,7 +356,7 @@ ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_prep)
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
-acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state, u8 flags)
+acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 {
 	acpi_status status;
 
@@ -371,7 +370,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state, u8 flags)
 	}
 
 	status =
-	    acpi_hw_sleep_dispatch(sleep_state, flags, ACPI_SLEEP_FUNCTION_ID);
+	    acpi_hw_sleep_dispatch(sleep_state, ACPI_SLEEP_FUNCTION_ID);
 	return_ACPI_STATUS(status);
 }
 
@@ -391,14 +390,14 @@ ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state)
  *              Called with interrupts DISABLED.
  *
  ******************************************************************************/
-acpi_status acpi_leave_sleep_state_prep(u8 sleep_state, u8 flags)
+acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 {
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state_prep);
 
 	status =
-	    acpi_hw_sleep_dispatch(sleep_state, flags,
+	    acpi_hw_sleep_dispatch(sleep_state,
 				   ACPI_WAKE_PREP_FUNCTION_ID);
 	return_ACPI_STATUS(status);
 }
@@ -423,8 +422,7 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 
 	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state);
 
-
-	status = acpi_hw_sleep_dispatch(sleep_state, 0, ACPI_WAKE_FUNCTION_ID);
+	status = acpi_hw_sleep_dispatch(sleep_state, ACPI_WAKE_FUNCTION_ID);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 23a53c0..bd35e3c 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -28,34 +28,6 @@
 #include "internal.h"
 #include "sleep.h"
 
-u8 wake_sleep_flags = ACPI_NO_OPTIONAL_METHODS;
-static unsigned int gts, bfs;
-static int set_param_wake_flag(const char *val, struct kernel_param *kp)
-{
-	int ret = param_set_int(val, kp);
-
-	if (ret)
-		return ret;
-
-	if (kp->arg == (const char *)&gts) {
-		if (gts)
-			wake_sleep_flags |= ACPI_EXECUTE_GTS;
-		else
-			wake_sleep_flags &= ~ACPI_EXECUTE_GTS;
-	}
-	if (kp->arg == (const char *)&bfs) {
-		if (bfs)
-			wake_sleep_flags |= ACPI_EXECUTE_BFS;
-		else
-			wake_sleep_flags &= ~ACPI_EXECUTE_BFS;
-	}
-	return ret;
-}
-module_param_call(gts, set_param_wake_flag, param_get_int, &gts, 0644);
-module_param_call(bfs, set_param_wake_flag, param_get_int, &bfs, 0644);
-MODULE_PARM_DESC(gts, "Enable evaluation of _GTS on suspend.");
-MODULE_PARM_DESC(bfs, "Enable evaluation of _BFS on resume".);
-
 static u8 sleep_states[ACPI_S_STATE_COUNT];
 static bool pwr_btn_event_pending;
 
@@ -305,7 +277,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	switch (acpi_state) {
 	case ACPI_STATE_S1:
 		barrier();
-		status = acpi_enter_sleep_state(acpi_state, wake_sleep_flags);
+		status = acpi_enter_sleep_state(acpi_state);
 		break;
 
 	case ACPI_STATE_S3:
@@ -319,8 +291,8 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	/* This violates the spec but is required for bug compatibility. */
 	acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
 
-	/* Reprogram control registers and execute _BFS */
-	acpi_leave_sleep_state_prep(acpi_state, wake_sleep_flags);
+	/* Reprogram control registers */
+	acpi_leave_sleep_state_prep(acpi_state);
 
 	/* ACPI 3.0 specs (P62) says that it's the responsibility
 	 * of the OSPM to clear the status bit [ implying that the
@@ -603,9 +575,9 @@ static int acpi_hibernation_enter(void)
 	ACPI_FLUSH_CPU_CACHE();
 
 	/* This shouldn't return.  If it returns, we have a problem */
-	status = acpi_enter_sleep_state(ACPI_STATE_S4, wake_sleep_flags);
-	/* Reprogram control registers and execute _BFS */
-	acpi_leave_sleep_state_prep(ACPI_STATE_S4, wake_sleep_flags);
+	status = acpi_enter_sleep_state(ACPI_STATE_S4);
+	/* Reprogram control registers */
+	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
 
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
@@ -617,8 +589,8 @@ static void acpi_hibernation_leave(void)
 	 * enable it here.
 	 */
 	acpi_enable();
-	/* Reprogram control registers and execute _BFS */
-	acpi_leave_sleep_state_prep(ACPI_STATE_S4, wake_sleep_flags);
+	/* Reprogram control registers */
+	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
 	/* Check the hardware signature */
 	if (facs && s4_hardware_signature != facs->hardware_signature) {
 		printk(KERN_EMERG "ACPI: Hardware changed while hibernated, "
@@ -876,33 +848,7 @@ static void acpi_power_off(void)
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
 	printk(KERN_DEBUG "%s called\n", __func__);
 	local_irq_disable();
-	acpi_enter_sleep_state(ACPI_STATE_S5, wake_sleep_flags);
-}
-
-/*
- * ACPI 2.0 created the optional _GTS and _BFS,
- * but industry adoption has been neither rapid nor broad.
- *
- * Linux gets into trouble when it executes poorly validated
- * paths through the BIOS, so disable _GTS and _BFS by default,
- * but do speak up and offer the option to enable them.
- */
-static void __init acpi_gts_bfs_check(void)
-{
-	acpi_handle dummy;
-
-	if (ACPI_SUCCESS(acpi_get_handle(ACPI_ROOT_OBJECT, METHOD_PATHNAME__GTS, &dummy)))
-	{
-		printk(KERN_NOTICE PREFIX "BIOS offers _GTS\n");
-		printk(KERN_NOTICE PREFIX "If \"acpi.gts=1\" improves suspend, "
-			"please notify linux-acpi@vger.kernel.org\n");
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(ACPI_ROOT_OBJECT, METHOD_PATHNAME__BFS, &dummy)))
-	{
-		printk(KERN_NOTICE PREFIX "BIOS offers _BFS\n");
-		printk(KERN_NOTICE PREFIX "If \"acpi.bfs=1\" improves resume, "
-			"please notify linux-acpi@vger.kernel.org\n");
-	}
+	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 
 int __init acpi_sleep_init(void)
@@ -963,6 +909,5 @@ int __init acpi_sleep_init(void)
 	 * object can also be evaluated when the system enters S5.
 	 */
 	register_reboot_notifier(&tts_notifier);
-	acpi_gts_bfs_check();
 	return 0;
 }
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 2c744c7..26a92fc 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -491,11 +491,11 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 * slp_typ_a, u8 * slp_typ_b);
 
 acpi_status acpi_enter_sleep_state_prep(u8 sleep_state);
 
-acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state, u8 flags);
+acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state);
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void))
 
-acpi_status acpi_leave_sleep_state_prep(u8 sleep_state, u8 flags);
+acpi_status acpi_leave_sleep_state_prep(u8 sleep_state);
 
 acpi_status acpi_leave_sleep_state(u8 sleep_state);
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 3af87de..3d00bd5 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -803,7 +803,7 @@ typedef u8 acpi_adr_space_type;
 
 /* Sleep function dispatch */
 
-typedef acpi_status(*ACPI_SLEEP_FUNCTION) (u8 sleep_state, u8 flags);
+typedef acpi_status(*ACPI_SLEEP_FUNCTION) (u8 sleep_state);
 
 struct acpi_sleep_functions {
 	ACPI_SLEEP_FUNCTION legacy_function;
-- 
1.7.12.rc0

