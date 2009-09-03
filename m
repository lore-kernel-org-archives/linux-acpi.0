From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Resend: ACPI/CPUFREQ: Introduce hw_limit per cpu cpufreq sysfs interface
Date: Thu, 3 Sep 2009 13:23:28 +0200
Message-ID: <200909031323.29420.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:55400 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754666AbZICLX3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Sep 2009 07:23:29 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Len Brown <lenb@kernel.org>
Cc: cpufreq@vger.kernel.org, linux@dominikbrodowski.net, linux-acpi@vger.kernel.org, Pallipadi Venkatesh <venkatesh.pallipadi@intel.com>

Hi,

I now realized that this patch somewhat clashes with
cpufrequtils cpufreq-info --hwlimits command.
IMO "cpufreq-info --hwlimits" is wrong here as it evaluates
max_freq sysfs value which could also get limited by the user.

Ideal solution would be to enhance cpufreq-info with:
--hwlimits    # evaluate the sysfs entry hwlimits introduced by this patch
--user_limits # evaluate user limits which is not possible with current
              # sysfs implementation as max_freq currenlty shows the
              # min(hwlimit, thermal_limit, user_limit)
--thermal_limits # evaluate passive cooling triggered limits
                 # Could/should already be possible by looking at the
                 # generic thermal sysfs driver exposed limits

The diff is based on cpufreq next tree.

Thanks,

   Thomas

----------
ACPI/CPUFREQ: Introduce hw_limit per cpu cpufreq sysfs interface

Len,Dave: This patch touches acpi and cpufreq subsystems.

What do you think about it?
How could this get pushed without much conflicts,
through the cpufreq tree?

This interface is mainly intended (and implemented) for ACPI _PPC BIOS
frequency limitations, but other cpufreq drivers can also use it for
similar use-cases.

Why is this needed:

Currently it's not obvious why cpufreq got limited.
People see cpufreq/scaling_max_freq reduced, but this could have
happened by:
  - any userspace prog writing to scaling_max_freq
  - thermal limitations
  - hardware (_PPC in ACPI case) limitiations

Therefore export hw_limit (in kHz) to:
  - Point the user that it's the BIOS (broken or intended) which limits
    frequency
  - Export it as a sysfs interface for userspace progs.
    While this was a rarely used feature on laptops, there will appear
    more and more server implemenations providing "Green IT" features like
    allowing the service processor to limit the frequency. People want
    to know about HW/BIOS frequency limitations.

All ACPI P-state driven cpufreq drivers are covered with this patch:
  - powernow-k8
  - powernow-k7
  - acpi-cpufreq

Tested with a patched DSDT which limits the first two cores (_PPC returns 1)
via _PPC, exposed by hw_limit:
# echo 2200000 >cpu2/cpufreq/scaling_max_freq
# cat cpu*/cpufreq/scaling_max_freq
2600000
2600000
2200000
2200000
# #scaling_max_freq shows general user/thermal/BIOS limitations

# cat cpu*/cpufreq/hw_limit
2600000
2600000
2800000
2800000
# #hw_limit only shows the HW/BIOS limitation

CC: Pallipadi Venkatesh <venkatesh.pallipadi@intel.com>
CC: Len Brown <lenb@kernel.org>
CC: davej@codemonkey.org.uk
CC: linux@dominikbrodowski.net

Signed-off-by: Thomas Renninger <trenn@suse.de>

diff --git a/Documentation/cpu-freq/user-guide.txt b/Documentation/cpu-freq/user-guide.txt
index 2a5b850..7430949 100644
--- a/Documentation/cpu-freq/user-guide.txt
+++ b/Documentation/cpu-freq/user-guide.txt
@@ -203,6 +203,17 @@ scaling_cur_freq :		Current frequency of the CPU as determined by
 				the frequency the kernel thinks the CPU runs
 				at.
 
+hw_limit :			If the BIOS tells the OS to limit a CPU to
+				lower frequencies, the user can read out the
+				maximum available frequency from this file.
+				This typically can happen through (often not
+				intended) BIOS settings, restrictions
+				triggered through a service processor or other
+				BIOS/HW based implementations.
+				This does not cover thermal ACPI limitations
+				which can be detected through the generic
+				thermal driver.
+
 If you have selected the "userspace" governor which allows you to
 set the CPU operating frequency to a specific value, you can read out
 the current frequency in
diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index ae9b503..d5ea9d0 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -801,14 +801,15 @@ static struct freq_attr *acpi_cpufreq_attr[] = {
 };
 
 static struct cpufreq_driver acpi_cpufreq_driver = {
-	.verify = acpi_cpufreq_verify,
-	.target = acpi_cpufreq_target,
-	.init = acpi_cpufreq_cpu_init,
-	.exit = acpi_cpufreq_cpu_exit,
-	.resume = acpi_cpufreq_resume,
-	.name = "acpi-cpufreq",
-	.owner = THIS_MODULE,
-	.attr = acpi_cpufreq_attr,
+	.verify		= acpi_cpufreq_verify,
+	.target		= acpi_cpufreq_target,
+	.hw_limit	= acpi_processor_get_bios_limit,
+	.init		= acpi_cpufreq_cpu_init,
+	.exit		= acpi_cpufreq_cpu_exit,
+	.resume		= acpi_cpufreq_resume,
+	.name		= "acpi-cpufreq",
+	.owner		= THIS_MODULE,
+	.attr		= acpi_cpufreq_attr,
 };
 
 static int __init acpi_cpufreq_init(void)
