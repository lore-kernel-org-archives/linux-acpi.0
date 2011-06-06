From: Len Brown <lenb@kernel.org>
Subject: [PATCH] acpi-cpufreq: remove unreliable get-frequency functions
Date: Mon, 06 Jun 2011 01:47:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1106060144310.6779@x980>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:55113 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab1FFFrz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jun 2011 01:47:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: cpufreq@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>

From: Len Brown <len.brown@intel.com>

Reading the current frequency from PERF_STATUS
is fundamentally unreliable for multiple reasons
on multiple systems.

Indeed, one can make the case that the PERF_STATUS MSR
should be deleted from the x86 architecture due to its
ability to mis-lead.

The most common case of decpetion is P-state "hardware coordination"
that is used on all HT and multi-core processors that share
the same voltage regulator.  Here the hardware runs at the speed
of the fastest sibling, and thus the "current frequency"
on the sibling that asked for a slower frequency
is erroneous 100% of the time.

For over 10 years, TM1 and TM2 have changed the frequency
out from under the system due to thermal emergencies,
without necessarily updating PERF_STATUS.

Finally, even on hardware that dutifully updates PERF_STATUS
to reflect reality, there is a race condition between software
reading the register and the changes above -- making it
fundamentally un-relaible for determining frequency.

The reliable way to determine frequency is to simply ask the
hardware how many unhalted cycles it has executed during a
known period of time via the APERF MSR.  This is how
turbostat and other utilities do it...

Delete the concept of reading the current frequency from acpi-cpufreq,
and the unreliable code that is built upon it.

As the cpufreq interface has a concept of "cur" frequency,
simply return the last request.  The reality is that 99% of the time
it would have got that answer from reading the hardware anway,
and so simply returning this cached value is no less accurate.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c |  201 +---------------------------------------
 1 files changed, 1 insertions(+), 200 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 4e04e12..d7bd6e5 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -73,8 +73,6 @@ static struct acpi_processor_performance __percpu *acpi_perf_data;
 
 static struct cpufreq_driver acpi_cpufreq_driver;
 
-static unsigned int acpi_pstate_strict;
-
 static int check_est_cpu(unsigned int cpuid)
 {
 	struct cpuinfo_x86 *cpu = &cpu_data(cpuid);
@@ -82,47 +80,6 @@ static int check_est_cpu(unsigned int cpuid)
 	return cpu_has(cpu, X86_FEATURE_EST);
 }
 
-static unsigned extract_io(u32 value, struct acpi_cpufreq_data *data)
-{
-	struct acpi_processor_performance *perf;
-	int i;
-
-	perf = data->acpi_data;
-
-	for (i = 0; i < perf->state_count; i++) {
-		if (value == perf->states[i].status)
-			return data->freq_table[i].frequency;
-	}
-	return 0;
-}
-
-static unsigned extract_msr(u32 msr, struct acpi_cpufreq_data *data)
-{
-	int i;
-	struct acpi_processor_performance *perf;
-
-	msr &= INTEL_MSR_RANGE;
-	perf = data->acpi_data;
-
-	for (i = 0; data->freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		if (msr == perf->states[data->freq_table[i].index].status)
-			return data->freq_table[i].frequency;
-	}
-	return data->freq_table[0].frequency;
-}
-
-static unsigned extract_freq(u32 val, struct acpi_cpufreq_data *data)
-{
-	switch (data->cpu_feature) {
-	case SYSTEM_INTEL_MSR_CAPABLE:
-		return extract_msr(val, data);
-	case SYSTEM_IO_CAPABLE:
-		return extract_io(val, data);
-	default:
-		return 0;
-	}
-}
-
 struct msr_addr {
 	u32 reg;
 };
@@ -142,26 +99,6 @@ struct drv_cmd {
 	u32 val;
 };
 
-/* Called via smp_call_function_single(), on the target CPU */
-static void do_drv_read(void *_cmd)
-{
-	struct drv_cmd *cmd = _cmd;
-	u32 h;
-
-	switch (cmd->type) {
-	case SYSTEM_INTEL_MSR_CAPABLE:
-		rdmsr(cmd->addr.msr.reg, cmd->val, h);
-		break;
-	case SYSTEM_IO_CAPABLE:
-		acpi_os_read_port((acpi_io_address)cmd->addr.io.port,
-				&cmd->val,
-				(u32)cmd->addr.io.bit_width);
-		break;
-	default:
-		break;
-	}
-}
-
 /* Called via smp_call_function_many(), on the target CPUs */
 static void do_drv_write(void *_cmd)
 {
@@ -184,15 +121,6 @@ static void do_drv_write(void *_cmd)
 	}
 }
 
-static void drv_read(struct drv_cmd *cmd)
-{
-	int err;
-	cmd->val = 0;
-
-	err = smp_call_function_any(cmd->mask, do_drv_read, cmd, 1);
-	WARN_ON_ONCE(err);	/* smp_call_function_any() was buggy? */
-}
-
 static void drv_write(struct drv_cmd *cmd)
 {
 	int this_cpu;
@@ -204,80 +132,6 @@ static void drv_write(struct drv_cmd *cmd)
 	put_cpu();
 }
 
