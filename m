From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v12 7/8] clocksource/drivers/arm_arch_timer: Add GTDT
 support for memory-mapped timer
Date: Tue, 13 Sep 2016 19:31:36 +0800
Message-ID: <cc5a4eea-a8d9-3657-1938-610d2b4e855e@linaro.org>
References: <1473763144-5653-1-git-send-email-fu.wei@linaro.org>
 <1473763144-5653-8-git-send-email-fu.wei@linaro.org>
 <57D7DC59.6000705@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57D7DC59.6000705-5wv7dgnIgG8@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Marc,


On 09/13/2016 07:00 PM, Marc Zyngier wrote:
> Argh, new version...
>
> On 13/09/16 11:39, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> The patch add memory-mapped timer register support by using the information
>> provided by the new GTDT driver of ACPI.
>>
>> Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 127 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 124 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 0197ef9..d33802b 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -888,7 +888,128 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>>  		       arch_timer_mem_init);
>>  
>>  #ifdef CONFIG_ACPI_GTDT
>> -/* Initialize per-processor generic timer */
>> +static struct gt_timer_data __init *arch_timer_mem_get_timer(
>> +						struct gt_block_data *gt_blocks)
>> +{
>> +	struct gt_block_data *gt_block = gt_blocks;
>> +	struct gt_timer_data *best_frame = NULL;
>> +	void __iomem *cntctlbase;
>> +	u32 cnttidr;
>> +	int i;
>> +
>> +	/*
>> +	 * According to ARMv8 Architecture Reference Manual(ARM),
>> +	 * the size of CNTCTLBase frame of memory-mapped timer
>> +	 * is SZ_4K(Offset 0x000 – 0xFFF).
>> +	 */
>> +	cntctlbase = ioremap(gt_block->cntctlbase_phy, SZ_4K);
>> +	if (!cntctlbase) {
>> +		pr_err("Failed to map mem timer control frame base address\n");
>> +		return NULL;
>> +	}
>> +	cnttidr = readl_relaxed(cntctlbase + CNTTIDR);
>> +
>> +	/*
>> +	 * Try to find a virtual capable frame. Otherwise fall back to a
>> +	 * physical capable frame.
>> +	 */
>> +	for (i = 0; i < gt_block->timer_count; i++) {
>> +		int n;
>> +		u32 cntacr;
>> +
>> +		n = gt_block->timer[i].frame_nr;
>> +
>> +		/* Try enabling everything, and see what sticks */
>> +		cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
>> +			 CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
>> +		writel_relaxed(cntacr, cntctlbase + CNTACR(n));
>> +		cntacr = readl_relaxed(cntctlbase + CNTACR(n));
>> +
>> +		if ((cnttidr & CNTTIDR_VIRT(n)) &&
>> +		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
>> +			best_frame = &gt_block->timer[i];
>> +			arch_timer_mem_use_virtual = true;
>> +			break;
>> +		}
>> +
>> +		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
>> +			continue;
>> +
>> +		best_frame = &gt_block->timer[i];
>> +	}
>> +	iounmap(cntctlbase);
> As I just said in my reply to the same patch in v11, all of this is
> duplicating existing infrastructure that already exists for DT. Please
> consider decoupling the core driver code from the firmware side and make
> this reusable.

Great thanks for your help, I am working on it now.
Any suggestion for other arm_arch_timer patches?

> Thanks,
>
> 	M.

-- 
Best regards,

Fu Wei
Software Engineer
Red Hat 

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
