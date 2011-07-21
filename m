From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH, RESEND] acpi-cpufreq: remove unreliable optional device.get() code
Date: Thu, 21 Jul 2011 11:48:22 +0200
Message-ID: <201107211148.22654.trenn@suse.de>
References: <alpine.LFD.2.02.1106060144310.6779@x980> <alpine.LFD.2.02.1107131718270.9546@x980> <alpine.LFD.2.02.1107161846130.11045@x980>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47272 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab1GUJsZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jul 2011 05:48:25 -0400
In-Reply-To: <alpine.LFD.2.02.1107161846130.11045@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Dave Jones <davej@redhat.com>, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, mjg59@srcf.ucam.org

On Sunday, July 17, 2011 12:49:34 AM Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> Date: Mon, 6 Jun 2011 01:06:57 -0400
> 
> cpufreq offers the optional driver.get() entry point
> for drivers to export instantaneous frequency in
> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq.

I wonder how much that could affect Matthew's efforts to
glue together powernow-k8 parts with acpi-cpufreq.

It's nice to see quite some lines vanish, but it's not
worth much if they get re-added with another patch series
some weeks later.

> 25% of the acpi-cpufreq driver is involved in supporting
> that optional feature, but on modern processors, it
> is not reliable.
It could get checked for boot_cpu_has(X86_FEATURE_IDA), machines
having this bit should introduce autonmous frequency switching.

But I'd also say it would be nice to see the lines removed.
It's easy to get the MSR read via userspace as well and if
it's not reliable on latest machines anyway...

      Thomas
 
