From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/acpi: check rsdp address received via bootparams to
 be valid
Date: Wed, 17 Jan 2018 19:12:43 +0100
Message-ID: <a0a790b4-069b-8c99-e898-368fce01c632@suse.com>
References: <20180116135730.19216-1-jgross@suse.com>
 <20180116154630.ke53suvokynj73qd@gmail.com>
 <432c21ab-24d8-1e70-a471-ad8a14357d4e@suse.com>
 <20180116163529.rc5j23oqmwk45rp5@gmail.com>
 <4a8b0233-9bb8-3c95-0a08-93a5ceffc231@suse.com>
 <20180117153404.qnv3tjf6jhk4xijs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46023 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752579AbeAQSMq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Jan 2018 13:12:46 -0500
In-Reply-To: <20180117153404.qnv3tjf6jhk4xijs@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com

On 17/01/18 16:34, Ingo Molnar wrote:
> 
> * Juergen Gross <jgross@suse.com> wrote:
> 
>> On 16/01/18 17:35, Ingo Molnar wrote:
>>>
>>> * Juergen Gross <jgross@suse.com> wrote:
>>>
>>>> On 16/01/18 16:46, Ingo Molnar wrote:
>>>>>
>>>>> * Juergen Gross <jgross@suse.com> wrote:
>>>>>
>>>>>> There seem to exist several grub2 versions trashing
>>>>>> boot_params.hdr.acpi_rsdp_addr.
>>>>>>
>>>>>> So don't just believe this address to be valid, but verify it pointing
>>>>>> to a valid RSDP table.
>>>>>
>>>>> Exactly what kind of values do those Grub2 versions put into that field? Pointer 
>>>>> to something, or random noise?
>>>>
>>>> Looks like random noise. On Mike's system it was 0x000000000151.
>>>>
>>>>> Also, what exactly does 'validation' mean, how robustly does it filter out of spec 
>>>>> uses of the boot protocol?
>>>>
>>>> It validates the RSDP has the correct 8 byte eye catcher in it and
>>>> the checksum of the structure is correct. Searching the RSDP by
>>>> scanning memory is using the same checks, so I guess this ought to
>>>> be okay. Odds are about 1 : 2^80 for false positives.
>>>
>>> Ok, this should work - but only because the RSDP is defined in such a robust 
>>> fashion.
>>>
>>> The boot protocol extension is still fragile: what I worry about is that if we 
>>> start relying on the extended boot protocol with widespread installed base of out 
>>> of spec Grub2 loaders, other extensions (which cannot be sanity checked) would be 
>>> less robust.
>>>
>>> Is there a way to detect the broken Grub2 versions somehow and just limit the boot 
>>> protocol for them?
>>>
>>> The other solution would be to just discontinue this boot protocol extension and 
>>> define a new one.
>>
>> I think the best way to do it would be to let grub2 report the version
>> of the protocol it is honoring. This reported version should not be
>> higher than that of the kernel. The kernel would then know which fields
>> of setup_header are known by grub2 and thus can be trusted to be
>> correct.
>>
>> I can modify my patch series to add the grub2 version information before
>> the new rsdp_address field so this band-aid patch won't be required.
>>
>> What do you think?
> 
> Such an approach would be a lot more future proof I think - except that I don't 
> think the ABI should be 'version' based but 'size' based, like 
> sys_sched_getattr().

Hmm, the interface from the kernel to the bootloader already has the
version in it. So it would be more natural to use the same kind of
information in the other direction, too.

> The idea is that we introduce a 'size' field in the existing boot params, which 
> would be zero for old bootloaders. (Is such a free field available?)

No. Look in arch/x86/include/uapi/asm/bootparam.h for struct
setup_header.

> The boot loader puts the boot parameter structure size it currently supports, and 
> the kernel reads it and acts accordingly.

And here the problems begin: lets say current kernel knows about
setup_header size of 200 bytes. The boot loader is writing 300 into
the size field. Does this mean the boot loader is very new, or did
it just write garbage into the size field?

> This is flexible in a both forwards and backwards ABI-compatible manner, i.e. old 
> kernel could run with new boot loader and old bootloader could run with new 
> kernel, while having the maximum common set of boot protocol features supported.
> 
> If such an interface would be possible to create, that is.

What I suggested (adding the boot loader version after the current end)
won't work. We need some kind of feedback in the current header, as
otherwise we can never be sure whether the feedback is garbage or real.

So what about the following:

>From version 0x020e on (current version without my patches is 0x020d)
the boot loader will write its supported version or'ed with 0x8000 into
the same version field. So we can be sure any added fields are filled
with real data or the information has been evaluated by the boot loader,
if the returned version included that field. If the boot loader finds
the kernel supports a version < 0x020e it won't return its supported
version.


Juergen
