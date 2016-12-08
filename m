From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [Linaro-acpi] [PATCH v17 08/15] clocksource/drivers/arm_arch_timer:
 move arch_timer_needs_of_probing into DT init call
Date: Thu, 8 Dec 2016 19:20:59 +0800
Message-ID: <CADyBb7u+EJ2ehan4suUCtXaP09S-OuZ6BMnCVF3=MpE0W2-Nag@mail.gmail.com>
References: <20161125084623.22515-9-fu.wei@linaro.org> <201611252221.UyJ9iWPV%fengguang.wu@intel.com>
 <CADyBb7uAObQn_JVp_qw9+7POiqUctdzy3cYLsb0rk-JMX5W1uw@mail.gmail.com>
 <CAOZdJXU7Lg66RKvA=sYtUXUdwLLbh9FtcW0_U-fmjaztnqS3Ng@mail.gmail.com>
 <CADyBb7vAfMGV5ERFqAbwo4v4BhJv5s_-x4DXmdvy=iUacBzJWQ@mail.gmail.com> <20161208110410.GA9768@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161208110410.GA9768@leverpostej>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Wei Huang <wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, "Abdulhamid, Harb" <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Julien Grall <julien.grall-5wv7dgnIgG8@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kern
List-Id: linux-acpi@vger.kernel.org

Hi Mark,

On 8 December 2016 at 19:04, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> On Thu, Dec 08, 2016 at 11:16:21AM +0800, Fu Wei wrote:
>> Hi Timur,
>>
>> On 8 December 2016 at 01:25, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> > On Fri, Nov 25, 2016 at 9:06 AM, Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> >>
>> >> a "+ int ret;" should be move from [12/15] to here, I have fix the
>> >> problem in my repo, it would happen in next patchset
>> >>
>> >> https://git.linaro.org/people/fu.wei/linux.git/log/?h=topic-gtdt-wakeup-timer_upstream_v18_devel
>> >
>> > Fu, please post v18 to the mailing list so that it can be picked up
>> > for 4.10 (if it's not too late already).
>
> Unfortunately, it's too late for v4.10. It hasn't been sat in linux-next
> at all, and we've seen kbuild test failures.
>
> Hopefully there's time to beat this into shape and get it into
> linux-next so that it's ready to queue for v4.11, though.

cross fingers for getting into v4.11 :-)

>
>> Great thanks for your suggestion!  :-)
>> yes, you are right, I would love to post v18 ASAP.
>>
>> But I am still waiting for more feedback from the maintainers.
>
> Please post a version which passes inspection by the kbuild test robot.
> I haven't had a chance to look at this yet, and it'll be better to look
> at a version that actually works.

OK, NP, will post them in several hours
Great thanks for your feedback.

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
