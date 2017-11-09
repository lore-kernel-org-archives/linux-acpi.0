From: Zhengqiang <zhengqiang10@huawei.com>
Subject: Re: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use
 fixmap
Date: Thu, 9 Nov 2017 20:22:53 +0800
Message-ID: <5A04489D.2040201@huawei.com>
References: <20171031153832.17746-1-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:10045 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754241AbdKIMYn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Nov 2017 07:24:43 -0500
In-Reply-To: <20171031153832.17746-1-james.morse@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>, Xie XiuQi <xiexiuqi@huawei.com>, Tyler Baicar <tbaicar@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Dongjiu Geng <gengdongjiu@huawei.com>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>



On 2017/10/31 23:38, James Morse wrote:
> GHES is doing ioremap_page_range() in both NMI and irq context, neither
> are safe as it may sleep to allocate intermediate levels of page table.
> 
> Replace the NMI/irq GHES_IOREMAP_PAGES to use a fixmap entry each.
> 
> After this nothing uses ghes_ioremap_area or arch_apei_flush_tlb_one(),
> rip them out.
> 
> RFC as I've only build-tested this on x86. For arm64 I've tested it on a
> software model. Any more testing would be welcome. These patches are based
> on rc7.
> 


Tested-by:  Qiang Zheng <zhengqiang10@huawei.com>

Verified on our arm64, it work for me. Thanks.

Qiang

