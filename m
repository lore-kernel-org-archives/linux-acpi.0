From: Len Brown <lenb@kernel.org>
Subject: [PATCH 096/112] cpuidle: Add a poll_idle method
Date: Thu,  7 Feb 2008 04:34:58 -0500
Message-ID: <9a0b841586c3c6c846effdbe75885c2ebc0031b0.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758441AbYBGJgy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:54 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "venkatesh.pallipadi@intel.com" <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: venkatesh.pallipadi@intel.com <venkatesh.pallipadi@intel.com>

Add a default poll idle state with 0 latency. Provides an option to users
to use poll_idle by using 0 as the latency requirement.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/Kconfig              |    3 +++
 drivers/acpi/processor_idle.c |    4 +++-
 drivers/cpuidle/cpuidle.c     |   41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h       |   13 ++++++++++---
 4 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e6728bd..fd42650 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -105,6 +105,9 @@ config GENERIC_TIME_VSYSCALL
 	bool
 	default X86_64
 
+config ARCH_HAS_CPU_RELAX
+	def_bool y
+
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool X86_64
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index fea7159..32488e6 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1628,7 +1628,7 @@ struct cpuidle_driver acpi_idle_driver = {
  */
 static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 {
-	int i, count = 0;
+	int i, count = CPUIDLE_DRIVER_STATE_START;
 	struct acpi_processor_cx *cx;
 	struct cpuidle_state *state;
 	struct cpuidle_device *dev = &pr->power.dev;
@@ -1687,6 +1687,8 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 		}
 
 		count++;
+		if (count == CPUIDLE_STATE_MAX)
+			break;
 	}
 
 	dev->state_count = count;
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 2a98d99..2c4b2d4 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -15,6 +15,7 @@
 #include <linux/pm_qos_params.h>
 #include <linux/cpu.h>
 #include <linux/cpuidle.h>
+#include <linux/ktime.h>
 
 #include "cpuidle.h"
 
@@ -180,6 +181,44 @@ void cpuidle_disable_device(struct cpuidle_device *dev)
 
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
+	while (!need_resched())
+		cpu_relax();
+
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
@@ -198,6 +237,8 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 
 	mutex_lock(&cpuidle_lock);
 
+	poll_idle_init(dev);
+
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
 	if ((ret = cpuidle_add_sysfs(sys_dev))) {
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index b0fd85a..385d45b 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
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
 
@@ -178,4 +179,10 @@ static inline void cpuidle_unregister_governor(struct cpuidle_governor *gov) { }
 
 #endif
 
+#ifdef CONFIG_ARCH_HAS_CPU_RELAX
+#define CPUIDLE_DRIVER_STATE_START	1
+#else
+#define CPUIDLE_DRIVER_STATE_START	0
+#endif
+
 #endif /* _LINUX_CPUIDLE_H */
-- 
1.5.4.23.gef5b9

