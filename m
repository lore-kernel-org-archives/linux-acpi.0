From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 2.6] (2/5) move /proc/acpi/processor/./performance
	output to drivers/acpi/processor.c
Date: 31 Jan 2004 00:43:57 -0500
Sender: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
Message-ID: <1075527836.2456.23.camel@dhcppc4>
References: <20040129105851.GB5372@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <20040129105851.GB5372@dominikbrodowski.de>
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

This means it will be pulled into AKPM's 2.6 mm tree on the next update,
and is in the test queue for early 2.6.3.

thanks Dominik,
-Len

On Thu, 2004-01-29 at 05:58, Dominik Brodowski wrote:
> Move the /proc/acpi/processor/./performance output to
> drivers/acpi/processor.c -- it's the same for all lowlevel drivers.
> 
> By doing so, the lowlevel drivers no longer need to have access to struct
> acpi_processor.
> 
>  arch/i386/kernel/cpu/cpufreq/acpi.c |  157 ------------------------------------
>  drivers/acpi/processor.c            |  153 ++++++++++++++++++++++++++++++++++-
>  include/acpi/processor.h            |    1
>  3 files changed, 155 insertions(+), 156 deletions(-)
> 
> 
> diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
> --- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-18 13:49:06.382927744 +0100
> +++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-18 13:52:03.771960512 +0100
> @@ -42,7 +42,6 @@
>  #define ACPI_PROCESSOR_CLASS		"processor"
>  #define ACPI_PROCESSOR_DRIVER_NAME	"ACPI Processor P-States Driver"
>  #define ACPI_PROCESSOR_DEVICE_NAME	"Processor"
> -#define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
>  
>  #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
>  ACPI_MODULE_NAME		("acpi_processor_perf")
> @@ -95,6 +94,7 @@
>  static int
>  acpi_processor_set_performance (
>  	struct acpi_processor_performance	*perf,
> +	unsigned int		cpu,
>  	int			state)
>  {
>  	u16			port = 0;
> @@ -106,7 +106,7 @@
>  
>  	ACPI_FUNCTION_TRACE("acpi_processor_set_performance");
>  
> -	if (!perf || !perf->pr)
> +	if (!perf)
>  		return_VALUE(-EINVAL);
>  
>  	if (state >= perf->state_count) {
> @@ -125,7 +125,7 @@
>  		perf->state, state));
>  
>  	/* cpufreq frequency struct */
> -	cpufreq_freqs.cpu = perf->pr->id;
> +	cpufreq_freqs.cpu = cpu;
>  	cpufreq_freqs.old = perf->states[perf->state].core_frequency * 1000;
>  	cpufreq_freqs.new = perf->states[state].core_frequency * 1000;
>  
> @@ -200,152 +200,6 @@
>  }
>  
> 
> -#ifdef CONFIG_X86_ACPI_CPUFREQ_PROC_INTF
> -/* /proc/acpi/processor/../performance interface (DEPRECATED) */
> -
> -static int acpi_processor_perf_open_fs(struct inode *inode, struct file *file);
> -static struct file_operations acpi_processor_perf_fops = {
> -	.open 		= acpi_processor_perf_open_fs,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> -
> -static int acpi_processor_perf_seq_show(struct seq_file *seq, void *offset)
> -{
> -	struct acpi_processor	*pr = (struct acpi_processor *)seq->private;
> -	int			i = 0;
> -
> -	ACPI_FUNCTION_TRACE("acpi_processor_perf_seq_show");
> -
> -	if (!pr)
> -		goto end;
> -
> -	if (!pr->performance) {
> -		seq_puts(seq, "<not supported>\n");
> -		goto end;
> -	}
> -
> -	seq_printf(seq, "state count:             %d\n"
> -			"active state:            P%d\n",
> -			pr->performance->state_count,
> -			pr->performance->state);
> -
> -	seq_puts(seq, "states:\n");
> -	for (i = 0; i < pr->performance->state_count; i++)
> -		seq_printf(seq, "   %cP%d:                  %d MHz, %d mW, %d uS\n",
> -			(i == pr->performance->state?'*':' '), i,
> -			(u32) pr->performance->states[i].core_frequency,
> -			(u32) pr->performance->states[i].power,
> -			(u32) pr->performance->states[i].transition_latency);
> -
> -end:
> -	return 0;
> -}
> -
> -static int acpi_processor_perf_open_fs(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, acpi_processor_perf_seq_show,
> -						PDE(inode)->data);
> -}
> -
> -static int
> -acpi_processor_write_performance (
> -        struct file		*file,
> -        const char		__user *buffer,
> -        size_t			count,
> -        loff_t			*data)
> -{
> -	int			result = 0;
> -	struct seq_file		*m = (struct seq_file *) file->private_data;
> -	struct acpi_processor	*pr = (struct acpi_processor *) m->private;
> -	struct acpi_processor_performance *perf;
> -	char			state_string[12] = {'\0'};
> -	unsigned int            new_state = 0;
> -	struct cpufreq_policy   policy;
> -
> -	ACPI_FUNCTION_TRACE("acpi_processor_write_performance");
> -
> -	if (!pr || (count > sizeof(state_string) - 1))
> -		return_VALUE(-EINVAL);
> -
> -	perf = pr->performance;
> -	if (!perf)
> -		return_VALUE(-EINVAL);
> -	
> -	if (copy_from_user(state_string, buffer, count))
> -		return_VALUE(-EFAULT);
> -	
> -	state_string[count] = '\0';
> -	new_state = simple_strtoul(state_string, NULL, 0);
> -
> -	if (new_state >= perf->state_count)
> -		return_VALUE(-EINVAL);
> -
> -	cpufreq_get_policy(&policy, pr->id);
> -
> -	policy.cpu = pr->id;
> -	policy.min = perf->states[new_state].core_frequency * 1000;
> -	policy.max = perf->states[new_state].core_frequency * 1000;
> -
> -	result = cpufreq_set_policy(&policy);
> -	if (result)
> -		return_VALUE(result);
> -
> -	return_VALUE(count);
> -}
> -
> -static void
> -acpi_cpufreq_add_file (
> -	struct acpi_processor *pr)
> -{
> -	struct proc_dir_entry	*entry = NULL;
> -	struct acpi_device	*device = NULL;
> -
> -	ACPI_FUNCTION_TRACE("acpi_cpufreq_addfile");
> -
> -	if (acpi_bus_get_device(pr->handle, &device))
> -		return_VOID;
> -
> -	/* add file 'performance' [R/W] */
> -	entry = create_proc_entry(ACPI_PROCESSOR_FILE_PERFORMANCE,
> -		  S_IFREG|S_IRUGO|S_IWUSR, acpi_device_dir(device));
> -	if (!entry)
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> -			"Unable to create '%s' fs entry\n",
> -			ACPI_PROCESSOR_FILE_PERFORMANCE));
> -	else {
> -		entry->proc_fops = &acpi_processor_perf_fops;
> -		entry->proc_fops->write = acpi_processor_write_performance;
> -		entry->data = acpi_driver_data(device);
> -	}
> -	return_VOID;
> -}
> -
> -static void
> -acpi_cpufreq_remove_file (
> -	struct acpi_processor *pr)
> -{
> -	struct acpi_device	*device = NULL;
> -
> -	ACPI_FUNCTION_TRACE("acpi_cpufreq_addfile");
> -
> -	if (acpi_bus_get_device(pr->handle, &device))
> -		return_VOID;
> -
> -	/* remove file 'performance' */
> -	remove_proc_entry(ACPI_PROCESSOR_FILE_PERFORMANCE,
> -		  acpi_device_dir(device));
> -
> -	return_VOID;
> -}
> -
> -#else
> -static void acpi_cpufreq_add_file (struct acpi_processor *pr) { return; }
> -static void acpi_cpufreq_remove_file (struct acpi_processor *pr) { return; }
> -#endif /* CONFIG_X86_ACPI_CPUFREQ_PROC_INTF */
> -
> -
>  static int
>  acpi_cpufreq_target (
>  	struct cpufreq_policy   *policy,
> @@ -366,7 +220,7 @@
>  	if (result)
>  		return_VALUE(result);
>  
> -	result = acpi_processor_set_performance (perf, next_state);
> +	result = acpi_processor_set_performance (perf, policy->cpu, next_state);
>  
>  	return_VALUE(result);
>  }
> @@ -445,8 +299,6 @@
>  
>  	result = cpufreq_frequency_table_cpuinfo(policy, &perf->freq_table[0]);
>  
> -	acpi_cpufreq_add_file(perf->pr);
> -
>  	printk(KERN_INFO "cpufreq: CPU%u - ACPI performance management activated.\n",
>  	       cpu);
>  	for (i = 0; i < perf->state_count; i++)
> @@ -477,7 +329,6 @@
>  	ACPI_FUNCTION_TRACE("acpi_cpufreq_cpu_exit");
>  
>  	if (perf) {
> -		acpi_cpufreq_remove_file(perf->pr);
>  		performance[policy->cpu] = NULL;
>  		acpi_processor_unregister_performance(perf, policy->cpu);
>  		kfree(perf);
> diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
> --- linux-original/drivers/acpi/processor.c	2004-01-18 13:49:06.422921664 +0100
> +++ linux/drivers/acpi/processor.c	2004-01-18 13:50:51.972875632 +0100
> @@ -58,6 +58,7 @@
>  #define ACPI_PROCESSOR_FILE_POWER	"power"
>  #define ACPI_PROCESSOR_FILE_THROTTLING	"throttling"
>  #define ACPI_PROCESSOR_FILE_LIMIT	"limit"
> +#define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
>  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
>  #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
>  
> @@ -1067,6 +1068,152 @@
>  }
>  
> 
> +#ifdef CONFIG_X86_ACPI_CPUFREQ_PROC_INTF
> +/* /proc/acpi/processor/../performance interface (DEPRECATED) */
> +
> +static int acpi_processor_perf_open_fs(struct inode *inode, struct file *file);
> +static struct file_operations acpi_processor_perf_fops = {
> +	.open 		= acpi_processor_perf_open_fs,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int acpi_processor_perf_seq_show(struct seq_file *seq, void *offset)
> +{
> +	struct acpi_processor	*pr = (struct acpi_processor *)seq->private;
> +	int			i = 0;
> +
> +	ACPI_FUNCTION_TRACE("acpi_processor_perf_seq_show");
> +
> +	if (!pr)
> +		goto end;
> +
> +	if (!pr->performance) {
> +		seq_puts(seq, "<not supported>\n");
> +		goto end;
> +	}
> +
> +	seq_printf(seq, "state count:             %d\n"
> +			"active state:            P%d\n",
> +			pr->performance->state_count,
> +			pr->performance->state);
> +
> +	seq_puts(seq, "states:\n");
> +	for (i = 0; i < pr->performance->state_count; i++)
> +		seq_printf(seq, "   %cP%d:                  %d MHz, %d mW, %d uS\n",
> +			(i == pr->performance->state?'*':' '), i,
> +			(u32) pr->performance->states[i].core_frequency,
> +			(u32) pr->performance->states[i].power,
> +			(u32) pr->performance->states[i].transition_latency);
> +
> +end:
> +	return 0;
> +}
> +
> +static int acpi_processor_perf_open_fs(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, acpi_processor_perf_seq_show,
> +						PDE(inode)->data);
> +}
> +
> +static int
> +acpi_processor_write_performance (
> +        struct file		*file,
> +        const char		__user *buffer,
> +        size_t			count,
> +        loff_t			*data)
> +{
> +	int			result = 0;
> +	struct seq_file		*m = (struct seq_file *) file->private_data;
> +	struct acpi_processor	*pr = (struct acpi_processor *) m->private;
> +	struct acpi_processor_performance *perf;
> +	char			state_string[12] = {'\0'};
> +	unsigned int            new_state = 0;
> +	struct cpufreq_policy   policy;
> +
> +	ACPI_FUNCTION_TRACE("acpi_processor_write_performance");
> +
> +	if (!pr || (count > sizeof(state_string) - 1))
> +		return_VALUE(-EINVAL);
> +
> +	perf = pr->performance;
> +	if (!perf)
> +		return_VALUE(-EINVAL);
> +	
> +	if (copy_from_user(state_string, buffer, count))
> +		return_VALUE(-EFAULT);
> +	
> +	state_string[count] = '\0';
> +	new_state = simple_strtoul(state_string, NULL, 0);
> +
> +	if (new_state >= perf->state_count)
> +		return_VALUE(-EINVAL);
> +
> +	cpufreq_get_policy(&policy, pr->id);
> +
> +	policy.cpu = pr->id;
> +	policy.min = perf->states[new_state].core_frequency * 1000;
> +	policy.max = perf->states[new_state].core_frequency * 1000;
> +
> +	result = cpufreq_set_policy(&policy);
> +	if (result)
> +		return_VALUE(result);
> +
> +	return_VALUE(count);
> +}
> +
> +static void
> +acpi_cpufreq_add_file (
> +	struct acpi_processor *pr)
> +{
> +	struct proc_dir_entry	*entry = NULL;
> +	struct acpi_device	*device = NULL;
> +
> +	ACPI_FUNCTION_TRACE("acpi_cpufreq_addfile");
> +
> +	if (acpi_bus_get_device(pr->handle, &device))
> +		return_VOID;
> +
> +	/* add file 'performance' [R/W] */
> +	entry = create_proc_entry(ACPI_PROCESSOR_FILE_PERFORMANCE,
> +		  S_IFREG|S_IRUGO|S_IWUSR, acpi_device_dir(device));
> +	if (!entry)
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +			"Unable to create '%s' fs entry\n",
> +			ACPI_PROCESSOR_FILE_PERFORMANCE));
> +	else {
> +		entry->proc_fops = &acpi_processor_perf_fops;
> +		entry->proc_fops->write = acpi_processor_write_performance;
> +		entry->data = acpi_driver_data(device);
> +	}
> +	return_VOID;
> +}
> +
> +static void
> +acpi_cpufreq_remove_file (
> +	struct acpi_processor *pr)
> +{
> +	struct acpi_device	*device = NULL;
> +
> +	ACPI_FUNCTION_TRACE("acpi_cpufreq_addfile");
> +
> +	if (acpi_bus_get_device(pr->handle, &device))
> +		return_VOID;
> +
> +	/* remove file 'performance' */
> +	remove_proc_entry(ACPI_PROCESSOR_FILE_PERFORMANCE,
> +		  acpi_device_dir(device));
> +
> +	return_VOID;
> +}
> +
> +#else
> +static void acpi_cpufreq_add_file (struct acpi_processor *pr) { return; }
> +static void acpi_cpufreq_remove_file (struct acpi_processor *pr) { return; }
> +#endif /* CONFIG_X86_ACPI_CPUFREQ_PROC_INTF */
> +
> +
>  int 
>  acpi_processor_register_performance (
>  	struct acpi_processor_performance * performance,
> @@ -1093,7 +1240,6 @@
>  	}
>  
>  	pr->performance = performance;
> -	performance->pr = pr;
>  
>  	if (acpi_processor_get_performance_info(pr)) {
>  		pr->performance = NULL;
> @@ -1101,6 +1247,8 @@
>  		return_VALUE(-EIO);
>  	}
>  
> +	acpi_cpufreq_add_file(pr);
> +
>  	up(&performance_sem);
>  	return_VALUE(0);
>  }
> @@ -1128,7 +1276,8 @@
>  	}
>  
>  	pr->performance = NULL;
> -	performance->pr = NULL;
> +
> +	acpi_cpufreq_remove_file(pr);
>  
>  	up(&performance_sem);
>  
> diff -ruN linux-original/include/acpi/processor.h linux/include/acpi/processor.h
> --- linux-original/include/acpi/processor.h	2004-01-18 13:12:13.822288088 +0100
> +++ linux/include/acpi/processor.h	2004-01-18 13:49:27.640696072 +0100
> @@ -77,7 +77,6 @@
>  	int			state_count;
>  	struct acpi_processor_px states[ACPI_PROCESSOR_MAX_PERFORMANCE];
>  	struct cpufreq_frequency_table freq_table[ACPI_PROCESSOR_MAX_PERFORMANCE];
> -	struct acpi_processor   *pr;
>  };
>  
> 
