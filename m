From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v2 3/3] ACPI video: Fix applying indexed initial brightness
 value.
Date: Mon, 18 Mar 2013 16:34:27 +0800
Message-ID: <5146D193.1030104@intel.com>
References: <1363342248-6496-1-git-send-email-dannybaumann@web.de> <1363342248-6496-3-git-send-email-dannybaumann@web.de> <5146CD67.8070203@intel.com> <5146CFC0.7090907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52149 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913Ab3CRIdP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Mar 2013 04:33:15 -0400
In-Reply-To: <5146CFC0.7090907@web.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Baumann <dannybaumann@web.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>

On 03/18/2013 04:26 PM, Danny Baumann wrote:
> Hi,
> 
>  >> +static unsigned long long
>>> +acpi_video_bqc_value_to_level(struct acpi_video_device *device,
>>> +			      unsigned long long bqc_value)
>>> +{
>>> +	unsigned long long level;
>>> +
>>> +	if (device->brightness->flags._BQC_use_index) {
>>> +		if (device->brightness->flags._BCL_reversed)
>>> +			bqc_value = device->brightness->count - 3 - bqc_value;
>>> +
>>> +		level = device->brightness->levels[bqc_value + 2];
>>
>> I don't understand this, what does the +2 have to do here?
>> _BQC returned us an index, and then we should just convert it to level,
>> why +2?
>>
>> The only explanation would be, for BIOS tables that return _BQC as
>> index, they are indexing from the 3rd entry. Is it the case? If so, I
>> think we need to put a comment here.
> 
> Yes, that's the case. The old code did the same thing:

Yes, I see that, but I didn't really think about it until reviewing your
patch :-)

> 
>>> -			if (device->brightness->flags._BQC_use_index) {
>>> -				if (device->brightness->flags._BCL_reversed)
>>> -					*level = device->brightness->count
>>> -								 - 3 - (*level);
>>> -				*level = device->brightness->levels[*level + 2];
>>> +			*level = acpi_video_bqc_value_to_level(device, *level);
> 
> That's also the reason for the -3 instead of -1 in the BCL_reversed 
> case. I can add a comment, though.

OK, thanks.
That would make people reading the code feel less confused, hopefully.

-Aaron

> 
>>> +	if (use_bios_initial_backlight) {
>>> +		if (!br->flags._BQC_use_index) {
>>> +			/*
>>> +			 * Set the backlight to the initial state.
>>> +			 * On some buggy laptops, _BQC returns an uninitialized
>>> +			 * value when invoked for the first time, i.e.
>>> +			 * level_old is invalid. Set the backlight to max_level
>>> +			 * in this case.
>>> +			 */
>>>   			for (i = 2; i < br->count; i++)
>>>   				if (level_old == br->levels[i]) {
>>>   					level = level_old;
>>>   					break;
>>>   				}
>>> +		} else {
>>> +			level = acpi_video_bqc_value_to_level(device,
>>> +							      level_old);
>>
>> What about we convert the value to level first?
>>
>> 	if (use_bios_initial_backlight) {
>> 		level = acpi_video_bqc_value_to_level(device, level_old);
>> 		/*
>> 		 * Set the backlight to the initial state.
>> 		 * On some buggy laptops, _BQC returns an uninitialized
>> 		 * value when invoked for the first time, i.e.
>> 		 * level_old is invalid(no matter it is a level, or an
>> 		 * index.) Set the backlight to max_level in this case.
>> 		 */
>> 		for (i = 2; i < br->count; i++)
>> 			if (level == br->levels[i])
>> 				break;
>> 		if (i == br->count)
>> 			level = max_level;
>> 	}
> 
> That works as well, and looks cleaner to me as well. I'll change that.
> 
> Regards,
> 
> Danny
> 

