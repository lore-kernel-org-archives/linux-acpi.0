From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 02/33] genirq: Add irq_alloc_reserved_desc()
Date: Sat, 22 Feb 2014 11:08:28 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402221104440.21251@ionos.tec.linutronix.de>
References: <1388707565-16535-1-git-send-email-yinghai@kernel.org> <1388707565-16535-3-git-send-email-yinghai@kernel.org> <alpine.DEB.2.02.1401222241100.24986@ionos.tec.linutronix.de> <CAE9FiQUo9NGbjiZbMsf2yBFbn=iLJ-jc3QtZ8K6qwVuhmqzq=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45940 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbaBVKId (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Feb 2014 05:08:33 -0500
In-Reply-To: <CAE9FiQUo9NGbjiZbMsf2yBFbn=iLJ-jc3QtZ8K6qwVuhmqzq=Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

On Mon, 17 Feb 2014, Yinghai Lu wrote:
> On Wed, Jan 22, 2014 at 4:03 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > There is a clear step by step approach to get this done proper:
> >
> >  1) Get rid of the existing misconception/misnomer of
> >     irq_reserve_irqs().
> >
> >     Make it explicit that this is dealing with legacy irq spaces. It's
> >     not that hard as there are only two users in tree which are both
> >     trivial to fix.
> 
> Hi, Thomas,
> 
> While going through the code for kill irq_reserve_irqs(), I found that
> there is irq_reserve_irq().
> 
> in include/linux/irq.h
> 
> static inline int irq_reserve_irq(unsigned int irq)
> {
>         return irq_reserve_irqs(irq, 1);
> }
> 
> it is called via kernel/irq/chip.c::irq_set_chip().
> 
>         /*
>          * For !CONFIG_SPARSE_IRQ make the irq show up in
>          * allocated_irqs. For the CONFIG_SPARSE_IRQ case, it is
>          * already marked, and this call is harmless.
>          */
>         irq_reserve_irq(irq);
> 
> There are tens of irq_set_chip... calling for arches that does not
> support SPARSE_IRQ yet, and they does not use  irq_alloc_desc()
> anywhere.
> 
> so how about change those irq_reserve_irq to irq_set_allocated_irqs() and
> leave them there?

As I said before irq_reserve_irq() is a misnomer and a
misconception. Of course this needs to be fixed as well.

And you cannot just blindly change it because !SPARSE can use the
allocation. We are not creating stupid corner cases just to support
your sloppyness. Its not rocket science to do it the right way.

That said, it might be worthwhile to get rid of the !SPARSE case
completely. That would probably make quite some stuff simpler.

Thanks,

	tglx




