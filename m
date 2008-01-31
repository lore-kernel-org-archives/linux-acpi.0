From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Date: Thu, 31 Jan 2008 21:26:06 +0100
Message-ID: <200801312126.06816.rjw@sisk.pl>
References: <200801301116.44902.rjw@sisk.pl> <924EFEDD5F540B4284297C4DC59F3DEE7202F5@orsmsx423.amr.corp.intel.com> <87fxwd92wl.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55169 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbYAaU2K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jan 2008 15:28:10 -0500
In-Reply-To: <87fxwd92wl.fsf@paris.hilman.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, 31 of January 2008, Kevin Hilman wrote:
> [Updated patch pased on suggestions from Venkatesh.]
> 
> Convert cpu_idle_wait() to cpuidle_kick_cpus() macro which is
> SMP-only, and gives error on non supported CPU.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index d2fabe7..762d878 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -18,6 +18,14 @@
>  
>  #include "cpuidle.h"
>  
> +#if !defined(CONFIG_SMP)
> +#define cpuidle_kick_cpus()	do { } while (0)
> +#elif defined(CONFIG_X86)
> +#define cpuidle_kick_cpus()	cpu_idle_wait()
> +#else
> +#error "Arch needs cpu_idle_wait() equivalent here"
> +#endif

Perhaps it would be better to define cpuidle_kick_cpus() as a static inline
function in cpuidle.h .  Pretty please?

> +
>  DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
>  
>  DEFINE_MUTEX(cpuidle_lock);
> @@ -82,7 +90,7 @@ void cpuidle_uninstall_idle_handler(void)
>  {
>  	if (enabled_devices && (pm_idle != pm_idle_old)) {
>  		pm_idle = pm_idle_old;
> -		cpu_idle_wait();
> +		cpuidle_kick_cpus();
>  	}
>  }
>  
> -
