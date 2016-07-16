From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v7 4/9] acpi/arm64: Add GTDT table parse driver
Date: Sat, 16 Jul 2016 10:24:35 +0800
Message-ID: <CADyBb7tLyABzWFEW_8A3bK9XeWiHJjh7TqWQc=vDn5O_WUJX5w@mail.gmail.com>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
 <5101961.eCg7ixLQWc@vostro.rjw.lan>
 <CADyBb7sXxY_a+tJQoH01eUk5-xvg9jRZtzyhB-tDstWoBAWfLg@mail.gmail.com>
 <1580087.dlcVOb6fx1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1580087.dlcVOb6fx1@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rruigrok@codeaurora.org, Wim Van Sebroeck <wim@iguana.be>, Jiri Slaby <jslaby@suse.cz>, wei@redhat.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, kvalo@codeaurora.org, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, harba@codeaurora.org, Julien Grall <julien.grall@arm.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutroni>
List-Id: linux-acpi@vger.kernel.org

Hi Rafeal,

On 16 July 2016 at 05:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Saturday, July 16, 2016 12:32:14 AM Fu Wei wrote:
>> Hi Rafael,
>>
>> On 15 July 2016 at 21:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Friday, July 15, 2016 02:15:27 PM Rafael J. Wysocki wrote:
>> >> On Friday, July 15, 2016 03:32:35 PM Fu Wei wrote:
>> >> > Hi Rafael,
>> >> >
>> >
>> > [cut]
>> >
>> >> > >
>> >> > >> +               return 0;
>> >> > >> +       }
>> >> > >> +
>> >> > >> +       if (!gtdt->platform_timer_count) {
>> >> > >> +               pr_info("No Platform Timer.\n");
>> >> > >> +               return 0;
>> >> > >> +       }
>> >> > >> +
>> >> > >> +       acpi_gtdt_desc.platform_timer_start = (void *)gtdt +
>> >> > >> +                                             gtdt->platform_timer_offset;
>> >> > >> +       if (acpi_gtdt_desc.platform_timer_start <
>> >> > >> +           (void *)table + sizeof(struct acpi_table_gtdt)) {
>> >> > >> +               pr_err(FW_BUG "Platform Timer pointer error.\n");
>> >> > >
>> >> > > Why pr_err()?
>> >> >
>> >> > if (true), that means the GTDT table has bugs.
>> >> >
>> >>
>> >> And that's not a very useful piece of information unless you're debugging the
>> >> platform, is it?
>> >
>> > FWIW, I'm not a big fan of printing "your firmware is buggy" type of messages
>> > (especially at the "error" log level or higher) unless they can be clearly
>> > connected to a specific type of functional failure.
>> >
>> > So if you want to pring an error-level message, something like "I cannot do X
>> > because of the firmware bug Y" would be better IMO.
>>
>> So can I do this:
>> pr_err(FW_BUG "Can NOT init platform_timer pointer, because of the
>> GTDT table bug\n");
>>
>> or pr_debug(FW_BUG "Can NOT init platform_timer_start, because of
>> platform_timer_offset bug in GTDT\n");
>>
>> or just delete it?
>>
>> which one do you prefer?  I think maybe should provide some clue for
>> users to fix the problem  :-)
>
> And how exactly would they fix it then?
>
>>
>> any thought ?
>
> If you print variable or function names and the like, the message should be
> a debug one, because that's information that can only be understood by
> developers (some developers are users too, but they are a minority).
>
> If you want to report an error, say what is not working (or not available
> etc) and why (if you know the reason at the time the message is printed).

Great thanks, I guess I got you point.

maybe just a very simple message like:
pr_err(FW_BUG "Failed to init table: GTDT table is buggy.\n");

I will also check other pr_* , if I can update them


>
> Thanks,
> Rafael
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
