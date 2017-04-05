From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
Date: Wed, 5 Apr 2017 19:38:09 +0100
Message-ID: <20170405183808.GB27550@leverpostej>
References: <20170331175105.8370-1-fu.wei@linaro.org>
 <20170331175105.8370-10-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170331175105.8370-10-fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I tried to fix the issue that Lornzo raised, such that I could queue
these patches. From looking at this patch in more detail however, I
think there are further issues that need to be addressed.

On Sat, Apr 01, 2017 at 01:51:03AM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> +	/*
> +	 * Get the GT timer Frame data for every GT Block Timer
> +	 */
> +	for (i = 0; i < block->timer_count; i++, gtdt_frame++) {
> +		if (gtdt_frame->common_flags & ACPI_GTDT_GT_IS_SECURE_TIMER)
> +			continue;
> +
> +		if (!gtdt_frame->base_address || !gtdt_frame->timer_interrupt)
> +			goto error;
> +
> +		frame = &timer_mem->frame[gtdt_frame->frame_number];
> +		frame->phys_irq = map_gt_gsi(gtdt_frame->timer_interrupt,
> +					     gtdt_frame->timer_flags);
> +		if (frame->phys_irq <= 0) {
> +			pr_warn("failed to map physical timer irq in frame %d.\n",
> +				gtdt_frame->frame_number);
> +			goto error;
> +		}
> +
> +		if (gtdt_frame->virtual_timer_interrupt) {
> +			frame->virt_irq =
> +				map_gt_gsi(gtdt_frame->virtual_timer_interrupt,
> +					   gtdt_frame->virtual_timer_flags);
> +			if (frame->virt_irq <= 0) {
> +				pr_warn("failed to map virtual timer irq in frame %d.\n",
> +					gtdt_frame->frame_number);
> +				acpi_unregister_gsi(gtdt_frame->timer_interrupt);
> +				goto error;
> +			}
> +		} else {
> +			frame->virt_irq = 0;
> +			pr_debug("virtual timer in frame %d not implemented.\n",
> +				 gtdt_frame->frame_number);
> +		}
> +
> +		frame->cntbase = gtdt_frame->base_address;
> +		/*
> +		 * The CNTBaseN frame is 4KB (register offsets 0x000 - 0xFFC).
> +		 * See ARM DDI 0487A.k_iss10775, page I1-5130, Table I1-4
> +		 * "CNTBaseN memory map".
> +		 */
> +		frame->size = SZ_4K;
> +		frame->valid = true;
> +	}
> +
> +	return 0;
> +
> +error:
> +	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
> +		frame = &timer_mem->frame[i];
> +		if (!frame->valid)
> +			continue;
> +		irq_dispose_mapping(frame->phys_irq);
> +		if (frame->virt_irq)
> +			irq_dispose_mapping(frame->virt_irq);
> +	}

We assign interrupts and may goto error before setting valid, so here we
won't free the interrupts of the last frame we parsed.

> +	return -EINVAL;
> +}
> +
> +/**
> + * acpi_arch_timer_mem_init() - Get the info of all GT blocks in GTDT table.
> + * @timer_mem:	The pointer to the array of struct arch_timer_mem for returning
> + *		the result of parsing. The element number of this array should
> + *		be platform_timer_count(the total number of platform timers).
> + * @timer_count: It points to a integer variable which is used for storing the
> + *		number of GT blocks we have parsed.
> + *
> + * Return: 0 if success, -EINVAL/-ENODEV if error.
> + */
> +int __init acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem,
> +				    int *timer_count)
> +{
> +	int ret;
> +	void *platform_timer;
> +
> +	*timer_count = 0;
> +	for_each_platform_timer(platform_timer) {
> +		if (is_timer_block(platform_timer)) {
> +			ret = gtdt_parse_timer_block(platform_timer, timer_mem);
> +			if (ret)
> +				return ret;
> +			timer_mem++;
> +			(*timer_count)++;
> +		}
> +	}

If we were to have multiple GT blocks, this would leave timer_mem in an
inconsistent state. In gtdt_parse_timer_block we'll blat any existing
timer_mem->cntctlbase, and blat some arbitrary set of frames. however,
*some* frames may have been held over from a previous iteration.

My understanding was that the system level timer had a single CNTCTLBase
frame, and hence we should only have a single GT block.

Judging by ARM DDI 0487A.k_iss10775, I1.3 "Memory-mapped timer
components" and I3.4 "Generic Timer memory-mapped registers overview",
it does appear that the system should only have one CNTCTLBase frame.

What's going on here?

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
