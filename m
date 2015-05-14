From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell Inspiron
 7437
Date: Thu, 14 May 2015 14:02:02 -0500
Message-ID: <5554F12A.3010003@dell.com>
References: <1429759476-13186-1-git-send-email-alex.hung@canonical.com>	<20150424082115.GA3783@srcf.ucam.org>	<CAJ=jquYe97ObpE=3eTij705QsopnH4+hChssdj0qu7YFHGsSXg@mail.gmail.com>	<20150427174646.GA22664@srcf.ucam.org>	<CAJ=jquZ7wTNBMEwZaxKRd6B2iC6qaum5h+oW=Qf364+xhs20kg@mail.gmail.com>	<20150428052448.GA3458@srcf.ucam.org>	<CAJ=jquYYDixG7-XtVJRvuHDWHgF3Ww3fiafDbmgD5KY8QJjeQQ@mail.gmail.com>	<20150428171100.GA24599@srcf.ucam.org> <CAJ=jquZMMBNsKO2CZe649OcXTBxfzO43gkxwkJn2mvHhnp+zSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223]:49720 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933597AbbENTCW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2015 15:02:22 -0400
In-Reply-To: <CAJ=jquZMMBNsKO2CZe649OcXTBxfzO43gkxwkJn2mvHhnp+zSQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux ACPI Mailing List <linux-acpi@vger.kernel.org>



On 04/29/2015 05:09 AM, Alex Hung wrote:
> Matthew,
>
> Your conclusion is correct. Disabling OSI(Windows 2012/2013) in kernel
> 4.1rc will not work. I will take a closer look into this machine.
>
> Thanks.
>
> On Wed, Apr 29, 2015 at 1:11 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>> With Windows 8 enabled you're going down this path:
>>
>>          If (_OSI (WIN8))
>>          {
>>              Local0 = 0x81
>>          }
>>
>> With it blacklisted, you're going down this path:
>>
>>          If (_OSI (WIN7))
>>          {
>>              Local0 = 0x80
>>              Local1 = _REV /* \_REV */
>>              If ((Local1 == 0x05))
>>              {
>>                  Local0 = 0x40
>>              }
>>          }
>>
>> So your guess about _REV was actually correct - if the OS claims to be
>> Windows 7 and returns 5 to _REV, it'll let Local0 to 0x40. This results
>> in:
>>
>>          If ((Local0 == 0x40))
>>          {
>>              MIS0 = SMI (0x98, Zero)
>>              MIS0 &= 0x13
>>          }
>>
>> MIS0 appears to be involved in various event delivery paths, so my
>> suspicion is that the firmware is deliberately working around a quirk of
>> Linux behaviour in order to deliver events appropriately. If so, your
>> patch won't help in 4.1 because _REV now returns 2, and so we need to
>> root cause the actual problem and fix that instead.
>>
>> --
>> Matthew Garrett | mjg59@srcf.ucam.org
Matthew,

Thank you for bringing this to my attention on that other thread. I've 
checked with the team more on this.  I'm also looking into any other 
platforms that are quirking behavior on _REV.  If you are aware of any 
other specifics I can inquire on those too.
The 7437 platform (and it's two sister platforms 7537 and 7737) include 
the following differences when acpi_osi=Windows 2009 and _REV is 5.  
These platforms were enabled in the era before Windows 2013 was default 
_OSI in the Linux kernel.
* Backlight control is set to 16 levels in Win7 and Linux.  It's set to 
10 levels in Win 8/Win8.1.
* Battery information was not displayed in the OS.  The BIOS team found 
that the Linux wasn't asking for battery information in the OS in the 
same way that Windows does.  The delta path creates a SMI event to get 
battery information.

Alex,

Does dell-rbtn/dell-airplane work properly with this platform when set 
to Windows 2013?  I'd expect that should fix the wireless hotkey issue.  
As you know airplane mode is only effective on systems with _OSI of 
Windows 2013.


