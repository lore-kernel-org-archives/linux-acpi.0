From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/84] ACPI: change processors from array to per_cpu variable
Date: Sat, 28 Jun 2008 01:43:09 -0400
Message-ID: <e1d755bbddba413c4050db1bfbe1f7e17dee3002.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:34360 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbYF1Foy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:44:54 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500D9QRMZVC73@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:37:48 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Mike Travis <travis@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Mike Travis <travis@sgi.com>

Change processors from an array sized by NR_CPUS to a per_cpu variable.

Signed-off-by: Mike Travis <travis@sgi.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c       |   20 +++++++++-----------
 drivers/acpi/processor_idle.c       |    8 ++++----
 drivers/acpi/processor_perflib.c    |   18 +++++++++---------
 drivers/acpi/processor_throttling.c |   14 +++++++-------
 include/acpi/processor.h            |    2 +-
 5 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 386e5aa..776d453 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -119,7 +119,7 @@ static const struct file_operations acpi_processor_info_fops = {
 	.release = single_release,
 };
 
-struct acpi_processor *processors[NR_CPUS];
+DEFINE_PER_CPU(struct acpi_processor *, processors);
 struct acpi_processor_errata errata __read_mostly;
 
 /* --------------------------------------------------------------------------
@@ -615,7 +615,7 @@ static int acpi_processor_get_info(struct acpi_processor *pr, unsigned has_uid)
 	return 0;
 }
 
-static void *processor_device_array[NR_CPUS];
+static DEFINE_PER_CPU(void *, processor_device_array);
 
 static int __cpuinit acpi_processor_start(struct acpi_device *device)
 {
@@ -639,15 +639,15 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 	 * ACPI id of processors can be reported wrongly by the BIOS.
 	 * Don't trust it blindly
 	 */
