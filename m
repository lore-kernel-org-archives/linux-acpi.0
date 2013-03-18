From: Danny Baumann <dannybaumann@web.de>
Subject: Re: [PATCH v2 3/3] ACPI video: Fix applying indexed initial brightness
 value.
Date: Mon, 18 Mar 2013 09:26:40 +0100
Message-ID: <5146CFC0.7090907@web.de>
References: <1363342248-6496-1-git-send-email-dannybaumann@web.de> <1363342248-6496-3-git-send-email-dannybaumann@web.de> <5146CD67.8070203@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nick.hrz.tu-chemnitz.de ([134.109.228.11]:40154 "EHLO
	nick.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab3CRIu6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Mar 2013 04:50:58 -0400
In-Reply-To: <5146CD67.8070203@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>

Hi,

 >> +static unsigned long long
>> +acpi_video_bqc_value_to_level(struct acpi_video_device *device,
>> +			      unsigned long long bqc_value)
>> +{
>> +	unsigned long long level;
>> +
>> +	if (device->brightness->flags._BQC_use_index) {
>> +		if (device->brightness->flags._BCL_reversed)
>> +			bqc_value = device->brightness->count - 3 - bqc_value;
>> +
>> +		level = device->brightness->levels[bqc_value + 2];
>
> I don't understand this, what does the +2 have to do here?
> _BQC returned us an index, and then we should just convert it to level,
> why +2?
>
> The only explanation would be, for BIOS tables that return _BQC as
> index, they are indexing from the 3rd entry. Is it the case? If so, I
> think we need to put a comment here.

Yes, that's the case. The old code did the same thing:

>> -			if (device->brightness->flags._BQC_use_index) {
>> -				if (device->brightness->flags._BCL_reversed)
>> -					*level = device->brightness->count
>> -								 - 3 - (*level);
>> -				*level = device->brightness->levels[*level + 2];
>> +			*level = acpi_video_bqc_value_to_level(device, *level);

That's also the reason for the -3 instead of -1 in the BCL_reversed 
case. I can add a comment, though.

>> +	if (use_bios_initial_backlight) {
>> +		if (!br->flags._BQC_use_index) {
>> +			/*
>> +			 * Set the backlight to the initial state.
>> +			 * On some buggy laptops, _BQC returns an uninitialized
>> +			 * value when invoked for the first time, i.e.
>> +			 * level_old is invalid. Set the backlight to max_level
>> +			 * in this case.
>> +			 */
>>   			for (i = 2; i < br->count; i++)
>>   				if (level_old == br->levels[i]) {
>>   					level = level_old;
>>   					break;
>>   				}
>> +		} else {
>> +			level = acpi_video_bqc_value_to_level(device,
>> +							      level_old);
>
> What about we convert the value to level first?
>
> 	if (use_bios_initial_backlight) {
> 		level = acpi_video_bqc_value_to_level(device, level_old);
> 		/*
> 		 * Set the backlight to the initial state.
> 		 * On some buggy laptops, _BQC returns an uninitialized
> 		 * value when invoked for the first time, i.e.
> 		 * level_old is invalid(no matter it is a level, or an
> 		 * index.) Set the backlight to max_level in this case.
> 		 */
> 		for (i = 2; i < br->count; i++)
> 			if (level == br->levels[i])
> 				break;
> 		if (i == br->count)
> 			level = max_level;
> 	}

That works as well, and looks cleaner to me as well. I'll change that.

Regards,

Danny
