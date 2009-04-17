From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC][PATCH] ACPICA: Drop Operand cache
Date: Fri, 17 Apr 2009 23:55:40 +0400
Message-ID: <49E8DEBC.8030307@suse.de>
References: <49E8C9A8.5020201@suse.de> <4911F71203A09E4D9981D27F9D83085821F006A4@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:48476 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750984AbZDQTzm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Apr 2009 15:55:42 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D83085821F006A4@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Moore, Robert wrote:
> Please explain further what this accomplishes. This removes the use of any cache for the acpi operand object? What about performance? That was the major reason the cache was added in the first place.
Our cache implementation fights with memory debugger in Microsoft Visual C standard library. If you care about performance, the best way is to disable this memory debugger, as we don't use it anyway. You could accomplish it in two ways, one is to disable all DEBUG, the other is to only disable memory debugger.

With this patch, every object type is allowed to have it's own size, thus allowing separate optimization. For example, "extra" object, tied to region and field objects could be folded in to save both space and code, this optimization was implemented by Kuzmich some time ago, but was lost during layoffs. 

Regards,
Alex.

> 
> 
>> -----Original Message-----
>> From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
>> Sent: Friday, April 17, 2009 11:26 AM
>> To: Moore, Robert; Len Brown
>> Cc: ACPI Devel Maling List
>> Subject: [RFC][PATCH] ACPICA: Drop Operand cache
>>
>> Hi,
>>
>> I've played with AcpiOperandObject union and corresponding cache. Removing
>> the union does not seem to be viable -- patch easily overcomes .5 meg
>> barrier, without any visible change. Dropping only the cache and making all
>> individual objects allocated from heap requires smaller number  of changes
>> and chould make SLAB/SLUB developers happy.
>>
>> Regards,
>> Alex.

