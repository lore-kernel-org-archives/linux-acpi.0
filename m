From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 7/7] x86/pci: update pirq_enable_irq to setup io apic
 routing -v2
Date: Thu, 7 May 2009 09:52:56 -0700
Message-ID: <20090507095256.7f87fb42@jbarnes-g45>
References: <4A01C35C.7060207@kernel.org>
	<4A01C46E.8000501@kernel.org>
	<20090507141222.GI481@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756999AbZEGQz2@vger.kernel.org>
In-Reply-To: <20090507141222.GI481@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Yinghai Lu <yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 7 May 2009 16:12:22 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Yinghai Lu <yinghai@kernel.org> wrote:
> 
> > 
> > so we could set io apic routing only when enable device irq.
> > 
> > also could make setup_IO_APIC_irqs and setup_ioapic_dest only handle
> > first ioapic...
> > 
> > v2: remove one one not needed style change.
> >     merge the patch only setup io_apic for acpi on in
> > setup_IO_APIC_irqs
> > 
> > [ Impact: make mptable irq enable more like acpi is used, and
> > numa_irq_desc could get correct node when acpi=off ]
> > 
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > 
> > ---
> >  arch/x86/kernel/apic/io_apic.c |  148
> > ++++++++++++++++++++---------------------
> > arch/x86/pci/irq.c             |   84 ++++++++--------------- 2
> > files changed, 103 insertions(+), 129 deletions(-)
> 
> Jesse, did this patch have your Acked-by?

Yeah, both of them are fine with me.  Ultimately you get to keep any
broken pieces from io_apic changes anyway, right? :)

Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>
