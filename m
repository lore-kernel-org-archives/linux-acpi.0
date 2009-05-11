From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 7/7] x86/pci: update pirq_enable_irq to setup io apic
	routing -v2
Date: Mon, 11 May 2009 09:49:13 +0200
Message-ID: <20090511074913.GA5636@elte.hu>
References: <4A01C35C.7060207@kernel.org> <4A01C46E.8000501@kernel.org> <20090507141222.GI481@elte.hu> <20090507095256.7f87fb42@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:42317 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbZEKHuJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 May 2009 03:50:09 -0400
Content-Disposition: inline
In-Reply-To: <20090507095256.7f87fb42@jbarnes-g45>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Yinghai Lu <yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>


* Jesse Barnes <jbarnes@virtuousgeek.org> wrote:

> On Thu, 7 May 2009 16:12:22 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Yinghai Lu <yinghai@kernel.org> wrote:
> > 
> > > 
> > > so we could set io apic routing only when enable device irq.
> > > 
> > > also could make setup_IO_APIC_irqs and setup_ioapic_dest only handle
> > > first ioapic...
> > > 
> > > v2: remove one one not needed style change.
> > >     merge the patch only setup io_apic for acpi on in
> > > setup_IO_APIC_irqs
> > > 
> > > [ Impact: make mptable irq enable more like acpi is used, and
> > > numa_irq_desc could get correct node when acpi=off ]
> > > 
> > > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > > 
> > > ---
> > >  arch/x86/kernel/apic/io_apic.c |  148
> > > ++++++++++++++++++++---------------------
> > > arch/x86/pci/irq.c             |   84 ++++++++--------------- 2
> > > files changed, 103 insertions(+), 129 deletions(-)
> > 
> > Jesse, did this patch have your Acked-by?
> 
> Yeah, both of them are fine with me.  Ultimately you get to keep 
> any broken pieces from io_apic changes anyway, right? :)

Yeah, generally. But the wider the blame can be spread when it does 
break, the better! ;-)

> Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

Thanks!

	Ingo
