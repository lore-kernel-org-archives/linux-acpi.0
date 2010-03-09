From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Tue, 09 Mar 2010 13:27:17 -0500
Message-ID: <4B969305.9070103@redhat.com>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com> <20100309154243.GA26520@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13985 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab0CIS1S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Mar 2010 13:27:18 -0500
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o29IRHIY006102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Tue, 9 Mar 2010 13:27:18 -0500
In-Reply-To: <20100309154243.GA26520@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org



Matthew Garrett wrote:
> On Tue, Mar 09, 2010 at 09:12:03AM -0500, Prarit Bhargava wrote:
>   
>> New sockets have on-die memory controllers.  This means that in certain
>> HW configurations the memory behind the socket comes and goes as the socket
>> is physically enabled and disabled.
>>
>> Since the cpu bringup code does on node memory allocations, the memory on the
>> added socket must be onlined first.
>>
>> Add a .config option to automatically online hot added memory, and enable it
>> in the acpi memory add path.
>>     
>
> This seems like the right thing to do.
>
>   
>> +config ACPI_HOTPLUG_MEMORY_AUTO_ONLINE
>> +	bool "Automatically online hotplugged memory"
>> +	depends on ACPI_HOTPLUG_MEMORY
>> +	default n
>>     
>
> default !S390? default x86?
>   

I've been inquiring about this.  It seems that some vendors want the 
capability to manually bring memory online.  I'm trying to get more 
details as this doesn't seem intuitive.  It seems to me that if you add 
memory you want to online it right now.

>   
>> +		result = online_pages(info->start_addr >> PAGE_SHIFT,
>> +				      info->length >> PAGE_SHIFT);
>> +		if (!result)
>> +			set_memory_state(info->start_addr, MEM_ONLINE);
>> +		else
>> +			printk("Memory online failed.\n");
>>     
>
> That probably wants to be more descriptive and have a loglevel. 

Oops.  I'm very bad about setting the loglevel's on my printk's ;) ... 
I'll fix that in the next patch.

> What 
> happens if this fails? The CPU presumably can't be brought up?
>   

That's a good question...  After thinking about it I think that 
acpi_processor_add() must check the node to see if it has memory before 
bringing the cpu online.

I'll code that up, test, and repost.

P.