-	if (processor_device_array[pr->id] != NULL &&
-	    processor_device_array[pr->id] != device) {
+	if (per_cpu(processor_device_array, pr->id) != NULL &&
+	    per_cpu(processor_device_array, pr->id) != device) {
 		printk(KERN_WARNING "BIOS reported wrong ACPI id "
 			"for the processor\n");
 		return -ENODEV;
 	}
-	processor_device_array[pr->id] = device;
+	per_cpu(processor_device_array, pr->id) = device;
 
-	processors[pr->id] = pr;
+	per_cpu(processors, pr->id) = pr;
 
 	result = acpi_processor_add_fs(device);
 	if (result)
@@ -750,7 +750,7 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
 		unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
-	struct acpi_processor *pr = processors[cpu];
+	struct acpi_processor *pr = per_cpu(processors, cpu);
 
 	if (action == CPU_ONLINE && pr) {
 		acpi_processor_ppc_has_changed(pr);
@@ -820,8 +820,8 @@ static int acpi_processor_remove(struct acpi_device *device, int type)
 		pr->cdev = NULL;
 	}
 
-	processors[pr->id] = NULL;
-	processor_device_array[pr->id] = NULL;
+	per_cpu(processors, pr->id) = NULL;
+	per_cpu(processor_device_array, pr->id) = NULL;
 	kfree(pr);
 
 	return 0;
@@ -1069,8 +1069,6 @@ static int __init acpi_processor_init(void)
 {
 	int result = 0;
 
-
-	memset(&processors, 0, sizeof(processors));
 	memset(&errata, 0, sizeof(errata));
 
 #ifdef CONFIG_SMP
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 2dd2c1f..c6df957 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -401,7 +401,7 @@ static void acpi_processor_idle(void)
 	 */
 	local_irq_disable();
 
-	pr = processors[smp_processor_id()];
+	pr = __get_cpu_var(processors);
 	if (!pr) {
 		local_irq_enable();
 		return;
@@ -1431,7 +1431,7 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 	struct acpi_processor *pr;
 	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
 
-	pr = processors[smp_processor_id()];
+	pr = __get_cpu_var(processors);
 
 	if (unlikely(!pr))
 		return 0;
@@ -1471,7 +1471,7 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	u32 t1, t2;
 	int sleep_ticks = 0;
 
-	pr = processors[smp_processor_id()];
+	pr = __get_cpu_var(processors);
 
 	if (unlikely(!pr))
 		return 0;
@@ -1549,7 +1549,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	u32 t1, t2;
 	int sleep_ticks = 0;
 
-	pr = processors[smp_processor_id()];
+	pr = __get_cpu_var(processors);
 
 	if (unlikely(!pr))
 		return 0;
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index d80b2d1..b474996 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -89,7 +89,7 @@ static int acpi_processor_ppc_notifier(struct notifier_block *nb,
 	if (event != CPUFREQ_INCOMPATIBLE)
 		goto out;
 
-	pr = processors[policy->cpu];
+	pr = per_cpu(processors, policy->cpu);
 	if (!pr || !pr->performance)
 		goto out;
 
@@ -572,7 +572,7 @@ int acpi_processor_preregister_performance(
 
 	/* Call _PSD for all CPUs */
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr) {
 			/* Look only at processors in ACPI namespace */
 			continue;
@@ -603,7 +603,7 @@ int acpi_processor_preregister_performance(
 	 * domain info.
 	 */
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr)
 			continue;
 
@@ -624,7 +624,7 @@ int acpi_processor_preregister_performance(
 
 	cpus_clear(covered_cpus);
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr)
 			continue;
 
@@ -651,7 +651,7 @@ int acpi_processor_preregister_performance(
 			if (i == j)
 				continue;
 
-			match_pr = processors[j];
+			match_pr = per_cpu(processors, j);
 			if (!match_pr)
 				continue;
 
@@ -680,7 +680,7 @@ int acpi_processor_preregister_performance(
 			if (i == j)
 				continue;
 
-			match_pr = processors[j];
+			match_pr = per_cpu(processors, j);
 			if (!match_pr)
 				continue;
 
@@ -697,7 +697,7 @@ int acpi_processor_preregister_performance(
 
 err_ret:
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr || !pr->performance)
 			continue;
 
@@ -728,7 +728,7 @@ acpi_processor_register_performance(struct acpi_processor_performance
 
 	mutex_lock(&performance_mutex);
 
-	pr = processors[cpu];
+	pr = per_cpu(processors, cpu);
 	if (!pr) {
 		mutex_unlock(&performance_mutex);
 		return -ENODEV;
@@ -766,7 +766,7 @@ acpi_processor_unregister_performance(struct acpi_processor_performance
 
 	mutex_lock(&performance_mutex);
 
-	pr = processors[cpu];
+	pr = per_cpu(processors, cpu);
 	if (!pr) {
 		mutex_unlock(&performance_mutex);
 		return;
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index bb06738..8728782 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -71,7 +71,7 @@ static int acpi_processor_update_tsd_coord(void)
 	 * coordination between all CPUs.
 	 */
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr)
 			continue;
 
@@ -93,7 +93,7 @@ static int acpi_processor_update_tsd_coord(void)
 
 	cpus_clear(covered_cpus);
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr)
 			continue;
 
@@ -119,7 +119,7 @@ static int acpi_processor_update_tsd_coord(void)
 			if (i == j)
 				continue;
 
-			match_pr = processors[j];
+			match_pr = per_cpu(processors, j);
 			if (!match_pr)
 				continue;
 
@@ -152,7 +152,7 @@ static int acpi_processor_update_tsd_coord(void)
 			if (i == j)
 				continue;
 
-			match_pr = processors[j];
+			match_pr = per_cpu(processors, j);
 			if (!match_pr)
 				continue;
 
@@ -172,7 +172,7 @@ static int acpi_processor_update_tsd_coord(void)
 
 err_ret:
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr)
 			continue;
 
@@ -214,7 +214,7 @@ static int acpi_processor_throttling_notifier(unsigned long event, void *data)
 	struct acpi_processor_throttling *p_throttling;
 
 	cpu = p_tstate->cpu;
-	pr = processors[cpu];
+	pr = per_cpu(processors, cpu);
 	if (!pr) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Invalid pr pointer\n"));
 		return 0;
@@ -1035,7 +1035,7 @@ int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
 		 * cpus.
 		 */
 		for_each_cpu_mask(i, online_throttling_cpus) {
-			match_pr = processors[i];
+			match_pr = per_cpu(processors, i);
 			/*
 			 * If the pointer is invalid, we will report the
 			 * error message and continue.
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 06480bc..4a1b66a 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -255,7 +255,7 @@ extern void acpi_processor_unregister_performance(struct
 int acpi_processor_notify_smm(struct module *calling_module);
 
 /* for communication between multiple parts of the processor kernel module */
-extern struct acpi_processor *processors[NR_CPUS];
+DECLARE_PER_CPU(struct acpi_processor *, processors);
 extern struct acpi_processor_errata errata;
 
 void arch_acpi_processor_init_pdc(struct acpi_processor *pr);
-- 
1.5.6.1.89.gd544

