From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 2.6] update _PPC handling
Date: 28 Jan 2004 17:44:17 -0500
Sender: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
Message-ID: <1075329857.2497.105.camel@dhcppc4>
References: <20040114103717.GA4957@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <20040114103717.GA4957@dominikbrodowski.de>
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

Accepted into ACPI test tree
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.0
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.1
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.2

This means it will be pulled into AKPM's mm tree on the next update.

thanks Dominik,
-Len

On Wed, 2004-01-14 at 05:37, Dominik Brodowski wrote:
> This patch, which depends on the "update passive cooling algorithm" patch
> sent yesterday[*], updates the _PPC handling. It is handled as a CPUfreq
> policy notifier which adjusts the maximum CPU speed according to the current
> platform limit.
> 
> Len, could you test and verify this patch, and push it to Linus, please?
> 
> [*] http://marc.theaimsgroup.com/?l=acpi4linux&m=107398568612489&w=2
> 
>  arch/i386/kernel/cpu/cpufreq/acpi.c |    5 -
>  drivers/acpi/processor.c            |  170 ++++++++++++++++++++++++++---------- 
>  include/acpi/processor.h            |    2
>  3 files changed, 123 insertions(+), 54 deletions(-)
> 
> 
> diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
> --- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-11 21:56:52.000000000 +0100
> +++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-13 22:42:43.734011528 +0100
> @@ -540,10 +540,6 @@
>  	if (result)
>  		return_VALUE(result);
>  
> -	result = acpi_processor_get_platform_limit(perf->pr);
> -	if (result)
> -		return_VALUE(result);
> -
>  	return_VALUE(0);
>  }
>  
> @@ -643,7 +639,6 @@
>  	int                     result = 0;
>  	int                     i = 0;
>  	struct acpi_processor   *pr = NULL;
> -	struct acpi_processor_performance *perf = NULL;
>  
>  	ACPI_FUNCTION_TRACE("acpi_cpufreq_init");
>  
> diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
> --- linux-original/drivers/acpi/processor.c	2004-01-13 22:40:29.754379528 +0100
> +++ linux/drivers/acpi/processor.c	2004-01-13 22:47:50.089438424 +0100
> @@ -746,7 +746,62 @@
>  /* --------------------------------------------------------------------------
>                                Performance Management
>     -------------------------------------------------------------------------- */
> -int 
> +#ifdef CONFIG_CPU_FREQ
> +
> +static DECLARE_MUTEX(performance_sem);
> +
> +/*
> + * _PPC support is implemented as a CPUfreq policy notifier: 
> + * This means each time a CPUfreq driver registered also with
> + * the ACPI core is asked to change the speed policy, the maximum
> + * value is adjusted so that it is within the platform limit.
> + * 
> + * Also, when a new platform limit value is detected, the CPUfreq
> + * policy is adjusted accordingly.
> + */
> +
> +static int acpi_processor_ppc_is_init = 0;
> +
> +static int acpi_processor_ppc_notifier(struct notifier_block *nb, 
> +	unsigned long event,
> +	void *data)
> +{
> +	struct cpufreq_policy *policy = data;
> +	struct acpi_processor *pr;
> +	unsigned int ppc = 0;
> +
> +	down(&performance_sem);
> +
> +	if (event != CPUFREQ_INCOMPATIBLE)
> +		goto out;
> +
> +	pr = processors[policy->cpu];
> +	if (!pr || !pr->performance)
> +		goto out;
> +
> +	ppc = (unsigned int) pr->performance_platform_limit;
> +	if (!ppc)
> +		goto out;
> +
> +	if (ppc > pr->performance->state_count)
> +		goto out;
> +
> +	cpufreq_verify_within_limits(policy, 0, 
> +		pr->performance->states[ppc].core_frequency * 1000);
> +
> + out:
> +	up(&performance_sem);
> +
> +	return 0;
> +}
> +
> +
> +static struct notifier_block acpi_ppc_notifier_block = {
> +	.notifier_call = acpi_processor_ppc_notifier,
> +};
> +
> +
> +static int
>  acpi_processor_get_platform_limit (
>  	struct acpi_processor*	pr)
>  {
> @@ -770,12 +825,38 @@
>  
>  	pr->performance_platform_limit = (int) ppc;
>  	
> -	acpi_processor_get_limit_info(pr);
> -	
>  	return_VALUE(0);
>  }
>  EXPORT_SYMBOL(acpi_processor_get_platform_limit);
>  
> +
> +static int acpi_processor_ppc_has_changed(
> +	struct acpi_processor *pr)
> +{
> +	int ret = acpi_processor_get_platform_limit(pr);
> +	if (ret < 0)
> +		return (ret);
> +	else
> +		return cpufreq_update_policy(pr->id);
> +}
> +
> +
> +static void acpi_processor_ppc_init(void) {
> +	if (!cpufreq_register_notifier(&acpi_ppc_notifier_block, CPUFREQ_POLICY_NOTIFIER))
> +		acpi_processor_ppc_is_init = 1;
> +	else
> +		printk(KERN_DEBUG "Warning: Processor Platform Limit not supported.\n");
> +}
> +
> +
> +static void acpi_processor_ppc_exit(void) {
> +	if (acpi_processor_ppc_is_init)
> +		cpufreq_unregister_notifier(&acpi_ppc_notifier_block, CPUFREQ_POLICY_NOTIFIER);
> +
> +	acpi_processor_ppc_is_init = 0;
> +}
> +
> +
>  int 
>  acpi_processor_register_performance (
>  	struct acpi_processor_performance * performance,
> @@ -784,21 +865,49 @@
>  {
>  	ACPI_FUNCTION_TRACE("acpi_processor_register_performance");
>  
> +	if (!acpi_processor_ppc_is_init)
> +		return_VALUE(-EINVAL);
> +
> +	down(&performance_sem);
> +
>  	*pr = processors[cpu];
> -	if (!*pr)
> +	if (!*pr) {
> +		up(&performance_sem);
>  		return_VALUE(-ENODEV);
> +	}
>  
> -	if ((*pr)->performance)
> +	if ((*pr)->performance) {
> +		up(&performance_sem);
>  		return_VALUE(-EBUSY);
> +	}
>  
>  	(*pr)->performance = performance;
>  	performance->pr = *pr;
> +
> +	up(&performance_sem);
>  	return 0;
>  }
>  EXPORT_SYMBOL(acpi_processor_register_performance);
>  
> -/* for the rest of it, check cpufreq/acpi.c */
>  
> +/* for the rest of it, check arch/i386/kernel/cpu/cpufreq/acpi.c */
> +
> +#else  /* !CONFIG_CPU_FREQ */
> +
> +static void acpi_processor_ppc_init(void) { return; }
> +static void acpi_processor_ppc_exit(void) { return; }
> +
> +static int acpi_processor_ppc_has_changed(struct acpi_processor *pr) {
> +	static unsigned int printout = 1;
> +	if (printout) {
> +		printk(KERN_WARNING "Warning: Processor Platform Limit event detected, but not handled.\n");
> +		printk(KERN_WARNING "Consider compiling CPUfreq support into your kernel.\n");
> +		printout = 0;
> +	}
> +	return 0;
> +}
> +
> +#endif /* CONFIG_CPU_FREQ */
>  
>  /* --------------------------------------------------------------------------
>                                Throttling Control
> @@ -1043,27 +1152,6 @@
>  	if (!pr->flags.limit)
>  		return_VALUE(-ENODEV);
>  
> -#ifdef CONFIG_CPU_FREQ
> -	if (pr->flags.performance) {
> -		px = pr->performance_platform_limit;
> -		if (pr->limit.user.px > px)
> -			px = pr->limit.user.px;
> -		if (pr->limit.thermal.px > px)
> -			px = pr->limit.thermal.px;
> -		{
> -			struct cpufreq_policy policy;
> -			policy.cpu = pr->id;
> -			cpufreq_get_policy(&policy, pr->id);
> -			policy.max = pr->performance->states[px].core_frequency * 1000; /* racy */
> -			result = cpufreq_set_policy(&policy);
> -		}
> -		if (result)
> -			goto end;
> -	} else if (pr->performance_platform_limit) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Platform limit event detected. Consider using ACPI P-States CPUfreq driver\n"));
> -	}
> -#endif
> -
>  	if (pr->flags.throttling) {
>  		if (pr->limit.user.tx > tx)
>  			tx = pr->limit.user.tx;
> @@ -1338,14 +1426,12 @@
>  			"bus mastering control:   %s\n"
>  			"power management:        %s\n"
>  			"throttling control:      %s\n"
> -			"performance management:  %s\n"
>  			"limit interface:         %s\n",
>  			pr->id,
>  			pr->acpi_id,
>  			pr->flags.bm_control ? "yes" : "no",
>  			pr->flags.power ? "yes" : "no",
>  			pr->flags.throttling ? "yes" : "no",
> -			pr->flags.performance ? "yes" : "no",
>  			pr->flags.limit ? "yes" : "no");
>  
>  end:
> @@ -1502,11 +1588,9 @@
>  	}
>  
>  	seq_printf(seq, "active limit:            P%d:T%d\n"
> -			"platform limit:          P%d:T0\n"
>  			"user limit:              P%d:T%d\n"
>  			"thermal limit:           P%d:T%d\n",
>  			pr->limit.state.px, pr->limit.state.tx,
> -			pr->flags.performance?pr->performance_platform_limit:0,
>  			pr->limit.user.px, pr->limit.user.tx,
>  			pr->limit.thermal.px, pr->limit.thermal.tx);
>  
> @@ -1553,15 +1637,6 @@
>  		return_VALUE(-EINVAL);
>  	}
>  
> -	if (pr->flags.performance) {
> -		if ((px < pr->performance_platform_limit) 
> -			|| (px > (pr->performance->state_count - 1))) {
> -			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid px\n"));
> -			return_VALUE(-EINVAL);
> -		}
> -		pr->limit.user.px = px;
> -	}
> -
>  	if (pr->flags.throttling) {
>  		if ((tx < 0) || (tx > (pr->throttling.state_count - 1))) {
>  			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid tx\n"));
> @@ -1741,9 +1816,9 @@
>  	}
>  
>  	acpi_processor_get_power_info(pr);
> -	pr->flags.performance = 0;
> -	pr->performance_platform_limit = 0;
> -	acpi_processor_get_platform_limit(pr);
> +#ifdef CONFIG_CPU_FREQ
> +	acpi_processor_ppc_has_changed(pr);
> +#endif
>  	acpi_processor_get_throttling_info(pr);
>  	acpi_processor_get_limit_info(pr);
>  
> @@ -1757,7 +1832,6 @@
>  	u32			event,
>  	void			*data)
>  {
> -	int			result = 0;
>  	struct acpi_processor	*pr = (struct acpi_processor *) data;
>  	struct acpi_device	*device = NULL;
>  
> @@ -1771,9 +1845,7 @@
>  
>  	switch (event) {
>  	case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
> -		result = acpi_processor_get_platform_limit(pr);
> -		if (!result)
> -			acpi_processor_apply_limit(pr);
> +		acpi_processor_ppc_has_changed(pr);
>  		acpi_bus_generate_event(device, event, 
>  			pr->performance_platform_limit);
>  		break;
> @@ -1921,6 +1993,8 @@
>  
>  	acpi_thermal_cpufreq_init();
>  
> +	acpi_processor_ppc_init();
> +
>  	return_VALUE(0);
>  }
>  
> @@ -1930,6 +2004,8 @@
>  {
>  	ACPI_FUNCTION_TRACE("acpi_processor_exit");
>  
> +	acpi_processor_ppc_exit();
> +
>  	acpi_thermal_cpufreq_exit();
>  
>  	acpi_bus_unregister_driver(&acpi_processor_driver);
> diff -ruN linux-original/include/acpi/processor.h linux/include/acpi/processor.h
> --- linux-original/include/acpi/processor.h	2004-01-11 21:56:50.000000000 +0100
> +++ linux/include/acpi/processor.h	2004-01-13 22:42:12.196805912 +0100
> @@ -131,8 +131,6 @@
>  	struct acpi_processor_limit limit;
>  };
>  
> -extern int acpi_processor_get_platform_limit (
> -	struct acpi_processor*	pr);
>  extern int acpi_processor_register_performance (
>  	struct acpi_processor_performance * performance,
>  	struct acpi_processor ** pr,
