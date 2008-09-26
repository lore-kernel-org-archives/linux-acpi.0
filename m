From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Fri, 26 Sep 2008 19:47:23 +0400
Message-ID: <48DD040B.9020807@gmail.com>
References: <20080925170030.15311.27823.stgit@thinkpad> <200809261718.41641.rjw@sisk.pl> <48DCFE05.7050702@suse.de> <200809261748.54054.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:4718 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbYIZPrU (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 11:47:20 -0400
Received: by ey-out-2122.google.com with SMTP id 6so327380eyi.37
        for <Linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008 08:47:18 -0700 (PDT)
In-Reply-To: <200809261748.54054.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, "Zhao, Yakui" <yakui.zhao@intel.com>, Sitsofe Wheeler <sitsofe@yahoo.com>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
> On Friday, 26 of September 2008, Alexey Starikovskiy wrote:
>   
>> Rafael J. Wysocki wrote:
>>     
>>>> He refers to the ec->curr (former ec->t).
>>>>         
>>> Hm, I'm not sure what the failing scenario in this case would be.
>>>       
>> Last one was the thread of the stack is killed during transaction,
>> thus stack vanishes and interrupt goes over freed memory.
>>     
>
> This isn't possible IMO.  The thread is uninterruptible while waiting for the
> transaction to finish (if I'm not mistaken).
>   
Right, I already explained it to Yakui, this is why he only claims 
"ugly" now.
> That said, we can still embed 'curr' in 'struct acpi_ec' and do
> 'ec.curr = t' instead of 'ec->curr = &t' in acpi_ec_transaction_unlocked().
> Now, if 'command' is embedded in 'curr', it will be sufficient to do
> 'if (curr.command)' instead of doing 'if (ec->curr)', wherever applicable.
>   
No, I like current way more. Now it is not possible to use transaction 
data if
acpi_ec_transaction is not on the stack.


