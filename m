From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
Date: Fri, 7 Apr 2017 02:07:40 +0800
Message-ID: <CADyBb7suSedttCma7Q6-RGfduJBOD5AWCpOA3pyvjDn6z+uSow@mail.gmail.com>
References: <20170331175105.8370-1-fu.wei@linaro.org> <20170331175105.8370-10-fu.wei@linaro.org>
 <20170405183808.GB27550@leverpostej> <CADyBb7sz6ongbyqR0FzBZybJBYwnLvqV+NsX1+W=6tv0_vLt1g@mail.gmail.com>
 <20170406172410.GA11871@leverpostej> <CADyBb7vEHQCpMoXhtBMGf_iou1qxsvVSJfxcYy5W33SNFyCwwA@mail.gmail.com>
 <20170406175252.GB11871@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170406175252.GB11871@leverpostej>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "Abdulhamid, Harb" <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Mark,

On 7 April 2017 at 01:52, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> On Fri, Apr 07, 2017 at 01:39:09AM +0800, Fu Wei wrote:
>> On 7 April 2017 at 01:24, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>> > On Fri, Apr 07, 2017 at 12:47:47AM +0800, Fu Wei wrote:
>> >> On 6 April 2017 at 02:38, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>> >> > On Sat, Apr 01, 2017 at 01:51:03AM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>
>> > However, I would prefer to simplify this such that we only free the
>> > IRQs in the error path.
>> >
>> > We should be able to iterate over all freams, freeing any non-zero
>> > interrupt, since !valid frames shouldn't have non-zero interrupts.
>>
>> Yes, that is what I am doing :
>>
>>  if (!frame->valid)
>>           continue;
>
> What I meant was that we won't look at the frame->valid flag at all;
> only the interrupts. e.g.
>
> for (int i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
>         if (frame->phys_irq > 0)
>                 free_the_phys_irq_somehow();
>         if (frame->virt_irq > 0)
>                 free_the_virt_irq_somehow();
> }

Since we use "kcalloc" to allocate struct arch_timer_mem, this should be OK.

>
> ... where we somehow figure out the GSI, or we introduce an api like
> unregister_gsi_for_irq(irq).

Yes, If you are OK with introducing a new API , this problem is solved :-)

>
> Since the !valid frames should all have zero for their interrupt fields,
> no special handling is necessary.
>
> That way, we only free the IRQs in one place, it's obvious that we
> consistently free all of them, etc.
>
>> Lorenzo addressed the API issue, we may can fix it by getting GSI info
>> from DT, then register it until we figure the best frame.
>> It may need some big change in DT code
>
> I'd prefer to keep this constrained to the ACPI code. ;)
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
