From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell Inspiron
 7437
Date: Wed, 20 May 2015 15:16:08 -0500
Message-ID: <555CEB88.70407@dell.com>
References: <20150427174646.GA22664@srcf.ucam.org> <CAJ=jquZ7wTNBMEwZaxKRd6B2iC6qaum5h+oW=Qf364+xhs20kg@mail.gmail.com> <20150428052448.GA3458@srcf.ucam.org> <CAJ=jquYYDixG7-XtVJRvuHDWHgF3Ww3fiafDbmgD5KY8QJjeQQ@mail.gmail.com> <20150428171100.GA24599@srcf.ucam.org> <CAJ=jquZMMBNsKO2CZe649OcXTBxfzO43gkxwkJn2mvHhnp+zSQ@mail.gmail.com> <5554F12A.3010003@dell.com> <20150514191358.GB23853@srcf.ucam.org> <5554F4B2.8080801@dell.com> <555CC776.3030802@dell.com> <20150520184242.GA32453@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:47010 "EHLO
	ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbbETURK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2015 16:17:10 -0400
In-Reply-To: <20150520184242.GA32453@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alex Hung <alex.hung@canonical.com>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>



On 05/20/2015 01:42 PM, Matthew Garrett wrote:
> On Wed, May 20, 2015 at 12:42:14PM -0500, Mario Limonciello wrote:
>
>> I've gotten some more information on this.
>> Windows: Asks for battery information update multiple times.
>> Linux: Only asks once for battery information update.
>>
>> The net result is that on Linux ACPI battery is missing.  In the
>> _REV test BIOS workaround, a SMI event was added to ask for battery
>> information update.
> Hm. Why does only asking once not result in us seeing the battery?
>
I'm not sure, this is all I was told about the difference in behavior 
with Windows that prompted this bios workaround.  Looking through the 
kernel log, i'm wondering if maybe 
75646e758a0ecbed5024454507d5be5b9ea9dcbf will actually have fixed this.

Alex,

What was the last kernel validated on the 7*37 family?  Can you see if a 
kernel that includes 75646e758a0ecbed5024454507d5be5b9ea9dcbf does 
resolve it?


