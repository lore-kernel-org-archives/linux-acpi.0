From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
Date: Wed, 1 Feb 2017 02:43:02 +0800
Message-ID: <CADyBb7uqomC10mR4oMcUKrvYCbrOfLB6q1T6feMfiYA4cMnduA@mail.gmail.com>
References: <20170118132541.8989-1-fu.wei@linaro.org> <20170118132541.8989-9-fu.wei@linaro.org>
 <20170124172400.GG7572@leverpostej> <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
 <20170125172505.GB29027@leverpostej> <CADyBb7syNx+HJ6t5JKPMnLqvq-98kPi1knuXU=SSe6_Uz6Gg1A@mail.gmail.com>
 <20170130174958.GA3496@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170130174958.GA3496@leverpostej>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "Abdulhamid, Harb" <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Mark,

On 31 January 2017 at 01:49, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> On Thu, Jan 26, 2017 at 01:49:03PM +0800, Fu Wei wrote:
>> On 26 January 2017 at 01:25, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>> > On Wed, Jan 25, 2017 at 02:46:12PM +0800, Fu Wei wrote:
>> >> On 25 January 2017 at 01:24, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>> >> > On Wed, Jan 18, 2017 at 09:25:32PM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> >> >> From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
>> > For CNT{,EL0}BaseN.CNTFRQ, I am very concerned by the wording in the
>> > current ARMv8 ARM ARM. This does not match my understanding, nor does it
>> > match the description in the ARMv7 ARM. I believe this may be a
>> > documentation error, and I'm chasing that up internally.
>> >
>> > Either the currently logic in the driver which attempts to read
>> > CNT{,EL0}BaseN.CNTFRQ is flawed, or the description in the ARM ARM is
>> > erroneous.
>>
>> Yes, those description did confuse me. :-(
>>
>> But according to another document(ARMv8-A Foundation Platform User
>> Guide  ARM DUI0677K),
>> Table 3-2 ARMv8-A Foundation Platform memory map (continued)
>>
>> AP_REFCLK CNTBase0, Generic Timer 64KB   S
>> AP_REFCLK CNTBase1, Generic Timer 64KB   S/NS
>>
>> Dose it means the timer frame 0 can be accessed in SECURE status  only,
>> and the timer frame 1 can be accessed in both status?
>
> That does appear to be what it says.
>
> I assume in this case CNTCTLBase.CNTSAR<0> is RES0.
>
>> And because Linux kernel is running on Non-secure EL1, so should we
>> skip "SECURE" timer in Linux?
>
> I guess you mean by checking the GTx Common flags, to see if the timer
> is secure? Yes, we must skip those.

Yes, exactly.

I think we can check the  GTx Common flags, if the timer is set as
SECURE, this driver should just skip this timer.

Reason:
1, IF the timer is designed to be a secure timer which is only can be
accessed in secure status, the ACPI table should label this as SECURE,
then driver should skip it.
2, IF the timer is accessible from both status, but the firmware want
to use this driver for secure OS,  the ACPI table should also label
this as SECURE(meanwhile firmware should configure CNTSAR too), then
driver should skip it, too.

Actually I have added this into my next patchset v21. If you don't
have other suggestion I can post it tomorrow.

Can I? any thought?

>
> Looking further at this, the ACPI spec is sorely lacking any statement
> as to the configuration of CNTCTLBase.{CNTSAR,CNTTIDR,CNTACR}, so it's
> not clear if we can access anything in a frame, even if it is listed as
> being a non-secure timer.
>
> I think we need a stronger statement here. Otherwise, we will encounter
> problems. Linux currently assumes that CNTCTLBase.CNTACR<N> is
> writeable, given a non-secure frame N. This is only the case if
> CNTCTLBase.CNTSAR.NS<N> == 1.

the original driver has checked these registers, but the problem is:
What if the timer frame is designed to be a secure timer, all the
register in this frame is only can be accessed in secure status, just
like foundation model?
Note: for foundation model, Please check Table 3-1 Access permissions
of 3.1 ARMv8-A Foundation Platform memory map in ARMv8-A Foundation
Platform User Guide

So I think we should check the GTDT first, if it's not a secure timer,
then we can go on checking CNTSAR. :-)

Please correct me, If I miss something. :-)

Great thanks for your info :-)

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
