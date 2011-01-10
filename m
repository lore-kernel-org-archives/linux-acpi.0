From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH]intel_idle: open broadcast clock event - resend
Date: Mon, 10 Jan 2011 09:38:12 +0800
Message-ID: <1294623493.1949.589.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15567 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772Ab1AJBiz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Jan 2011 20:38:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

last post is lost, resend it.


Intel_idle driver uses CLOCK_EVT_NOTIFY_BROADCAST_ENTER/CLOCK_EVT_NOTIFY_BROADCAST_EXIT
for broadcast clock events. The _ENTER/_EXIT doesn't really open broadcast clock
events, please see processor_idle.c for an example. In some situation, this will
cause boot hang, because some CPUs enters idle but local APIC timer stalls.

Reported-and-tested-by: Yan Zheng <zheng.z.yan@intel.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>

---
 drivers/idle/intel_idle.c |   47 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

Index: linux/drivers/idle/intel_idle.c
===================================================================
--- linux.orig/drivers/idle/intel_idle.c	2011-01-10 09:27:07.000000000 +0800
+++ linux/drivers/idle/intel_idle.c	2011-01-10 09:29:59.000000000 +0800
@@ -59,6 +59,8 @@
 #include <linux/hrtimer.h>	/* ktime_get_real() */
 #include <trace/events/power.h>
 #include <linux/sched.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 #include <asm/mwait.h>
 
 #define INTEL_IDLE_VERSION "0.4"
@@ -73,6 +75,7 @@ static int max_cstate = MWAIT_MAX_NUM_CS
 
 static unsigned int mwait_substates;
 
+#define LAPIC_TIMER_ALWAYS_RELIABLE 0xFFFFFFFF
 /* Reliable LAPIC Timer States, bit 1 for C1 etc.  */
 static unsigned int lapic_timer_reliable_states = (1 << 1);	 /* Default to only C1 */
 
@@ -243,6 +246,39 @@ static int intel_idle(struct cpuidle_dev
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
@@ -305,7 +341,11 @@ static int intel_idle_probe(void)
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
@@ -428,6 +468,11 @@ static void __exit intel_idle_exit(void)
 	intel_idle_cpuidle_devices_uninit();
 	cpuidle_unregister_driver(&intel_idle_driver);
 
+	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE) {
+		smp_call_function(__setup_broadcast_timer, (void *)false, 1);
+		unregister_cpu_notifier(&setup_broadcast_notifier);
+	}
+
 	return;
 }
 


