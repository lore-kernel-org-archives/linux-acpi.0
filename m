From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [patch][rfc] acpi: do not use kmem caches
Date: Mon, 01 Dec 2008 17:14:36 +0300
Message-ID: <4933F14C.7020200@gmail.com>
References: <20081201083128.GB2529@wotan.suse.de> <84144f020812010318v205579ean57edecf7992ec7ef@mail.gmail.com> <20081201120002.GB10790@wotan.suse.de> <4933E2C3.4020400@gmail.com> <20081201133646.GC10790@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:9058 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYLAOOm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 09:14:42 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2676870ugf.37
        for <linux-acpi@vger.kernel.org>; Mon, 01 Dec 2008 06:14:40 -0800 (PST)
In-Reply-To: <20081201133646.GC10790@wotan.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Linux Memory Management List <linux-mm@kvack.org>, linux-acpi@vger.kernel.org, lenb@kernel.org

Nick Piggin wrote:
> On Mon, Dec 01, 2008 at 04:12:35PM +0300, Alexey Starikovskiy wrote:
>   
>> Nick Piggin wrote:
>>     
>>> On Mon, Dec 01, 2008 at 01:18:33PM +0200, Pekka Enberg wrote:
>>>  
>>>       
>>>> Hi Nick,
>>>>
>>>> On Mon, Dec 1, 2008 at 10:31 AM, Nick Piggin <npiggin@suse.de> wrote:
>>>>    
>>>>         
>>>>> What does everyone think about this patch?
>>>>>      
>>>>>           
>>>> Doesn't matter all that much for SLUB which already merges the ACPI
>>>> caches with the generic kmalloc caches. But for SLAB, it's an obvious
>>>> wil so:
>>>>
>>>> Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>
>>>>    
>>>>         
>>> Actually I think it is also somewhat of a bugfix (not to mention that it
>>> seems like a good idea to share testing code with other operating systems).
>>>
>>>  
>>>       
>> It is not "kind of a bugfix". Caches were used to allocate all frequenly
>> created objects of fixed size. Removing native cache interface will
>> increase memory consumption and increase code size, and will make it harder
>> to spot actual memory leaks.
>>     
>
> Slabs can take a non-trivial amount of memory. On bigger machines it can
> be many megabytes. On smaller machines perhaps not, but what is the benefit??
> The only ACPI slabs I have with anything in them total a couple of hundred
> kB, and anyway they are 64 and 32 bytes so they will pack exactly into
> kmalloc slabs.
>   
Oh right, we don't care about memory footprint any longer...
> Code size... Does it matter? Is it really performance critical? If you are
> worried about code size, then I will implement them directly with kmalloc
> and kfree for you.
>   
Why then you try to delete ACPICA code, which might be just disabled by
undefining ACPI_USE_LOCAL_CACHE?
If you do want to go that path, you need to create patch against ACPICA, not
Linux code.
> kmem caches are not exactly an appropriate tool to detect memory leaks. If
> that were the case then we'd have million kmem caches everywhere.
>
>
>   
>>> Because acpi_os_purge_cache seems to want to free all active objects in the
>>> cache, but kmem_cache_shrink actually does nothing of the sort. So there
>>> ends up being a memory leak.
>>>  
>>>       
>> No. acpi_os_purge_cache wants to free only unused objects, so it is a 
>> direct map to
>>     
>
> Ah OK I misread, that's the cache's freelist... ACPI shouldn't be poking
> this button inside the slab allocator anyway, honestly. What is it
> for?
>   
And it is not actually used -- you cannot unload ACPI interpreter, and
this function is called only from there.
>>> In practice, there are warnings in some of the allocators if this ever
>>> happens and I don't think I have seen these trigger, so perhaps the ACPI
>>> code which calls this never actually cares. But still seems like a good
>>> idea to use the generic code (which seems to get this right)
>>>
>>> Anyway, thanks for the ack. Yes it should help SLAB.
>>>
>>>  
>>>       
>> NACK.
>>     
>
> Is there a reasonable performance or memory win by using kmem cache? If
> not, then they should not be used
ACPI is still working in machines with several megabytes of RAM and 
100mhz Pentium processors. Do you say we should just not consider them 
any longer?
If so, then just delete all ACPICA caches altogether.
And this still needs to be patch against ACPICA, not Linux -- at least 
with BSD license attached.

Regards,
Alex.


