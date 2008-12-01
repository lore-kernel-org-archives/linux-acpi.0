From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [patch][rfc] acpi: do not use kmem caches
Date: Mon, 01 Dec 2008 19:45:14 +0300
Message-ID: <4934149A.4020604@gmail.com>
References: <20081201083128.GB2529@wotan.suse.de> <84144f020812010318v205579ean57edecf7992ec7ef@mail.gmail.com> <20081201120002.GB10790@wotan.suse.de> <4933E2C3.4020400@gmail.com> <1228138641.14439.18.camel@penberg-laptop> <4933EE8A.2010007@gmail.com> <20081201161404.GE10790@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:38589 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbYLAQpU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 11:45:20 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2723780ugf.37
        for <linux-acpi@vger.kernel.org>; Mon, 01 Dec 2008 08:45:17 -0800 (PST)
In-Reply-To: <20081201161404.GE10790@wotan.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Linux Memory Management List <linux-mm@kvack.org>, linux-acpi@vger.kernel.org, lenb@kernel.org

Nick Piggin wrote:
> On Mon, Dec 01, 2008 at 05:02:50PM +0300, Alexey Starikovskiy wrote:
>   
>> Because SLAB has standard memory wells of 2^x size. None of cached ACPI
>> objects has exactly this size, so bigger block will be used. Plus, 
>> internal ACPICA caching will add some overhead.
>>     
>
> That's an insane looking caching thing now that I come to closely read
> the code. There is so much stuff there that I thought it must have been
> doing something useful which is why I didn't replace the Linux functions
> with kmalloc/kfree directly.
>
> There is really some operating system you support that has such a poor
> allocator that you think ACPI can do better in 300 lines of code? Why
> not just rip that whole thing out?
>   
You would laugh, this is due to Windows userspace debug library -- it 
checks for
memory leaks by default, and it takes ages to do this.
And ACPICA maintainer is sitting on Windows, so he _cares_.
>> Do you have another interpreter in kernel space?
>>     
>
> So what makes it special?
>
>   
You don't know what size of program you will end up with.
DSDT could be almost empty, or you could have several thousand of SSDT 
tables.