-static u32 get_cur_val(const struct cpumask *mask)
-{
-	struct acpi_processor_performance *perf;
-	struct drv_cmd cmd;
-
-	if (unlikely(cpumask_empty(mask)))
-		return 0;
-
-	switch (per_cpu(acfreq_data, cpumask_first(mask))->cpu_feature) {
-	case SYSTEM_INTEL_MSR_CAPABLE:
-		cmd.type = SYSTEM_INTEL_MSR_CAPABLE;
-		cmd.addr.msr.reg = MSR_IA32_PERF_STATUS;
-		break;
-	case SYSTEM_IO_CAPABLE:
-		cmd.type = SYSTEM_IO_CAPABLE;
-		perf = per_cpu(acfreq_data, cpumask_first(mask))->acpi_data;
-		cmd.addr.io.port = perf->control_register.address;
-		cmd.addr.io.bit_width = perf->control_register.bit_width;
-		break;
-	default:
-		return 0;
-	}
-
-	cmd.mask = mask;
-	drv_read(&cmd);
-
-	pr_debug("get_cur_val = %u\n", cmd.val);
-
-	return cmd.val;
-}
-
-static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
-{
-	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, cpu);
-	unsigned int freq;
-	unsigned int cached_freq;
-
-	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
-
-	if (unlikely(data == NULL ||
-		     data->acpi_data == NULL || data->freq_table == NULL)) {
-		return 0;
-	}
-
-	cached_freq = data->freq_table[data->acpi_data->state].frequency;
-	freq = extract_freq(get_cur_val(cpumask_of(cpu)), data);
-	if (freq != cached_freq) {
-		/*
-		 * The dreaded BIOS frequency change behind our back.
-		 * Force set the frequency on next target call.
-		 */
-		data->resume = 1;
-	}
-
-	pr_debug("cur freq = %u\n", freq);
-
-	return freq;
-}
-
-static unsigned int check_freqs(const struct cpumask *mask, unsigned int freq,
-				struct acpi_cpufreq_data *data)
-{
-	unsigned int cur_freq;
-	unsigned int i;
-
-	for (i = 0; i < 100; i++) {
-		cur_freq = extract_freq(get_cur_val(mask), data);
-		if (cur_freq == freq)
-			return 1;
-		udelay(10);
-	}
-	return 0;
-}
-
 static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 			       unsigned int target_freq, unsigned int relation)
 {
@@ -352,15 +206,6 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 
 	drv_write(&cmd);
 
-	if (acpi_pstate_strict) {
-		if (!check_freqs(cmd.mask, freqs.new, data)) {
-			pr_debug("acpi_cpufreq_target failed (%d)\n",
-				policy->cpu);
-			result = -EAGAIN;
-			goto out;
-		}
-	}
-
 	for_each_cpu(i, policy->cpus) {
 		freqs.cpu = i;
 		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
@@ -380,34 +225,6 @@ static int acpi_cpufreq_verify(struct cpufreq_policy *policy)
 	return cpufreq_frequency_table_verify(policy, data->freq_table);
 }
 
-static unsigned long
-acpi_cpufreq_guess_freq(struct acpi_cpufreq_data *data, unsigned int cpu)
-{
-	struct acpi_processor_performance *perf = data->acpi_data;
-
-	if (cpu_khz) {
-		/* search the closest match to cpu_khz */
-		unsigned int i;
-		unsigned long freq;
-		unsigned long freqn = perf->states[0].core_frequency * 1000;
-
-		for (i = 0; i < (perf->state_count-1); i++) {
-			freq = freqn;
-			freqn = perf->states[i+1].core_frequency * 1000;
-			if ((2 * cpu_khz) > (freqn + freq)) {
-				perf->state = i;
-				return freq;
-			}
-		}
-		perf->state = perf->state_count-1;
-		return freqn;
-	} else {
-		/* assume CPU is at P0... */
-		perf->state = 0;
-		return perf->states[0].core_frequency * 1000;
-	}
-}
-
 static void free_acpi_perf_data(void)
 {
 	unsigned int i;
@@ -638,18 +455,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (perf->states[0].core_frequency * 1000 != policy->cpuinfo.max_freq)
 		printk(KERN_WARNING FW_WARN "P-state 0 is not max freq\n");
 
-	switch (perf->control_register.space_id) {
-	case ACPI_ADR_SPACE_SYSTEM_IO:
-		/* Current speed is unknown and not detectable by IO port */
-		policy->cur = acpi_cpufreq_guess_freq(data, policy->cpu);
-		break;
-	case ACPI_ADR_SPACE_FIXED_HARDWARE:
-		acpi_cpufreq_driver.get = get_cur_freq_on_cpu;
-		policy->cur = get_cur_freq_on_cpu(cpu);
-		break;
-	default:
-		break;
-	}
+	policy->cur = data->freq_table[data->acpi_data->state].frequency;
 
 	/* notify BIOS that we exist */
 	acpi_processor_notify_smm(THIS_MODULE);
@@ -762,11 +568,6 @@ static void __exit acpi_cpufreq_exit(void)
 	free_percpu(acpi_perf_data);
 }
 
-module_param(acpi_pstate_strict, uint, 0644);
-MODULE_PARM_DESC(acpi_pstate_strict,
-	"value 0 or non-zero. non-zero -> strict ACPI checks are "
-	"performed during frequency changes.");
-
 late_initcall(acpi_cpufreq_init);
 module_exit(acpi_cpufreq_exit);
 
-- 
1.7.5.3.367.ga9930

