From: Takayoshi Kochi <t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org>
Subject: Re: [PATCH] PCI IRQ resource deallocation support [2/3]
Date: Fri, 24 Sep 2004 14:52:29 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040924.145229.108814142.t-kochi@bq.jp.nec.com>
References: <414FEBDB.2050201@soft.fujitsu.com>
	<200409210857.59457.bjorn.helgaas@hp.com>
	<4150D458.3050400@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4150D458.3050400-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org
Cc: bjorn.helgaas-VXdhtT5mjnY@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kaneshige.kenji-tPnzhWqfZ96MLkP6nYsO9A@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [ACPI] [PATCH] PCI IRQ resource deallocation support [2/3]
Date: Wed, 22 Sep 2004 10:24:40 +0900

> >> +  * dev->irq is cleared by BIOS-assigned IRQ set during boot.
> >> +  */
> >> + pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
> >> + if (irq)
> >> +  pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
> >> + dev->irq = irq;
> > 
> > Why do we need to fiddle with dev->irq?  I think it should
> > just be undefined after acpi_pci_irq_disable().
> 
> I had been considering what the "undefined dev->irq" was.
> In fact, I had other ideas that was clearing it by zero or
> -1 (0xffffffff). But I didn't know if we can use these values
> as a undefined IRQ number. So I'm clearing it by the value
> which was assigned by PCI core code (pci_read_irq()) before
> acpi_pci_irq_enable() was called. 

I think it has little sense in restoring value from the configuration
space to dev->irq or clearing it.

If we do preventive programming, it may be worth
trying to define some magic constant (e.g. PCI_UNDEFINED_IRQ) and
panic/BUG when the irq is being enabled.
Otherwise, leaving dev->irq as it is would be ok.

---
Takayoshi Kochi <t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org>


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
