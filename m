From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 4.12-rc1 REGRESSION "ACPI / sleep: Ignore spurious SCI wakeups
 from suspend-to-idle" causes system to not wakeup
Date: Thu, 25 May 2017 01:07:35 +0200
Message-ID: <CAJZ5v0gw307HWchHb29+0w6kRMOH3ZCeq41HKMSQP+bZ6g2ELw@mail.gmail.com>
References: <e267ef96-4ca4-6432-311b-4af0c2786f9a@redhat.com>
 <1762448.ZPPEFgdK7X@aspire.rjw.lan> <ff6b5078-ee77-1b5e-fc5b-29efedf85649@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:37327 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164566AbdEXXHh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 May 2017 19:07:37 -0400
Received: by mail-it0-f49.google.com with SMTP id g126so48519430ith.0
        for <linux-acpi@vger.kernel.org>; Wed, 24 May 2017 16:07:37 -0700 (PDT)
In-Reply-To: <ff6b5078-ee77-1b5e-fc5b-29efedf85649@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi <linux-acpi@vger.kernel.org>, "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>

On Wed, May 24, 2017 at 9:01 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 24-05-17 01:47, Rafael J. Wysocki wrote:
>>
>> On Tuesday, May 23, 2017 09:58:49 PM Hans de Goede wrote:
>>>
>>> Hi,
>>
>>
>> Hi,
>>
>>> On (some?) Cherry Trail devices the system can be woken up
>>> by pressing a key on the USB attached keyboard (even on some tablets
>>> with an external USB keyboard).
>>
>>
>> So first I need to know if this is with USB wakeup properly enabled via
>> sysfs
>> or just because the system reacts to the first ACPI interrupt triggered
>> while
>> suspended.
>>
>> Note that USB wakeup is not enabled by default in the kernel, so if user
>> space init doesn't do that, it has to be done manually.
>
>
> I'm not doing anything specific to enable USB wakeup, but I just checked
> in sysfs and yes it is enabled. I guess this gets inherited from the BIOS
> and on this system the BIOS enables this by default ?

That's possible.  OK

[cut]

>>> Looking at the "ACPI / sleep: Ignore spurious SCI wakeups from
>>> suspend-to-idle" commit I've added a pm_wakeup_hard_event()
>>> to the int0002 driver when the GPE0A_PME_B0_STS_BIT is set and
>>> with this change the fix works for 4.12-rc1 too and fixes the
>>> issue with the system more or less hanging on the first wakeup
>>> attempt by USB-keyboard.
>>
>>
>> Does the USB keyboard still wake up only once?
>
>
> No with the INT0002 driver in place I can reliable wakeup the system
> with the USB keyboard every time.

OK, good.

Thanks,
Rafael
