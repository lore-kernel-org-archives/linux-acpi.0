From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v6 4/6] ACPI: in HW reduced mode, using FADT PM information
 is not allowed.
Date: Mon, 13 Jan 2014 15:46:58 -0700
Message-ID: <52D46CE2.8020300@linaro.org>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org> <1389394340-2680-5-git-send-email-al.stone@linaro.org> <4248842.kTIlfoGImy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:60136 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbaAMWrA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jan 2014 17:47:00 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa1so1331270pad.27
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2014 14:47:00 -0800 (PST)
In-Reply-To: <4248842.kTIlfoGImy@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On 01/10/2014 04:31 PM, Rafael J. Wysocki wrote:
> On Friday, January 10, 2014 03:52:18 PM al.stone@linaro.org wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> Per the ACPI 5.0 specification, section 5.2.9, none of the power
>> management fields in the FADT are to be used.  Short-circuit using
>> any of those fields in acpi_processor_get_power_info_fadt().
>
> So the spec says that we're supposed to ignore the information in
> certain FADT fields if the HW_REDUCED_ACPI flag is set.
>
> However, what about systems in which that information is actually
> valid even though HW_REDUCED_ACPI is set?
>
> Does it break things if we attempt to use that information?

The way I see it in the spec, we just don't use that info _if_ we wish
to remain compliant with the spec.  If we insist on using it anyway, we
can't say we're implementing hardware reduced mode correctly.  That
being said, from my read of the code it appears things would operate
the same as they did before if this part of the spec was ignored _and_
the info in the tables was still valid (same control register addresses
and content and so on).

>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/processor_idle.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index eac984a..89f0a0f 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -270,6 +270,14 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
>>   	if (!pr->pblk)
>>   		return -ENODEV;
>>
>> +	/*
>> +	 * Using power management information from the FADT is not
>> +	 * allowed when in HW reduced mode.  See ACPI 5.0, section
>> +	 * 5.2.9.
>> +	 */
>> +	if (acpi_gbl_reduced_hardware)
>> +		return -ENODEV;
>> +
>>   	/* if info is obtained from pblk/fadt, type equals state */
>>   	pr->power.states[ACPI_STATE_C2].type = ACPI_STATE_C2;
>>   	pr->power.states[ACPI_STATE_C3].type = ACPI_STATE_C3;
>>
>


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
