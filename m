From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v5 02/33] genirq: Add irq_alloc_reserved_desc()
Date: Mon, 17 Feb 2014 16:59:32 -0800
Message-ID: <CAE9FiQUo9NGbjiZbMsf2yBFbn=iLJ-jc3QtZ8K6qwVuhmqzq=Q@mail.gmail.com>
References: <1388707565-16535-1-git-send-email-yinghai@kernel.org>
	<1388707565-16535-3-git-send-email-yinghai@kernel.org>
	<alpine.DEB.2.02.1401222241100.24986@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1401222241100.24986@ionos.tec.linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 22, 2014 at 4:03 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> There is a clear step by step approach to get this done proper:
>
>  1) Get rid of the existing misconception/misnomer of
>     irq_reserve_irqs().
>
>     Make it explicit that this is dealing with legacy irq spaces. It's
>     not that hard as there are only two users in tree which are both
>     trivial to fix.

Hi, Thomas,

While going through the code for kill irq_reserve_irqs(), I found that
there is irq_reserve_irq().

in include/linux/irq.h

static inline int irq_reserve_irq(unsigned int irq)
{
        return irq_reserve_irqs(irq, 1);
}

it is called via kernel/irq/chip.c::irq_set_chip().

        /*
         * For !CONFIG_SPARSE_IRQ make the irq show up in
         * allocated_irqs. For the CONFIG_SPARSE_IRQ case, it is
         * already marked, and this call is harmless.
         */
        irq_reserve_irq(irq);

There are tens of irq_set_chip... calling for arches that does not
support SPARSE_IRQ yet, and they does not use  irq_alloc_desc()
anywhere.

so how about change those irq_reserve_irq to irq_set_allocated_irqs() and
leave them there?

Thanks

Yinghai
