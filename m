From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 4/9] acpi/arm64: Add GTDT table parse driver
Date: Wed, 20 Jul 2016 02:25:35 +0800
Message-ID: <CADyBb7uiu2d-6bkA6qg9rWCePrZPtv3aMktXUvn7UciiR-WLhA@mail.gmail.com>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
 <1580087.dlcVOb6fx1@vostro.rjw.lan> <CADyBb7tLyABzWFEW_8A3bK9XeWiHJjh7TqWQc=vDn5O_WUJX5w@mail.gmail.com>
 <16716612.zdLA2RMyjn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <16716612.zdLA2RMyjn-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Catal
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On 16 July 2016 at 20:35, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> On Saturday, July 16, 2016 10:24:35 AM Fu Wei wrote:
>> Hi Rafeal,
>>
>> On 16 July 2016 at 05:22, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
>> > On Saturday, July 16, 2016 12:32:14 AM Fu Wei wrote:
>> >> Hi Rafael,
>> >>
>> >> On 15 July 2016 at 21:07, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
>> >> > On Friday, July 15, 2016 02:15:27 PM Rafael J. Wysocki wrote:
>> >> >> On Friday, July 15, 2016 03:32:35 PM Fu Wei wrote:
>> >> >> > Hi Rafael,
>> >> >> >
>> >> >
>> >> > [cut]
>> >> >
>> >> >> > >
>> >> >> > >> +               return 0;
>> >> >> > >> +       }
>> >> >> > >> +
>> >> >> > >> +       if (!gtdt->platform_timer_count) {
>> >> >> > >> +               pr_info("No Platform Timer.\n");
>> >> >> > >> +               return 0;
>> >> >> > >> +       }
>> >> >> > >> +
>> >> >> > >> +       acpi_gtdt_desc.platform_timer_start = (void *)gtdt +
>> >> >> > >> +                                             gtdt->platform_timer_offset;
>> >> >> > >> +       if (acpi_gtdt_desc.platform_timer_start <
>> >> >> > >> +           (void *)table + sizeof(struct acpi_table_gtdt)) {
>> >> >> > >> +               pr_err(FW_BUG "Platform Timer pointer error.\n");
>> >> >> > >
>> >> >> > > Why pr_err()?
>> >> >> >
>> >> >> > if (true), that means the GTDT table has bugs.
>> >> >> >
>> >> >>
>> >> >> And that's not a very useful piece of information unless you're debugging the
>> >> >> platform, is it?
>> >> >
>> >> > FWIW, I'm not a big fan of printing "your firmware is buggy" type of messages
>> >> > (especially at the "error" log level or higher) unless they can be clearly
>> >> > connected to a specific type of functional failure.
>> >> >
>> >> > So if you want to pring an error-level message, something like "I cannot do X
>> >> > because of the firmware bug Y" would be better IMO.
>> >>
>> >> So can I do this:
>> >> pr_err(FW_BUG "Can NOT init platform_timer pointer, because of the
>> >> GTDT table bug\n");
>> >>
>> >> or pr_debug(FW_BUG "Can NOT init platform_timer_start, because of
>> >> platform_timer_offset bug in GTDT\n");
>> >>
>> >> or just delete it?
>> >>
>> >> which one do you prefer?  I think maybe should provide some clue for
>> >> users to fix the problem  :-)
>> >
>> > And how exactly would they fix it then?
>> >
>> >>
>> >> any thought ?
>> >
>> > If you print variable or function names and the like, the message should be
>> > a debug one, because that's information that can only be understood by
>> > developers (some developers are users too, but they are a minority).
>> >
>> > If you want to report an error, say what is not working (or not available
>> > etc) and why (if you know the reason at the time the message is printed).
>>
>> Great thanks, I guess I got you point.
>>
>> maybe just a very simple message like:
>> pr_err(FW_BUG "Failed to init table: GTDT table is buggy.\n");
>
> To understand this message one needs to know what "table" means here
> and what "GTDT" is.  Also the prefix already will be something like
> "ACPI: GTDT:", so repeating part of it is not really useful IMO.
>
> Can you tell me please what's not going to work when that message is printed?
>
> Will the system boot at all then?  If so, the functionality will be limited
> somehow I suppose.  How is it going to be limited?

when that message is printed, all kind of platform timer(memory-mapped
timer and SBSA watchdog) can't work.
actually, I think system can boot without them.
I have updated this on my v8(just posted), let's discuss this on v8 :-)

>
>> I will also check other pr_* , if I can update them
>
> OK, great!
>
> Thanks,
> Rafael
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