diff --git a/arch/x86/kernel/cpu/cpufreq/powernow-k7.c b/arch/x86/kernel/cpu/cpufreq/powernow-k7.c
index d47c775..f9f2a2c 100644
--- a/arch/x86/kernel/cpu/cpufreq/powernow-k7.c
+++ b/arch/x86/kernel/cpu/cpufreq/powernow-k7.c
@@ -714,14 +714,17 @@ static struct freq_attr *powernow_table_attr[] = {
 };
 
 static struct cpufreq_driver powernow_driver = {
-	.verify	= powernow_verify,
-	.target	= powernow_target,
-	.get	= powernow_get,
-	.init	= powernow_cpu_init,
-	.exit	= powernow_cpu_exit,
-	.name	= "powernow-k7",
-	.owner	= THIS_MODULE,
-	.attr	= powernow_table_attr,
+	.verify		= powernow_verify,
+	.target		= powernow_target,
+	.get		= powernow_get,
+#ifdef CONFIG_X86_POWERNOW_K7_ACPI
+	.hw_limit	= acpi_processor_get_bios_limit,
+#endif
+	.init		= powernow_cpu_init,
+	.exit		= powernow_cpu_exit,
+	.name		= "powernow-k7",
+	.owner		= THIS_MODULE,
+	.attr		= powernow_table_attr,
 };
 
 static int __init powernow_init(void)
diff --git a/arch/x86/kernel/cpu/cpufreq/powernow-k8.c b/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
index 2a50ef8..67204f6 100644
--- a/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
+++ b/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
@@ -1413,14 +1413,15 @@ static struct freq_attr *powernow_k8_attr[] = {
 };
 
 static struct cpufreq_driver cpufreq_amd64_driver = {
-	.verify = powernowk8_verify,
-	.target = powernowk8_target,
-	.init = powernowk8_cpu_init,
-	.exit = __devexit_p(powernowk8_cpu_exit),
-	.get = powernowk8_get,
-	.name = "powernow-k8",
-	.owner = THIS_MODULE,
-	.attr = powernow_k8_attr,
+	.verify		= powernowk8_verify,
+	.target		= powernowk8_target,
+	.hw_limit	= acpi_processor_get_bios_limit,
+	.init		= powernowk8_cpu_init,
+	.exit		= __devexit_p(powernowk8_cpu_exit),
+	.get		= powernowk8_get,
+	.name		= "powernow-k8",
+	.owner		= THIS_MODULE,
+	.attr		= powernow_k8_attr,
 };
 
 /* driver entry point for init */
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 60e543d..c4f75bd 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -165,6 +165,19 @@ int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
 		return cpufreq_update_policy(pr->id);
 }
 
+int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
+{
+	struct acpi_processor *pr;
+
+	pr = per_cpu(processors, cpu);
+	if (!pr || !pr->performance || !pr->performance->state_count)
+		return -ENODEV;
+	*limit = pr->performance->states[pr->performance_platform_limit].
+		core_frequency * 1000;
+	return 0;
+}
+EXPORT_SYMBOL(acpi_processor_get_bios_limit);
+
 void acpi_processor_ppc_init(void)
 {
 	if (!cpufreq_register_notifier
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0d55280..15bd425 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -727,6 +727,21 @@ static ssize_t show_affected_cpus(struct cpufreq_policy *policy, char *buf)
 	return show_cpus(policy->cpus, buf);
 }
 
+/**
+ * show_scaling_driver - show the current cpufreq HW/BIOS limitation
+ */
+static ssize_t show_hw_limit(struct cpufreq_policy *policy, char *buf)
+{
+	unsigned int limit;
+	int ret;
+	if (cpufreq_driver->hw_limit) {
+		ret = cpufreq_driver->hw_limit(policy->cpu, &limit);
+		if (!ret)
+			return sprintf(buf, "%u\n", limit);
+	}
+	return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
+}
+
 #define define_one_ro(_name) \
 static struct freq_attr _name = \
 __ATTR(_name, 0444, show_##_name, NULL)
@@ -744,6 +759,7 @@ define_one_ro(cpuinfo_min_freq);
 define_one_ro(cpuinfo_max_freq);
 define_one_ro(cpuinfo_transition_latency);
 define_one_ro(scaling_cur_freq);
+define_one_ro(hw_limit);
 define_one_ro(related_cpus);
 define_one_ro(affected_cpus);
 define_one_rw(scaling_min_freq);
@@ -757,6 +773,7 @@ static struct attribute *default_attrs[] = {
 	&scaling_max_freq.attr,
 	&affected_cpus.attr,
 	&related_cpus.attr,
+	&hw_limit.attr,
 	&scaling_governor_old.attr,
 	&scaling_driver_old.attr,
 	&scaling_available_governors_old.attr,
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index baf1e0a..1e40a0b 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -295,6 +295,7 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 void acpi_processor_ppc_init(void);
 void acpi_processor_ppc_exit(void);
 int acpi_processor_ppc_has_changed(struct acpi_processor *pr);
+extern int acpi_processor_get_bios_limit(int cpu, unsigned int *limit);
 #else
 static inline void acpi_processor_ppc_init(void)
 {
@@ -316,6 +317,11 @@ static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
 	}
 	return 0;
 }
+int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
+{
+	return -ENODEV;
+}
+
 #endif				/* CONFIG_CPU_FREQ */
 
 /* in processor_throttling.c */
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 336017a..f0baecf 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -226,8 +226,9 @@ struct cpufreq_driver {
 	unsigned int	(*get)	(unsigned int cpu);
 
 	/* optional */
-	unsigned int (*getavg)	(struct cpufreq_policy *policy,
+	unsigned int(*getavg)	(struct cpufreq_policy *policy,
 				 unsigned int cpu);
+	int	(*hw_limit)	(int cpu, unsigned int *limit);
 
 	int	(*exit)		(struct cpufreq_policy *policy);
 	int	(*suspend)	(struct cpufreq_policy *policy, pm_message_t pmsg);

