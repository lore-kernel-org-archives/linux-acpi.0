From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: patch for bugs 9998 and 10724
Date: Tue, 09 Sep 2008 13:28:06 +0400
Message-ID: <48C641A6.7030302@suse.de>
References: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com>	 <20080904121820.GC18288@one.firstfloor.org> <48BFD5AA.3090006@suse.de>	 <48BFD609.2050604@suse.de> <1220581596.3441.2.camel@rzhang-dt>	 <48C129D3.5000904@suse.de> <1220842582.3441.30.camel@rzhang-dt>	 <48C4E15F.2020701@suse.de> <1220951583.3989.85.camel@yakui_zhao.sh.intel.com> <48C63E0B.2030801@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51064 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753532AbYIIJ2O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2008 05:28:14 -0400
In-Reply-To: <48C63E0B.2030801@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

One more thought. One of your patches increase the time of
QUERY_PENDING bit significantly (by including whole notify handling into it),
so you need to worry more about it, and not my patch :)

Your patch actually fails to address it's purpose, as the main
consumer of queries on these broken machines is SBS HC, which does it's
own deferred execution right now. This fact saves you at the moment, as
QUERY_PENDING needs to be clear (and be able to send more queries) 
for execution of SBS HC callback to complete.

Regards,
Alex.

Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
>> Hi, Alexey
>>     You attached the updated patch on the bug 10724/9998.
>>     Can the following situation be handled by your patch?(For example:
>> bug 10724)
>>        EC GPE Interrupt storm is detected and EC GPE will be disabled
>> when doing EC transaction.
>>        If EC notification event happens while doing EC transaction(EC
>> GPE is disabled), the SCI_EVT bit of EC status register is cleared
>> automatically before we can handle it.
> SCI_EVT is cleared only as a response to query command sent to EC, there 
> is no timeout on it.
> Transaction will take at most 2 ms (1 write/1 read or 2 writes in poll 
> mode), and at the end of the transaction there is a check of the SCI bit.
> With the un-patched EC SCI bit needs to stay for period while the 
> QUERY_PENDING bit is set,
> which could be quite more than 2 ms, and it seems to comply with that 
> even on most broken
> hardware.
>>        Can the EC notification event be handled by OS?
> What do you mean?
>>
>>  Thanks
>>      Yakui.
> Please strip unneeded tails from your mails.
> 

