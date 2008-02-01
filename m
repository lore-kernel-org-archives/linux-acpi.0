From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Date: Fri, 1 Feb 2008 02:40:36 +0100
Message-ID: <200802010240.36693.rjw@sisk.pl>
References: <200801301116.44902.rjw@sisk.pl> <924EFEDD5F540B4284297C4DC59F3DEE720540@orsmsx423.amr.corp.intel.com> <871w7x5utp.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56351 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbYBABmb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jan 2008 20:42:31 -0500
In-Reply-To: <871w7x5utp.fsf@paris.hilman.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Friday, 1 of February 2008, Kevin Hilman wrote:
> OK, one more (last?) time.  :)

Er, no.

> Convert cpu_idle_wait() to cpuidle_kick_cpus() macro which is
> SMP-only, and gives error on non supported CPU.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 80b7ba4..a3e8ef4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -105,6 +105,9 @@ config ARCH_HAS_ILOG2_U32
>  config ARCH_HAS_ILOG2_U64
>  	def_bool n
>  
> +config ARCH_HAS_CPU_IDLE_WAIT
> +	def_bool y
> +
>  config GENERIC_CALIBRATE_DELAY
>  	def_bool y
>  
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index d2fabe7..794962d 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -82,7 +82,7 @@ void cpuidle_uninstall_idle_handler(void)
>  {
>  	if (enabled_devices && (pm_idle != pm_idle_old)) {
>  		pm_idle = pm_idle_old;
> -		cpu_idle_wait();
> +		cpuidle_kick_cpus();
>  	}
>  }
>  
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index c4e0016..b1c7355 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -72,6 +72,19 @@ cpuidle_set_statedata(struct cpuidle_state *state, void *data)
>  	state->driver_data = data;
>  }
>  
> +#ifdef CONFIG_SMP
> +#ifdef CONFIG_ARCH_HAS_CPU_IDLE_WAIT
> +static inline void cpuidle_kick_cpus(void)
> +{
> +	cpu_idle_wait()
> +}
> +#else /* !ARCH_HAS_CPU_IDLE_WAIT */

Please add the CONFIG_ here too.

> +#error "Arch needs cpu_idle_wait() equivalent here"
> +#endif /* !ARCH_HAS_CPU_IDLE_WAIT */

And here.

> +#else /* !CONFIG_SMP */
> +static inline void cpuidle_kick_cpus(void) {}
> +#endif /* !CONFIG_SMP */
> +
>  struct cpuidle_state_kobj {
>  	struct cpuidle_state *state;
>  	struct completion kobj_unregister;
> 

Thanks,
Rafael
