From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] PNPACPI: ignore the producer/consumer bit for extended IRQ descriptors
Date: Fri, 22 Aug 2008 09:47:17 -0600
Message-ID: <200808220947.18253.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:24640 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbYHVPrV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Aug 2008 11:47:21 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Adam M Belay <abelay@mit.edu>, Matthieu CASTET <matthieu.castet@parrot.com>, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

The Extended Interrupt descriptor has a producer/consumer bit, but
it's not clear what that would mean, and existing BIOSes use the bit
inconsistently.  This patch makes Linux PNPACPI ignore the bit.

The ACPI spec contains examples of PCI Interrupt Link devices marked
as ResourceProducers, but many BIOSes mark them as ResourceConsumers.

I also checked with a Windows contact, who said:

    Windows uses only "resource consumer" when dealing with
    interrupts.  There's no useful way of looking at a resource
    producer of interrupts.

    ... NT-based Windows largely infers the producer/consumer stuff
    from the device type and ignores the bits in the namespace.  This
    was necessary because Windows 98 ignored them and early namespaces
    contained random junk.

The reason I want to change this is because if PNPACPI devices exclude
ResourceProducer IRQ resources, we can't write PNP drivers for those
devices.

For example, on machines such as the the HP rx7620, rx7640, rx8620,
rx8640, and Superdome, HPET interrupts are ResourceProducers.  The
HPET driver currently has to use acpi_bus_register_driver() and do its
own _CRS parsing, even though it requires absolutely no ACPI-specific
functionality.

It would be better if the HPET driver were a PNP driver and took
advantage of the _CRS parsing built into PNPACPI.

This producer/consumer check was originally added here:
    http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=2b8de5f50e4a302b83ebcd5b0120621336d50bd6

to fix this bug:
    http://bugzilla.kernel.org/show_bug.cgi?id=6292

However, the bug was related only to memory and I/O port resources,
where the distinction is sensible and important to Linux.  Given that
the distinction is muddled for IRQ resources, I think it was a mistake
to add the check there.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/pnp/pnpacpi/rsparser.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)


diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 85baf16..adf1785 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -406,8 +406,6 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		extended_irq = &res->data.extended_irq;
-		if (extended_irq->producer_consumer == ACPI_PRODUCER)
-			return AE_OK;
 
 		if (extended_irq->interrupt_count == 0)
 			pnp_add_irq_resource(dev, 0, IORESOURCE_DISABLED);
