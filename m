From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V2 3/3] acpi, apei: use EFI memmap to map GHES memory
Date: Fri, 5 Jun 2015 12:25:56 +0200
Message-ID: <20150605102556.GC3679@pd.tnic>
References: <1433185940-24770-1-git-send-email-zjzhang@codeaurora.org>
 <1433185940-24770-4-git-send-email-zjzhang@codeaurora.org>
 <20150605095701.GA20042@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150605095701.GA20042@codeblueprint.co.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, leif.lindholm@linaro.org, al.stone@linaro.org, fu.wei@linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linaro-acpi@lists.linaro.org, vgandhi@codeaurora.org, Tony Luck <tony.luck@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 05, 2015 at 10:57:01AM +0100, Matt Fleming wrote:
> [ Cc'ing Boris and Tony. Folks original patch is here,
>   https://lkml.kernel.org/r/1433185940-24770-4-git-send-email-zjzhang@codeaurora.org ]
> 
> On Mon, 01 Jun, at 12:12:20PM, Jonathan (Zhixiong) Zhang wrote:
> > From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
> > 
> > With ACPI APEI firmware first handling, generic hardware error
> > record is updated by firmware in GHES memory region. When firmware
> > updated GHES memory region in DDR without going through cache,

What is DDR?

I think this needs to be clarified first before we go any further.

I picked up on the sidelines that this might be arm64-specific stuff. If
so, your approach is wrong: you're merging efi_* facilities from x86 and
ia64 into generic efi ones but then doing CONFIG_EFI ifdeffery in GHES.

What you should do instead is have arch-specific:

ghes_ioremap_pfn_irq()
ghes_iounmap_irq()
...

and whatever else functionality which is different on your arch and
which get called from the generic ghes.c driver.

In the arch-specific ones you can go wild with the ifdeffery and whatnot
is needed on that specific arch.

Something like that, at least.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
