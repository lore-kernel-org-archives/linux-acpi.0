From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] acpi-cpufreq fixups
Date: 28 Jan 2004 17:44:35 -0500
Sender: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
Message-ID: <1075329875.2484.107.camel@dhcppc4>
References: <20040115233215.GC5386@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <20040115233215.GC5386@dominikbrodowski.de>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

Accepted into ACPI test trees
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.1
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.2

This means it will be pulled into AKPM's mm tree on the next update.

thanks Dominik,
-Len

On Thu, 2004-01-15 at 18:32, Dominik Brodowski wrote:
> This patch applies on top of 
> 
> [1] http://marc.theaimsgroup.com/?l=acpi4linux&m=107398569012495&w=2
> [2] http://marc.theaimsgroup.com/?l=acpi4linux&m=107398568612489&w=2
> [3] http://marc.theaimsgroup.com/?l=acpi4linux&m=107407671712989&w=2
> 
> and fixes the following issues:
> 
> - remove unnecessary usage of flags.performance
> - remove double check of _PPC in acpi-cpufreq driver as it's handled in
>   drivers/acpi/processor.c already
> - remove unneeded EXPORT_SYMBOL
> - allocation of memory only for probed CPUs
> - add unregistration function to the core
> - fix OOPS when PST has core_frequency values of zero
> - fix cpufreq_get() output
> - fix /proc/acpi/processor/*/performance write support [deprecated]
> 
> It has been tested thoroughly on my P-States capable notebook.
> 
>  arch/i386/kernel/cpu/cpufreq/acpi.c |  173 +++++++++++++++---------------------
>  drivers/acpi/processor.c            |   50 ++++++++--
>  include/acpi/processor.h            |    4 
>  3 files changed, 116 insertions(+), 111 deletions(-)
> 
> diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
> --- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-14 20:39:45.000000000 +0100
> +++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-15 19:17:52.835415040 +0100
> @@ -52,7 +52,7 @@
>  MODULE_LICENSE("GPL");
>  
> 
> -static struct acpi_processor_performance	*performance;
> +static struct acpi_processor_performance	*performance[NR_CPUS];
>  
> 
>  static int 
> @@ -187,9 +187,6 @@
>  	else
>  		perf->state_count = pss->package.count;
>  
> -	if (perf->state_count > 1)
> -		perf->pr->flags.performance = 1;
> -
>  	for (i = 0; i < perf->state_count; i++) {
>  
>  		struct acpi_processor_px *px = &(perf->states[i]);
> @@ -216,6 +213,12 @@
>  			(u32) px->bus_master_latency,
>  			(u32) px->control, 
>  			(u32) px->status));
> +
> +		if (!px->core_frequency) {
> +			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "core_frequency is 0\n"));
> +			result = -EFAULT;
> +			goto end;
> +		}
>  	}
>  
>  end:
> @@ -240,22 +243,12 @@
>  	if (!perf || !perf->pr)
>  		return_VALUE(-EINVAL);
>  
> -	if (!perf->pr->flags.performance)
> -		return_VALUE(-ENODEV);
> -
>  	if (state >= perf->state_count) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_WARN, 
>  			"Invalid target state (P%d)\n", state));
>  		return_VALUE(-ENODEV);
>  	}
>  
> -	if (state < perf->pr->performance_platform_limit) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_WARN, 
> -			"Platform limit (P%d) overrides target state (P%d)\n",
> -			perf->pr->performance_platform_limit, state));
> -		return_VALUE(-ENODEV);
> -	}
> -
>  	if (state == perf->state) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
>  			"Already at target state (P%d)\n", state));
> @@ -267,8 +260,8 @@
>  
>  	/* cpufreq frequency struct */
>  	cpufreq_freqs.cpu = perf->pr->id;
> -	cpufreq_freqs.old = perf->states[perf->state].core_frequency;
> -	cpufreq_freqs.new = perf->states[state].core_frequency;
> +	cpufreq_freqs.old = perf->states[perf->state].core_frequency * 1000;
> +	cpufreq_freqs.new = perf->states[state].core_frequency * 1000;
>  
>  	/* notify cpufreq */
>  	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
> @@ -350,7 +343,7 @@
>  	if (!pr)
>  		goto end;
>  
> -	if (!pr->flags.performance || !pr->performance) {
> +	if (!pr->performance) {
>  		seq_puts(seq, "<not supported>\n");
>  		goto end;
>  	}
> @@ -386,14 +379,20 @@
>          loff_t			*data)
>  {
>  	int			result = 0;
> -	struct acpi_processor	*pr = (struct acpi_processor *) data;
> +	struct seq_file		*m = (struct seq_file *) file->private_data;
> +	struct acpi_processor	*pr = (struct acpi_processor *) m->private;
> +	struct acpi_processor_performance *perf;
>  	char			state_string[12] = {'\0'};
>  	unsigned int            new_state = 0;
>  	struct cpufreq_policy   policy;
>  
>  	ACPI_FUNCTION_TRACE("acpi_processor_write_performance");
>  
> -	if (!pr || !pr->performance || (count > sizeof(state_string) - 1))
> +	if (!pr || (count > sizeof(state_string) - 1))
> +		return_VALUE(-EINVAL);
> +
> +	perf = pr->performance;
> +	if (!perf)
>  		return_VALUE(-EINVAL);
>  	
>  	if (copy_from_user(state_string, buffer, count))
> @@ -402,10 +401,14 @@
>  	state_string[count] = '\0';
>  	new_state = simple_strtoul(state_string, NULL, 0);
>  
> +	if (new_state >= perf->state_count)
> +		return_VALUE(-EINVAL);
> +
>  	cpufreq_get_policy(&policy, pr->id);
>  
>  	policy.cpu = pr->id;
> -	policy.max = pr->performance->states[new_state].core_frequency * 1000;
> +	policy.min = perf->states[new_state].core_frequency * 1000;
> +	policy.max = perf->states[new_state].core_frequency * 1000;
>  
>  	result = cpufreq_set_policy(&policy);
>  	if (result)
> @@ -471,14 +474,14 @@
>  	unsigned int target_freq,
>  	unsigned int relation)
>  {
> -	struct acpi_processor_performance *perf = &performance[policy->cpu];
> +	struct acpi_processor_performance *perf = performance[policy->cpu];
>  	unsigned int next_state = 0;
>  	unsigned int result = 0;
>  
>  	ACPI_FUNCTION_TRACE("acpi_cpufreq_setpolicy");
>  
>  	result = cpufreq_frequency_table_target(policy, 
> -			&perf->freq_table[perf->pr->limit.state.px],
> +			perf->freq_table,
>  			target_freq,
>  			relation,
>  			&next_state);
> @@ -496,17 +499,17 @@
>  	struct cpufreq_policy   *policy)
>  {
>  	unsigned int result = 0;
> -	struct acpi_processor_performance *perf = &performance[policy->cpu];
> +	struct acpi_processor_performance *perf = performance[policy->cpu];
>  
>  	ACPI_FUNCTION_TRACE("acpi_cpufreq_verify");
>  
>  	result = cpufreq_frequency_table_verify(policy, 
> -			&perf->freq_table[perf->pr->limit.state.px]);
> +			perf->freq_table);
>  
>  	cpufreq_verify_within_limits(
>  		policy, 
>  		perf->states[perf->state_count - 1].core_frequency * 1000,
> -		perf->states[perf->pr->limit.state.px].core_frequency * 1000);
> +		perf->states[0].core_frequency * 1000);
>  
>  	return_VALUE(result);
>  }
> @@ -550,35 +553,43 @@
>  {
>  	unsigned int		i;
>  	unsigned int		cpu = policy->cpu;
> -	struct acpi_processor	*pr = NULL;
> -	struct acpi_processor_performance *perf = &performance[policy->cpu];
> -	struct acpi_device	*device;
> +	struct acpi_processor_performance *perf;
>  	unsigned int		result = 0;
>  
>  	ACPI_FUNCTION_TRACE("acpi_cpufreq_cpu_init");
>  
> -	acpi_processor_register_performance(perf, &pr, cpu);
> +	perf = kmalloc(sizeof(struct acpi_processor_performance), GFP_KERNEL);
> +	if (!perf)
> +		return_VALUE(-ENOMEM);
> +	memset(perf, 0, sizeof(struct acpi_processor_performance));
> +
> +	performance[cpu] = perf;
>  
> -	pr = performance[cpu].pr;
> -	if (!pr)
> -		return_VALUE(-ENODEV);
> +	result = acpi_processor_register_performance(perf, cpu);
> +	if (result)
> +		goto err_free;
>  
>  	result = acpi_processor_get_performance_info(perf);
>  	if (result)
> -		return_VALUE(-ENODEV);
> +		goto err_unreg;
>  
>  	/* capability check */
> -	if (!pr->flags.performance)
> -		return_VALUE(-ENODEV);
> +	if (perf->state_count <= 1)
> +		goto err_unreg;
>  
>  	/* detect transition latency */
>  	policy->cpuinfo.transition_latency = 0;
> -	for (i=0;i<perf->state_count;i++) {
> +	for (i=0; i<perf->state_count; i++) {
>  		if ((perf->states[i].transition_latency * 1000) > policy->cpuinfo.transition_latency)
>  			policy->cpuinfo.transition_latency = perf->states[i].transition_latency * 1000;
>  	}
>  	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
> -	policy->cur = perf->states[pr->limit.state.px].core_frequency * 1000;
> +
> +	/* 
> +	 * The current speed is unknown and not detectable by ACPI... argh! Assume 
> +	 * it's P0, it will be set to this value later during initialization.
> +	 */
> +	policy->cur = perf->states[0].core_frequency * 1000;
>  
>  	/* table init */
>  	for (i=0; i<=perf->state_count; i++)
> @@ -592,19 +603,25 @@
>  
>  	result = cpufreq_frequency_table_cpuinfo(policy, &perf->freq_table[0]);
>  
> -	acpi_cpufreq_add_file(pr);
> +	acpi_cpufreq_add_file(perf->pr);
>  
> -	if (acpi_bus_get_device(pr->handle, &device))
> -		device = NULL;
> -		
> -	printk(KERN_INFO "cpufreq: %s - ACPI performance management activated.\n",
> -		device ? acpi_device_bid(device) : "CPU??");
> -	for (i = 0; i < pr->performance->state_count; i++)
> +	printk(KERN_INFO "cpufreq: CPU%u - ACPI performance management activated.\n",
> +	       cpu);
> +	for (i = 0; i < perf->state_count; i++)
>  		printk(KERN_INFO "cpufreq: %cP%d: %d MHz, %d mW, %d uS\n",
> -			(i == pr->performance->state?'*':' '), i,
> -			(u32) pr->performance->states[i].core_frequency,
> -			(u32) pr->performance->states[i].power,
> -			(u32) pr->performance->states[i].transition_latency);
> +			(i == perf->state?'*':' '), i,
> +			(u32) perf->states[i].core_frequency,
> +			(u32) perf->states[i].power,
> +			(u32) perf->states[i].transition_latency);
> +
> +	return_VALUE(result);
> +
> + err_unreg:
> +	acpi_processor_unregister_performance(perf, cpu);
> + err_free:
> +	kfree(perf);
> +	performance[cpu] = NULL;
> +
>  	return_VALUE(result);
>  }
>  
> @@ -613,11 +630,16 @@
>  acpi_cpufreq_cpu_exit (
>  	struct cpufreq_policy   *policy)
>  {
> -	struct acpi_processor  *pr = performance[policy->cpu].pr;
> +	struct acpi_processor_performance  *perf = performance[policy->cpu];
>  
>  	ACPI_FUNCTION_TRACE("acpi_cpufreq_cpu_exit");
>  
> -	acpi_cpufreq_remove_file(pr);
> +	if (perf) {
> +		acpi_cpufreq_remove_file(perf->pr);
> +		performance[policy->cpu] = NULL;
> +		acpi_processor_unregister_performance(perf, policy->cpu);
> +		kfree(perf);
> +	}
>  
>  	return_VALUE(0);
>  }
> @@ -637,41 +659,10 @@
>  acpi_cpufreq_init (void)
>  {
>  	int                     result = 0;
> -	int                     i = 0;
> -	struct acpi_processor   *pr = NULL;
>  
>  	ACPI_FUNCTION_TRACE("acpi_cpufreq_init");
>  
> -	/* alloc memory */
> -	performance = kmalloc(NR_CPUS * sizeof(struct acpi_processor_performance), GFP_KERNEL);
> -	if (!performance)
> -		return_VALUE(-ENOMEM);
> -	memset(performance, 0, NR_CPUS * sizeof(struct acpi_processor_performance));
> -
> -	/* register struct acpi_processor_performance performance */
> -	for (i=0; i<NR_CPUS; i++) {
> -		if (cpu_online(i))
> -			acpi_processor_register_performance(&performance[i], &pr, i);
> -	}
> -
> -	/* initialize  */
> -	for (i=0; i<NR_CPUS; i++) {
> -		if (cpu_online(i) && performance[i].pr)
> -			result = acpi_processor_get_performance_info(&performance[i]);
> -	}
> -
>   	result = cpufreq_register_driver(&acpi_cpufreq_driver);
> -	if (result) {
> -		/* unregister struct acpi_processor_performance performance */
> -		for (i=0; i<NR_CPUS; i++) {
> -			if (performance[i].pr) {
> -				performance[i].pr->flags.performance = 0;
> -				performance[i].pr->performance = NULL;
> -				performance[i].pr = NULL;
> -			}
> -		}
> -		kfree(performance);
> -	}
>  	
>  	return_VALUE(result);
>  }
> @@ -680,27 +671,9 @@
>  static void __exit
>  acpi_cpufreq_exit (void)
>  {
> -	int                     i = 0;
> -
>  	ACPI_FUNCTION_TRACE("acpi_cpufreq_exit");
>  
> -	for (i=0; i<NR_CPUS; i++) {
> -		if (performance[i].pr)
> -			performance[i].pr->flags.performance = 0;
> -	}
> -
> -	 cpufreq_unregister_driver(&acpi_cpufreq_driver);
> -
> -	/* unregister struct acpi_processor_performance performance */
> -	for (i=0; i<NR_CPUS; i++) {
> -		if (performance[i].pr) {
> -			performance[i].pr->flags.performance = 0;
> -			performance[i].pr->performance = NULL;
> -			performance[i].pr = NULL;
> -		}
> -	}
> -
> -	kfree(performance);
> +	cpufreq_unregister_driver(&acpi_cpufreq_driver);
>  
>  	return_VOID;
>  }
> diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
> --- linux-original/drivers/acpi/processor.c	2004-01-14 20:39:45.000000000 +0100
> +++ linux/drivers/acpi/processor.c	2004-01-14 20:50:24.000000000 +0100
> @@ -3,6 +3,7 @@
>   *
>   *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
>   *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
> + *  Copyright (C) 2004       Dominik Brodowski <linux@brodo.de>
>   *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   *
> @@ -55,7 +56,6 @@
>  #define ACPI_PROCESSOR_DEVICE_NAME	"Processor"
>  #define ACPI_PROCESSOR_FILE_INFO	"info"
>  #define ACPI_PROCESSOR_FILE_POWER	"power"
> -#define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
>  #define ACPI_PROCESSOR_FILE_THROTTLING	"throttling"
>  #define ACPI_PROCESSOR_FILE_LIMIT	"limit"
>  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
> @@ -827,7 +827,6 @@
>  	
>  	return_VALUE(0);
>  }
> -EXPORT_SYMBOL(acpi_processor_get_platform_limit);
>  
> 
>  static int acpi_processor_ppc_has_changed(
> @@ -860,9 +859,10 @@
>  int 
>  acpi_processor_register_performance (
>  	struct acpi_processor_performance * performance,
> -	struct acpi_processor ** pr,
>  	unsigned int cpu)
>  {
> +	struct acpi_processor *pr;
> +
>  	ACPI_FUNCTION_TRACE("acpi_processor_register_performance");
>  
>  	if (!acpi_processor_ppc_is_init)
> @@ -870,26 +870,56 @@
>  
>  	down(&performance_sem);
>  
> -	*pr = processors[cpu];
> -	if (!*pr) {
> +	pr = processors[cpu];
> +	if (!pr) {
>  		up(&performance_sem);
>  		return_VALUE(-ENODEV);
>  	}
>  
> -	if ((*pr)->performance) {
> +	if (pr->performance) {
>  		up(&performance_sem);
>  		return_VALUE(-EBUSY);
>  	}
>  
> -	(*pr)->performance = performance;
> -	performance->pr = *pr;
> +	pr->performance = performance;
> +	performance->pr = pr;
>  
>  	up(&performance_sem);
> -	return 0;
> +	return_VALUE(0);
>  }
>  EXPORT_SYMBOL(acpi_processor_register_performance);
>  
> 
> +void 
> +acpi_processor_unregister_performance (
> +	struct acpi_processor_performance * performance,
> +	unsigned int cpu)
> +{
> +	struct acpi_processor *pr;
> +
> +	ACPI_FUNCTION_TRACE("acpi_processor_unregister_performance");
> +
> +	if (!acpi_processor_ppc_is_init)
> +		return_VOID;
> +
> +	down(&performance_sem);
> +
> +	pr = processors[cpu];
> +	if (!pr) {
> +		up(&performance_sem);
> +		return_VOID;
> +	}
> +
> +	pr->performance = NULL;
> +	performance->pr = NULL;
> +
> +	up(&performance_sem);
> +
> +	return_VOID;
> +}
> +EXPORT_SYMBOL(acpi_processor_unregister_performance);
> +
> +
>  /* for the rest of it, check arch/i386/kernel/cpu/cpufreq/acpi.c */
>  
>  #else  /* !CONFIG_CPU_FREQ */
> @@ -1399,7 +1429,7 @@
>  	if (!pr)
>  		return_VALUE(-EINVAL);
>  
> -	if (pr->flags.performance || pr->flags.throttling)
> +	if (pr->flags.throttling)
>  		pr->flags.limit = 1;
>  
>  	return_VALUE(0);
> diff -ruN linux-original/include/acpi/processor.h linux/include/acpi/processor.h
> --- linux-original/include/acpi/processor.h	2004-01-14 16:03:20.000000000 +0100
> +++ linux/include/acpi/processor.h	2004-01-14 20:33:39.000000000 +0100
> @@ -133,7 +133,9 @@
>  
>  extern int acpi_processor_register_performance (
>  	struct acpi_processor_performance * performance,
> -	struct acpi_processor ** pr,
> +	unsigned int cpu);
> +extern void acpi_processor_unregister_performance (
> +	struct acpi_processor_performance * performance,
>  	unsigned int cpu);
>  
>  #endif
