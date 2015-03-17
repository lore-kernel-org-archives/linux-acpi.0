From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for HP Pavilion dv6
Date: Tue, 17 Mar 2015 14:14:13 +0800
Message-ID: <CAJ=jquagkMj2QuGFpBS53yS9FxxctfRecTZPnQnE+kkO+pDpag@mail.gmail.com>
References: <1425364754-31900-1-git-send-email-alex.hung@canonical.com>
	<1941299.sLe76u91Cr@vostro.rjw.lan>
	<CAJ=jquZxC7rxj8rsy254Oy0ZYRYoKDNvXyEZ1ANP6FmbPaWikA@mail.gmail.com>
	<5045126.GmAGs977fU@vostro.rjw.lan>
	<55079923.8050400@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35597 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbbCQGOO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2015 02:14:14 -0400
Received: by qgez64 with SMTP id z64so60762qge.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2015 23:14:14 -0700 (PDT)
In-Reply-To: <55079923.8050400@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

Rafael and Aaron,

Thanks for the comment. I will try drivers/acpi/video.c instead and
submit another patch.

Cheers,
Alex Hung

On Tue, Mar 17, 2015 at 11:01 AM, Aaron Lu <aaron.lu@intel.com> wrote:
> Hi Alex,
>
> On 03/17/2015 10:31 AM, Rafael J. Wysocki wrote:
>> On Saturday, March 14, 2015 08:46:25 PM Alex Hung wrote:
>>> Rafael,
>>>
>>> Do you mean /sys/class/backlight/intel_backlight? It works but acpi_video fails.
>
> Is it the hotkey broken with Win8 OSI or the acpi_video interface?
> If it is just the interface, then you can add the system into the dmi
> table in drivers/acpi/video.c with video_disable_native_backlight as
> the DMI callback function.
>
> Thanks,
> Aaron
>
>>>
>>> We have some cases that needs working acpi_video interfaces. I'd also
>>> like to backport to previous kernels that has not use native backlight
>>
>> If backlight is the only reason, we don't add machines to blacklist.c any
>> more.
>>
>>
>>> On Wed, Mar 11, 2015 at 6:20 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>> On Tuesday, March 03, 2015 02:39:14 PM Alex Hung wrote:
>>>>> The brightness hotkeys of HP Pavilion dv6 does not work with Win8 OSI. Due
>>>>> to insufficient documentation for the driver implementation, blacklist
>>>>> it as a workaround.
>>>>
>>>> I gather that the native backlight interface doesn't work on those systems too,
>>>> is that correct?
>>>>
>>>>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>>>>> ---
>>>>>  drivers/acpi/blacklist.c |   12 ++++++++++++
>>>>>  1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
>>>>> index 9b693d5..98aa360 100644
>>>>> --- a/drivers/acpi/blacklist.c
>>>>> +++ b/drivers/acpi/blacklist.c
>>>>> @@ -300,6 +300,18 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>>>>>       },
>>>>>
>>>>>       /*
>>>>> +      * The brightness hotkeys do not work on those machines when
>>>>> +      * returning true for _OSI("Windows 2012")
>>>>> +      */
>>>>> +     {
>>>>> +     .callback = dmi_disable_osi_win8,
>>>>> +     .ident = "HP Pavilion dv6",
>>>>> +     .matches = {
>>>>> +                 DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
>>>>> +                 DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv6 Notebook PC"),
>>>>> +             },
>>>>> +     },
>>>>> +     /*
>>>>>        * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
>>>>>        * Linux ignores it, except for the machines enumerated below.
>>>>>        */
>>>>>
>>>>
>>
>



-- 
Cheers,
Alex Hung
