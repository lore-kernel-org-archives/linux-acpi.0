From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Mon, 22 Sep 2008 15:36:26 +0400
Message-ID: <48D7833A.9030207@suse.de>
References: <48D695B3.5000303@tuffmail.co.uk> <48D69DC9.5060100@suse.de> <48D760A2.3030007@tuffmail.co.uk> <48D77B3C.8070103@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:52571 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751354AbYIVLga (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2008 07:36:30 -0400
In-Reply-To: <48D77B3C.8070103@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Alan Jenkins wrote:
> Alan Jenkins wrote:
>> Alexey Starikovskiy wrote:
>>   
>>> Hi Alan,
>>> That patch is old news already...
>>> There is a new shiny one appended to 9998/10724/11549...
>>> Please give it a try. It does disable GPE, but for very small duration.
>>>     
>> Ok.  I was put off by the noise :-).
>>
>> I've just tested 2.6.27-rc6 with
>> <http://bugzilla.kernel.org/show_bug.cgi?id=9998#c81>.  It still "drops"
>> some events, but now it takes longer to happen.  I have to work much
>> harder bashing the keys to reproduce it.
>>
>>
>> Like before, missing an event has severe consequences.  The missed event
>> is buffered.  When a new event occurs, only the oldest event is removed
>> from the buffer.  Therefore the buffer can only grow.  Eventually,
>> something breaks.  Events stop being delivered altogether; presumably
>> the buffer overflows.  I confirmed that this does still happen.
>>
>> Remember that these are the consequences of a specific EC bug.  On my
>> EC, querying an event always clears SCI_EVT, even if there are more
>> events pending.  It is only re-raised when a new event fires.
>>
>>
>> I'll try reading the patch.  I may try capturing an EC debug log to show
>> how the event is dropped, but that will take time.
>>   
> 
> Ok, I think I've isolated the problem to a specific change.  It's our
> good friend EC_FLAGS_QUERY_PENDING again.
> 
> Your new patch clears the pending flag after the query transaction has
> finished.  Previously, it was cleared as soon as the query command was
> initiated.
> 
> I hacked it back and it works.  Was there a specific reason for the change?
Thanks! There was no particular reason to put it after transaction, other than
original place is gone.

I'll post updated patch.
Regards,
Alex.
> 
> Regards
> Alan
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 97168d4..2078cff 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -262,6 +262,8 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
>  	ec->t.rlen = rdata_len;
>  	/* start transaction */
>  	acpi_ec_write_cmd(ec, command);
> +	if (command == ACPI_EC_COMMAND_QUERY)
> +		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
>  	/* if we selected poll mode or failed in GPE-mode do a poll loop */
>  	if (force_poll ||
>  	    !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
> @@ -453,7 +455,6 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 * data)
>  	 */
>  
>  	result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_QUERY, NULL, 0, &d, 1, 0);
> -	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
>  	if (result)
>  		return result;
>  
> 
> 

