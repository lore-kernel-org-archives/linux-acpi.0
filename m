From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v24 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
Date: Wed, 19 Apr 2017 16:56:27 +0100
Message-ID: <20170419155627.GA9439@red-moon>
References: <20170414184014.8524-1-fu.wei@linaro.org>
 <20170414184014.8524-10-fu.wei@linaro.org>
 <20170418172107.GA1401@red-moon>
 <20170419150725.GH27829@leverpostej>
 <20170419154554.GJ27829@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170419154554.GJ27829@leverpostej>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 19, 2017 at 04:45:54PM +0100, Mark Rutland wrote:
> On Wed, Apr 19, 2017 at 04:07:25PM +0100, Mark Rutland wrote:
> > On Tue, Apr 18, 2017 at 06:21:07PM +0100, Lorenzo Pieralisi wrote:
> > > On Sat, Apr 15, 2017 at 02:40:12AM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>  
> > > If yes, why can't it simply be written like this ?
> > > 
> > > for (; i >= 0; i--, gtdt_frame--) {
> > > 	frame = &timer_mem->frame[gtdt_frame->frame_number];
> > > 
> > > 	/* not sure this check is actually needed */
> > > 	if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
> > > 		continue;
> > > 
> > > 	if (frame->phys_irq > 0)
> > > 		acpi_unregister_gsi(gtdt_frame->timer_interrupt);
> > > 	if (frame->virt_irq > 0)
> > > 		acpi_unregister_gsi(gtdt_frame->virtual_timer_interrupt);
> > > }
> > 
> > A reverse loop of this form will work.
> > 
> > That requires some restructuring, and care to avoid going out of bounds
> > instantaneously with the gtdt_frame--, so as to not invoke nasal demons.
> > 
> > I've attacked this locally, and will send this out after testing. I'll
> > drop the new ACPI API patch.
> 
> FWIW, I've set this up so the cleanup path is:
> 
> do {
>         if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER ||
>             gtdt_frame->frame_number >= ARCH_TIMER_MEM_MAX_FRAMES)
>                 continue;
> 
>         frame = &timer_mem->frame[gtdt_frame->frame_number];
> 
>         if (frame->phys_irq > 0)
>                 acpi_unregister_gsi(gtdt_frame->timer_interrupt);
>         frame->phys_irq = 0;
> 
>         if (frame->virt_irq > 0)
>                 acpi_unregister_gsi(gtdt_frame->virtual_timer_interrupt);
>         frame->virt_irq = 0;
> } while (i-- >= 0 && gtdt_frame--);
> 
> ... the zeroing is to account for duplicate frames, which I now check for in
> the probe path (as we do for DT).
> 
> Can I take it per your comment on the prior version that with this change I can
> take your ack?

Yes, thanks for fixing it up, please add my:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>

> I also assume that you're happy for all of the drivers/acpi/arm64/ patches in the
> series to go via the clocksource tree?

Yes that's how I expect them to go upstream, that's the simplest way.

Thanks !
Lorenzo
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
