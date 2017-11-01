From: Borislav Petkov <bp@suse.de>
Subject: Re: [RFC/RFT PATCH 3/6] ACPI / APEI:  Replace ioremap_page_range()
 with fixmap
Date: Wed, 1 Nov 2017 14:34:30 +0100
Message-ID: <20171101133430.if3j2kzins44nv7o@pd.tnic>
References: <20171031153832.17746-1-james.morse@arm.com>
 <20171031153832.17746-4-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751853AbdKANej (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Nov 2017 09:34:39 -0400
Content-Disposition: inline
In-Reply-To: <20171031153832.17746-4-james.morse@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>, torvalds@linux-foundation.org

On Tue, Oct 31, 2017 at 03:38:29PM +0000, James Morse wrote:
> Replace ghes_io{re,un}map_pfn_{nmi,irq}()s use of ioremap_page_range()
> with __set_fixmap() as ioremap_page_range() may sleep to allocate a new
> level of page-table, even if its passed an existing final-address to
> use in the mapping.
> 
> clear_fixmap() does the TLB invalidation in __set_fixmap() for arm64
> and __set_pte_vaddr() for x86. In each case its the same as the
> respective arch_apei_flush_tlb_one().
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> CC: Tyler Baicar <tbaicar@codeaurora.org>
> CC: Dongjiu Geng <gengdongjiu@huawei.com>
> CC: Xie XiuQi <xiexiuqi@huawei.com>
> 
> ---
> CC'd people I've seen posting CPER log fragments, could you give this a
> test on your platforms?
> 
>  drivers/acpi/apei/ghes.c | 45 +++++++++++++++------------------------------
>  1 file changed, 15 insertions(+), 30 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
