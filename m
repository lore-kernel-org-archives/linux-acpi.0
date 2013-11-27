From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v2 2/6] ACPI: bus master reload not supported in reduced
 HW mode
Date: Wed, 27 Nov 2013 15:35:53 -0700
Message-ID: <529673C9.5050206@linaro.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org> <1385080915-23430-3-git-send-email-al.stone@linaro.org> <528ECA31.80101@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39249 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757442Ab3K0Wfz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Nov 2013 17:35:55 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so10805926pde.35
        for <linux-acpi@vger.kernel.org>; Wed, 27 Nov 2013 14:35:54 -0800 (PST)
In-Reply-To: <528ECA31.80101@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On 11/21/2013 08:06 PM, Hanjun Guo wrote:
> On 2013-11-22 8:41, al.stone@linaro.org wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> Remove the saving and restoring of bus master reload registers in
>> suspend/resume when in reduced HW mode; according to the spec, no
>> such registers should exist
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/processor_idle.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 597cdab..b18e7ab 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -202,7 +202,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
>>
>>   #endif
>>
>> -#ifdef CONFIG_PM_SLEEP
>> +#if (IS_ENABLED(CONFIG_PM_SLEEP) && !IS_ENABLED(CONFIG_ACPI_REDUCED_HARDWARE))
>>   static u32 saved_bm_rld;
>>
>>   static int acpi_processor_suspend(void)
>> @@ -236,7 +236,11 @@ void acpi_processor_syscore_exit(void)
>>   {
>>   	unregister_syscore_ops(&acpi_processor_syscore_ops);
>>   }
>> -#endif /* CONFIG_PM_SLEEP */
>
> I think the code below is not needed, because acpi_processor_suspend/resume()
> are not used by anywhere else.
>
>> +#else
>> +/* Bus master reload is not supported in reduced HW mode. */
>> +static int acpi_processor_suspend(void) { return 0; }
>> +static void acpi_processor_resume(void) { return; }
>> +#endif
>
> Thanks
> Hanjun
>

Agreed.  Removed in next version.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
