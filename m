From: Len Brown <lenb@kernel.org>
Subject: PCI, ACPI, IRQ, IOAPIC: reroute PCI interrupt to legacy boot interrupt
 equivalent
Date: Fri, 09 Jan 2009 18:03:44 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091743310.20020@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759998AbZAIXES@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Assmann <sassmann@suse.de>, Ingo Molnar <mingo@elte.hu>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olaf Dabrunz <od@suse.de>, Thomas
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Stefan,
I had to exclude your changes to drivers/acpi/pci_irq.c from
e1d3a90846b40ad3160bf4b648d36c6badad39ac
in order to get some other changes to that file upstream in the
2.6.29 merge window.

I left the other parts of the quirk intact - so at the moment
on one of the quirked machines, you'll see

PCI quirk: reroute interrupts for...

but will not see

pci irq %d -> rerouted to legacy

as the quirk is effectively disabled.

I had difficulty trying to port this patch to the new pci_irq.c
because fundamentally I don't understand what it is trying
to do, and why.

The quirk is specific to Intel chipsets, so with all the
Linux guys now working at Intel, I'm hopeful that we can
reach a clear understanding of the issue and a consensus
on the proper fix.

BTW. I'm not excited about how the original patch
drops a chipset specific workaround inside the ACPI code
to go behind the mirrors and lie about what ACPI returns.
I'm hopeful that a better place for the workaround
can be found if this is the approach we need to take..

Can you help us understand what the failure is?

thanks,
-Len
