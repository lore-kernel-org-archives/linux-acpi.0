From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI : Add the support for _TTS object
Date: Tue, 12 Aug 2008 10:20:22 +0800
Message-ID: <1218507622.3998.14.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7684 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbYHLCGc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 22:06:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Subject: ACPI : Add the support for _TTS object
>From : Zhao Yakui <yakui.zhao@intel.com>

    The _TTS object is defined in the section 7.3 of acpi 3.0b spec.
    The _TTS control method is executed by the OSPM at the beginning of 
the sleep transition process for S1,S2, S3, S4, and orderly S5 shutdown.
OS will invoke _TTS before it has notified any native mode device drivers
of the sleep state transition. The target sleeping state value is passed to
the _TTS control method.

    The _TTS control method is also executed by the OSPM at the end of 
any sleep transition process when the system transitions to S0 from 
S1, S2, S3, or S4. The _TTS object should be evaluated after it has 
notified any native mode device drivers of the end of the sleep state 
transition. The working state value (0) is passed to the _TTS control method.
    
    So it is necessary to add the support for _TTS object. The _TTS object
will be evaluated if it exists.
    At the same time a block notifier is added to the reboot notifier list so
that the _TTS object will also be evaluated when the system shutdown.

http://bugzilla.kernel.org/show_bug.cgi?id=11132

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 drivers/acpi/sleep/main.c |   49 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -15,6 +15,7 @@
 #include <linux/dmi.h>
 #include <linux/device.h>
 #include <linux/suspend.h>
+#include <linux/reboot.h>
 
 #include <asm/io.h>
 
@@ -24,6 +25,36 @@
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
 
+static void acpi_sleep_tts_switch(u32 acpi_state)
+{
+	union acpi_object in_arg = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list arg_list = { 1, &in_arg };
+	acpi_status status = AE_OK;
+
+	in_arg.integer.value = acpi_state;
+	status = acpi_evaluate_object(NULL, "\\_TTS", &arg_list, NULL);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+		/*
+		 * OS can't evaluate the _TTS object correctly. Some warning
+		 * message will be printed. But it won't break anything.
+		 */
+		printk(KERN_NOTICE "Failure in evaluating _TTS object\n");
+	}
+}
+
+static int tts_notify_reboot(struct notifier_block *this,
+			unsigned long code, void *x)
+{
+	acpi_sleep_tts_switch(ACPI_STATE_S5);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block tts_notifier = {
+	.notifier_call	= tts_notify_reboot,
+	.next		= NULL,
+	.priority	= 0,
+};
+
 static int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
@@ -131,6 +162,7 @@ static void acpi_pm_end(void)
 	 * failing transition to a sleep state.
 	 */
 	acpi_target_sleep_state = ACPI_STATE_S0;
+	acpi_sleep_tts_switch(acpi_target_sleep_state);
 }
 #endif /* CONFIG_PM_SLEEP */
 
@@ -155,6 +187,7 @@ static int acpi_suspend_begin(suspend_st
 
 	if (sleep_states[acpi_state]) {
 		acpi_target_sleep_state = acpi_state;
+		acpi_sleep_tts_switch(acpi_target_sleep_state);
 	} else {
 		printk(KERN_ERR "ACPI does not support this state: %d\n",
 			pm_state);
@@ -313,6 +346,7 @@ void __init acpi_no_s4_hw_signature(void
 static int acpi_hibernation_begin(void)
 {
 	acpi_target_sleep_state = ACPI_STATE_S4;
+	acpi_sleep_tts_switch(acpi_target_sleep_state);
 	return 0;
 }
 
@@ -376,7 +410,15 @@ static struct platform_hibernation_ops a
  */
 static int acpi_hibernation_begin_old(void)
 {
-	int error = acpi_sleep_prepare(ACPI_STATE_S4);
+	int error;
+	/*
+	 * The _TTS object should always be evaluated before the _PTS object.
+	 * When the old_suspended_ordering is true, the _PTS object is
+	 * evaluated in the acpi_sleep_prepare.
+	 */
+	acpi_sleep_tts_switch(ACPI_STATE_S4);
+
+	error = acpi_sleep_prepare(ACPI_STATE_S4);
 
 	if (!error)
 		acpi_target_sleep_state = ACPI_STATE_S4;
@@ -596,5 +638,10 @@ int __init acpi_sleep_init(void)
 		pm_power_off = acpi_power_off;
 	}
 	printk(")\n");
+	/*
+	 * Register the tts_notifier to reboot notifier list so that the _TTS
+	 * object can also be evaluated when the system enters S5.
+	 */
+	register_reboot_notifier(&tts_notifier);
 	return 0;
 }


