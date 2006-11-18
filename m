From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Sat, 18 Nov 2006 19:18:23 +0300
Message-ID: <455F324F.3090208@linux.intel.com>
References: <200611142303.47325.david-b@pacbell.net> <455C8696.80508@linux.intel.com> <200611162222.44836.david-b@pacbell.net> <200611171304.00889.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51868 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1755178AbWKRQS0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Nov 2006 11:18:26 -0500
In-Reply-To: <200611171304.00889.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Please take a look at 7466, they seem to fight same problem, so may be 
removing same patch will work...
And Linus is about to drop it anyway...
Regards,
    Alex.
David Brownell wrote:
> On Thursday 16 November 2006 10:22 pm, David Brownell wrote:
>   
>> On Thursday 16 November 2006 7:41 am, Alexey Starikovskiy wrote:
>>     
>>> --- a/drivers/acpi/ec.c
>>> +++ b/drivers/acpi/ec.c
>>> @@ -467,8 +467,8 @@ static u32 acpi_ec_gpe_handler(void *dat
>>>                 status = acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
>>>         }
>>>         acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
>>> -       return status == AE_OK ?
>>> -           ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
>>> +       WARN_ON(ACPI_FAILURE(status));
>>> +       return ACPI_INTERRUPT_HANDLED;
>>>  }
>>>  
>>>       
>> Strange ... applying this on top of the previous patch seems to work
>> much better, but that WARN_ON hasn't triggered.  At least, not yet.
>> Updating to RC6, with your two patches installed...
>>     
>
> ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
> ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [2006070
> 7]
> ACPI Error (psparse-0537): Method parse/execution failed [\_TZ_.THRM._TMP] (Node ffff810002032d10), AE
> _TIME
>
> OK, I don't get the WARN_ON when these happen, so it's got to be one of the
> other EC updates.
>
> It'd be nice if this were easily reproducible ...
>
> - Dave
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
