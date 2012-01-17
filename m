From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] intel_idle: Split up and provide per CPU initialization func
Date: Tue, 17 Jan 2012 22:40:08 +0100
Message-ID: <1326836408-23177-3-git-send-email-trenn@suse.de>
References: <1326836408-23177-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53864 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755945Ab2AQVkP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 16:40:15 -0500
In-Reply-To: <1326836408-23177-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org
Cc: shaohua.li@intel.com, Thomas Renninger <trenn@suse.de>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

Function split up, should have no functional change.

Provides entry point for physically hotplugged CPUs
to initialize and activate cpuidle.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
CC: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
CC: Shaohua Li <shaohua.li@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/idle/intel_idle.c |   82 +++++++++++++++++++++++----------------------
 include/linux/cpuidle.h   |    7 ++++
 2 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 91aff18..20bce51 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -478,64 +478,60 @@ static int intel_idle_cpuidle_driver_init(void)
 
 
 /*
- * intel_idle_cpuidle_devices_init()
+ * intel_idle_cpu_init()
  * allocate, initialize, register cpuidle_devices
+ * @cpu: cpu/core to initialize
  */
-static int intel_idle_cpuidle_devices_init(void)
+int intel_idle_cpu_init(int cpu)
 {
-	int i, cstate;
+	int cstate;
 	struct cpuidle_device *dev;
 
-	intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
-	if (intel_idle_cpuidle_devices == NULL)
-		return -ENOMEM;
-
-	for_each_online_cpu(i) {
-		dev = per_cpu_ptr(intel_idle_cpuidle_devices, i);
+	dev = per_cpu_ptr(intel_idle_cpuidle_devices, cpu);
 
-		dev->state_count = 1;
+	dev->state_count = 1;
 
-		for (cstate = 1; cstate < MWAIT_MAX_NUM_CSTATES; ++cstate) {
-			int num_substates;
+	for (cstate = 1; cstate < MWAIT_MAX_NUM_CSTATES; ++cstate) {
+		int num_substates;
 
-			if (cstate > max_cstate) {
-				printk(PREFIX "max_cstate %d reached\n",
-					max_cstate);
-				break;
-			}
+		if (cstate > max_cstate) {
+			printk(PREFIX "max_cstate %d reached\n",
+			       max_cstate);
+			break;
+		}
 
-			/* does the state exist in CPUID.MWAIT? */
-			num_substates = (mwait_substates >> ((cstate) * 4))
-						& MWAIT_SUBSTATE_MASK;
-			if (num_substates == 0)
-				continue;
-			/* is the state not enabled? */
-			if (cpuidle_state_table[cstate].enter == NULL) {
-				continue;
-			}
+		/* does the state exist in CPUID.MWAIT? */
+		num_substates = (mwait_substates >> ((cstate) * 4))
+			& MWAIT_SUBSTATE_MASK;
+		if (num_substates == 0)
+			continue;
+		/* is the state not enabled? */
+		if (cpuidle_state_table[cstate].enter == NULL)
+			continue;
 
-			dev->states_usage[dev->state_count].driver_data =
-				(void *)get_driver_data(cstate);
+		dev->states_usage[dev->state_count].driver_data =
+			(void *)get_driver_data(cstate);
 
 			dev->state_count += 1;
 		}
+	dev->cpu = cpu;
 
-		dev->cpu = i;
-		if (cpuidle_register_device(dev)) {
-			pr_debug(PREFIX "cpuidle_register_device %d failed!\n",
-				 i);
-			intel_idle_cpuidle_devices_uninit();
-			return -EIO;
-		}
+	if (cpuidle_register_device(dev)) {
+		pr_debug(PREFIX "cpuidle_register_device %d failed!\n", cpu);
+		intel_idle_cpuidle_devices_uninit();
+		return -EIO;
 	}
 
+	if (auto_demotion_disable_flags)
+		smp_call_function_single(cpu, auto_demotion_disable, NULL, 1);
+
 	return 0;
 }
 
 
 static int __init intel_idle_init(void)
 {
-	int retval;
+	int retval, i;
 
 	/* Do not load intel_idle at all for now if idle= is passed */
 	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
@@ -553,10 +549,16 @@ static int __init intel_idle_init(void)
 		return retval;
 	}
 
-	retval = intel_idle_cpuidle_devices_init();
-	if (retval) {
-		cpuidle_unregister_driver(&intel_idle_driver);
-		return retval;
+	intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
+	if (intel_idle_cpuidle_devices == NULL)
+		return -ENOMEM;
+
+	for_each_online_cpu(i) {
+		retval = intel_idle_cpu_init(i);
+		if (retval) {
+			cpuidle_unregister_driver(&intel_idle_driver);
+			return retval;
+		}
 	}
 
 	return 0;
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 7408af8..93df66e 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -188,7 +188,14 @@ struct cpuidle_governor {
 extern int cpuidle_register_governor(struct cpuidle_governor *gov);
 extern void cpuidle_unregister_governor(struct cpuidle_governor *gov);
 
+#ifdef CONFIG_INTEL_IDLE
+extern int intel_idle_cpu_init(int cpu);
 #else
+static inline int intel_idle_cpu_init(int cpu) { return -1; }
+#endif
+
+#else
+static inline int intel_idle_cpu_init(int cpu) { return -1; }
 
 static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
 {return 0;}
-- 
1.7.6.1

