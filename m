From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: re-name acpi_pm_ops to acpi_suspend_ops
Date: Tue, 29 Apr 2008 10:20:32 -0400
Message-ID: <200804291020.33068.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43104 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765975AbYD2OV0 (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 10:21:26 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Linux-acpi@vger.kernel.org

Pavel, Rafael,
I re-named the acpi_pm_* ops to be acpi_suspend_* below.

I think also that main.c isn't the best name for this file,
how about acpi_platform_suspend.c, or maybe just acpi_suspend.c?

thanks,
-Len

commit 2c6e33c366bff2f839df60d9235ff09143e28dd9
Author: Len Brown <len.brown@intel.com>
Date:   Wed Apr 23 18:02:52 2008 -0400

    ACPI: re-name acpi_pm_ops to acpi_suspend_ops
    
    ... as they are platform_suspend_ops after all.
    
    cosmetic re-name only, no functional change.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 71183ee..c3b0cd8 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -51,7 +51,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
 }
 
 #ifdef CONFIG_SUSPEND
-static struct platform_suspend_ops acpi_pm_ops;
+static struct platform_suspend_ops acpi_suspend_ops;
 
 extern void do_suspend_lowlevel(void);
 
@@ -65,11 +65,11 @@ static u32 acpi_suspend_states[] = {
 static int init_8259A_after_S1;
 
 /**
- *	acpi_pm_begin - Set the target system sleep state to the state
+ *	acpi_suspend_begin - Set the target system sleep state to the state
  *		associated with given @pm_state, if supported.
  */
 
-static int acpi_pm_begin(suspend_state_t pm_state)
+static int acpi_suspend_begin(suspend_state_t pm_state)
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
 	int error = 0;
@@ -85,13 +85,13 @@ static int acpi_pm_begin(suspend_state_t pm_state)
 }
 
 /**
- *	acpi_pm_prepare - Do preliminary suspend work.
+ *	acpi_suspend_prepare - Do preliminary suspend work.
  *
  *	If necessary, set the firmware waking vector and do arch-specific
  *	nastiness to get the wakeup code to the waking vector.
  */
 
-static int acpi_pm_prepare(void)
+static int acpi_suspend_prepare(void)
 {
 	int error = acpi_sleep_prepare(acpi_target_sleep_state);
 
@@ -104,7 +104,7 @@ static int acpi_pm_prepare(void)
 }
 
 /**
- *	acpi_pm_enter - Actually enter a sleep state.
+ *	acpi_suspend_enter - Actually enter a sleep state.
  *	@pm_state: ignored
  *
  *	Flush caches and go to sleep. For STR we have to call arch-specific
@@ -112,7 +112,7 @@ static int acpi_pm_prepare(void)
  *	It's unfortunate, but it works. Please fix if you're feeling frisky.
  */
 
-static int acpi_pm_enter(suspend_state_t pm_state)
+static int acpi_suspend_enter(suspend_state_t pm_state)
 {
 	acpi_status status = AE_OK;
 	unsigned long flags = 0;
@@ -169,13 +169,13 @@ static int acpi_pm_enter(suspend_state_t pm_state)
 }
 
 /**
- *	acpi_pm_finish - Instruct the platform to leave a sleep state.
+ *	acpi_suspend_finish - Instruct the platform to leave a sleep state.
  *
  *	This is called after we wake back up (or if entering the sleep state
  *	failed). 
  */
 
-static void acpi_pm_finish(void)
+static void acpi_suspend_finish(void)
 {
 	u32 acpi_state = acpi_target_sleep_state;
 
@@ -196,19 +196,19 @@ static void acpi_pm_finish(void)
 }
 
 /**
- *	acpi_pm_end - Finish up suspend sequence.
+ *	acpi_suspend_end - Finish up suspend sequence.
  */
 
-static void acpi_pm_end(void)
+static void acpi_suspend_end(void)
 {
 	/*
-	 * This is necessary in case acpi_pm_finish() is not called during a
+	 * This is necessary in case acpi_suspend_finish() is not called during a
 	 * failing transition to a sleep state.
 	 */
 	acpi_target_sleep_state = ACPI_STATE_S0;
 }
 
-static int acpi_pm_state_valid(suspend_state_t pm_state)
+static int acpi_suspend_state_valid(suspend_state_t pm_state)
 {
 	u32 acpi_state;
 
@@ -224,13 +224,13 @@ static int acpi_pm_state_valid(suspend_state_t pm_state)
 	}
 }
 
-static struct platform_suspend_ops acpi_pm_ops = {
-	.valid = acpi_pm_state_valid,
-	.begin = acpi_pm_begin,
-	.prepare = acpi_pm_prepare,
-	.enter = acpi_pm_enter,
-	.finish = acpi_pm_finish,
-	.end = acpi_pm_end,
+static struct platform_suspend_ops acpi_suspend_ops = {
+	.valid = acpi_suspend_state_valid,
+	.begin = acpi_suspend_begin,
+	.prepare = acpi_suspend_prepare,
+	.enter = acpi_suspend_enter,
+	.finish = acpi_suspend_finish,
+	.end = acpi_suspend_end,
 };
 
 /*
@@ -492,7 +492,7 @@ int __init acpi_sleep_init(void)
 		}
 	}
 
-	suspend_set_ops(&acpi_pm_ops);
+	suspend_set_ops(&acpi_suspend_ops);
 #endif
 
 #ifdef CONFIG_HIBERNATION
