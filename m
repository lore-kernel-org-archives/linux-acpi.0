From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch]intel_idle: open broadcast clock event
Date: Fri, 31 Dec 2010 16:14:47 +0800
Message-ID: <1293783287.10593.61.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:56363 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab0LaIPM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Dec 2010 03:15:12 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Yan, Zheng Z" <zheng.z.yan@intel.com>

Intel_idle driver doesn't open broadcast clock events which will cause
boot hang.

Reported-and-tested-by: Yan Zheng <zheng.z.yan@intel.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c131d58..9e1017a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -59,6 +59,8 @@
 #include <linux/hrtimer.h>	/* ktime_get_real() */
 #include <trace/events/power.h>
 #include <linux/sched.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 #include <asm/mwait.h>
 
 #define INTEL_IDLE_VERSION "0.4"
@@ -73,6 +75,7 @@ static int max_cstate = MWAIT_MAX_NUM_CSTATES - 1;
 
 static unsigned int mwait_substates;
 
+#define LAPIC_TIMER_ALWAYS_RELIABLE 0xFFFFFFFF
 /* Reliable LAPIC Timer States, bit 1 for C1 etc.  */
 static unsigned int lapic_timer_reliable_states = (1 << 1);	 /* Default to only C1 */
 
@@ -244,6 +247,39 @@ static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state)
 	return usec_delta;
 }
 
+static void __setup_broadcast_timer(void *arg)
+{
+	unsigned long reason = (unsigned long)arg;
+	int cpu = smp_processor_id();
+
+	reason = reason ?
+		CLOCK_EVT_NOTIFY_BROADCAST_ON : CLOCK_EVT_NOTIFY_BROADCAST_OFF;
+
+	clockevents_notify(reason, &cpu);
+}
+
+static int __cpuinit setup_broadcast_cpuhp_notify(struct notifier_block *n,
+		unsigned long action, void *hcpu)
+{
+	int hotcpu = (unsigned long)hcpu;
+
+	switch (action & 0xf) {
+	case CPU_ONLINE:
+		smp_call_function_single(hotcpu, __setup_broadcast_timer,
+			(void *)true, 1);
+		break;
+	case CPU_DOWN_PREPARE:
+		smp_call_function_single(hotcpu, __setup_broadcast_timer,
+			(void *)false, 1);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata setup_broadcast_notifier = {
+	.notifier_call = setup_broadcast_cpuhp_notify,
+};
+
 /*
  * intel_idle_probe()
  */
@@ -306,7 +342,11 @@ static int intel_idle_probe(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
-		lapic_timer_reliable_states = 0xFFFFFFFF;
+		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
+	else {
+		smp_call_function(__setup_broadcast_timer, (void *)true, 1);
+		register_cpu_notifier(&setup_broadcast_notifier);
+	}
 
 	pr_debug(PREFIX "v" INTEL_IDLE_VERSION
 		" model 0x%X\n", boot_cpu_data.x86_model);
@@ -429,6 +469,11 @@ static void __exit intel_idle_exit(void)
 	intel_idle_cpuidle_devices_uninit();
 	cpuidle_unregister_driver(&intel_idle_driver);
 
+	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE) {
+		smp_call_function(__setup_broadcast_timer, (void *)false, 1);
+		unregister_cpu_notifier(&setup_broadcast_notifier);
+	}
+
 	return;
 }
 


