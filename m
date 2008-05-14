From: akpm@linux-foundation.org
Subject: [patch 08/11] acpi: change processors from array to per_cpu variable
Date: Wed, 14 May 2008 16:09:20 -0700
Message-ID: <200805142309.m4EN9LDv025997@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58485 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752570AbYENXKI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 19:10:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, travis@sgi.com, len.brown@intel.com

From: Mike Travis <travis@sgi.com>

Change processors from an array sized by NR_CPUS to a per_cpu variable.

Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Mike Travis <travis@sgi.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_core.c       |   20 +++++++++-----------
 drivers/acpi/processor_idle.c       |    8 ++++----
 drivers/acpi/processor_perflib.c    |   18 +++++++++---------
 drivers/acpi/processor_throttling.c |   14 +++++++-------
 include/acpi/processor.h            |    2 +-
 5 files changed, 30 insertions(+), 32 deletions(-)

diff -puN drivers/acpi/processor_core.c~acpi-change-processors-from-array-to-per_cpu-variable drivers/acpi/processor_core.c
--- a/drivers/acpi/processor_core.c~acpi-change-processors-from-array-to-per_cpu-variable
+++ a/drivers/acpi/processor_core.c
@@ -119,7 +119,7 @@ static const struct file_operations acpi
 	.release = single_release,
 };
 
-struct acpi_processor *processors[NR_CPUS];
+DEFINE_PER_CPU(struct acpi_processor *, processors);
 struct acpi_processor_errata errata __read_mostly;
 
 /* --------------------------------------------------------------------------
@@ -615,7 +615,7 @@ static int acpi_processor_get_info(struc
 	return 0;
 }
 
-static void *processor_device_array[NR_CPUS];
+static DEFINE_PER_CPU(void *, processor_device_array);
 
 static int __cpuinit acpi_processor_start(struct acpi_device *device)
 {
@@ -639,15 +639,15 @@ static int __cpuinit acpi_processor_star
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
@@ -753,7 +753,7 @@ static int acpi_cpu_soft_notify(struct n
 		unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
-	struct acpi_processor *pr = processors[cpu];
+	struct acpi_processor *pr = per_cpu(processors, cpu);
 
 	if (action == CPU_ONLINE && pr) {
 		acpi_processor_ppc_has_changed(pr);
@@ -825,8 +825,8 @@ static int acpi_processor_remove(struct 
 		pr->cdev = NULL;
 	}
 
-	processors[pr->id] = NULL;
-	processor_device_array[pr->id] = NULL;
+	per_cpu(processors, pr->id) = NULL;
+	per_cpu(processor_device_array, pr->id) = NULL;
 	kfree(pr);
 
 	return 0;
@@ -1074,8 +1074,6 @@ static int __init acpi_processor_init(vo
 {
 	int result = 0;
 
-
-	memset(&processors, 0, sizeof(processors));
 	memset(&errata, 0, sizeof(errata));
 
 #ifdef CONFIG_SMP
diff -puN drivers/acpi/processor_idle.c~acpi-change-processors-from-array-to-per_cpu-variable drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~acpi-change-processors-from-array-to-per_cpu-variable
+++ a/drivers/acpi/processor_idle.c
@@ -419,7 +419,7 @@ static void acpi_processor_idle(void)
 	 */
 	local_irq_disable();
 
