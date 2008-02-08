From: Mike Travis <travis@sgi.com>
Subject: [PATCH 2/4] acpi: change cpufreq tables to per_cpu variables
Date: Fri, 08 Feb 2008 15:37:40 -0800
Message-ID: <20080208233738.427702000@polaris-admin.engr.sgi.com>
References: <20080208233738.108449000@polaris-admin.engr.sgi.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:47179 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753567AbYBHXhj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Feb 2008 18:37:39 -0500
Content-Disposition: inline; filename=nr_cpus-in-acpi-driver
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@sgi.com>, Jack Steiner <steiner@sgi.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

Change cpufreq tables from arrays to per_cpu variables in
drivers/acpi/processor_thermal.c

Based on linux-2.6.git + x86.git

Cc: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Mike Travis <travis@sgi.com>
---
 drivers/acpi/processor_thermal.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -93,7 +93,7 @@ static int acpi_processor_apply_limit(st
  * _any_ cpufreq driver and not only the acpi-cpufreq driver.
  */
 
-static unsigned int cpufreq_thermal_reduction_pctg[NR_CPUS];
+static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
 static unsigned int acpi_thermal_cpufreq_is_init = 0;
 
 static int cpu_has_cpufreq(unsigned int cpu)
@@ -109,8 +109,8 @@ static int acpi_thermal_cpufreq_increase
 	if (!cpu_has_cpufreq(cpu))
 		return -ENODEV;
 
-	if (cpufreq_thermal_reduction_pctg[cpu] < 60) {
-		cpufreq_thermal_reduction_pctg[cpu] += 20;
+	if (per_cpu(cpufreq_thermal_reduction_pctg, cpu) < 60) {
+		per_cpu(cpufreq_thermal_reduction_pctg, cpu) += 20;
 		cpufreq_update_policy(cpu);
 		return 0;
 	}
@@ -123,13 +123,13 @@ static int acpi_thermal_cpufreq_decrease
 	if (!cpu_has_cpufreq(cpu))
 		return -ENODEV;
 
-	if (cpufreq_thermal_reduction_pctg[cpu] > 20)
-		cpufreq_thermal_reduction_pctg[cpu] -= 20;
+	if (per_cpu(cpufreq_thermal_reduction_pctg, cpu) > 20)
+		per_cpu(cpufreq_thermal_reduction_pctg, cpu) -= 20;
 	else
-		cpufreq_thermal_reduction_pctg[cpu] = 0;
+		per_cpu(cpufreq_thermal_reduction_pctg, cpu) = 0;
 	cpufreq_update_policy(cpu);
 	/* We reached max freq again and can leave passive mode */
-	return !cpufreq_thermal_reduction_pctg[cpu];
+	return !per_cpu(cpufreq_thermal_reduction_pctg, cpu);
 }
 
 static int acpi_thermal_cpufreq_notifier(struct notifier_block *nb,
@@ -143,7 +143,7 @@ static int acpi_thermal_cpufreq_notifier
 
 	max_freq =
 	    (policy->cpuinfo.max_freq *
-	     (100 - cpufreq_thermal_reduction_pctg[policy->cpu])) / 100;
+	     (100 - per_cpu(cpufreq_thermal_reduction_pctg, policy->cpu))) / 100;
 
 	cpufreq_verify_within_limits(policy, 0, max_freq);
 
@@ -159,8 +159,9 @@ void acpi_thermal_cpufreq_init(void)
 {
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++)
-		cpufreq_thermal_reduction_pctg[i] = 0;
+	for (i = 0; i < nr_cpu_ids; i++)
+		if (cpu_present(i))
+			per_cpu(cpufreq_thermal_reduction_pctg, i) = 0;
 
 	i = cpufreq_register_notifier(&acpi_thermal_cpufreq_notifier_block,
 				      CPUFREQ_POLICY_NOTIFIER);

-- 
