From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v14 5/9] clocksource/drivers/arm_arch_timer: Simplify
 ACPI support code.
Date: Fri, 21 Oct 2016 12:14:01 +0100
Message-ID: <20161021111352.GA16630@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-6-git-send-email-fu.wei@linaro.org>
 <20161020165747.GD27598@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161020165747.GD27598@leverpostej>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 20, 2016 at 05:58:17PM +0100, Mark Rutland wrote:
> On Thu, Sep 29, 2016 at 02:17:13AM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> > +	arch_timer_ppi[PHYS_NONSECURE_PPI] = acpi_gtdt_map_ppi(PHYS_NONSECURE_PPI);
> > +	arch_timer_ppi[VIRT_PPI] = acpi_gtdt_map_ppi(VIRT_PPI);
> > +	arch_timer_ppi[HYP_PPI] = acpi_gtdt_map_ppi(HYP_PPI);
> > +	/* Always-on capability */
> > +	arch_timer_c3stop = acpi_gtdt_c3stop();
> 
> ... I think we should check the flag on the relevant interrupt, though
> that's worth clarifying.

I see I misread the spec; this is part of the common flags.

Please ignore this point; sorry for the noise.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
