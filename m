From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 2.6] remove unnecessary check in acpi-cpufreq driver
Date: 28 Jan 2004 17:44:08 -0500
Sender: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
Message-ID: <1075329848.2499.103.camel@dhcppc4>
References: <20040111210059.GA26722@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <20040111210059.GA26722@dominikbrodowski.de>
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

On Sun, 2004-01-11 at 16:00, Dominik Brodowski wrote:
> The acpi cpufreq driver includes a test at startup which detects whether
> ACPI P-States are supported on any CPU, and whether transitions work.
> However, this test is faulty: it is only run _after_ the acpi driver is
> registered, causing race situations. Also, it doesn't save anything _as_ the
> driver is already registered. So, it can safely be removed.
> 
>  arch/i386/kernel/cpu/cpufreq/acpi.c |   74 ++++--------------------------------
>  1 files changed, 10 insertions(+), 64 deletions(-)
> 
> diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
> --- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-11 20:50:52.000000000 +0100
> +++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-11 20:57:10.927599960 +0100
> @@ -1,9 +1,9 @@
>  /*
> - * acpi_processor_perf.c - ACPI Processor P-States Driver ($Revision: 1.3 $)
> + * acpi-cpufreq-io.c - ACPI Processor P-States Driver ($Revision: 1.3 $)
>   *
>   *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
>   *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
> - *  Copyright (C) 2002, 2003 Dominik Brodowski <linux@brodo.de>
> + *  Copyright (C) 2002 - 2004 Dominik Brodowski <linux@brodo.de>
>   *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   *
> @@ -641,7 +641,6 @@
>  acpi_cpufreq_init (void)
>  {
>  	int                     result = 0;
> -	int                     current_state = 0;
>  	int                     i = 0;
>  	struct acpi_processor   *pr = NULL;
>  	struct acpi_processor_performance *perf = NULL;
> @@ -649,9 +648,6 @@
>  	ACPI_FUNCTION_TRACE("acpi_cpufreq_init");
>  
>  	/* alloc memory */
> -	if (performance)
> -		return_VALUE(-EBUSY);
> -
>  	performance = kmalloc(NR_CPUS * sizeof(struct acpi_processor_performance), GFP_KERNEL);
>  	if (!performance)
>  		return_VALUE(-ENOMEM);
> @@ -669,69 +665,19 @@
>  			result = acpi_processor_get_performance_info(&performance[i]);
>  	}
>  
> -	/* test it on one CPU */
> -	for (i=0; i<NR_CPUS; i++) {
> -		if (!cpu_online(i))
> -			continue;
> -		pr = performance[i].pr;
> -		if (pr && pr->flags.performance)
> -			goto found_capable_cpu;
> -	}
> -	result = -ENODEV;
> -	goto err0;
> -
> - found_capable_cpu:
> -	
>   	result = cpufreq_register_driver(&acpi_cpufreq_driver);
> -	if (result) 
> -		goto err0;
> -	
> -	perf = pr->performance;
> -	current_state = perf->state;
> -
> -	if (current_state == pr->limit.state.px) {
> -		result = acpi_processor_set_performance(perf, (perf->state_count - 1));
> -		if (result) {
> -			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Disabled P-States due to failure while switching.\n"));
> -			result = -ENODEV;
> -			goto err1;
> -		}
> -	}
> -
> -	result = acpi_processor_set_performance(perf, pr->limit.state.px);
>  	if (result) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Disabled P-States due to failure while switching.\n"));
> -		result = -ENODEV;
> -		goto err1;
> -	}
> -	
> -	if (current_state != 0) {
> -		result = acpi_processor_set_performance(perf, current_state);
> -		if (result) {
> -			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Disabled P-States due to failure while switching.\n"));
> -			result = -ENODEV;
> -			goto err1;
> +		/* unregister struct acpi_processor_performance performance */
> +		for (i=0; i<NR_CPUS; i++) {
> +			if (performance[i].pr) {
> +				performance[i].pr->flags.performance = 0;
> +				performance[i].pr->performance = NULL;
> +				performance[i].pr = NULL;
> +			}
>  		}
> +		kfree(performance);
>  	}
> -
> -	return_VALUE(0);
> -
> -	/* error handling */
> - err1:
> -	cpufreq_unregister_driver(&acpi_cpufreq_driver);
> -	
> - err0:
> -	/* unregister struct acpi_processor_performance performance */
> -	for (i=0; i<NR_CPUS; i++) {
> -		if (performance[i].pr) {
> -			performance[i].pr->flags.performance = 0;
> -			performance[i].pr->performance = NULL;
> -			performance[i].pr = NULL;
> -		}
> -	}
> -	kfree(performance);
>  	
> -	printk(KERN_INFO "cpufreq: No CPUs supporting ACPI performance management found.\n");
>  	return_VALUE(result);
>  }
>  
