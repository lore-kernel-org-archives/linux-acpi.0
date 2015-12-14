From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
Date: Mon, 14 Dec 2015 11:46:59 +0000
Message-ID: <20151214114658.GE6992@arm.com>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
 <20151208123433.GB404@red-moon>
 <5666D28C.4090305@linaro.org>
 <CADyBb7tByoke4PGZqcx_jHvgCK0xNTneod8WoVv7VmoSYii+hg@mail.gmail.com>
 <20151208140720.GA2395@red-moon>
 <CADyBb7sLAJdiC=2UzKFsHQ=+Tfuwd6FGi80O9H+1sj70qtCiPg@mail.gmail.com>
 <CADyBb7vVaPsNZeKp=XQ0zwd-qH1mwuECCtCfkpqm0jDyFTzDcg@mail.gmail.com>
 <20151210110135.GC21134@arm.com>
 <20151214112004.GB11630@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42469 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932203AbbLNLq6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Dec 2015 06:46:58 -0500
Content-Disposition: inline
In-Reply-To: <20151214112004.GB11630@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, rruigrok@codeaurora.org, Michal Hocko <mhocko@suse.cz>, Fu Wei <fu.wei@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, linux-acpi@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>, Len Brown <lenb@kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, rrichter@cavium.com, linux-arm-kernel@lists.infradead.org, G Gregory <graeme.gregory@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, jarkko.nikula@linux.intel.com, Hanjun Guo <hanjun.>

On Mon, Dec 14, 2015 at 12:20:04PM +0100, Borislav Petkov wrote:
> On Thu, Dec 10, 2015 at 11:01:35AM +0000, Will Deacon wrote:
> > [adding Boris, as he might know how this works]
> 
> Gee, thanks Will, now you're making me look at this too :-)

Hey, I was having way too much fun by myself, so figured you'd like to
be involved as well!

> > It's not about flushing one page, flush_tlb_kernel_range (which is called
> > by unmap_kernel_range) already takes care of that. The problem is that
> > the unmap is called from irq/nmi context, so the IPIs required for
> > broadcasting the TLB maintenance on x86 cannot be safely executed.
> 
> Hmm, if you're talking about ghes_iounmap_nmi() and ghes_iounmap_irq()
> which are the two callers of unmap_kernel_range_noflush(), that last one
> is calling vunmap_page_range() which is fiddling with the page table.
> And I don't see TLB flushing IPIs there.
> 
> If you mean arch_apei_flush_tlb_one(), that's INVLPG on x86 so also no
> IPI.
> 
> What am I missing?

We're in violent agreement. I'm just saying that's *why*
arch_apei_flush_tlb_one exists, as opposed to calling unmap_kernel_range
in the driver (which will attempt IPIs). On arm64, unmap_kernel_range
will actually work correctly, since we don't need IPIs to broadcast TLB
maintenance.

The (incorrect) premise earlier in the thread was that
arch_apei_flush_tlb_one exists because there's no portable API for
flushing a single page, but that's simply not true.

> > Ideally, I think the ghes code would just use unmap_kernel_range unless
> > the architecture specifically says that doesn't work in irq context. In
> > that case, we don't need to implement the arch_apei_flush_tlb_one callback
> > on arm64.
> 
> Well, what bothers me with using
> unmap_kernel_range()/vunmap_page_range() is that if a GHES IRQ/NMI
> happens while something is executing those, the NMI will interrupt
> whatever's happening and it will possibly corrupt the pagetable, IMHO.
> 
> Michal, Vlasta, can you please take a look?
> 
> More specifically, those ghes_iounmap_nmi/ghes_iounmap_irq calls to
> unmap_kernel_range_noflush() happening in NMI/IRQ context.

Yikes, I'd not even thought about that. Perhaps its all serialised
somehow, but I have no idea.

> > One thing I don't fully grok about the code: since the page is mapped
> > using ioremap_page_range, doesn't that allow other CPUs to speculatively
> > fill their TLB with entries corresponding to the page mapped by the IRQ
> > handler on another core? If the core with the speculative entries then
> > takes an APEI exception, what guarantees do we have that it's looking at
> > the right page? I think, for x86, we need a local invalidation on map,
> > too.
> 
> You're looking at ghes_copy_tofrom_phys(), right? That's grabbing
> spinlocks in IRQ/NMI context and doing the iounmap a bit later, below
> on the same core. I mean, I don't see us landing on another core in
> between, we're non-preemptible...
> 
> Or do you mean something else?

Right, imagine the following sequence of events:

 1. CPU x takes a GHES IRQ
 2. CPU x then maps the buffer a page at a time in ghes_copy_tofrom_phys.
    After each unmap, it performs a local TLBI. Let's say that it has
    the final page of the buffer mapped when...
 3. ... CPU y is meanwhile happily executing some other kernel code.
 4. CPU y's page table walker speculatively fills the TLB with a translation
    for the last buffer page that CPU x has mapped (because its just been
    mapped with ioremap_page_range and is in the kernel page table).
 5. CPU x unmaps the last page, performs a *local* TLBI, handles the
    event and returns from the exception
 6. CPU y takes a GHES IRQ
 7. CPU y then maps the first buffer page at the same virtual address
    that CPU x used to map the last buffer page
 8. CPU y accesses the page, hits the stale TLB entry and gets junk

which I think means you need to perform local TLB invalidation on map
as well as unmap.

Is there some reason this can't happen on x86? It sounds plausible on
arm64 if we were to use local invalidation.

Will
