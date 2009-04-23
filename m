From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] ACPI/hpet: prevent boot hang when hpet=force used on
 ICH-4M
Date: Thu, 23 Apr 2009 16:18:15 -0700
Message-ID: <1240528695.4529.9152.camel@localhost.localdomain>
References: <alpine.LFD.2.00.0904222223200.21119@localhost.localdomain>
	 <alpine.LFD.2.00.0904231917030.15843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760652AbZDWXVt@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0904231917030.15843@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
List-Id: linux-acpi@vger.kernel.org


Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On Thu, 2009-04-23 at 16:18 -0700, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Linux tells ICH4 users that they can (manually) invoke
> "hpet=force" to enable the undocumented ICH-4M HPET.
> The HPET becomes available for both clocksource and clockevents.
> 
> But as of ff69f2bba67bd45514923aaedbf40fe351787c59
> (acpi: fix of pmtimer overflow that make Cx states time incorrect)
> the HPET may be used via clocksource for idle accounting, and
> hpet=force on an ICH4 box hangs boot.
> 
> It turns out that touching the MMIO HPET withing
> the ARB_DIS part of C3 will hang the hardware.
> 
> The fix is to simply move the timer access outside
> the ARB_DIS region.  This is a no-op on modern hardware
> because ARB_DIS is no longer used.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=13087
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/processor_idle.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 6fe1214..ea23c64 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -955,6 +955,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
>  	 */
>  	acpi_state_timer_broadcast(pr, cx, 1);
>  
> +	kt1 = ktime_get_real();
>  	/*
>  	 * disable bus master
>  	 * bm_check implies we need ARB_DIS
> @@ -976,10 +977,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
>  		ACPI_FLUSH_CPU_CACHE();
>  	}
>  
> -	kt1 = ktime_get_real();
>  	acpi_idle_do_entry(cx);
> -	kt2 = ktime_get_real();
> -	idle_time =  ktime_to_us(ktime_sub(kt2, kt1));
>  
>  	/* Re-enable bus master arbitration */
>  	if (pr->flags.bm_check && pr->flags.bm_control) {
> @@ -988,6 +986,8 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
>  		c3_cpu_count--;
>  		spin_unlock(&c3_lock);
>  	}
> +	kt2 = ktime_get_real();
> +	idle_time =  ktime_to_us(ktime_sub(kt2, kt1));
>  
>  #if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
>  	/* TSC could halt in idle, so notify users */
