From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v22 00/11] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Sat, 1 Apr 2017 01:55:29 +0800
Message-ID: <CADyBb7uP031z6UoB75yEW10xsgZmY2j6-TmZuF8YaRxi1bmSfg@mail.gmail.com>
References: <20170321163122.9183-1-fu.wei@linaro.org> <1cc5a994-0af6-79ea-930d-44b3fc789427@jonmasters.org>
 <CADyBb7ujZKDF0aUJZRUN81jor04mZ-V5ESWScAjaxoHQUeVFSA@mail.gmail.com>
 <20170328130552.GA8643@leverpostej> <CADyBb7vddnQ4TZXaem3q=+v=vC41J7O4cVsokn04S2jGGU8veA@mail.gmail.com>
 <20170328145325.GD8643@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170328145325.GD8643@leverpostej>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Jon Masters <jcm-Zp4isUonpHBD60Wz+7aTrA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "Abdulhamid, Harb" <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone@linaro>
List-Id: linux-acpi@vger.kernel.org

Hi Mark,

On 28 March 2017 at 22:53, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi,
>
> On Tue, Mar 28, 2017 at 10:29:10PM +0800, Fu Wei wrote:
>> On 28 March 2017 at 21:05, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>> > Sorry for the delay; I have not had the time to focus on this as I would
>> > like to. I'm happy with patches 1-4, but from patch 5 onwards, there's
>> > one change I'd like to see.
>> >
>> > I'd prefer that mmio timer frame rame N was always stored at
>> > arch_timer_mem::frame[N], rather than arch_timer_mem::frame[] being in
>> > an arbitrary order. That will make arch_timer_mem_frame::frame_nr
>> > redundant.
>> >
>> > To allow arch_timer_mem::frame[] this to be sparse, I'm happy to have a
>> > bool arch_timer_mem_frame::valid field that we set when probing each
>> > frame. Then we don't need arch_timer_mem::num_frames.
>> >
>> > This will make iterating over the frames far less confusing, and makes
>> > it simple to detect when a frame number is erroneously reused.
>> >
>> > Otherwise, I'm largely happy to pick the rest and apply any fixups
>> > myself.
>>
>> Great thanks for your feedback!
>> I will follow your suggestion to improve my patches, then post it in a day.
>
> Thanks, that is much appreciated.
>
>> So I will rebase my patchset on arch-timer/gtdt branch of your REPO
>> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arch-timer/gtdt
>
> Yes please! The current HEAD should be:
>
> ebbfe8889cffa12f ("clocksource: arm_arch_timer: move arch_timer_needs_of_probing into DT init call").

Because there are some improvements on the first 4 patches, so I
fetched your gtdt branch, then rebase my v23  to the
arch-timer/cleanup

Thanks for your help! :-)

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
