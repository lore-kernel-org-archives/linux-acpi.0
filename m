From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell Inspiron 7437
Date: Tue, 2 Jun 2015 11:20:18 +0800
Message-ID: <CAJ=jquaab4ONUJMp0HBQoC__GMX23KGjTY8tMx53ADKyWqsstQ@mail.gmail.com>
References: <20150427174646.GA22664@srcf.ucam.org>
	<CAJ=jquZ7wTNBMEwZaxKRd6B2iC6qaum5h+oW=Qf364+xhs20kg@mail.gmail.com>
	<20150428052448.GA3458@srcf.ucam.org>
	<CAJ=jquYYDixG7-XtVJRvuHDWHgF3Ww3fiafDbmgD5KY8QJjeQQ@mail.gmail.com>
	<20150428171100.GA24599@srcf.ucam.org>
	<CAJ=jquZMMBNsKO2CZe649OcXTBxfzO43gkxwkJn2mvHhnp+zSQ@mail.gmail.com>
	<5554F12A.3010003@dell.com>
	<20150514191358.GB23853@srcf.ucam.org>
	<5554F4B2.8080801@dell.com>
	<555CC776.3030802@dell.com>
	<20150520184242.GA32453@srcf.ucam.org>
	<555CEB88.70407@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33196 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873AbbFBDUT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jun 2015 23:20:19 -0400
Received: by qkhg32 with SMTP id g32so94643302qkh.0
        for <linux-acpi@vger.kernel.org>; Mon, 01 Jun 2015 20:20:18 -0700 (PDT)
In-Reply-To: <555CEB88.70407@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

I ran at least kernel 3.19 (Ubuntu Vivid), 4.0 and 4.1rc on 7437, and
they have the same symptom - ACPI events are not generated with
wireless hotkey presses and battery info is not updated. The commit
75646e758a0ecbed5024454507d5be5b9ea9dcbf is included.

If I ran "cat /proc/interrupts", interrupt 9 (acpi) is not incrementing.

If AC is plugged/unplugged, battery will be updated once. This implies
AC event is generated correctly.

On Thu, May 21, 2015 at 4:16 AM, Mario Limonciello
<mario_limonciello@dell.com> wrote:
>
>
> On 05/20/2015 01:42 PM, Matthew Garrett wrote:
>>
>> On Wed, May 20, 2015 at 12:42:14PM -0500, Mario Limonciello wrote:
>>
>>> I've gotten some more information on this.
>>> Windows: Asks for battery information update multiple times.
>>> Linux: Only asks once for battery information update.
>>>
>>> The net result is that on Linux ACPI battery is missing.  In the
>>> _REV test BIOS workaround, a SMI event was added to ask for battery
>>> information update.
>>
>> Hm. Why does only asking once not result in us seeing the battery?
>>
> I'm not sure, this is all I was told about the difference in behavior with
> Windows that prompted this bios workaround.  Looking through the kernel log,
> i'm wondering if maybe 75646e758a0ecbed5024454507d5be5b9ea9dcbf will
> actually have fixed this.
>
> Alex,
>
> What was the last kernel validated on the 7*37 family?  Can you see if a
> kernel that includes 75646e758a0ecbed5024454507d5be5b9ea9dcbf does resolve
> it?
>
>



-- 
Cheers,
Alex Hung
