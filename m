From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell Inspiron
 7437
Date: Wed, 20 May 2015 12:42:14 -0500
Message-ID: <555CC776.3030802@dell.com>
References: <1429759476-13186-1-git-send-email-alex.hung@canonical.com> <20150424082115.GA3783@srcf.ucam.org> <CAJ=jquYe97ObpE=3eTij705QsopnH4+hChssdj0qu7YFHGsSXg@mail.gmail.com> <20150427174646.GA22664@srcf.ucam.org> <CAJ=jquZ7wTNBMEwZaxKRd6B2iC6qaum5h+oW=Qf364+xhs20kg@mail.gmail.com> <20150428052448.GA3458@srcf.ucam.org> <CAJ=jquYYDixG7-XtVJRvuHDWHgF3Ww3fiafDbmgD5KY8QJjeQQ@mail.gmail.com> <20150428171100.GA24599@srcf.ucam.org> <CAJ=jquZMMBNsKO2CZe649OcXTBxfzO43gkxwkJn2mvHhnp+zSQ@mail.gmail.com> <5554F12A.3010003@dell.com> <20150514191358.GB23853@srcf.ucam.org> <5554F4B2.8080801@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207]:1063 "EHLO
	ausxippc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbbETRmR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2015 13:42:17 -0400
In-Reply-To: <5554F4B2.8080801@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alex Hung <alex.hung@canonical.com>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On 05/14/2015 02:17 PM, Mario Limonciello wrote:
>
> On 05/14/2015 02:13 PM, Matthew Garrett wrote:
>> On Thu, May 14, 2015 at 02:02:02PM -0500, Mario Limonciello wrote:
>>
>>> * Battery information was not displayed in the OS.  The BIOS team
>>> found that the Linux wasn't asking for battery information in the OS
>>> in the same way that Windows does.  The delta path creates a SMI
>>> event to get battery information.
>> Huh. Is there any chance we can find out what the difference is so we
>> can make them equivalent?
>>
> That was my reaction too.  I'm asking for some technical details on this.
Hi Matthew,

I've gotten some more information on this.
Windows: Asks for battery information update multiple times.
Linux: Only asks once for battery information update.

The net result is that on Linux ACPI battery is missing.  In the _REV 
test BIOS workaround, a SMI event was added to ask for battery 
information update.

Thanks,
