From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH 05/12] ACPI: ARM: exclude calls on ARM platforms, not
 include them on x86
Date: Wed, 20 Nov 2013 14:25:32 -0700
Message-ID: <528D28CC.3070402@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-6-git-send-email-al.stone@linaro.org> <17533512.3VVEMyRe92@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:46806 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab3KTVZd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2013 16:25:33 -0500
Received: by mail-ie0-f175.google.com with SMTP id x13so1609068ief.20
        for <linux-acpi@vger.kernel.org>; Wed, 20 Nov 2013 13:25:33 -0800 (PST)
In-Reply-To: <17533512.3VVEMyRe92@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On 11/17/2013 03:08 PM, Rafael J. Wysocki wrote:
> On Saturday, November 09, 2013 06:36:15 PM al.stone@linaro.org wrote:
>> From: Al Stone <ahs3@redhat.com>
>>
>> Corrected #ifdef so that DMI is not used on ARM platforms which are
>> currently implementing reduced HW mode.
>
> Please define an empty dmi_check_system() stub for ARM/ARM64 then.
>
> Generally, please avoid adding compiler directives into function bodies if
> possible.

Will do.

>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/bus.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 6a54dd5..f41949a 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -513,11 +513,15 @@ void __init acpi_early_init(void)
>>
>>   	acpi_gbl_permanent_mmap = 1;
>>
>> +#if !(CONFIG_ARM || CONFIG_ARM64)
>>   	/*
>> +	 * NB: ARM does not use DMI at present.
>> +	 *
>>   	 * If the machine falls into the DMI check table,
>>   	 * DSDT will be copied to memory
>>   	 */
>>   	dmi_check_system(dsdt_dmi_table);
>> +#endif
>>
>>   	status = acpi_reallocate_root_table();
>>   	if (ACPI_FAILURE(status)) {
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
