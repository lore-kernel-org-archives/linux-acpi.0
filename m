From: ykzhao <yakui.zhao@intel.com>
Subject: [Patch] CPUFREQ: Add the suspend/resume flag to avoid smp_call in
	cpufreq_suspend/resume
Date: Fri, 24 Jul 2009 09:37:43 +0800
Message-ID: <1248399463.3556.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6606 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbZGXBhP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2009 21:37:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: davej@redhat.com
Cc: cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

Subject: [CPUFREQ]: Add the suspend/resume flag to avoid smp_call in cpufreq_suspend/resume 
From: Zhao Yakui <yakui.zhao@intel.com>

Only CPU0 is available in course of cpufreq_suspend/resume.
So it is unnecessary to do the smp_call for getting the current
cpufreq.

Add a flag of suspend/resume to avoid the smp_call in course of
cpufreq_suspend/resume.

http://bugzilla.kernel.org/show_bug.cgi?id=13781
http://bugzilla.kernel.org/show_bug.cgi?id=13269

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Tested-by: Christian Casteyde<casteyde.christian@free.fr>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c  |   24 +++++++++++++++++++++---
 arch/x86/kernel/cpu/cpufreq/powernow-k8.c   |   13 ++++++++++++-
 arch/x86/kernel/cpu/cpufreq/speedstep-ich.c |   12 ++++++++++--
 drivers/cpufreq/cpufreq.c                   |    7 +++++++
 include/linux/cpufreq.h                     |    2 ++
 5 files changed, 52 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.orig/drivers/cpufreq/cpufreq.c	2009-07-23 09:23:36.000000000 +0800
+++ linux-2.6/drivers/cpufreq/cpufreq.c	2009-07-24 09:08:27.000000000 +0800
@@ -1266,6 +1266,9 @@
 	/* only handle each CPU group once */
 	if (unlikely(cpu_policy->cpu != cpu))
 		goto out;
+	/* Set the flag of suspend/resume */
+	if (!cpufreq_driver->suspend_resume)
+		cpufreq_driver->suspend_resume = 1;
 
 	if (cpufreq_driver->suspend) {
 		ret = cpufreq_driver->suspend(cpu_policy, pmsg);
@@ -1391,6 +1394,10 @@
 	schedule_work(&cpu_policy->update);
 fail:
 	cpufreq_cpu_put(cpu_policy);
+	/* clear the flag of suspend/resume */
+	if (cpufreq_driver->suspend_resume)
+		cpufreq_driver->suspend_resume = 0;
+
 	return ret;
 }
 
Index: linux-2.6/include/linux/cpufreq.h
===================================================================
--- linux-2.6.orig/include/linux/cpufreq.h	2009-07-09 13:03:11.000000000 +0800
+++ linux-2.6/include/linux/cpufreq.h	2009-07-24 09:08:27.000000000 +0800
@@ -234,6 +234,8 @@
 	int	(*suspend)	(struct cpufreq_policy *policy, pm_message_t pmsg);
 	int	(*resume)	(struct cpufreq_policy *policy);
 	struct freq_attr	**attr;
+	int			suspend_resume; /* indicates whether it is
+						 * suspend/resume */
 };
 
 /* flags */
Index: linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c	2009-07-09 13:07:06.000000000 +0800
+++ linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c	2009-07-24 09:08:27.000000000 +0800
@@ -197,19 +197,37 @@
 
 static void drv_read(struct drv_cmd *cmd)
 {
-	cmd->val = 0;
+	struct cpufreq_driver *freq_driver;
 
-	smp_call_function_single(cpumask_any(cmd->mask), do_drv_read, cmd, 1);
+	freq_driver = &acpi_cpufreq_driver;
+	cmd->val = 0;
+	/*
+	 * In fact only CPU0 is availabe in course of sysdev_suspend/resume.
+	 * So do it on the current cpu directly
+	 */
+	if (!freq_driver->suspend_resume)
+		smp_call_function_single(cpumask_any(cmd->mask),
+				do_drv_read, cmd, 1);
+	else
+		do_drv_read(cmd);
 }
 
 static void drv_write(struct drv_cmd *cmd)
 {
+	struct cpufreq_driver *freq_driver;
 	int this_cpu;
 
 	this_cpu = get_cpu();
+	freq_driver = &acpi_cpufreq_driver;
 	if (cpumask_test_cpu(this_cpu, cmd->mask))
 		do_drv_write(cmd);
-	smp_call_function_many(cmd->mask, do_drv_write, cmd, 1);
+
+	/*
+	 * Only CPU0 is available in course of sysdev_suspend/resume.
+	 * Don't use the smp call again when it is in suspend/resume.
+	 */
+	if (!freq_driver->suspend_resume)
+		smp_call_function_many(cmd->mask, do_drv_write, cmd, 1);
 	put_cpu();
 }
 
Index: linux-2.6/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/cpufreq/powernow-k8.c	2009-07-23 09:23:36.000000000 +0800
+++ linux-2.6/arch/x86/kernel/cpu/cpufreq/powernow-k8.c	2009-07-24 09:08:27.000000000 +0800
@@ -53,6 +53,7 @@
 static DEFINE_PER_CPU(struct powernow_k8_data *, powernow_data);
 
 static int cpu_family = CPU_OPTERON;
+static struct cpufreq_driver cpufreq_amd64_driver;
 
 #ifndef CONFIG_SMP
 static inline const struct cpumask *cpu_core_mask(int cpu)
@@ -1388,11 +1389,21 @@
 	struct powernow_k8_data *data = per_cpu(powernow_data, cpu);
 	unsigned int khz = 0;
 	int err;
+	struct cpufreq_driver *freq_driver = &cpufreq_amd64_driver;
 
 	if (!data)
 		return -EINVAL;
 
-	smp_call_function_single(cpu, query_values_on_cpu, &err, true);
+	/*
+	 * Only CPU0 is available in course of sysdev_suspend/resume.
+	 * So do it on the current cpu directly in course of
+	 * sysdev_suspend/resume.
+	 */
+	if (!freq_driver->suspend_resume)
+		smp_call_function_single(cpu, query_values_on_cpu, &err, true);
+	else
+		query_values_on_cpu(&err);
+
 	if (err)
 		goto out;
 
Index: linux-2.6/arch/x86/kernel/cpu/cpufreq/speedstep-ich.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/cpufreq/speedstep-ich.c	2009-07-09 13:07:08.000000000 +0800
+++ linux-2.6/arch/x86/kernel/cpu/cpufreq/speedstep-ich.c	2009-07-24 09:08:27.000000000 +0800
@@ -41,6 +41,8 @@
  */
 static unsigned int speedstep_processor;
 
+static struct cpufreq_driver speedstep_driver;
+
 static u32 pmbase;
 
 /*
@@ -246,11 +248,17 @@
 
 static unsigned int speedstep_get(unsigned int cpu)
 {
+	struct cpufreq_driver *freq_driver = &speedstep_driver;
 	struct get_freq_data data = { .processor = cpu };
 
+	/* In fact only CPU0 is available in course of sysdev_suspend/resume.
+	 * So do it on the current cpu directly
+	 */
+	if (freq_driver->suspend_resume)
+		get_freq_data(&data);
 	/* You're supposed to ensure CPU is online. */
-	if (smp_call_function_single(cpu, get_freq_data, &data, 1) != 0)
-		BUG();
+	else
+		smp_call_function_single(cpu, get_freq_data, &data, 1);
 
 	dprintk("detected %u kHz as current frequency\n", data.speed);
 	return data.speed;


