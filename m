From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH 12/12] ACPI: correct #ifdef so compilation without ACPI_REDUCED_HARDWARE
 works
Date: Wed, 20 Nov 2013 15:17:41 -0700
Message-ID: <528D3505.4010202@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-13-git-send-email-al.stone@linaro.org> <1685828.kuHnzG34kb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:58985 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab3KTWRn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2013 17:17:43 -0500
Received: by mail-ie0-f173.google.com with SMTP id to1so4211977ieb.4
        for <linux-acpi@vger.kernel.org>; Wed, 20 Nov 2013 14:17:42 -0800 (PST)
In-Reply-To: <1685828.kuHnzG34kb@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On 11/17/2013 03:28 PM, Rafael J. Wysocki wrote:
> On Saturday, November 09, 2013 06:36:22 PM al.stone@linaro.org wrote:
>> From: Al Stone <ahs3@redhat.com>
>
> Doesn't this fix problems with one of the previous patches in the series?

Whups.  Yes, it does.  I'll merge them.

>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/bus.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index f41949a..e868de3 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -513,7 +513,7 @@ void __init acpi_early_init(void)
>>
>>   	acpi_gbl_permanent_mmap = 1;
>>
>> -#if !(CONFIG_ARM || CONFIG_ARM64)
>> +#if !(defined(CONFIG_ARM) || defined(CONFIG_ARM64))
>>   	/*
>>   	 * NB: ARM does not use DMI at present.
>>   	 *
>> @@ -544,7 +544,7 @@ void __init acpi_early_init(void)
>>   		goto error0;
>>   	}
>>
>> -#if (!CONFIG_ACPI_REDUCED_HARDWARE)
>> +#if !(defined(CONFIG_ARM) || defined(CONFIG_ARM64)) && (!ACPI_REDUCED_HARDWARE)
>>   	/* NB: in HW reduced mode, FADT sci_interrupt has no meaning */
>>   	if (!acpi_ioapic) {
>>   		/* compatible (0) means level (3) */
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
