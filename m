From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: add _PRT quirks to work around broken firmware
Date: Wed, 12 Mar 2008 18:04:25 -0400
Message-ID: <200803121804.26015.lenb@kernel.org>
References: <200803111445.16316.bjorn.helgaas@hp.com> <200803112340.05293.lenb@kernel.org> <200803121600.50080.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34091 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbYCLWJh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 18:09:37 -0400
In-Reply-To: <200803121600.50080.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Pierre Ossman <drzeus-bugzilla@drzeus.cx>, Michael Fu <michael.fu@intel.com>, Martin Kirst <martin.kirst@s1998.tu-chemnitz.de>, Hadmut Danisch <hadmut@danisch.de>, Johann-Nikolaus Andreae <johann-nikolaus.andreae@nacs.de>, Dominik =?iso-8859-1?q?Sch=E4fer?= <schaedpq2@gmx.de>, Alex Williamson <alex.williamson@hp.com>, Aron Griffis <aron@hp.com>

On Wednesday 12 March 2008, Bjorn Helgaas wrote:
> On Tuesday 11 March 2008 09:40:04 pm Len Brown wrote:
> > Thanks for following up on these, Bjorn.
> > 
> > Is it true that simply enabling pci=routeirq on these boxes
> > is an insufficient workaround?
> > 
> > I suspect the answer is yes, because when pci=routeirq works
> > we may just be lucky -- eg. we happen to assign the real
> > and the fake link to the same IRQ and thus the driver
> > actually registers for the correct IRQ, but by accident.
> 
> I double-checked this, and your guess is correct.  On the MD9580
> laptop, the BIOS reports 00:09[A] is connected to LNKA, which we
> assign to IRQ 10:
> 
>   ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
> 
> The device is actually connected to LNKB, which we also assigned
> to IRQ 10 (before my patch, we only enable LNKB with pci=routeirq
> because it's used by 00:06, for which we don't have a driver):
> 
>   ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
> 
> Similarly, on the Dell OptiPlex, we set both LNKA and LNKB to IRQ 10.
> The 00:0d[A] line is connected to LNKA, but the BIOS reports it on
> LNKB.  Without pci=routeirq, we may not enable LNKA because it's
> only used by 01:00[A], which is a VGA device.

Thanks, Bjorn.

This again raises suspicion that Windows doesn't disable and then re-enable
PCI interrupt links.  It is probably just using them in-place.

While we disable them at boot and re-enable at probe
b/c it fixed some spurious interrupt issues --
it may be that those issues were IOAPIC mode issues
and for PIC systems we should do something different,
such as not touch the links at all.

-Len

