From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Fix acpi_processor_idle and idle= boot parameter interaction
Date: Wed, 30 Apr 2008 22:12:01 -0400
Message-ID: <200804302212.01674.lenb@kernel.org>
References: <20080429225726.GA27244@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43485 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423AbYEACMU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2008 22:12:20 -0400
In-Reply-To: <20080429225726.GA27244@linux-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org

This is upstream now.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=36a913586597cab1cd565e9bf348d037f0df955b

thanks,
-Len

On Tuesday 29 April 2008, Venki Pallipadi wrote:
> 
> acpi_processor_idle and "idle=" boot parameter interaction is broken.
> The problem is that, at boot time acpi driver is checking for "idle=" boot
> option and not registering the acpi idle handler. But, when there is a CST
> changed callback (typically when switching AC <-> battery or suspend-resume)
> there are no checks for boot_option_idle_override and acpi idle handler tries
> to get installed with nasty side effects.
> 
> With CPU_IDLE configured this issue causes results in a nasty oops on CST
> change callback and without CPU_IDLE there is no oops, but boot option
> of "idle=" gets ignored and acpi idle handler gets installed.
> 
> Change the behavior to not do anything in acpi idle handler when there is a
> "idle=" boot option.
> 
> Note that the problem is only there when "idle=" boot option is used.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> ---
>  drivers/acpi/processor_idle.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/processor_idle.c	2008-04-29 14:28:06.000000000 -0700
> +++ linux-2.6/drivers/acpi/processor_idle.c	2008-04-29 14:28:13.000000000 -0700
> @@ -1295,6 +1295,8 @@ int acpi_processor_cst_has_changed(struc
>  {
>  	int result = 0;
>  
> +	if (boot_option_idle_override)
> +		return 0;
>  
>  	if (!pr)
>  		return -EINVAL;
> @@ -1734,6 +1736,9 @@ int acpi_processor_cst_has_changed(struc
>  {
>  	int ret;
>  
> +	if (boot_option_idle_override)
> +		return 0;
> +
>  	if (!pr)
>  		return -EINVAL;
>  
> @@ -1764,6 +1769,8 @@ int __cpuinit acpi_processor_power_init(
>  	struct proc_dir_entry *entry = NULL;
>  	unsigned int i;
>  
> +	if (boot_option_idle_override)
> +		return 0;
>  
>  	if (!first_run) {
>  		dmi_check_system(processor_power_dmi_table);
> @@ -1799,7 +1806,7 @@ int __cpuinit acpi_processor_power_init(
>  	 * Note that we use previously set idle handler will be used on
>  	 * platforms that only support C1.
>  	 */
> -	if ((pr->flags.power) && (!boot_option_idle_override)) {
> +	if (pr->flags.power) {
>  #ifdef CONFIG_CPU_IDLE
>  		acpi_processor_setup_cpuidle(pr);
>  		pr->power.dev.cpu = pr->id;
> @@ -1835,8 +1842,11 @@ int __cpuinit acpi_processor_power_init(
>  int acpi_processor_power_exit(struct acpi_processor *pr,
>  			      struct acpi_device *device)
>  {
> +	if (boot_option_idle_override)
> +		return 0;
> +
>  #ifdef CONFIG_CPU_IDLE
> -	if ((pr->flags.power) && (!boot_option_idle_override))
> +	if (pr->flags.power)
>  		cpuidle_unregister_device(&pr->power.dev);
>  #endif
>  	pr->flags.power_setup_done = 0;
> 


