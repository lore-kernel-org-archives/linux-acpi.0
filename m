From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPICA serialized objects?
Date: Thu, 3 Dec 2015 02:26:08 +0100
Message-ID: <CAJZ5v0jygkagyqwvEmtXPKXkhEFnspTj9XPgjeRowfsV5_Kjvw@mail.gmail.com>
References: <CALCETrWFSs0Ornr9airzqL=9ph06WDghOUaKmA_8cAorrw1Kpw@mail.gmail.com>
	<CAJZ5v0gxE2kN75K4F9TxNAhz1Xb0zoi1CMn_R36OPeBHuQ9-Qw@mail.gmail.com>
	<CALCETrXnbVCnisYrq_+GrT0PPqi6tG51TBtcx1rnQTdbLetK0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:32826 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467AbbLCB0K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2015 20:26:10 -0500
Received: by lfaz4 with SMTP id z4so73812046lfa.0
        for <linux-acpi@vger.kernel.org>; Wed, 02 Dec 2015 17:26:09 -0800 (PST)
In-Reply-To: <CALCETrXnbVCnisYrq_+GrT0PPqi6tG51TBtcx1rnQTdbLetK0A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>, Lv <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Robert Moore <robert.moore@intel.com>

On Thu, Dec 3, 2015 at 2:22 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Wed, Dec 2, 2015 at 5:13 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> Hi,
>>
>> On Thu, Dec 3, 2015 at 1:37 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> [resend as plain text]
>>>
>>> I want to bundle up an arbitrary ACPI_OBJECT into a copyable stream of
>>> bytes, is there some standard way to do this?
>>>
>>> I'm asking because I want to try to upstream something resembling the
>>> rusty old acpi_call module to allow users with debugfs access who are
>>> willing to taint their kernel to evaluate ACPI objects from userspace.
>>> Presumably there would be a user tool to get object info and to
>>> evaluate methods, and we could handle translation to/from strings in
>>> userspace, but I still need some way to shove the data back and forth.
>>
>> Please don't do that, this is broken as a concept.
>>
>> User space has no idea whatsoever about when and it what conditions a
>> given AML can be executed in the first place, so in addition to
>> tainting the kernel it may just outright break things.
>>
>> Not to mention the possibility of confusing the kernel's reference
>> counting and breaking assumptions made by it on the current state of
>> things based on what AML has been already executed.
>
> This is something that I want as a reader of decompiled DSDTs and a
> writer of drivers.  I think we could do it in a way that it doesn't
> get used for evil.  For example, make it a module, taint the kernel if
> it's loaded and enabled, only expose the interface if an actual *boot*
> parameter allow_user_acpi_calls=1 is set, encourage distros to
> seriously consider not building the module, disallow it entirely under
> secure boot, etc.
>
> I want to use it for things like "hey, it looks like \NEXP might have
> a funny value -- let's see what's there without manually figuring out
> how to peek at the relevant OpRegion".

So please check the debugger thing.

Lv, can you please help Andy with this?

Thanks,
Rafael
