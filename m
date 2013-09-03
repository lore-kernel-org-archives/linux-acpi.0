From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH RESEND 2/3] x86, mm: Update min_pfn_mapped in add_pfn_range_mapped().
Date: Tue, 03 Sep 2013 13:38:20 +0800
Message-ID: <522575CC.6010001@cn.fujitsu.com>
References: <1378117829-9095-1-git-send-email-tangchen@cn.fujitsu.com> <1378117829-9095-3-git-send-email-tangchen@cn.fujitsu.com> <CAE9FiQXtWc6ud6BpsvUa5F4KKEX7cT5Phj4wvZfEr6zeWZVpZA@mail.gmail.com> <52253607.9010907@cn.fujitsu.com> <CAE9FiQXeiBZU9X7MprpBtyCQgW-u3u5m7XwvEujnvs5wHYdM4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:40633 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932219Ab3ICFji (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Sep 2013 01:39:38 -0400
In-Reply-To: <CAE9FiQXeiBZU9X7MprpBtyCQgW-u3u5m7XwvEujnvs5wHYdM4A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Pekka Enberg <penberg@kernel.org>, Jacob Shin <jacob.shin@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

On 09/03/2013 10:48 AM, Yinghai Lu wrote:
> On Mon, Sep 2, 2013 at 6:06 PM, Tang Chen<tangchen@cn.fujitsu.com>  wrote:
>> Hi Yinghai,
>>
>> On 09/03/2013 02:41 AM, Yinghai Lu wrote:
>
>> How about change the "for (from low to high)" in init_range_memory_mapping()
>> to
>> "for_rev(from high to low)" ?
>> Then we can update min_pfn_mapped in add_pfn_range_mapped().
>>
>> And also, the outer loop is from high to low, we can change the inner loop
>> to be from high
>> to low too.
>
> No. there is other reason for doing local from low to high.
>
> kernel_physical_mapping_init() could clear some mapping near the end
> of PUG/PMD entries but not the head.

Thanks for your explanation. But sorry, I'd like to understand it more 
clearly.

Are you talking about the following code ?
	phys_pud_init()
	{
                 if (addr >= end) {
                         if (!after_bootmem &&
                             !e820_any_mapped(addr & PUD_MASK, next, 
E820_RAM) &&
                             !e820_any_mapped(addr & PUD_MASK, next, 
E820_RESERVED_KERN))
                                 set_pud(pud, __pud(0));
                         continue;
                 }
	}
It will clear the PUD/PMD out of range.


But,
init_mem_mapping()
{
     while (from high to low) {
         init_range_memory_mapping()
         {
             for (from low to high) {						/* I'm saying changing this 
loop */
                 init_memory_mapping()
                 {
                     for () {							/* Not this one */
                         kernel_physical_mapping_init();
                     }
                     add_pfn_range_mapped();
                 }
             }
         }
     }
}

I'm saying changing the outer loop in init_range_memory_mapping(), not 
the one in init_memory_mapping().
I think it is OK to call init_memory_mapping() with any order. The loop 
is out of init_memory_mapping(), right ?

In init_memory_mapping(), it is still from low to high. But when the 
kernel_physical_mapping_init() finished,
we can update min_pfn_mapped in add_pfn_range_mapped() because the outer 
loop is from high to low.

Am I missing something here ?  Please tell me.

>
>>
>> I think updating min_pfn_mapped in init_mem_mapping() is less readable. And
>> min_pfn_mapped
>> and max_pfn_mapped should be updated together.
>
> min_pfn_mapped is early local variable to control allocation in alloc_low_pages.
> put it in init_mem_mapping is more readable.
>

But add_pfn_range_mapped() is in the same file with init_mem_mapping(). 
I think
it is OK to update min_pfn_mapped in it.

Thanks.
