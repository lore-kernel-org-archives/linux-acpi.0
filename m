From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] ACPI: disable the gpe that doesn't have a GPE handler
 correctly
Date: Tue, 20 Nov 2007 11:55:59 +0300
Message-ID: <4742A11F.1090705@gmail.com>
References: <1195457566.2971.12.camel@acpi-hp.sh.intel.com> <1195524603.2971.15.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:15663 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbXKTIzZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Nov 2007 03:55:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1122995ugc
        for <linux-acpi@vger.kernel.org>; Tue, 20 Nov 2007 00:55:24 -0800 (PST)
In-Reply-To: <1195524603.2971.15.camel@acpi-hp.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, astarikovskiy@suse.de, linux-acpi@vger.kernel.org

Zhang Rui wrote:
> On Mon, 2007-11-19 at 15:32 +0800, Zhang Rui wrote:
>   
>> From: Zhang Rui <rui.zhang@intel.com>
>>
>> The current code only disable the GPE by judging the
>> GPE type, which is one of WAKE, RUNTIME and WAKE_RUN.
>> In bug 6217, GPE 17 is enabled by the AML code ...
>> And it will be triggerred when an extra CRT is connected.
>> As GPE 17 is not ec gpe, and there is no _Lxx/_Exx method
>> exists in the _GPE scope, the type flag of GPE 17 is cleared
>> at the boot time and it's none of the three GPE types.
>> In this case, the GPE is not disabled correctly.
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=6217
>>
>>     
> Hi, Alexey,
> Any comments on this patch? :)
>
>   
See below. Idea itself seem to be right.
> Thanks,
> Rui
>   
>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> ---
>>  drivers/acpi/events/evgpe.c |    5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> Index: linux-2.6/drivers/acpi/events/evgpe.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/acpi/events/evgpe.c
>> +++ linux-2.6/drivers/acpi/events/evgpe.c
>> @@ -277,11 +277,10 @@ acpi_status acpi_ev_disable_gpe(struct a
>>  		/* Disable the requested runtime GPE */
>>  
>>  		ACPI_CLEAR_BIT(gpe_event_info->flags, ACPI_GPE_RUN_ENABLED);
>> -		status = acpi_hw_write_gpe_enable_reg(gpe_event_info);
>> -		break;
>>     
put /* lint -fallthrough */ here, same as above.
>>  
>>  	default:
>> -		return_ACPI_STATUS(AE_BAD_PARAMETER);
>> +		acpi_hw_write_gpe_enable_reg(gpe_event_info);
>> +		break;
>>     
don't need this break...
>>  	}
>>  
>>  	return_ACPI_STATUS(AE_OK);
>>     
Regards,
Alex.
