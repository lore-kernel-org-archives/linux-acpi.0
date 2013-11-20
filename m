From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH 02/12] ACPI: bus master reload not supported in reduced
 HW mode
Date: Wed, 20 Nov 2013 14:11:34 -0700
Message-ID: <528D2586.7010503@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-3-git-send-email-al.stone@linaro.org> <2902248.9mmxm8tccy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:53143 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab3KTVLg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2013 16:11:36 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so7217565ieb.22
        for <linux-acpi@vger.kernel.org>; Wed, 20 Nov 2013 13:11:35 -0800 (PST)
In-Reply-To: <2902248.9mmxm8tccy@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On 11/17/2013 02:56 PM, Rafael J. Wysocki wrote:
> On Saturday, November 09, 2013 06:36:12 PM al.stone@linaro.org wrote:
>> From: Al Stone <ahs3@redhat.com>
>>
>> Remove the saving and restoring of bus master reload registers in
>> suspend/resume when in reduces HW mode; according to the spec, no
>> such registers should exist
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/processor_idle.c | 8 +++++++-
>>   include/acpi/acpixf.h         | 6 ++++++
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 35c8f2b..28079a6 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -210,6 +210,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
>>   #endif
>>
>>   #ifdef CONFIG_PM_SLEEP
>> +#if (!ACPI_REDUCED_HARDWARE)
>
> Why don't you use #ifndef CONFIG_ACPI_REDUCED_HARDWARE here?
>
> And I believe we don't need acpi_processor_syscore_ops in that case at all?
>
> So why don't you put the whole section under
>
> #if (IS_ENABLED(CONFIG_PM_SLEEP) && !IS_ENABLED(CONFIG_ACPI_REDUCED_HARDWARE)) ?

My original thinking was that ACPI_REDUCED_HARDWARE is the flag
being used in the ACPICA code.  On re-thinking it (and I'll use
your suggestion, if you don't mind), is it fair to say that there
is essentially a policy of keeping the Linux acpi driver and the
ACPICA code as separate as possible?  If so -- and I would think
it makes sense -- then the ACPI_REDUCED_HARDWARE flag should not
be used here, as suggested.

Thanks.

>>   static u32 saved_bm_rld;
>>
>>   static int acpi_processor_suspend(void)
>> @@ -228,6 +229,11 @@ static void acpi_processor_resume(void)
>>
>>   	acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, saved_bm_rld);
>>   }
>> +#else
>> +/* Bus master reload is not supported in reduced HW mode. */
>> +static int acpi_processor_suspend(void) { return 0; }
>> +static void acpi_processor_resume(void) { return; }
>> +#endif /* (!ACPI_REDUCED_HARDWARE) */
>>
>>   static struct syscore_ops acpi_processor_syscore_ops = {
>>   	.suspend = acpi_processor_suspend,
>
> I'm not sure why you think that the changes below belong to this patch?

It doesn't.  My bad.  I'll remove this.

>> @@ -605,7 +611,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
>>   		case ACPI_STATE_C2:
>>   			if (!cx->address)
>>   				break;
>> -			cx->valid = 1;
>> +			cx->valid = 1;
>>   			break;
>>
>>   		case ACPI_STATE_C3:
>> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
>> index d8f9457..27ef69b 100644
>> --- a/include/acpi/acpixf.h
>> +++ b/include/acpi/acpixf.h
>> @@ -99,6 +99,9 @@ extern u8 acpi_gbl_disable_ssdt_table_load;
>>   #define ACPI_HW_DEPENDENT_RETURN_VOID(prototype) \
>>   	prototype;
>>
>> +#define ACPI_HW_DEPENDENT_RETURN_INT(prototype) \
>> +	prototype;
>> +
>>   #else
>>   #define ACPI_HW_DEPENDENT_RETURN_STATUS(prototype) \
>>   	static ACPI_INLINE prototype {return(AE_NOT_CONFIGURED);}
>> @@ -109,6 +112,9 @@ extern u8 acpi_gbl_disable_ssdt_table_load;
>>   #define ACPI_HW_DEPENDENT_RETURN_VOID(prototype) \
>>   	static ACPI_INLINE prototype {return;}
>>
>> +#define ACPI_HW_DEPENDENT_RETURN_INT(prototype) \
>> +	static ACPI_INLINE prototype {return 0;}
>> +
>>   #endif				/* !ACPI_REDUCED_HARDWARE */
>>
>>   /*
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
