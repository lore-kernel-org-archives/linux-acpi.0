From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/3] Revert "intel_idle: disable auto_demotion for hotplugged CPUs"
Date: Tue, 17 Jan 2012 17:31:33 +0100
Message-ID: <1326817895-81436-2-git-send-email-trenn@suse.de>
References: <1326817895-81436-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40501 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754707Ab2AQQbj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 11:31:39 -0500
In-Reply-To: <1326817895-81436-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org
Cc: deepthi@linux.vnet.ibm.com, shaohua.li@intel.com, Thomas Renninger <trenn@suse.de>

This reverts commit e5f03b06dc99348df53118c6ef7b51a8611a7256.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/idle/intel_idle.c |   53 +++++++++++++++++----------------------------
 1 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index e56ae0b..91aff18 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -296,42 +296,33 @@ static void __setup_broadcast_timer(void *arg)
 	clockevents_notify(reason, &cpu);
 }
 
-static void auto_demotion_disable(void *dummy)
-{
-	unsigned long long msr_bits;
-
-	rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
-	msr_bits &= ~auto_demotion_disable_flags;
-	wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
-}
-
-static void __intel_idle_notify_handler(void *arg)
-{
-	if (auto_demotion_disable_flags)
-		auto_demotion_disable(NULL);
-
-	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
-		__setup_broadcast_timer((void *)true);
-}
-
-static int setup_intelidle_cpuhp_notify(struct notifier_block *n,
+static int setup_broadcast_cpuhp_notify(struct notifier_block *n,
 		unsigned long action, void *hcpu)
 {
 	int hotcpu = (unsigned long)hcpu;
 
 	switch (action & 0xf) {
 	case CPU_ONLINE:
-		smp_call_function_single(hotcpu, __intel_idle_notify_handler,
-			NULL, 1);
+		smp_call_function_single(hotcpu, __setup_broadcast_timer,
+			(void *)true, 1);
 		break;
 	}
 	return NOTIFY_OK;
 }
 
-static struct notifier_block setup_intelidle_notifier = {
-	.notifier_call = setup_intelidle_cpuhp_notify,
+static struct notifier_block setup_broadcast_notifier = {
+	.notifier_call = setup_broadcast_cpuhp_notify,
 };
 
+static void auto_demotion_disable(void *dummy)
+{
+	unsigned long long msr_bits;
+
+	rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+	msr_bits &= ~auto_demotion_disable_flags;
+	wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+}
+
 /*
  * intel_idle_probe()
  */
@@ -402,8 +393,10 @@ static int intel_idle_probe(void)
 
 	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
 		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
-	else
+	else {
 		on_each_cpu(__setup_broadcast_timer, (void *)true, 1);
+		register_cpu_notifier(&setup_broadcast_notifier);
+	}
 
 	pr_debug(PREFIX "v" INTEL_IDLE_VERSION
 		" model 0x%X\n", boot_cpu_data.x86_model);
@@ -566,10 +559,6 @@ static int __init intel_idle_init(void)
 		return retval;
 	}
 
-	if (auto_demotion_disable_flags || lapic_timer_reliable_states !=
-	    LAPIC_TIMER_ALWAYS_RELIABLE)
-		register_cpu_notifier(&setup_intelidle_notifier);
-
 	return 0;
 }
 
@@ -578,12 +567,10 @@ static void __exit intel_idle_exit(void)
 	intel_idle_cpuidle_devices_uninit();
 	cpuidle_unregister_driver(&intel_idle_driver);
 
-	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
+	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE) {
 		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
-
-	if (auto_demotion_disable_flags || lapic_timer_reliable_states !=
-	    LAPIC_TIMER_ALWAYS_RELIABLE)
-		unregister_cpu_notifier(&setup_intelidle_notifier);
+		unregister_cpu_notifier(&setup_broadcast_notifier);
+	}
 
 	return;
 }
-- 
1.7.6.1

