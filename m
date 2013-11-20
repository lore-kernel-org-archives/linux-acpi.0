From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH 09/12] ACPI: add clarifying comment about processor throttling
 in HW reduced mode
Date: Wed, 20 Nov 2013 14:54:32 -0700
Message-ID: <528D2F98.6050601@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-10-git-send-email-al.stone@linaro.org> <4621090.bSNFRSzQnY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38252 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab3KTVye (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2013 16:54:34 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so8747380iec.30
        for <linux-acpi@vger.kernel.org>; Wed, 20 Nov 2013 13:54:34 -0800 (PST)
In-Reply-To: <4621090.bSNFRSzQnY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On 11/17/2013 03:20 PM, Rafael J. Wysocki wrote:
> On Saturday, November 09, 2013 06:36:19 PM al.stone@linaro.org wrote:
>> From: Al Stone <ahs3@redhat.com>
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/processor_throttling.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
>> index e7dd2c1..200738e 100644
>> --- a/drivers/acpi/processor_throttling.c
>> +++ b/drivers/acpi/processor_throttling.c
>> @@ -942,6 +942,10 @@ static int acpi_processor_get_fadt_info(struct acpi_processor *pr)
>>   		return -EINVAL;
>>   	}
>>
>> +	/*
>> +	 * NB: in HW reduced mode, duty_width is always zero
>> +	 * so this count may not be what is wanted.
>> +	 */
>>   	pr->throttling.state_count = 1 << acpi_gbl_FADT.duty_width;
>>
>>   	/*
>> @@ -991,6 +995,10 @@ static int acpi_processor_set_throttling_fadt(struct acpi_processor *pr,
>>   		/* Used to clear all duty_value bits */
>>   		duty_mask = pr->throttling.state_count - 1;
>>
>> +		/*
>> +		 * NB: in HW reduced mode, duty_offset is always zero
>> +		 * so this mask may not be what is wanted.
>> +		 */
>>   		duty_mask <<= acpi_gbl_FADT.duty_offset;
>>   		duty_mask = ~duty_mask;
>>   	}
>
> I'm not sure how these comments help to be honest.  It looks like
> pr->throttling.state_count should be 0 in HW reduced mode, shouldn't it?
>

It should.  The comments clarified things for me but perhaps
they should just note that these values are always zero in
reduced HW mode.  The other option would be to not add any
comments, of course.  Hopefully someone working with reduced
HW mode would be aware of these changes to the FADT values.

I can go either way; what's the preference?

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
