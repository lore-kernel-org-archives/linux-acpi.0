From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 3/3] ACPI video: Fix applying indexed initial brightness
 value.
Date: Fri, 15 Mar 2013 17:01:39 +0800
Message-ID: <5142E373.1020006@intel.com>
References: <1363257264-15984-1-git-send-email-dannybaumann@web.de> <1363257264-15984-4-git-send-email-dannybaumann@web.de> <5142E04F.1010400@intel.com> <5142E20C.40805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30152 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922Ab3COJA1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Mar 2013 05:00:27 -0400
In-Reply-To: <5142E20C.40805@web.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Baumann <dannybaumann@web.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>

On 03/15/2013 04:55 PM, Danny Baumann wrote:
> Hi,
> 
>  >> +static unsigned long long
>>> +acpi_video_index_to_level(struct acpi_video_device *device,
>>> +			  unsigned long long index)
>>> +{
>>> +	if (device->brightness->flags._BCL_reversed)
>>> +		index = device->brightness->count - 3 - index;
>>> +
>>> +	return device->brightness->levels[index + 2];
>>> +}
>>
>> What about making this function also take care of the
>> bqc_offset_aml_bug_workaround? so that this function serves more like a
>> conversion from raw value to fixed value, the function name can perhaps
>> be named as: acpi_video_fix_bqc_value, or whatever you think is more
>> appropriate.
> 
> Makes sense to me. How about acpi_video_bqc_to_level? I'd suggest 
> acpi_video_bqc_value_to_level, but that makes it hard to keep the 80 
> char limit in acpi_video_device_lcd_get_level_current.

Right, so let's go with acpi_video_bqc_to_level.

> 
>>> @@ -742,9 +749,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
>>>   				}
>>>   		}
>>>   	} else {
>>> -		if (br->flags._BCL_reversed)
>>> -			level_old = (br->count - 1) - level_old;
>>> -		level = br->levels[level_old];
>>> +		level = acpi_video_index_to_level(device, level_old);
>>
>> And here, that new function should be used, which also takes care of the
>> offset_aml_bug problem(though in theory, the two problems may not happen
>> on the same BIOS table).
> 
> But that new function (whatever it's named) is already used here?

Yes, I mean the new function that also takes care of offset_aml_bug :-)

> 
> BTW, shouldn't the use_bios_initial_backlight also be respected for the 
> BQC-returns-index case? Currently it's only used for the 
> BQC-returns-level case.

Definitely, we should care that.

> 
>> And the acpi_video_device_lcd_get_level_current's param init can
>> probably be renamed as raw, meaning if raw value is desired or fixed
>> value, but it's not a big deal.
> 
> Agreed. I'll send a new patch set (this time with signed-off-by) once I 
> get opinion on the question above.

Cool, thanks.

-Aaron

