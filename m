From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
Date: Mon, 14 Dec 2015 12:20:04 +0100
Message-ID: <20151214112004.GB11630@pd.tnic>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
 <20151208123433.GB404@red-moon>
 <5666D28C.4090305@linaro.org>
 <CADyBb7tByoke4PGZqcx_jHvgCK0xNTneod8WoVv7VmoSYii+hg@mail.gmail.com>
 <20151208140720.GA2395@red-moon>
 <CADyBb7sLAJdiC=2UzKFsHQ=+Tfuwd6FGi80O9H+1sj70qtCiPg@mail.gmail.com>
 <CADyBb7vVaPsNZeKp=XQ0zwd-qH1mwuECCtCfkpqm0jDyFTzDcg@mail.gmail.com>
 <20151210110135.GC21134@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55573 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932276AbbLNLUN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Dec 2015 06:20:13 -0500
Content-Disposition: inline
In-Reply-To: <20151210110135.GC21134@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Fu Wei <fu.wei@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>, rrichter@cavium.com, jarkko.nikula@linux.intel.com, Jonathan Zhang <jon.zhixiong.zhang@gmail.com>M

On Thu, Dec 10, 2015 at 11:01:35AM +0000, Will Deacon wrote:
> [adding Boris, as he might know how this works]

Gee, thanks Will, now you're making me look at this too :-)

> It's not about flushing one page, flush_tlb_kernel_range (which is ca=
lled
> by unmap_kernel_range) already takes care of that. The problem is tha=
t
> the unmap is called from irq/nmi context, so the IPIs required for
> broadcasting the TLB maintenance on x86 cannot be safely executed.

Hmm, if you're talking about ghes_iounmap_nmi() and ghes_iounmap_irq()
which are the two callers of unmap_kernel_range_noflush(), that last on=
e
is calling vunmap_page_range() which is fiddling with the page table.
And I don't see TLB flushing IPIs there.

If you mean arch_apei_flush_tlb_one(), that's INVLPG on x86 so also no
IPI.

What am I missing?

> Ideally, I think the ghes code would just use unmap_kernel_range unle=
ss
> the architecture specifically says that doesn't work in irq context. =
In
> that case, we don't need to implement the arch_apei_flush_tlb_one cal=
lback
> on arm64.

Well, what bothers me with using
unmap_kernel_range()/vunmap_page_range() is that if a GHES IRQ/NMI
happens while something is executing those, the NMI will interrupt
whatever's happening and it will possibly corrupt the pagetable, IMHO.

Michal, Vlasta, can you please take a look?

More specifically, those ghes_iounmap_nmi/ghes_iounmap_irq calls to
unmap_kernel_range_noflush() happening in NMI/IRQ context.

> One thing I don't fully grok about the code: since the page is mapped
> using ioremap_page_range, doesn't that allow other CPUs to speculativ=
ely
> fill their TLB with entries corresponding to the page mapped by the I=
RQ
> handler on another core? If the core with the speculative entries the=
n
> takes an APEI exception, what guarantees do we have that it's looking=
 at
> the right page? I think, for x86, we need a local invalidation on map=
,
> too.

You're looking at ghes_copy_tofrom_phys(), right? That's grabbing
spinlocks in IRQ/NMI context and doing the iounmap a bit later, below
on the same core. I mean, I don't see us landing on another core in
between, we're non-preemptible...

Or do you mean something else?

--=20
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on, HRB 21284 (AG N=C3=BCrnberg)
--=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
