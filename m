From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 01/11] ACPI: EC: count interrupts only if called from
 interrupt handler.
Date: Sat, 29 Nov 2008 22:45:07 +0300
Message-ID: <49319BC3.1020606@gmail.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>	 <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com> <9b2b86520811291036w399fce94ib93a71d2475c6577@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:56892 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbYK2TpK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Nov 2008 14:45:10 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2258255ugf.37
        for <linux-acpi@vger.kernel.org>; Sat, 29 Nov 2008 11:45:04 -0800 (PST)
In-Reply-To: <9b2b86520811291036w399fce94ib93a71d2475c6577@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, stable@kernel.org

Alan Jenkins wrote:
> On 11/27/08, Len Brown <lenb@kernel.org> wrote:
>   
>> From: Alexey Starikovskiy <astarikovskiy@suse.de>
>>
>> fix 2.6.28 EC interrupt storm regression
>>
>> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
>> Signed-off-by: Len Brown <len.brown@intel.com>
>> ---
>>     
>
> Yay, this means my EeePC no longer reports interrupt storms.
>
>   
Great!
> The patch looks obviously correct.  What about -stable?  -stable has
> all the previous EC fixes, so I assume it's affected by this
> regression.
>   
IMHO, Rafael already marked it for stable.

> The patch solves a bug I was about to report.  In storm avoidance
> mode, the polling is still not 100% robust against the flaky EC.
>
>   
My current understanding is that firmware for this controller is not 
written as a state machine,
and breaks if more than one timed action occurs.
I've found a contact with eeePC project manager and asked him about the 
whole "interrupt storm" issue,
but did not get any reply yet...
> 1) If I hold down brightness up/down and then remove the power cable,
> the EC stops working immediately.
>   
Probably, may be, you don't supposed to do it? :)
> 2) I had an odd one-off occasion with the familiar "out of sync
> hotkeys" & eventual EC death.
>
> Thanks
> Alan
>
>   
>>  drivers/acpi/ec.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index cf41f9f..30f3ef2 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -219,7 +219,8 @@ static void gpe_transaction(struct acpi_ec *ec, u8
>> status)
>>  	goto unlock;
>>  err:
>>  	/* false interrupt, state didn't change */
>> -	++ec->curr->irq_count;
>> +	if (in_interrupt())
>> +		++ec->curr->irq_count;
>>  unlock:
>>  	spin_unlock_irqrestore(&ec->curr_lock, flags);
>>  }
>> --
>> 1.5.6.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>     
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

