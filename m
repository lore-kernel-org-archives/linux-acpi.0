From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH 10/12] ACPI: ACPI_FADT_C2_MP_SUPPORTED must be ignored
 in HW reduced mode
Date: Wed, 20 Nov 2013 14:55:37 -0700
Message-ID: <528D2FD9.7010506@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-11-git-send-email-al.stone@linaro.org> <3195949.CaCUDbNC4B@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:48440 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab3KTVzj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2013 16:55:39 -0500
Received: by mail-ie0-f170.google.com with SMTP id qd12so5611337ieb.29
        for <linux-acpi@vger.kernel.org>; Wed, 20 Nov 2013 13:55:39 -0800 (PST)
In-Reply-To: <3195949.CaCUDbNC4B@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On 11/17/2013 03:24 PM, Rafael J. Wysocki wrote:
> On Saturday, November 09, 2013 06:36:20 PM al.stone@linaro.org wrote:
>> From: Al Stone <ahs3@redhat.com>
>
> -ENOCHANGELOG

Ack.

>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/processor_idle.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index e2bd0bf..262b84b 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -290,7 +290,8 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
>>   	 * Check for P_LVL2_UP flag before entering C2 and above on
>>   	 * an SMP system.
>>   	 */
>> -	if ((num_online_cpus() > 1) &&
>> +	if (!acpi_gbl_reduced_hardware &&
>> +	    (num_online_cpus() > 1) &&
>>   	    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
>>   		return -ENODEV;
>>   #endif
>
> Patch [8/12] added code to avoid calling this function for acpi_gbl_reduced_hardware
> set at all, so isn't the check added here actually useless?

Yup, it's redundant.  I'll sort out 8/12 and this part and simplify it.

>> @@ -965,7 +966,8 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
>>   			continue;
>>
>>   #ifdef CONFIG_HOTPLUG_CPU
>> -		if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
>> +		if (!acpi_gbl_reduced_hardware &&
>> +		    (cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
>>   		    !pr->flags.has_cst &&
>>   		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
>>   			continue;
>> @@ -1020,7 +1022,8 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
>>   			continue;
>>
>>   #ifdef CONFIG_HOTPLUG_CPU
>> -		if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
>> +		if (!acpi_gbl_reduced_hardware &&
>> +		    (cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
>>   		    !pr->flags.has_cst &&
>>   		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
>>   			continue;
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
