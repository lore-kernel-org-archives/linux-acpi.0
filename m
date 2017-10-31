From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC/RFT PATCH 2/6] x86/mm/fixmap: Add GHES fixmap entries
Date: Tue, 31 Oct 2017 20:04:38 +0100
Message-ID: <20171031190438.u6ctvc7lyeedo5dw@gmail.com>
References: <20171031153832.17746-1-james.morse@arm.com>
 <20171031153832.17746-3-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:56509 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932501AbdJaTEn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Oct 2017 15:04:43 -0400
Content-Disposition: inline
In-Reply-To: <20171031153832.17746-3-james.morse@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>, torvalds@linux-foundation.org


* James Morse <james.morse@arm.com> wrote:

> GHES is switching to use fixmap for its dynamic mapping of CPER records,
> to avoid using ioremap_page_range() in IRQ/NMI context.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/include/asm/fixmap.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
> index dcd9fb55e679..be3cc32db7f0 100644
> --- a/arch/x86/include/asm/fixmap.h
> +++ b/arch/x86/include/asm/fixmap.h
> @@ -104,6 +104,10 @@ enum fixed_addresses {
>  	FIX_GDT_REMAP_BEGIN,
>  	FIX_GDT_REMAP_END = FIX_GDT_REMAP_BEGIN + NR_CPUS - 1,
>  
> +	/* Used for GHES mapping from assorted contexts */
> +	FIX_APEI_GHES_IRQ,
> +	FIX_APEI_GHES_NMI,
> +

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
