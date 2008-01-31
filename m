From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Date: Thu, 31 Jan 2008 22:03:16 +0100
Message-ID: <200801312203.16737.rjw@sisk.pl>
References: <200801301116.44902.rjw@sisk.pl> <200801312126.06816.rjw@sisk.pl> <87zlul7mgz.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55414 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbYAaVFT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jan 2008 16:05:19 -0500
In-Reply-To: <87zlul7mgz.fsf@paris.hilman.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, 31 of January 2008, Kevin Hilman wrote:
> [ Updated with suggestions from Rafael ]
> 
> Convert cpu_idle_wait() to cpuidle_kick_cpus() macro which is
> SMP-only, and gives error on non supported CPU.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
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
> index c4e0016..12466ec 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -72,6 +72,17 @@ cpuidle_set_statedata(struct cpuidle_state *state, void *data)
>  	state->driver_data = data;
>  }
>  
> +#if !defined(CONFIG_SMP)

#ifndef surely?

> +static inline void cpuidle_kick_cpus(void) {}
> +#elif defined(CONFIG_X86)

I'd do that instead:

#ifdef CONFIG_SMP
#ifdef ARCH_HAS_CPU_IDLE_WAIT
> +static inline void cpuidle_kick_cpus(void)
> +{
> +	cpu_idle_wait()
> +}
#else /* !ARCH_HAS_CPU_IDLE_WAIT */
> +#error "Arch needs cpu_idle_wait() equivalent here"
#endif /* !ARCH_HAS_CPU_IDLE_WAIT */
#else /* !CONFIG_SMP */
static inline void cpuidle_kick_cpus(void) {}
#endif /* !CONFIG_SMP */
> +
>  struct cpuidle_state_kobj {
>  	struct cpuidle_state *state;
>  	struct completion kobj_unregister;

and define ARCH_HAS_CPU_IDLE_WAIT in the x86 Kconfig.
