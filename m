From: "Zhang, Jonathan Zhixiong" <zjzhang@codeaurora.org>
Subject: Re: [PATCH V2 3/3] acpi, apei: use EFI memmap to map GHES memory
Date: Fri, 05 Jun 2015 10:05:13 -0700
Message-ID: <5571D6C9.10903@codeaurora.org>
References: <1433185940-24770-1-git-send-email-zjzhang@codeaurora.org> <1433185940-24770-4-git-send-email-zjzhang@codeaurora.org> <20150605095701.GA20042@codeblueprint.co.uk> <20150605102556.GC3679@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150605102556.GC3679@pd.tnic>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Matt Fleming <matt@codeblueprint.co.uk>
Cc: rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, leif.lindholm@linaro.org, al.stone@linaro.org, fu.wei@linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linaro-acpi@lists.linaro.org, vgandhi@codeaurora.org, Tony Luck <tony.luck@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Thank you Borislav for the review. Pls. see comments inline...

On 6/5/2015 3:25 AM, Borislav Petkov wrote:
> On Fri, Jun 05, 2015 at 10:57:01AM +0100, Matt Fleming wrote:
>> [ Cc'ing Boris and Tony. Folks original patch is here,
>>    https://lkml.kernel.org/r/1433185940-24770-4-git-send-email-zjzhang@codeaurora.org ]
>>
>> On Mon, 01 Jun, at 12:12:20PM, Jonathan (Zhixiong) Zhang wrote:
>>> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
>>>
>>> With ACPI APEI firmware first handling, generic hardware error
>>> record is updated by firmware in GHES memory region. When firmware
>>> updated GHES memory region in DDR without going through cache,
>
> What is DDR?
>
> I think this needs to be clarified first before we go any further.
I thought the word "memory" might be confusing, because there are
memories on the system that is not accessible by Linux. In this
context, the APEI error data is accessed (read and write) by both Linux
and platform firmware; hence both sides should access the memory using
same cache attribute. I wanted to emphasize the idea that even though
normally DDR is cachable, but in this case when platform access it with
un-cached attribute, Linux should do the same.
I will try to make it more clear in next version of the patch.
>
> I picked up on the sidelines that this might be arm64-specific stuff. If
> so, your approach is wrong: you're merging efi_* facilities from x86 and
> ia64 into generic efi ones but then doing CONFIG_EFI ifdeffery in GHES.
>
> What you should do instead is have arch-specific:
>
> ghes_ioremap_pfn_irq()
> ghes_iounmap_irq()
> ...
>
> and whatever else functionality which is different on your arch and
> which get called from the generic ghes.c driver.
>
> In the arch-specific ones you can go wild with the ifdeffery and whatnot
> is needed on that specific arch.
>
> Something like that, at least.
Makes total sense. I was trying to reduce binary size for non-EFI
system, but as Matt pointed out in another feedback, on x86 even
BIOS based system has CONFIG_EFI enabled. I will submit a new version
accordingly.

-- 
Jonathan (Zhixiong) Zhang
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