-	pr = processors[smp_processor_id()];
+	pr = __get_cpu_var(processors);
 	if (!pr) {
 		local_irq_enable();
 		return;
@@ -1450,7 +1450,7 @@ static int acpi_idle_enter_c1(struct cpu
 	struct acpi_processor *pr;
 	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
 
-	pr = processors[smp_processor_id()];
+	pr = __get_cpu_var(processors);
 
 	if (unlikely(!pr))
 		return 0;
@@ -1490,7 +1490,7 @@ static int acpi_idle_enter_simple(struct
 	u32 t1, t2;
 	int sleep_ticks = 0;
 
-	pr = processors[smp_processor_id()];
+	pr = __get_cpu_var(processors);
 
 	if (unlikely(!pr))
 		return 0;
@@ -1568,7 +1568,7 @@ static int acpi_idle_enter_bm(struct cpu
 	u32 t1, t2;
 	int sleep_ticks = 0;
 
-	pr = processors[smp_processor_id()];
+	pr = __get_cpu_var(processors);
 
 	if (unlikely(!pr))
 		return 0;
diff -puN drivers/acpi/processor_perflib.c~acpi-change-processors-from-array-to-per_cpu-variable drivers/acpi/processor_perflib.c
--- a/drivers/acpi/processor_perflib.c~acpi-change-processors-from-array-to-per_cpu-variable
+++ a/drivers/acpi/processor_perflib.c
@@ -89,7 +89,7 @@ static int acpi_processor_ppc_notifier(s
 	if (event != CPUFREQ_INCOMPATIBLE)
 		goto out;
 
-	pr = processors[policy->cpu];
+	pr = per_cpu(processors, policy->cpu);
 	if (!pr || !pr->performance)
 		goto out;
 
@@ -572,7 +572,7 @@ int acpi_processor_preregister_performan
 
 	/* Call _PSD for all CPUs */
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr) {
 			/* Look only at processors in ACPI namespace */
 			continue;
@@ -603,7 +603,7 @@ int acpi_processor_preregister_performan
 	 * domain info.
 	 */
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr)
 			continue;
 
@@ -624,7 +624,7 @@ int acpi_processor_preregister_performan
 
 	cpus_clear(covered_cpus);
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr)
 			continue;
 
@@ -651,7 +651,7 @@ int acpi_processor_preregister_performan
 			if (i == j)
 				continue;
 
-			match_pr = processors[j];
+			match_pr = per_cpu(processors, j);
 			if (!match_pr)
 				continue;
 
@@ -680,7 +680,7 @@ int acpi_processor_preregister_performan
 			if (i == j)
 				continue;
 
-			match_pr = processors[j];
+			match_pr = per_cpu(processors, j);
 			if (!match_pr)
 				continue;
 
@@ -697,7 +697,7 @@ int acpi_processor_preregister_performan
 
 err_ret:
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr || !pr->performance)
 			continue;
 
@@ -728,7 +728,7 @@ acpi_processor_register_performance(stru
 
 	mutex_lock(&performance_mutex);
 
-	pr = processors[cpu];
+	pr = per_cpu(processors, cpu);
 	if (!pr) {
 		mutex_unlock(&performance_mutex);
 		return -ENODEV;
@@ -766,7 +766,7 @@ acpi_processor_unregister_performance(st
 
 	mutex_lock(&performance_mutex);
 
-	pr = processors[cpu];
+	pr = per_cpu(processors, cpu);
 	if (!pr) {
 		mutex_unlock(&performance_mutex);
 		return;
diff -puN drivers/acpi/processor_throttling.c~acpi-change-processors-from-array-to-per_cpu-variable drivers/acpi/processor_throttling.c
--- a/drivers/acpi/processor_throttling.c~acpi-change-processors-from-array-to-per_cpu-variable
+++ a/drivers/acpi/processor_throttling.c
@@ -71,7 +71,7 @@ static int acpi_processor_update_tsd_coo
 	 * coordination between all CPUs.
 	 */
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr)
 			continue;
 
@@ -93,7 +93,7 @@ static int acpi_processor_update_tsd_coo
 
 	cpus_clear(covered_cpus);
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr)
 			continue;
 
@@ -119,7 +119,7 @@ static int acpi_processor_update_tsd_coo
 			if (i == j)
 				continue;
 
-			match_pr = processors[j];
+			match_pr = per_cpu(processors, j);
 			if (!match_pr)
 				continue;
 
@@ -152,7 +152,7 @@ static int acpi_processor_update_tsd_coo
 			if (i == j)
 				continue;
 
-			match_pr = processors[j];
+			match_pr = per_cpu(processors, j);
 			if (!match_pr)
 				continue;
 
@@ -172,7 +172,7 @@ static int acpi_processor_update_tsd_coo
 
 err_ret:
 	for_each_possible_cpu(i) {
-		pr = processors[i];
+		pr = per_cpu(processors, i);
 		if (!pr)
 			continue;
 
@@ -214,7 +214,7 @@ static int acpi_processor_throttling_not
 	struct acpi_processor_throttling *p_throttling;
 
 	cpu = p_tstate->cpu;
-	pr = processors[cpu];
+	pr = per_cpu(processors, cpu);
 	if (!pr) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Invalid pr pointer\n"));
 		return 0;
@@ -1035,7 +1035,7 @@ int acpi_processor_set_throttling(struct
 		 * cpus.
 		 */
 		for_each_cpu_mask(i, online_throttling_cpus) {
-			match_pr = processors[i];
+			match_pr = per_cpu(processors, i);
 			/*
 			 * If the pointer is invalid, we will report the
 			 * error message and continue.
diff -puN include/acpi/processor.h~acpi-change-processors-from-array-to-per_cpu-variable include/acpi/processor.h
--- a/include/acpi/processor.h~acpi-change-processors-from-array-to-per_cpu-variable
+++ a/include/acpi/processor.h
@@ -255,7 +255,7 @@ extern void acpi_processor_unregister_pe
 int acpi_processor_notify_smm(struct module *calling_module);
 
 /* for communication between multiple parts of the processor kernel module */
-extern struct acpi_processor *processors[NR_CPUS];
+DECLARE_PER_CPU(struct acpi_processor *, processors);
 extern struct acpi_processor_errata errata;
 
 void arch_acpi_processor_init_pdc(struct acpi_processor *pr);
_
