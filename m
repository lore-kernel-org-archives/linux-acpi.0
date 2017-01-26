From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
Date: Thu, 26 Jan 2017 13:55:53 +0800
Message-ID: <CADyBb7sL0-CW=xiHyCEv7vxGz0cjfCGSkt6-XvAOC6ZGuY3_CQ@mail.gmail.com>
References: <20170118132541.8989-1-fu.wei@linaro.org> <20170118132541.8989-9-fu.wei@linaro.org>
 <20170124172400.GG7572@leverpostej> <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
 <e62c6f73-16e0-2764-126f-b8ed6adc3489@codeaurora.org> <20170125173516.GA25470@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170125173516.GA25470@leverpostej>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "Abdulhamid, Harb" <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Mark, Christopher,

On 26 January 2017 at 01:36, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Jan 25, 2017 at 10:38:01AM -0500, Christopher Covington wrote:
>> On 01/25/2017 01:46 AM, Fu Wei wrote:
>> > On 25 January 2017 at 01:24, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>> >> On Wed, Jan 18, 2017 at 09:25:32PM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> >>> From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
>> > And for CNTFRQ(in CNTCTLBase and CNTBaseN) , we can NOT access it in
>> > Linux kernel (EL1),
>> > Because ARMv8 ARM says:
>> > In a system that implements both Secure and Non-secure states, this
>> > register is only accessible by Secure accesses.
>> > That means we still need to get the frequency of the system counter
>> > from CNTFRQ_EL0 in MMIO timer code.
>> > This have been proved when I tested this driver on foundation model, I
>> > got "0" when I access CNTFRQ from Linux kernel (Non-secure EL1)
>>
>> That sounds like a firmware problem. Firmware in EL3 is supposed to write
>> the value into CNTFRQ.
>
> Definitely. FW *should* program the CNTFRQ_EL0 CPU registers and any
> MMIO CNTFRQ registers.

Many thanks for the explanation. This might be the problem. Maybe we
can check the UEFI :-)

>
>> If you're not currently using any firmware, I'd
>> recommend the bootwrapper on models/simulators/emulators.
>>
>> http://git.kernel.org/cgit/linux/kernel/git/mark/boot-wrapper-aarch64.git/tree/arch/aarch64/boot.S#n48
>
> Unfortunately, the boot-wrapper only programs the CNTFRQ_EL0 CPU system
> registers, and does not program any MMIO CNTFRQ registers.
>
> IIRC the models it was originally written for didn't have any (and we
> had no DT binding until far later...). Luckily the model DTs do not
> expose any MMIO timer addresses to the kernel currently.

But according to another document(ARMv8-A Foundation Platform User
Guide  ARM DUI0677K), Table 3-2 ARMv8-A Foundation Platform memory
map,
we may have two frames in the Generic timer block, right?


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
