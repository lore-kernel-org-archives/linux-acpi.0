From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] ACPI: skip boot interrupt rerouting when index is zero
Date: Sun, 12 Mar 2017 21:03:39 -0500
Message-ID: <20170313020339.GA8232@bhelgaas-glaptop.roam.corp.google.com>
References: <20170210114517.14812-1-sassmann@kpanic.de>
 <20170308223410.GA12086@bhelgaas-glaptop.roam.corp.google.com>
 <60c50f6c-bfc8-3f74-80aa-150558d6b703@kpanic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751935AbdCMCDq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Mar 2017 22:03:46 -0400
Content-Disposition: inline
In-Reply-To: <60c50f6c-bfc8-3f74-80aa-150558d6b703@kpanic.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Assmann <sassmann@kpanic.de>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net

On Fri, Mar 10, 2017 at 02:47:06PM +0100, Stefan Assmann wrote:
> On 08.03.2017 23:34, Bjorn Helgaas wrote:
> > Hi Stefan,
> 
> Hi Bjorn,
> 
> > On Fri, Feb 10, 2017 at 12:45:17PM +0100, Stefan Assmann wrote:
> >> When checking for boot interrupts and PRT index is zero avoid doing
> >> any interrupt rerouting since the code currently does not handle
> >> determining the IRQ via _CRS method.
> > 
> > I don't understand this at all.  Can you educate me a little?
> 
> Sure, I'll try to explain my chain of thoughts.
> 
> > This bug occurs on the M2N-LR system.  I think that board contains an
> > Intel 6702PXH PCIe-to-PCI-X bridge to support its PCI-X slots.  A
> > PCI-X 3ware 9550SX is plugged in below the 6702PXH, and the problem is
> > with the wired INTx interrupts from the 9550SX.
> > 
> > Can we tell where those PCI-X INTx wires are connected?  There's an
> > IOAPIC in the 6702PXH; if they're connected there, the Intel 6700PXH
> > 64-bit PCI Hub datasheet [1], sec 2.15.2, says it should generate
> > upstream PCIe INTx messages ("boot interrupts") if the PCI-X INTx
> > interrupt is masked in the APIC.
> 
> Correct, if you take a look at bridge_has_boot_interrupt_variant() we
> actually walk up all the bridges to the root bridge and check for the
> 6702PXH via irq_reroute_variant, which gets set via PCI quirks in
> quirk_reroute_to_boot_interrupts_intel().
> 
> > If the PCI-X INTx wires are connected elsewhere, e.g., to some other
> > IOAPIC, the 6702PXH should never see its IOAPIC inputs wiggle and it
> > should never generate a boot interrupt.
> > 
> > The fact that the 6702PXH IOAPIC doesn't appear in the lspci output
> > and that "pci=noioapicquirk" is a workaround makes me think that we
> > aren't using the 6702PXH IOAPIC and therefore we don't see boot
> > interrupts on this system.
> 
> Oh, I did not notice that dmesg only reports 1 IO-APIC. Though walking
> the bridges reports the 6702PXH IO-APIC being involved, otherwise the
> quirk wouldn't hit.

The 6702PXH is definitely involved as a PCIe-to-PCI-X bridge, but that
doesn't mean the 6702PXH IOAPIC is involved.  The PCI-X bus has INTx
wires that *could* be connected to the 6702PXH IOAPIC, but on this
system I think they're likely connected to an IOAPIC in the MCP55.

Bjorn
