From: Len Brown <lenb@kernel.org>
Subject: Re: [cpuidle 3/3] utilize max_cstate limit in acpi cpuidle driver
Date: Sun, 29 Apr 2007 00:41:30 -0400
Message-ID: <200704290041.31078.lenb@kernel.org>
References: <1177555209.11629.12.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57470 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754550AbXD2Ems (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:42:48 -0400
In-Reply-To: <1177555209.11629.12.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>

On Wednesday 25 April 2007 22:40, Shaohua Li wrote:
> With CPUIDLE framework, the max_cstate (to limit max cpu c-state) parameter is ingored. Some systems require it to ignore C2/C3 and some drivers like ipw require it too.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> ---
>  drivers/acpi/osl.c            |   10 ++++++++++
>  drivers/acpi/processor_core.c |    2 ++
>  drivers/acpi/processor_idle.c |   23 +++++++++++++++++++++--
>  include/acpi/processor.h      |    1 +
>  include/linux/acpi.h          |    7 ++-----
>  5 files changed, 36 insertions(+), 7 deletions(-)
> 
> Index: 21-rc6-mm1/drivers/acpi/osl.c
> ===================================================================
> --- 21-rc6-mm1.orig/drivers/acpi/osl.c	2007-04-26 10:06:41.000000000 +0800
> +++ 21-rc6-mm1/drivers/acpi/osl.c	2007-04-26 10:11:15.000000000 +0800
> @@ -996,6 +996,16 @@ unsigned int max_cstate = ACPI_PROCESSOR
>  
>  EXPORT_SYMBOL(max_cstate);
>  
> +void (*acpi_do_set_cstate_limit)(void);
> +EXPORT_SYMBOL(acpi_do_set_cstate_limit);

there must be a better name for this than ...do...


> +
> +void acpi_set_cstate_limit(unsigned int new_limit)
> +{
> +	max_cstate = new_limit;
> +	if (acpi_do_set_cstate_limit)
> +		acpi_do_set_cstate_limit();
> +}
> +
>  /*
>   * Acquire a spinlock.
>   *
> Index: 21-rc6-mm1/drivers/acpi/processor_core.c
> ===================================================================
> --- 21-rc6-mm1.orig/drivers/acpi/processor_core.c	2007-04-26 10:06:41.000000000 +0800
> +++ 21-rc6-mm1/drivers/acpi/processor_core.c	2007-04-26 10:11:15.000000000 +0800
> @@ -1030,11 +1030,13 @@ static int __init acpi_processor_init(vo
>  	acpi_processor_ppc_init();
>  
>  	cpuidle_register_driver(&acpi_idle_driver);
> +	acpi_do_set_cstate_limit = acpi_max_cstate_changed;
>  	return 0;
>  }
>  
>  static void __exit acpi_processor_exit(void)
>  {
> +	acpi_do_set_cstate_limit = NULL;
>  	cpuidle_unregister_driver(&acpi_idle_driver);
>  
>  	acpi_processor_ppc_exit();
> Index: 21-rc6-mm1/drivers/acpi/processor_idle.c
> ===================================================================
> --- 21-rc6-mm1.orig/drivers/acpi/processor_idle.c	2007-04-26 10:09:07.000000000 +0800
> +++ 21-rc6-mm1/drivers/acpi/processor_idle.c	2007-04-26 10:11:15.000000000 +0800
> @@ -75,7 +75,26 @@ ACPI_MODULE_NAME("processor_idle");
>  #define C2_OVERHEAD			1	/* 1us */
>  #define C3_OVERHEAD			1	/* 1us */
>  
> -module_param(max_cstate, uint, 0644);

but kernel-parameters.txt says this:

        processor.max_cstate=   [HW,ACPI]
                        Limit processor to maximum C-state
                        max_cstate=9 overrides any DMI blacklist limit.

> +void acpi_max_cstate_changed(void)
> +{
> +	/* Driver will reset devices' max cstate limit */
> +	cpuidle_force_redetect_devices(&acpi_idle_driver);
> +}
> +
> +static int change_max_cstate(const char *val, struct kernel_param *kp)
> +{
> +	int max;
> +
> +	max = simple_strtol(val, NULL, 0);
> +	if (!max)
> +		return -EINVAL;
> +	max_cstate = max;
> +	if (acpi_do_set_cstate_limit)
> +		acpi_do_set_cstate_limit();
> +	return 0;
> +}
> +
> +module_param_call(max_cstate, change_max_cstate, param_get_uint, &max_cstate, 0644);
>  
>  static unsigned int nocst __read_mostly;
>  module_param(nocst, uint, 0000);
> @@ -1055,7 +1074,7 @@ static int acpi_idle_init(struct cpuidle
>  		return -EINVAL;
>  	}
>  
> -	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
> +	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
>  		cx = &pr->power.states[i];
>  		state = &dev->states[count];
>  
> Index: 21-rc6-mm1/include/linux/acpi.h
> ===================================================================
> --- 21-rc6-mm1.orig/include/linux/acpi.h	2007-04-26 10:06:41.000000000 +0800
> +++ 21-rc6-mm1/include/linux/acpi.h	2007-04-26 10:11:15.000000000 +0800
> @@ -205,11 +205,8 @@ static inline unsigned int acpi_get_csta
>  {
>  	return max_cstate;
>  }
> -static inline void acpi_set_cstate_limit(unsigned int new_limit)
> -{
> -	max_cstate = new_limit;
> -	return;
> -}

WARNING: "acpi_set_cstate_limit" [drivers/net/wireless/ipw2100.ko] undefined!
make[1]: *** [__modpost] Error 1


> +extern void (*acpi_do_set_cstate_limit)(void);
> +extern void acpi_set_cstate_limit(unsigned int new_limit);
>  #else
>  static inline unsigned int acpi_get_cstate_limit(void) { return 0; }
>  static inline void acpi_set_cstate_limit(unsigned int new_limit) { return; }
> Index: 21-rc6-mm1/include/acpi/processor.h
> ===================================================================
> --- 21-rc6-mm1.orig/include/acpi/processor.h	2007-04-26 10:06:41.000000000 +0800
> +++ 21-rc6-mm1/include/acpi/processor.h	2007-04-26 10:11:15.000000000 +0800
> @@ -277,6 +277,7 @@ int acpi_processor_cst_has_changed(struc
>  int acpi_processor_power_exit(struct acpi_processor *pr,
>  			      struct acpi_device *device);
>  extern struct cpuidle_driver acpi_idle_driver;
> +void acpi_max_cstate_changed(void);
>  
>  /* in processor_thermal.c */
>  int acpi_processor_get_limit_info(struct acpi_processor *pr);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
