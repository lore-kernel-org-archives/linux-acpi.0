From: Borislav Petkov <bp@suse.de>
Subject: Re: [RFC/RFT PATCH 2/6] x86/mm/fixmap: Add GHES fixmap entries
Date: Tue, 31 Oct 2017 20:09:47 +0100
Message-ID: <20171031190947.gmbr67etuoanhu6n@pd.tnic>
References: <20171031153832.17746-1-james.morse@arm.com>
 <20171031153832.17746-3-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38055 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbdJaTJy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 31 Oct 2017 15:09:54 -0400
Content-Disposition: inline
In-Reply-To: <20171031153832.17746-3-james.morse@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>, torvalds@linux-foundation.org

On Tue, Oct 31, 2017 at 03:38:28PM +0000, James Morse wrote:
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

Maybe I'm missing something but shouldn't those two be inside
CONFIG_ACPI_APEI_GHES ifdeffery?

Ditto for the ARM side.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
