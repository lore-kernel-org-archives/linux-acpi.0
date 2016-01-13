From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: ACPICA serialized objects?
Date: Wed, 13 Jan 2016 14:31:43 -0800
Message-ID: <CALCETrVXE5CiqHbQoO72-xwYSahrSfvJi_khzP8gQRfMwpk+1Q@mail.gmail.com>
References: <CALCETrWFSs0Ornr9airzqL=9ph06WDghOUaKmA_8cAorrw1Kpw@mail.gmail.com>
 <CAJZ5v0gxE2kN75K4F9TxNAhz1Xb0zoi1CMn_R36OPeBHuQ9-Qw@mail.gmail.com>
 <CALCETrXnbVCnisYrq_+GrT0PPqi6tG51TBtcx1rnQTdbLetK0A@mail.gmail.com>
 <CAJZ5v0jygkagyqwvEmtXPKXkhEFnspTj9XPgjeRowfsV5_Kjvw@mail.gmail.com>
 <CALCETrVE9De-o29seijHRUwTMYGx4As_zOin=xQkTjbGviCUJA@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E883BAFAE98@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35038 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbcAMWcE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jan 2016 17:32:04 -0500
Received: by mail-oi0-f51.google.com with SMTP id p187so85800538oia.2
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jan 2016 14:32:02 -0800 (PST)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BAFAE98@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Wed, Dec 2, 2015 at 5:42 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Andy
>
> Sorry for the delay of reply.
>
>> From: Andy Lutomirski [mailto:luto@kernel.org]
>> Sent: Thursday, December 3, 2015 9:29 AM
>>
>> On Wed, Dec 2, 2015 at 5:26 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > On Thu, Dec 3, 2015 at 2:22 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> >> On Wed, Dec 2, 2015 at 5:13 PM, Rafael J. Wysocki <rafael@kernel.org>
>> wrote:
>> >>> Hi,
>> >>>
>> >>> On Thu, Dec 3, 2015 at 1:37 AM, Andy Lutomirski <luto@amacapital.net>
>> wrote:
>> >>>> [resend as plain text]
>> >>>>
>> >>>> I want to bundle up an arbitrary ACPI_OBJECT into a copyable stream of
>> >>>> bytes, is there some standard way to do this?
>> >>>>
>> >>>> I'm asking because I want to try to upstream something resembling the
>> >>>> rusty old acpi_call module to allow users with debugfs access who are
>> >>>> willing to taint their kernel to evaluate ACPI objects from userspace.
>> >>>> Presumably there would be a user tool to get object info and to
>> >>>> evaluate methods, and we could handle translation to/from strings in
>> >>>> userspace, but I still need some way to shove the data back and forth.
>> >>>
>> >>> Please don't do that, this is broken as a concept.
>> >>>
>> >>> User space has no idea whatsoever about when and it what conditions a
>> >>> given AML can be executed in the first place, so in addition to
>> >>> tainting the kernel it may just outright break things.
>> >>>
>> >>> Not to mention the possibility of confusing the kernel's reference
>> >>> counting and breaking assumptions made by it on the current state of
>> >>> things based on what AML has been already executed.
>> >>
>> >> This is something that I want as a reader of decompiled DSDTs and a
>> >> writer of drivers.  I think we could do it in a way that it doesn't
>> >> get used for evil.  For example, make it a module, taint the kernel if
>> >> it's loaded and enabled, only expose the interface if an actual *boot*
>> >> parameter allow_user_acpi_calls=1 is set, encourage distros to
>> >> seriously consider not building the module, disallow it entirely under
>> >> secure boot, etc.
>> >>
>> >> I want to use it for things like "hey, it looks like \NEXP might have
>> >> a funny value -- let's see what's there without manually figuring out
>> >> how to peek at the relevant OpRegion".
>> >
>> > So please check the debugger thing.
>> >
>> > Lv, can you please help Andy with this?
>> >
>>
>> Ooh, that's really cool!  It looks like acpidbg -b "execute \WHATEVER"
>> is *exactly* what I want.  Is there a git tree or up-to-date patchset
>> that works?  It looks like 4.4-rc3 has some but not all of the pieces
>> needed.
> [Lv Zheng]
> You can find them here:
> https://patchwork.kernel.org/project/linux-acpi/list/
> The patches are:
> [v3] ACPI / x86: introduce acpi_os_readable() support
> [v3,6/6] ACPI / debugger: Add module support for ACPI debugger
> [v3,5/6] tools/power/acpi: Add userspace AML interface support
> [v3,4/6] ACPI / debugger: Add IO interface to access debugger functionalities
> [v3,3/6] ACPICA: Debugger: Fix runtime stub issues of ACPI_DEBUGGER_EXEC using different stub mechanism
> [v3,2/6] ACPICA: Debugger: Convert some mechanisms to OSPM specific
> [v3,1/6] ACPICA: Debugger: Remove unnecessary status check
>
> It is based on linux-pm/linux-next tree.
> I'm going to send an update because to eliminate some recent introduced conflicts.
> I'll Cc you when the new version is sent out.
>
> Thanks and best regards
> -Lv
>

I finally had some time to play with the ACPI debugger, and it's
fantastic.  Thanks!

One minor feature request: have you considered adding readline or
libedit support?

--Andy
