From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [patch][rfc] acpi: do not use kmem caches
Date: Mon, 01 Dec 2008 17:02:50 +0300
Message-ID: <4933EE8A.2010007@gmail.com>
References: <20081201083128.GB2529@wotan.suse.de>	 <84144f020812010318v205579ean57edecf7992ec7ef@mail.gmail.com>	 <20081201120002.GB10790@wotan.suse.de>  <4933E2C3.4020400@gmail.com> <1228138641.14439.18.camel@penberg-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:62228 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbYLAOC4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 09:02:56 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2673273ugf.37
        for <linux-acpi@vger.kernel.org>; Mon, 01 Dec 2008 06:02:54 -0800 (PST)
In-Reply-To: <1228138641.14439.18.camel@penberg-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Nick Piggin <npiggin@suse.de>, Linux Memory Management List <linux-mm@kvack.org>, linux-acpi@vger.kernel.org, lenb@kernel.org

Pekka Enberg wrote:
> Hi,
>
> On Mon, 2008-12-01 at 16:12 +0300, Alexey Starikovskiy wrote:
>   
>>> Actually I think it is also somewhat of a bugfix (not to mention that it
>>> seems like a good idea to share testing code with other operating systems).
>>>       
>> It is not "kind of a bugfix". Caches were used to allocate all frequenly
>> created objects of fixed size. Removing native cache interface will
>> increase memory consumption and increase code size, and will make it harder
>> to spot actual memory leaks.
>>     
>
> Excuse me?
>
> Why do you think Nick's patch is going to _increase_ memory consumption?
> SLUB _already_ merges the ACPI caches with kmalloc caches so you won't
> see any difference there. For SLAB, it's a gain because there's not
> enough activity going on which results in lots of unused space in the
> slabs (which is, btw, the reason SLUB does slab merging in the first
> place).
>
>   
Because SLAB has standard memory wells of 2^x size. None of cached ACPI
objects has exactly this size, so bigger block will be used. Plus, 
internal ACPICA
caching will add some overhead.
> I'm also wondering why you think it's going to increase text size.
> Unless the ACPI code is doing something weird, the kmalloc() and
> kzalloc() shouldn't be a problem at all.
>
>   
if you don't use ACPI_USE_LOCAL_CACHE
ACPICA will enable it's own cache implementation, so it will increase
code size.
> For memory leaks, CONFIG_SLAB_LEAK has been in mainline for a long time
> plus there are the kmemleak patches floating around. So I fail to see
> how it's going to be harder to spot the memory leaks.
It will give you a memory leak, not the kind of it, right?
>  After all, the
> rest of the kernel manages fine without a special wrapper, so how is
> ACPI any different here?
>   
Do you have another interpreter in kernel space?


Regards,
Alex.
