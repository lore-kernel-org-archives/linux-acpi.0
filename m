From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH 08/12] ACPI: in HW reduced mode, getting power latencies
 from FADT is not allowed
Date: Wed, 20 Nov 2013 14:48:08 -0700
Message-ID: <528D2E18.4060005@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-9-git-send-email-al.stone@linaro.org> <2301729.KUltyzqvUq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:59035 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab3KTVsK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2013 16:48:10 -0500
Received: by mail-ie0-f179.google.com with SMTP id x13so1651233ief.24
        for <linux-acpi@vger.kernel.org>; Wed, 20 Nov 2013 13:48:10 -0800 (PST)
In-Reply-To: <2301729.KUltyzqvUq@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On 11/17/2013 03:17 PM, Rafael J. Wysocki wrote:
> On Saturday, November 09, 2013 06:36:18 PM al.stone@linaro.org wrote:
>> From: Al Stone <ahs3@redhat.com>
>>
>> Make sure we are not in HW reduced mode when we rely on the the
>> P_LVL2_LAT or P_LVL3_LAT (c2_latency, c3_latency) values from the
>> FADT.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/processor_idle.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 28079a6..e2bd0bf 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -644,7 +644,7 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
>>   	memset(pr->power.states, 0, sizeof(pr->power.states));
>>
>>   	result = acpi_processor_get_power_info_cst(pr);
>> -	if (result == -ENODEV)
>> +	if (!acpi_gbl_reduced_hardware && (result == -ENODEV))
>>   		result = acpi_processor_get_power_info_fadt(pr);
>
> Wouldn't it be better to make acpi_processor_get_power_info_fadt() check
> acpi_gbl_reduced_hardware ?

Hrm.  Yes, it would.  I'll change that.

>>
>>   	if (result)
>>


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
