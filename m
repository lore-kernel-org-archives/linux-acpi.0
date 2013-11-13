From: Aaron Lu <aaron.lu@intel.com>
Subject: More initial black screen system for removal from DMI table
Date: Wed, 13 Nov 2013 10:07:42 +0800
Message-ID: <5282DEEE.1040804@intel.com>
References: <1367828623-22998-1-git-send-email-alex.hung@canonical.com>	<52818C87.8080606@intel.com> <CAJ=jqubGRRYuKF2yFsGYniKu5=PotL6OR3KYjhhz-Zsx5wT+iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53335 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755874Ab3KMCGz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Nov 2013 21:06:55 -0500
In-Reply-To: <CAJ=jqubGRRYuKF2yFsGYniKu5=PotL6OR3KYjhhz-Zsx5wT+iA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>, Gustavo Maciel Dias Vieira <gustavo@sagui.org>
Cc: Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On 11/13/2013 01:04 AM, Alex Hung wrote:
> Hi,
> 
> It works as expected.

Thanks for the confirm!

Now I look at the DMI table for initial backlight broken systems, in
addition to the "HP Pavilion m4" and "HP 1000 Notebook PC", the following
systems are also candidates for removal:
HP Pavilion g6 Notebook PC - bug 56661
HP Pavilion dm4 - no bug entry
Fujitsu E753 - bug 60161
HP Folio 13-2000 - bug 51141

I've checked the acpidump of all the above laptops except HP dm4, which
doesn't have a bug page, they all have the same problem we are
talking about here. The HP dm4 is very suspicious according to its
corresponding commit message and its brand.

I've asked in the individual bug page for test, once confirmed, I'll
remove them all.

Hi Gustavo,
Can you please test this? I've prepared a branch for you:
https://github.com/aaronlu/linux acpi_video_dmi
It is based on Rafael's linux-next branch, with only one patch
on top: remove all the above systems from the DMI table.

Thanks,
Aaron

> 
> 
> 
> On Tue, Nov 12, 2013 at 10:03 AM, Aaron Lu <aaron.lu@intel.com> wrote:
>> On 05/06/2013 04:23 PM, Alex Hung wrote:
>>> On HP 1000 lapops, BIOS reports minimum backlight on boot and
>>> causes backlight to dim completely. This ignores the initial backlight
>>> values and set to max brightness.
>>>
>>> Buglink: https://bugs.launchpad.net/bugs/1167760
>>
>> I've checked the acpi dump from the bug page, it should be the same
>> firmware problem which the following patch is meant to solve:
>> http://www.spinics.net/lists/linux-acpi/msg47212.html
>>
>> commit 2c62333a408f5badd2d2ffd7177f95deeccc5ca4
>> Author: Aaron Lu <aaron.lu@intel.com>
>> Date:   Wed Nov 6 09:07:10 2013 +0800
>>
>>     ACPI / video: Quirk initial backlight level 0
>>
>> Possible to give it a test? It's in Rafael's linux-next branch:
>> http://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>>
>> If confirmed, we can save an entry in the DMI table.
>>
>> Thanks,
>> Aaron
>>
>>>
>>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>>> ---
>>>  drivers/acpi/video.c |    8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>>> index c3932d0..5b32e15 100644
>>> --- a/drivers/acpi/video.c
>>> +++ b/drivers/acpi/video.c
>>> @@ -456,6 +456,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>>>               DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dm4 Notebook PC"),
>>>               },
>>>       },
>>> +     {
>>> +      .callback = video_ignore_initial_backlight,
>>> +      .ident = "HP 1000 Notebook PC",
>>> +      .matches = {
>>> +             DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
>>> +             DMI_MATCH(Drjw@sisk.plMI_PRODUCT_NAME, "HP 1000 Notebook PC"),
>>> +             },
>>> +     },
>>>       {}
>>>  };
>>>
>>>
>>
> 
> 
> 

