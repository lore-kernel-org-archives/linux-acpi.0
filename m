From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 2/2]intel_idle: disable auto_demotion for hotpluged CPUs
Date: Fri, 03 Jun 2011 10:42:40 +0800
Message-ID: <1307068960.15392.53.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:24364 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278Ab1FCCmm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Jun 2011 22:42:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

auto_demotion_disable is called only for online CPUs. For hotpluged CPU,
we should disable it too.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/idle/intel_idle.c |   53 ++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

Index: linux/drivers/idle/intel_idle.c
===================================================================
--- linux.orig/drivers/idle/intel_idle.c	2011-06-03 10:09:24.000000000 +0800
+++ linux/drivers/idle/intel_idle.c	2011-06-03 10:23:51.000000000 +0800
@@ -270,33 +270,42 @@ static void __setup_broadcast_timer(void
 	clockevents_notify(reason, &cpu);
 }
 
-static int setup_broadcast_cpuhp_notify(struct notifier_block *n,
+static void auto_demotion_disable(void *dummy)
+{
+	unsigned long long msr_bits;
+
+	rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+	msr_bits &= ~auto_demotion_disable_flags;
+	wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+}
+
+static void __intel_idle_notify_handler(void *arg)
+{
+	if (auto_demotion_disable_flags)
+		auto_demotion_disable(NULL);
+
+	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
+		__setup_broadcast_timer((void *)true);
+}
+
+static int setup_intelidle_cpuhp_notify(struct notifier_block *n,
 		unsigned long action, void *hcpu)
 {
 	int hotcpu = (unsigned long)hcpu;
 
 	switch (action & 0xf) {
 	case CPU_ONLINE:
-		smp_call_function_single(hotcpu, __setup_broadcast_timer,
-			(void *)true, 1);
+		smp_call_function_single(hotcpu, __intel_idle_notify_handler,
+			NULL, 1);
 		break;
 	}
 	return NOTIFY_OK;
 }
 
-static struct notifier_block setup_broadcast_notifier = {
-	.notifier_call = setup_broadcast_cpuhp_notify,
+static struct notifier_block setup_intelidle_notifier = {
+	.notifier_call = setup_intelidle_cpuhp_notify,
 };
 
-static void auto_demotion_disable(void *dummy)
-{
-	unsigned long long msr_bits;
-
-	rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
-	msr_bits &= ~auto_demotion_disable_flags;
-	wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
-}
-
 /*
  * intel_idle_probe()
  */
@@ -366,10 +375,8 @@ static int intel_idle_probe(void)
 
 	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
 		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
-	else {
+	else
 		on_each_cpu(__setup_broadcast_timer, (void *)true, 1);
-		register_cpu_notifier(&setup_broadcast_notifier);
-	}
 
 	pr_debug(PREFIX "v" INTEL_IDLE_VERSION
 		" model 0x%X\n", boot_cpu_data.x86_model);
@@ -490,6 +497,10 @@ static int __init intel_idle_init(void)
 		return retval;
 	}
 
+	if (auto_demotion_disable_flags || lapic_timer_reliable_states !=
+	    LAPIC_TIMER_ALWAYS_RELIABLE)
+		register_cpu_notifier(&setup_intelidle_notifier);
+
 	return 0;
 }
 
@@ -498,10 +509,12 @@ static void __exit intel_idle_exit(void)
 	intel_idle_cpuidle_devices_uninit();
 	cpuidle_unregister_driver(&intel_idle_driver);
 
-	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE) {
+	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
 		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
-		unregister_cpu_notifier(&setup_broadcast_notifier);
-	}
+
+	if (auto_demotion_disable_flags || lapic_timer_reliable_states !=
+	    LAPIC_TIMER_ALWAYS_RELIABLE)
+		unregister_cpu_notifier(&setup_intelidle_notifier);
 
 	return;
 }


