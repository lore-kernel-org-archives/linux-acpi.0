From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v14 5/9] clocksource/drivers/arm_arch_timer: Simplify
 ACPI support code.
Date: Thu, 20 Oct 2016 17:58:17 +0100
Message-ID: <20161020165747.GD27598@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-6-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1475086637-1914-6-git-send-email-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 29, 2016 at 02:17:13AM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> The patch update arm_arch_timer driver to use the function
> provided by the new GTDT driver of ACPI.
> By this way, arm_arch_timer.c can be simplified, and separate
> all the ACPI GTDT knowledge from this timer driver.
> 
> Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This generally looks fine, but:

> +	arch_timer_ppi[PHYS_SECURE_PPI] = acpi_gtdt_map_ppi(PHYS_SECURE_PPI);

As mentioned on the prior patch, I think we shouldn't bother parsing the
secure interrupt, given the problem with the GSIV, and the fact that we
shouldn't need it in Linux.

> +	arch_timer_ppi[PHYS_NONSECURE_PPI] = acpi_gtdt_map_ppi(PHYS_NONSECURE_PPI);
> +	arch_timer_ppi[VIRT_PPI] = acpi_gtdt_map_ppi(VIRT_PPI);
> +	arch_timer_ppi[HYP_PPI] = acpi_gtdt_map_ppi(HYP_PPI);
> +	/* Always-on capability */
> +	arch_timer_c3stop = acpi_gtdt_c3stop();

... I think we should check the flag on the relevant interrupt, though
that's worth clarifying.

>  
> -	/* Always-on capability */
> -	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
> +	if (timer_count < 0)
> +		pr_err("Failed to get platform timer info.\n");

Why don't we log this in the code that would try to initialise the MMIO
timer? We can still fail after this.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
