From: venkatesh.pallipadi@intel.com
Subject: [patch 4/4] CPUIDLE: Add a poll_idle method into CPU_IDLE
Date: Thu, 31 Jan 2008 17:35:06 -0800
Message-ID: <20080201013629.746981000@intel.com>
References: <20080201013502.750627000@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47472 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934768AbYBABht (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jan 2008 20:37:49 -0500
Content-Disposition: inline; filename=cpuidle_poll_idle.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Add a default poll idle state with 0 latency. Provides an option to users
to use poll_idle by using 0 as the latency requirement.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.25-rc/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.25-rc.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.25-rc/drivers/acpi/processor_idle.c
@@ -1600,7 +1600,7 @@ struct cpuidle_driver acpi_idle_driver =
  */
 static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 {
-	int i, count = 0;
+	int i, count = CPUIDLE_DRIVER_STATE_START;
 	struct acpi_processor_cx *cx;
 	struct cpuidle_state *state;
 	struct cpuidle_device *dev = &pr->power.dev;
@@ -1659,6 +1659,8 @@ static int acpi_processor_setup_cpuidle(
 		}
 
 		count++;
+		if (count == CPUIDLE_STATE_MAX)
+			break;
 	}
 
 	dev->state_count = count;
Index: linux-2.6.25-rc/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-2.6.25-rc.orig/drivers/cpuidle/cpuidle.c
+++ linux-2.6.25-rc/drivers/cpuidle/cpuidle.c
@@ -15,6 +15,7 @@
 #include <linux/latency.h>
 #include <linux/cpu.h>
 #include <linux/cpuidle.h>
+#include <linux/ktime.h>
 
 #include "cpuidle.h"
 
@@ -180,6 +181,44 @@ void cpuidle_disable_device(struct cpuid
 
 EXPORT_SYMBOL_GPL(cpuidle_disable_device);
 
+#ifdef CONFIG_ARCH_HAS_CPU_RELAX
+static int poll_idle(struct cpuidle_device *dev, struct cpuidle_state *st)
+{
+	ktime_t	t1, t2;
+	s64 diff;
+	int ret;
+
+	t1 = ktime_get();
+	local_irq_enable();
+	while (!need_resched()) {
+		cpu_relax();
+	}
+	t2 = ktime_get();
+	diff = ktime_to_us(ktime_sub(t2, t1));
+	if (diff > INT_MAX)
+		diff = INT_MAX;
+
+	ret = (int) diff;
+	return ret;
+}
+
+static void poll_idle_init(struct cpuidle_device *dev)
+{
+	struct cpuidle_state *state = &dev->states[0];
+
+	cpuidle_set_statedata(state, NULL);
+
+	snprintf(state->name, CPUIDLE_NAME_LEN, "C0 (poll idle)");
+	state->exit_latency = 0;
+	state->target_residency = 0;
+	state->power_usage = -1;
+	state->flags = CPUIDLE_FLAG_POLL | CPUIDLE_FLAG_TIME_VALID;
+	state->enter = poll_idle;
+}
+#else
+static void poll_idle_init(struct cpuidle_device *dev) {}
+#endif /* CONFIG_ARCH_HAS_CPU_RELAX */
+
 /**
  * cpuidle_register_device - registers a CPU's idle PM feature
  * @dev: the cpu
@@ -198,6 +237,8 @@ int cpuidle_register_device(struct cpuid
 
 	mutex_lock(&cpuidle_lock);
 
+	poll_idle_init(dev);
+
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
 	if ((ret = cpuidle_add_sysfs(sys_dev))) {
Index: linux-2.6.25-rc/include/linux/cpuidle.h
===================================================================
--- linux-2.6.25-rc.orig/include/linux/cpuidle.h
+++ linux-2.6.25-rc/include/linux/cpuidle.h
@@ -46,9 +46,10 @@ struct cpuidle_state {
 /* Idle State Flags */
 #define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
 #define CPUIDLE_FLAG_CHECK_BM	(0x02) /* BM activity will exit state */
-#define CPUIDLE_FLAG_SHALLOW	(0x10) /* low latency, minimal savings */
-#define CPUIDLE_FLAG_BALANCED	(0x20) /* medium latency, moderate savings */
-#define CPUIDLE_FLAG_DEEP	(0x40) /* high latency, large savings */
+#define CPUIDLE_FLAG_POLL	(0x10) /* no latency, no savings */
+#define CPUIDLE_FLAG_SHALLOW	(0x20) /* low latency, minimal savings */
+#define CPUIDLE_FLAG_BALANCED	(0x40) /* medium latency, moderate savings */
+#define CPUIDLE_FLAG_DEEP	(0x80) /* high latency, large savings */
 
 #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
 
@@ -178,4 +179,10 @@ static inline void cpuidle_unregister_go
 
 #endif
 
+#ifdef CONFIG_ARCH_HAS_CPU_RELAX
+#define CPUIDLE_DRIVER_STATE_START	1
+#else
+#define CPUIDLE_DRIVER_STATE_START	0
+#endif
+
 #endif /* _LINUX_CPUIDLE_H */
Index: linux-2.6.25-rc/arch/x86/Kconfig
===================================================================
--- linux-2.6.25-rc.orig/arch/x86/Kconfig
+++ linux-2.6.25-rc/arch/x86/Kconfig
@@ -112,6 +112,9 @@ config GENERIC_TIME_VSYSCALL
 	bool
 	default X86_64
 
+config ARCH_HAS_CPU_RELAX
+	def_bool y
+
 config ARCH_SUPPORTS_OPROFILE
 	bool
 	default y

-- 
