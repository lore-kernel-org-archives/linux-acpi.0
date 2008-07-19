From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 1/3] acpi: Rip out EC_FLAGS_QUERY_PENDING (prevent race
 condition)
Date: Sun, 20 Jul 2008 01:12:49 +0400
Message-ID: <488258D1.4030506@suse.de>
References: <487D23C3.5070301@student.cs.york.ac.uk> <487F31D7.30803@suse.de> <20080717121309.GF31732@khazad-dum.debian.net> <487F3B6D.3090507@suse.de> <20080717162628.GB18457@khazad-dum.debian.net> <487F7724.5080905@tuffmail.co.uk> <20080717185032.GD18457@khazad-dum.debian.net> <487F986A.3070504@tuffmail.co.uk> <4881CE72.1090401@tuffmail.co.uk> <4881D239.4010402@tuffmail.co.uk> <48821D7B.1080209@suse.de> <4882517F.6080407@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:34539 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753790AbYGSVMe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jul 2008 17:12:34 -0400
In-Reply-To: <4882517F.6080407@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Jenkins wrote:
>     /* moved here from acpi_ec_transaction_unlocked() */
>     clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
> 
>     while (acpi_ec_query(ec, &value) == 0)
>         acpi_ec_gpe_run_handler(ec, value);
> }
> 
> The PENDING flag then reflects whether or not there's an item on the
> workqueue.  Does that make sense?
Yes, this is what the flag was made for -- 
to guard workqueue from being filled up.
> 
>> Your second patch is redundant if you add queue entry for each
>> interrupt, and as it does not
>> require any investments into memory, I like it more.
>>
> It's not quite redundant with the first patch.  We still have GPE
> polling mode - patch #1 doesn't affect that.  In polling mode, it's
> essential to query all the pending events - otherwise, if they arrive
> more frequently than the polling interval then you will inevitably drop
> events.
I meant that if we have patch #3, which drops poll mode, we only need
one of the first two, not both. And in this case I like #2 more than #1.
> 
> Patch #2 is also required to fix my buggy hardware.  My laptop's EC
> buffers multiple events, but clears SCI_EVT after every query.  This
> caused problems in polling mode; with multiple events between polling
> intervals only one gets queried - and after a while the buffer overflows
> and it breaks completely.
I fully agree here, it would be great to make sure that EC buffers are empty.
>> Also, it is very cool to rip of things you don't care for, but that
>> essentially reverts a fix done for 9998,
>> so at least, you should ask these people if you broke their setups.
>>
> I assume you're referring to the "would benefit from wider testing"
> patch #3. Thanks for identifying the bugzilla entry - I had difficulty
> separating the different entries on GPEs.  I'm optimistic that we can
> fix all these crazy buffering EC's without having to disable GPE interrupts.
I would say, we should test pair of #2 and #3, or your original patch + my patch.
I still like the option to not have any new interrupts until I'm done with current one --
much like the PENDING bit.
> 
> The reason I like my proposed fix is that it makes the code simple
> enough that I can understand it, without making any assumptions about
> how many interrupts arrive per GPE.  The EC can be broken in lots of
> ways, so long as:
> 
> 1. We receive interrupts when one or more GPE's are pending.
> 2. We don't get a constant interrupt storm.
> 
> I don't think I missed anything.  Is there anything else I should check
> before I try to get testing?
Well, there is Keith Packard with concern that either high number of interrupts or long
spins on polling status register could push battery life down the drain...
One more argument to disable GPE until we service previous. 

Regards,
Alex.
