From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v18 00/15] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Mon, 16 Jan 2017 08:54:46 +0800
Message-ID: <CADyBb7ugz_YpxKQUsJbF1vdjm_Nzyh2mH8TZMPqj1cSHGSPCFw@mail.gmail.com>
References: <20161208173319.6618-1-fu.wei@linaro.org> <20170113192920.GF2472@leverpostej>
 <CADyBb7vF0v2DwXA8fNUOTQcqriJK1Hp57_G8DKi0WO9FnvrB5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CADyBb7vF0v2DwXA8fNUOTQcqriJK1Hp57_G8DKi0WO9FnvrB5w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "Abdulhamid, Harb" <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Mark,

On 14 January 2017 at 19:34, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Hi Mark,
>
> On 14 January 2017 at 03:29, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>> Hi,
>>
>> On Fri, Dec 09, 2016 at 01:33:04AM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>>> From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>
>>> This patchset:
>>>     (1)Preparation for adding GTDT support in arm_arch_timer:
>>>         1. Move some enums and marcos to header file;
>>>         2. Add a new enum for spi type;
>>>         3. Improve printk relevant code;
>>>         4. Rename some enums and defines;
>>>         5. Rework PPI determination;
>>>         6. Rework counter frequency detection;
>>>         7. Refactor arch_timer_needs_probing, move it into DT init call
>>>         8. Introduce some new structs and refactor the MMIO timer init code
>>>         for reusing some common code.
>>>
>>>     (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
>>>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>>>     memory-mapped timer and SBSA Generic Watchdog timer.
>>>     This driver can help to simplify all the relevant timer drivers,
>>>     and separate all the ACPI GTDT knowledge from them.
>>>
>>>     (3)Simplify ACPI code for arm_arch_timer
>>>
>>>     (4)Add GTDT support for ARM memory-mapped timer.
>>>
>>> This patchset has been tested on the following platforms with ACPI enabled:
>>>     (1)ARM Foundation v8 model
>>
>> Once v4.10-rc4 comes out this weekend, could you please rebase and
>> repost this?
>
> Yes, of course.
>
> I have rebased v19 to the latest v4.10-rc3-e96f8f1, it dosen't need
> any modification.
> I will rebase it every day, and will repost it if it need any  modification.
>
> But for now, V19 works well with the master branch of upstream kernel.
> Do I need to re-post it even if it doesn't need any improvement or
> modification? :-)

I just fetched the latest mainline kernel, and rebase v19 on the top
of 4.10-rc4.
I have double checked it, V19 works well with  4.10-rc4.
For rebasing,  it doesn't need any modification.

So please help me to review V19, I will improve it ASAP according to
your suggestion.

Many thanks!

>
>>
>> Marc and I will be happy to take a look then.
>
> Great thanks for your help!
>
>>
>> Thanks,
>> Mark.
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
