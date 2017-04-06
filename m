From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
Date: Thu, 6 Apr 2017 18:24:10 +0100
Message-ID: <20170406172410.GA11871@leverpostej>
References: <20170331175105.8370-1-fu.wei@linaro.org>
 <20170331175105.8370-10-fu.wei@linaro.org>
 <20170405183808.GB27550@leverpostej>
 <CADyBb7sz6ongbyqR0FzBZybJBYwnLvqV+NsX1+W=6tv0_vLt1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADyBb7sz6ongbyqR0FzBZybJBYwnLvqV+NsX1+W=6tv0_vLt1g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "Abdulhamid, Harb" <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 07, 2017 at 12:47:47AM +0800, Fu Wei wrote:
> On 6 April 2017 at 02:38, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Sat, Apr 01, 2017 at 01:51:03AM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> >> +     /*
> >> +      * Get the GT timer Frame data for every GT Block Timer
> >> +      */
> >> +     for (i = 0; i < block->timer_count; i++, gtdt_frame++) {
> >> +             if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
> >> +                     continue;
> >> +
> >> +             if (!gtdt_frame->base_address || !gtdt_frame->timer_interrupt)
> >> +                     goto error;
> >> +
> >> +             frame = &timer_mem->frame[gtdt_frame->frame_number];
> >> +             frame->phys_irq = map_gt_gsi(gtdt_frame->timer_interrupt,
> >> +                                          gtdt_frame->timer_flags);
> >> +             if (frame->phys_irq <= 0) {
> >> +                     pr_warn("failed to map physical timer irq in frame %d.\n",
> >> +                             gtdt_frame->frame_number);
> >> +                     goto error;
> >> +             }
> >> +
> >> +             if (gtdt_frame->virtual_timer_interrupt) {
> >> +                     frame->virt_irq =
> >> +                             map_gt_gsi(gtdt_frame->virtual_timer_interrupt,
> >> +                                        gtdt_frame->virtual_timer_flags);
> >> +                     if (frame->virt_irq <= 0) {
> >> +                             pr_warn("failed to map virtual timer irq in frame %d.\n",
> >> +                                     gtdt_frame->frame_number);
> >> +                             acpi_unregister_gsi(gtdt_frame->timer_interrupt);
> >> +                             goto error;
> >> +                     }
> >> +             } else {
> >> +                     frame->virt_irq = 0;
> >> +                     pr_debug("virtual timer in frame %d not implemented.\n",
> >> +                              gtdt_frame->frame_number);
> >> +             }
> >> +
> >> +             frame->cntbase = gtdt_frame->base_address;
> >> +             /*
> >> +              * The CNTBaseN frame is 4KB (register offsets 0x000 - 0xFFC).
> >> +              * See ARM DDI 0487A.k_iss10775, page I1-5130, Table I1-4
> >> +              * "CNTBaseN memory map".
> >> +              */
> >> +             frame->size = SZ_4K;
> >> +             frame->valid = true;
> >> +     }
> >> +
> >> +     return 0;
> >> +
> >> +error:
> >> +     for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
> >> +             frame = &timer_mem->frame[i];
> >> +             if (!frame->valid)
> >> +                     continue;
> >> +             irq_dispose_mapping(frame->phys_irq);
> >> +             if (frame->virt_irq)
> >> +                     irq_dispose_mapping(frame->virt_irq);
> >> +     }
> >
> > We assign interrupts and may goto error before setting valid, so here we
> 
> yes, I mean to do it.(setting valid at the end of loop)
> 
> > won't free the interrupts of the last frame we parsed.
> 
> that won't  be a problem, we may assign two interrupts in a round:
> First of all, if  the assignment goes  wrong, that means the current
> interrupt haven't been successfully assigned.
> (1)if the first goes wrong, the we goto error to unwind  the irqs
> assigned in previous rounds.
> (2)if the second one goes wrong , we acpi_unregister_gsi the first one
> and then  goto error to unwind  the irqs assigned in previous rounds.
> (3)If the two assignments are successful, set up valid flag
> 
> So we won't miss freeing the interrupts of the last frame we parsed.
> 
> Did I miss something?

No; you are correct, and I was mistaken.

However, I would prefer to simplify this such that we only free the
IRQs in the error path.

We should be able to iterate over all freams, freeing any non-zero
interrupt, since !valid frames shouldn't have non-zero interrupts.

I can make that update locally; no need to respin.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
