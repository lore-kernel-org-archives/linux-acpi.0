From: Len Brown <lenb@kernel.org>
Subject: [PATCH 089/171] ACPI: re-name acpi_pm_ops to acpi_suspend_ops
Date: Tue, 29 Apr 2008 04:44:10 -0400
Message-ID: <13637711ff6647e661939f26d7657f4d3ed01b22.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:1417 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760387AbYD2IpI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:08 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

... as they are platform_suspend_ops after all.

cosmetic re-name only, no functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

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
-- 
1.5.5.1.99.gf0ec4

