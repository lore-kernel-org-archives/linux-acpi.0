From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 2.6] update passive cooling algorithm
Date: 28 Jan 2004 17:43:27 -0500
Sender: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
Message-ID: <1075329807.2484.97.camel@dhcppc4>
References: <20040111211255.GA31105@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <20040111211255.GA31105@dominikbrodowski.de>
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

On Sun, 2004-01-11 at 16:12, Dominik Brodowski wrote:
> [Len, could you test and verify this patch, and push it to Linus, please?]
> 
> The current algorithm used by Linux ACPI for passive thermal management has
> two shortcomings:
> 
> - if increasing the CPU processing power as a thermal situation goes away,
>   throttling states are decreased later than performance states. This is
>   not wise -- it should be the opposite ordering of going "up".
> 
> - only if the ACPI CPUfreq driver is used, performance states are used.
>   A generalized approach would offer passive cooling even if the ACPI
>   P-States cpufreq driver cannot be used (faulty BIOS, FixedHW access, etc.)
> 
> The attached patch addresses these issues.
> 
>  drivers/acpi/processor.c |  182 +++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 146 insertions(+), 36 deletions(-)
> 
> diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
> --- linux-original/drivers/acpi/processor.c	2004-01-11 20:51:17.000000000 +0100
> +++ linux/drivers/acpi/processor.c	2004-01-11 21:39:43.000000000 +0100
> @@ -1091,6 +1091,113 @@
>  }
>  
> 
> +#ifdef CONFIG_CPU_FREQ
> +
> +/* If a passive cooling situation is detected, primarily CPUfreq is used, as it
> + * offers (in most cases) voltage scaling in addition to frequency scaling, and
> + * thus a cubic (instead of linear) reduction of energy. Also, we allow for
> + * _any_ cpufreq driver and not only the acpi-cpufreq driver.
> + */
> +
> +static unsigned int cpufreq_thermal_reduction_pctg[NR_CPUS];
> +static unsigned int acpi_thermal_cpufreq_is_init = 0;
> +
> +
> +static int cpu_has_cpufreq(unsigned int cpu)
> +{
> +	struct cpufreq_policy policy;
> +	if (!acpi_thermal_cpufreq_is_init)
> +		return -ENODEV;
> +	if (!cpufreq_get_policy(&policy, cpu))
> +		return -ENODEV;
> +	return 0;
> +}
> +
> +
> +static int acpi_thermal_cpufreq_increase(unsigned int cpu)
> +{
> +	if (!cpu_has_cpufreq)
> +		return -ENODEV;
> +
> +	if (cpufreq_thermal_reduction_pctg[cpu] < 60) {
> +		cpufreq_thermal_reduction_pctg[cpu] += 20;
> +		cpufreq_update_policy(cpu);
> +		return 0;
> +	}
> +
> +	return -ERANGE;
> +}
> +
> +
> +static int acpi_thermal_cpufreq_decrease(unsigned int cpu)
> +{
> +	if (!cpu_has_cpufreq)
> +		return -ENODEV;
> +
> +	if (cpufreq_thermal_reduction_pctg[cpu] >= 20) {
> +		cpufreq_thermal_reduction_pctg[cpu] -= 20;
> +		cpufreq_update_policy(cpu);
> +		return 0;
> +	}
> +
> +	return -ERANGE;
> +}
> +
> +
> +static int acpi_thermal_cpufreq_notifier(
> +	struct notifier_block *nb,
> +	unsigned long event,
> +	void *data)
> +{
> +	struct cpufreq_policy *policy = data;
> +	unsigned long max_freq = 0;
> +
> +	if (event != CPUFREQ_ADJUST)
> +		goto out;
> +
> +	max_freq = (policy->cpuinfo.max_freq * (100 - cpufreq_thermal_reduction_pctg[policy->cpu])) / 100;
> +
> +	cpufreq_verify_within_limits(policy, 0, max_freq);
> +
> + out:
> +	return 0;
> +}
> +
> +
> +static struct notifier_block acpi_thermal_cpufreq_notifier_block = {
> +	.notifier_call = acpi_thermal_cpufreq_notifier,
> +};
> +
> +
> +static void acpi_thermal_cpufreq_init(void) {
> +	int i;
> +
> +	for (i=0; i<NR_CPUS; i++)
> +		cpufreq_thermal_reduction_pctg[i] = 0;
> +
> +	i = cpufreq_register_notifier(&acpi_thermal_cpufreq_notifier_block, CPUFREQ_POLICY_NOTIFIER);
> +	if (!i)
> +		acpi_thermal_cpufreq_is_init = 1;
> +}
> +
> +static void acpi_thermal_cpufreq_exit(void) {
> +	if (acpi_thermal_cpufreq_is_init)
> +		cpufreq_unregister_notifier(&acpi_thermal_cpufreq_notifier_block, CPUFREQ_POLICY_NOTIFIER);
> +
> +	acpi_thermal_cpufreq_is_init = 0;
> +}
> +
> +#else /* ! CONFIG_CPU_FREQ */
> +
> +static void acpi_thermal_cpufreq_init(void) { return; }
> +static void acpi_thermal_cpufreq_exit(void) { return; }
> +static int acpi_thermal_cpufreq_increase(unsigned int cpu) { return -ENODEV; }
> +static int acpi_thermal_cpufreq_decrease(unsigned int cpu) { return -ENODEV; }
> +
> +
> +#endif
> +
> +
>  int
>  acpi_processor_set_thermal_limit (
>  	acpi_handle		handle,
> @@ -1099,7 +1206,6 @@
>  	int			result = 0;
>  	struct acpi_processor	*pr = NULL;
>  	struct acpi_device	*device = NULL;
> -	int			px = 0;
>  	int			tx = 0;
>  
>  	ACPI_FUNCTION_TRACE("acpi_processor_set_thermal_limit");
> @@ -1116,12 +1222,7 @@
>  	if (!pr)
>  		return_VALUE(-ENODEV);
>  
> -	if (!pr->flags.limit)
> -		return_VALUE(-ENODEV);
> -
>  	/* Thermal limits are always relative to the current Px/Tx state. */
> -	if (pr->flags.performance)
> -		pr->limit.thermal.px = pr->performance->state;
>  	if (pr->flags.throttling)
>  		pr->limit.thermal.tx = pr->throttling.state;
>  
> @@ -1130,26 +1231,27 @@
>  	 * performance state.
>  	 */
>  
> -	px = pr->limit.thermal.px;
>  	tx = pr->limit.thermal.tx;
>  
>  	switch (type) {
>  
>  	case ACPI_PROCESSOR_LIMIT_NONE:
> -		px = 0;
> +		do {
> +			result = acpi_thermal_cpufreq_decrease(pr->id);
> +		} while (!result);
>  		tx = 0;
>  		break;
>  
>  	case ACPI_PROCESSOR_LIMIT_INCREMENT:
> -		if (pr->flags.performance) {
> -			if (px == (pr->performance->state_count - 1))
> -				ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> +		/* if going up: P-states first, T-states later */
> +
> +		result = acpi_thermal_cpufreq_increase(pr->id);
> +		if (!result)
> +			goto end;
> +		else if (result == -ERANGE)
> +			ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
>  					"At maximum performance state\n"));
> -			else {
> -				px++;
> -				goto end;
> -			}
> -		}
> +
>  		if (pr->flags.throttling) {
>  			if (tx == (pr->throttling.state_count - 1))
>  				ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> @@ -1160,37 +1262,41 @@
>  		break;
>  
>  	case ACPI_PROCESSOR_LIMIT_DECREMENT:
> -		if (pr->flags.performance) {
> -			if (px == pr->performance_platform_limit)
> -				ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> -					"At minimum performance state\n"));
> -			else  {
> -				px--;
> -				goto end;
> -			}
> -		}
> +		/* if going down: T-states first, P-states later */
> +
>  		if (pr->flags.throttling) {
>  			if (tx == 0)
>  				ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
>  					"At minimum throttling state\n"));
> -			else
> +			else {
>  				tx--;
> +				goto end;
> +			}
>  		}
> +
> +		result = acpi_thermal_cpufreq_decrease(pr->id);
> +		if (result == -ERANGE)
> +			ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> +					"At minimum performance state\n"));
> +
>  		break;
>  	}
>  
>  end:
> -	pr->limit.thermal.px = px;
> -	pr->limit.thermal.tx = tx;
> -
> -	result = acpi_processor_apply_limit(pr);
> -	if (result)
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
> -			"Unable to set thermal limit\n"));
> +	if (pr->flags.throttling) {
> +		pr->limit.thermal.px = 0;
> +		pr->limit.thermal.tx = tx;
>  
> -	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Thermal limit now (P%d:T%d)\n",
> -		pr->limit.thermal.px,
> -		pr->limit.thermal.tx));
> +		result = acpi_processor_apply_limit(pr);
> +		if (result)
> +			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
> +					  "Unable to set thermal limit\n"));
> +
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Thermal limit now (P%d:T%d)\n",
> +				  pr->limit.thermal.px,
> +				  pr->limit.thermal.tx));
> +	} else
> +		result = 0;
>  
>  	return_VALUE(result);
>  }
> @@ -1813,6 +1919,8 @@
>  		return_VALUE(-ENODEV);
>  	}
>  
> +	acpi_thermal_cpufreq_init();
> +
>  	return_VALUE(0);
>  }
>  
> @@ -1822,6 +1930,8 @@
>  {
>  	ACPI_FUNCTION_TRACE("acpi_processor_exit");
>  
> +	acpi_thermal_cpufreq_exit();
> +
>  	acpi_bus_unregister_driver(&acpi_processor_driver);
>  
>  	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
