From: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v14 5/9] clocksource/drivers/arm_arch_timer: Simplify
 ACPI support code.
Date: Fri, 11 Nov 2016 21:55:03 +0800
Message-ID: <5825CDB7.40606@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org> <1475086637-1914-6-git-send-email-fu.wei@linaro.org> <20161020165747.GD27598@leverpostej> <20161021111352.GA16630@leverpostej> <20161021112120.GC16630@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161021112120.GC16630@leverpostej>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, leo.duran-5C7GfCeVMHo@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 10/21/2016 07:21 PM, Mark Rutland wrote:
> On Fri, Oct 21, 2016 at 12:14:01PM +0100, Mark Rutland wrote:
>> On Thu, Oct 20, 2016 at 05:58:17PM +0100, Mark Rutland wrote:
>>> On Thu, Sep 29, 2016 at 02:17:13AM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>>>> +	arch_timer_ppi[PHYS_NONSECURE_PPI] = acpi_gtdt_map_ppi(PHYS_NONSECURE_PPI);
>>>> +	arch_timer_ppi[VIRT_PPI] = acpi_gtdt_map_ppi(VIRT_PPI);
>>>> +	arch_timer_ppi[HYP_PPI] = acpi_gtdt_map_ppi(HYP_PPI);
>>>> +	/* Always-on capability */
>>>> +	arch_timer_c3stop = acpi_gtdt_c3stop();
>>>
>>> ... I think we should check the flag on the relevant interrupt, though
>>> that's worth clarifying.
>>
>> I see I misread the spec; this is part of the common flags.
>>
>> Please ignore this point; sorry for the noise.
>
> Actually, I misread the spec this time around; the flag *can* differ per
> interrupt for the sysreg/cp15 timer, but not for the MMIO timers where
> the flag is in a common field.
>
> So please *do* consider the above.

Sorry, misread the email as well...

Check the spec again and it's per interrupt flag.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
