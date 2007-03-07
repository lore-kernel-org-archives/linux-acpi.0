From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/6] git-acpi-fix-cpuidle-borkage 2
Date: Wed, 7 Mar 2007 03:01:47 -0500
Message-ID: <200703070301.48192.lenb@kernel.org>
References: <200703061029.l26ATdeL019116@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58043 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964923AbXCGICu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Mar 2007 03:02:50 -0500
In-Reply-To: <200703061029.l26ATdeL019116@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, abelay@novell.com, shaohua.li@intel.com

Applied.

thanks,
-Len

On Tuesday 06 March 2007 05:29, akpm@linux-foundation.org wrote:
> From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Fix the compile issues when CPU_IDLE is not configured.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Cc: Adam Belay <abelay@novell.com>
> Cc: Shaohua Li <shaohua.li@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  include/linux/cpuidle.h |   23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff -puN include/linux/cpuidle.h~git-acpi-fix-cpuidle-borkage-2 include/linux/cpuidle.h
> --- a/include/linux/cpuidle.h~git-acpi-fix-cpuidle-borkage-2
> +++ a/include/linux/cpuidle.h
> @@ -130,10 +130,21 @@ struct cpuidle_driver {
>  	struct module 		*owner;
>  };
>  
> +#ifdef CONFIG_CPU_IDLE
> +
>  extern int cpuidle_register_driver(struct cpuidle_driver *drv);
>  extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
>  extern int cpuidle_force_redetect(struct cpuidle_device *dev);
>  
> +#else
> +
> +static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
> +{return 0;}
> +static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
> +static inline int cpuidle_force_redetect(struct cpuidle_device *dev)
> +{return 0;}
> +
> +#endif
>  
>  /******************************
>   * CPUIDLE GOVERNOR INTERFACE *
> @@ -153,8 +164,20 @@ struct cpuidle_governor {
>  	struct module 		*owner;
>  };
>  
> +#ifdef CONFIG_CPU_IDLE
> +
>  extern int cpuidle_register_governor(struct cpuidle_governor *gov);
>  extern void cpuidle_unregister_governor(struct cpuidle_governor *gov);
>  extern int cpuidle_get_bm_activity(void);
>  
> +#else
> +
> +static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
> +{return 0;}
> +static inline void cpuidle_unregister_governor(struct cpuidle_governor *gov) { }
> +static inline int cpuidle_get_bm_activity(void)
> +{return 0;}
> +
> +#endif
> +
>  #endif /* _LINUX_CPUIDLE_H */
> _
> 
