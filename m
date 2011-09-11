From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/5] intel_idle: Split up and provide per CPU initialization func
Date: Mon, 12 Sep 2011 01:42:28 +0200
Message-ID: <1315784551-39118-3-git-send-email-trenn@suse.de>
References: <1315784551-39118-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48666 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059Ab1IKXmn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Sep 2011 19:42:43 -0400
In-Reply-To: <1315784551-39118-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>

Function split up, should have no functional change

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
---
 drivers/idle/intel_idle.c |  108 +++++++++++++++++++++-----------------------
 include/linux/cpuidle.h   |    7 +++
 2 files changed, 59 insertions(+), 56 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5b0e456..1c0d132 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -398,77 +398,67 @@ static void intel_idle_cpuidle_devices_uninit(void)
 	return;
 }
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
+	dev = per_cpu_ptr(intel_idle_cpuidle_devices, cpu);
 
-	for_each_online_cpu(i) {
-		dev = per_cpu_ptr(intel_idle_cpuidle_devices, i);
+	dev->state_count = 1;
 
-		dev->state_count = 1;
-
-		for (cstate = 1; cstate < MWAIT_MAX_NUM_CSTATES; ++cstate) {
-			int num_substates;
-
-			if (cstate > max_cstate) {
-				printk(PREFIX "max_cstate %d reached\n",
-					max_cstate);
-				break;
-			}
-
-			/* does the state exist in CPUID.MWAIT? */
-			num_substates = (mwait_substates >> ((cstate) * 4))
-						& MWAIT_SUBSTATE_MASK;
-			if (num_substates == 0)
-				continue;
-			/* is the state not enabled? */
-			if (cpuidle_state_table[cstate].enter == NULL) {
-				/* does the driver not know about the state? */
-				if (*cpuidle_state_table[cstate].name == '\0')
-					pr_debug(PREFIX "unaware of model 0x%x"
-						" MWAIT %d please"
-						" contact lenb@kernel.org",
-					boot_cpu_data.x86_model, cstate);
-				continue;
-			}
-
-			if ((cstate > 2) &&
-				!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
-				mark_tsc_unstable("TSC halts in idle"
-					" states deeper than C2");
-
-			dev->states[dev->state_count] =	/* structure copy */
-				cpuidle_state_table[cstate];
-
-			dev->state_count += 1;
+	for (cstate = 1; cstate < MWAIT_MAX_NUM_CSTATES; ++cstate) {
+		int num_substates;
+
+		if (cstate > max_cstate) {
+			printk(PREFIX "max_cstate %d reached\n", max_cstate);
+			break;
 		}
 
-		dev->cpu = i;
-		if (cpuidle_register_device(dev)) {
-			pr_debug(PREFIX "cpuidle_register_device %d failed!\n",
-				 i);
-			intel_idle_cpuidle_devices_uninit();
-			return -EIO;
+		/* does the state exist in CPUID.MWAIT? */
+		num_substates = (mwait_substates >> ((cstate) * 4))
+			& MWAIT_SUBSTATE_MASK;
+		if (num_substates == 0)
+			continue;
+		/* is the state not enabled? */
+		if (cpuidle_state_table[cstate].enter == NULL) {
+			/* does the driver not know about the state? */
+			if (*cpuidle_state_table[cstate].name == '\0')
+				pr_debug(PREFIX "unaware of model 0x%x  MWAIT "
+					 "%d please contact lenb@kernel.org",
+					 boot_cpu_data.x86_model, cstate);
+			continue;
 		}
+
+		if ((cstate > 2) && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+			mark_tsc_unstable("TSC halts in idle"
+					  " states deeper than C2");
+
+		dev->states[dev->state_count] =	/* structure copy */
+			cpuidle_state_table[cstate];
+		dev->state_count += 1;
+	}
+	dev->cpu = cpu;
+	if (cpuidle_register_device(dev)) {
+		pr_debug(PREFIX "cpuidle_register_device %d failed!\n", cpu);
+		intel_idle_cpuidle_devices_uninit();
+		return -EIO;
 	}
 	if (auto_demotion_disable_flags)
-		smp_call_function(auto_demotion_disable, NULL, 1);
+		smp_call_function_single(cpu, auto_demotion_disable, NULL, 1);
 
 	return 0;
 }
+EXPORT_SYMBOL(intel_idle_cpu_init);
 
 
 static int __init intel_idle_init(void)
 {
-	int retval;
+	int retval, i;
 
 	/* Do not load intel_idle at all for now if idle= is passed */
 	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
@@ -485,10 +475,16 @@ static int __init intel_idle_init(void)
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
index b51629e..15bd1bd 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -179,7 +179,14 @@ struct cpuidle_governor {
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