> So here we delete this optional feature from acpi-cpufreq.
> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq
> will go away on acpi-cpufreq systems, but note that
> /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
> will still be presnet to indicate the most recent request.
> 
> (and yes, powertop still works:-)
> 
> The most common reason that driver.get() is not reliable
> is that modern processors autonomously change frequency
> without OS instruction.  This means that reading
> PERF_STATUS is possibly in-accurate as soon as the
> instruction after it is read.
> 
> Average frequency over an interval is more useful
> than instantaneous frequency on modern hardware.
> acpi-cpufreq supplies average frequency via
> the the driver->getavg() entry, which is what
> the ondemand governor uses.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |  201 
+---------------------------------------
>  1 files changed, 1 insertions(+), 200 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-
cpufreq.c
> index 4e04e12..d7bd6e5 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -73,8 +73,6 @@ static struct acpi_processor_performance __percpu 
*acpi_perf_data;
>  
>  static struct cpufreq_driver acpi_cpufreq_driver;
>  
> -static unsigned int acpi_pstate_strict;
> -
>  static int check_est_cpu(unsigned int cpuid)
>  {
>  	struct cpuinfo_x86 *cpu = &cpu_data(cpuid);
> @@ -82,47 +80,6 @@ static int check_est_cpu(unsigned int cpuid)
>  	return cpu_has(cpu, X86_FEATURE_EST);
>  }
>  
> -static unsigned extract_io(u32 value, struct acpi_cpufreq_data *data)
> -{
> -	struct acpi_processor_performance *perf;
> -	int i;
> -
> -	perf = data->acpi_data;
> -
> -	for (i = 0; i < perf->state_count; i++) {
> -		if (value == perf->states[i].status)
> -			return data->freq_table[i].frequency;
> -	}
> -	return 0;
> -}
> -
> -static unsigned extract_msr(u32 msr, struct acpi_cpufreq_data *data)
> -{
> -	int i;
> -	struct acpi_processor_performance *perf;
> -
> -	msr &= INTEL_MSR_RANGE;
> -	perf = data->acpi_data;
> -
> -	for (i = 0; data->freq_table[i].frequency != CPUFREQ_TABLE_END; i++) 
{
> -		if (msr == perf->states[data->freq_table[i].index].status)
> -			return data->freq_table[i].frequency;
> -	}
> -	return data->freq_table[0].frequency;
> -}
> -
> -static unsigned extract_freq(u32 val, struct acpi_cpufreq_data *data)
> -{
> -	switch (data->cpu_feature) {
> -	case SYSTEM_INTEL_MSR_CAPABLE:
> -		return extract_msr(val, data);
> -	case SYSTEM_IO_CAPABLE:
> -		return extract_io(val, data);
> -	default:
> -		return 0;
> -	}
> -}
> -
>  struct msr_addr {
>  	u32 reg;
>  };
> @@ -142,26 +99,6 @@ struct drv_cmd {
>  	u32 val;
>  };
>  
> -/* Called via smp_call_function_single(), on the target CPU */
> -static void do_drv_read(void *_cmd)
> -{
> -	struct drv_cmd *cmd = _cmd;
> -	u32 h;
> -
> -	switch (cmd->type) {
> -	case SYSTEM_INTEL_MSR_CAPABLE:
> -		rdmsr(cmd->addr.msr.reg, cmd->val, h);
> -		break;
> -	case SYSTEM_IO_CAPABLE:
> -		acpi_os_read_port((acpi_io_address)cmd->addr.io.port,
> -				&cmd->val,
> -				(u32)cmd->addr.io.bit_width);
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
>  /* Called via smp_call_function_many(), on the target CPUs */
>  static void do_drv_write(void *_cmd)
>  {
> @@ -184,15 +121,6 @@ static void do_drv_write(void *_cmd)
>  	}
>  }
>  
> -static void drv_read(struct drv_cmd *cmd)
> -{
> -	int err;
> -	cmd->val = 0;
> -
> -	err = smp_call_function_any(cmd->mask, do_drv_read, cmd, 1);
> -	WARN_ON_ONCE(err);	/* smp_call_function_any() was buggy? */
> -}
> -
>  static void drv_write(struct drv_cmd *cmd)
>  {
>  	int this_cpu;
> @@ -204,80 +132,6 @@ static void drv_write(struct drv_cmd *cmd)
>  	put_cpu();
>  }
>  
> -static u32 get_cur_val(const struct cpumask *mask)
> -{
> -	struct acpi_processor_performance *perf;
> -	struct drv_cmd cmd;
> -
> -	if (unlikely(cpumask_empty(mask)))
> -		return 0;
> -
> -	switch (per_cpu(acfreq_data, cpumask_first(mask))->cpu_feature) {
> -	case SYSTEM_INTEL_MSR_CAPABLE:
> -		cmd.type = SYSTEM_INTEL_MSR_CAPABLE;
> -		cmd.addr.msr.reg = MSR_IA32_PERF_STATUS;
> -		break;
> -	case SYSTEM_IO_CAPABLE:
> -		cmd.type = SYSTEM_IO_CAPABLE;
> -		perf = per_cpu(acfreq_data, cpumask_first(mask))->acpi_data;
> -		cmd.addr.io.port = perf->control_register.address;
> -		cmd.addr.io.bit_width = perf->control_register.bit_width;
> -		break;
> -	default:
> -		return 0;
> -	}
> -
> -	cmd.mask = mask;
> -	drv_read(&cmd);
> -
> -	pr_debug("get_cur_val = %u\n", cmd.val);
> -
> -	return cmd.val;
> -}
> -
> -static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
> -{
> -	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, cpu);
> -	unsigned int freq;
> -	unsigned int cached_freq;
> -
> -	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
> -
> -	if (unlikely(data == NULL ||
> -		     data->acpi_data == NULL || data->freq_table == NULL)) {
> -		return 0;
> -	}
> -
> -	cached_freq = data->freq_table[data->acpi_data->state].frequency;
> -	freq = extract_freq(get_cur_val(cpumask_of(cpu)), data);
> -	if (freq != cached_freq) {
> -		/*
> -		 * The dreaded BIOS frequency change behind our back.
> -		 * Force set the frequency on next target call.
> -		 */
> -		data->resume = 1;
> -	}
> -
> -	pr_debug("cur freq = %u\n", freq);
> -
> -	return freq;
> -}
> -
> -static unsigned int check_freqs(const struct cpumask *mask, unsigned 
int freq,
> -				struct acpi_cpufreq_data *data)
> -{
> -	unsigned int cur_freq;
> -	unsigned int i;
> -
> -	for (i = 0; i < 100; i++) {
> -		cur_freq = extract_freq(get_cur_val(mask), data);
> -		if (cur_freq == freq)
> -			return 1;
> -		udelay(10);
> -	}
> -	return 0;
> -}
> -
>  static int acpi_cpufreq_target(struct cpufreq_policy *policy,
>  			       unsigned int target_freq, unsigned int relation)
>  {
> @@ -352,15 +206,6 @@ static int acpi_cpufreq_target(struct 
cpufreq_policy *policy,
>  
>  	drv_write(&cmd);
>  
> -	if (acpi_pstate_strict) {
> -		if (!check_freqs(cmd.mask, freqs.new, data)) {
> -			pr_debug("acpi_cpufreq_target failed (%d)\n",
> -				policy->cpu);
> -			result = -EAGAIN;
> -			goto out;
> -		}
> -	}
> -
>  	for_each_cpu(i, policy->cpus) {
>  		freqs.cpu = i;
>  		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> @@ -380,34 +225,6 @@ static int acpi_cpufreq_verify(struct 
cpufreq_policy *policy)
>  	return cpufreq_frequency_table_verify(policy, data->freq_table);
>  }
>  
> -static unsigned long
> -acpi_cpufreq_guess_freq(struct acpi_cpufreq_data *data, unsigned int 
cpu)
> -{
> -	struct acpi_processor_performance *perf = data->acpi_data;
> -
> -	if (cpu_khz) {
> -		/* search the closest match to cpu_khz */
> -		unsigned int i;
> -		unsigned long freq;
> -		unsigned long freqn = perf->states[0].core_frequency * 1000;
> -
> -		for (i = 0; i < (perf->state_count-1); i++) {
> -			freq = freqn;
> -			freqn = perf->states[i+1].core_frequency * 1000;
> -			if ((2 * cpu_khz) > (freqn + freq)) {
> -				perf->state = i;
> -				return freq;
> -			}
> -		}
> -		perf->state = perf->state_count-1;
> -		return freqn;
> -	} else {
> -		/* assume CPU is at P0... */
> -		perf->state = 0;
> -		return perf->states[0].core_frequency * 1000;
> -	}
> -}
> -
>  static void free_acpi_perf_data(void)
>  {
>  	unsigned int i;
> @@ -638,18 +455,7 @@ static int acpi_cpufreq_cpu_init(struct 
cpufreq_policy *policy)
>  	if (perf->states[0].core_frequency * 1000 != policy-
>cpuinfo.max_freq)
>  		printk(KERN_WARNING FW_WARN "P-state 0 is not max freq\n");
>  
> -	switch (perf->control_register.space_id) {
> -	case ACPI_ADR_SPACE_SYSTEM_IO:
> -		/* Current speed is unknown and not detectable by IO port */
> -		policy->cur = acpi_cpufreq_guess_freq(data, policy->cpu);
> -		break;
> -	case ACPI_ADR_SPACE_FIXED_HARDWARE:
> -		acpi_cpufreq_driver.get = get_cur_freq_on_cpu;
> -		policy->cur = get_cur_freq_on_cpu(cpu);
> -		break;
> -	default:
> -		break;
> -	}
> +	policy->cur = data->freq_table[data->acpi_data->state].frequency;
>  
>  	/* notify BIOS that we exist */
>  	acpi_processor_notify_smm(THIS_MODULE);
> @@ -762,11 +568,6 @@ static void __exit acpi_cpufreq_exit(void)
>  	free_percpu(acpi_perf_data);
>  }
>  
> -module_param(acpi_pstate_strict, uint, 0644);
> -MODULE_PARM_DESC(acpi_pstate_strict,
> -	"value 0 or non-zero. non-zero -> strict ACPI checks are "
> -	"performed during frequency changes.");
> -
>  late_initcall(acpi_cpufreq_init);
>  module_exit(acpi_cpufreq_exit);
>  
> -- 
> 1.7.6.178.g55272
> 
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

