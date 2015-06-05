From: "Zhang, Jonathan Zhixiong" <zjzhang@codeaurora.org>
Subject: Re: [PATCH V2 3/3] acpi, apei: use EFI memmap to map GHES memory
Date: Fri, 05 Jun 2015 09:43:26 -0700
Message-ID: <5571D1AE.4050605@codeaurora.org>
References: <1433185940-24770-1-git-send-email-zjzhang@codeaurora.org> <1433185940-24770-4-git-send-email-zjzhang@codeaurora.org> <20150605095701.GA20042@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150605095701.GA20042@codeblueprint.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, leif.lindholm@linaro.org, al.stone@linaro.org, fu.wei@linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linaro-acpi@lists.linaro.org, vgandhi@codeaurora.org, Tony Luck <tony.luck@gmail.com>, Borislav Petkov <bp@alien8.de>
List-Id: linux-acpi@vger.kernel.org

Thanks Matt for the review. Yes, you are right on, I am following
this:
 > modify ghes_ioremap_* to query the EFI memmap (if
 > it's available at runtime) to lookup the correct mapping attributes.

Jonathan

On 6/5/2015 2:57 AM, Matt Fleming wrote:
> [ Cc'ing Boris and Tony. Folks original patch is here,
>    https://lkml.kernel.org/r/1433185940-24770-4-git-send-email-zjzhang@codeaurora.org ]
>
> On Mon, 01 Jun, at 12:12:20PM, Jonathan (Zhixiong) Zhang wrote:
>> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
>>
>> With ACPI APEI firmware first handling, generic hardware error
>> record is updated by firmware in GHES memory region. When firmware
>> updated GHES memory region in DDR without going through cache,
>> Linux reads stale data from cache.
>>
>> GHES memory region should be mapped with cache attributes
>> according to EFI memory map when applicable. If firmware updates
>> DDR directly, EFI memory map has GHES memory region defined as
>> uncached; If firmware updates cache, EFI memory map has GHES
>> memory region defined as cached.
>>
>> When EFI is configued, map IRQ page using efi_remap() provided by
>> EFI subsystem.
>
> [...]
>
>> @@ -159,6 +160,7 @@ static void __iomem *ghes_ioremap_pfn_nmi(u64 pfn)
>>   	return (void __iomem *)vaddr;
>>   }
>>
>> +#ifndef CONFIG_EFI
>>   static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
>>   {
>>   	unsigned long vaddr;
>
> Sprinkling CONFIG_EFI like this is wrong. On x86 we run kernels built
> with CONFIG_EFI on machines with BIOS - you can't make the EFI vs.
> non-EFI decision at compile-time.
>
> So this patch looks like a potential regression to me since on x86
> ghes_ioremap_pfn_irq() would not be used anymore and instead we'd be
> using efi_remap() which will perform an ioremap_nocache() if it gets
> called after efi_free_boot_services().
>
> And based on the comments in the apei code, that's going to cause issues
> because ioremap() does not work in atomic context, not to mention the
> fact that we've gone from a cached mapping to an uncached one.
>
> Instead, I suggest you modify ghes_ioremap_* to query the EFI memmap (if
> it's available at runtime) to lookup the correct mapping attributes.
>
> But I've Cc'd some more people who have actually worked on this code,
> since I'm not one of them.
>

-- 
Jonathan (Zhixiong) Zhang
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
