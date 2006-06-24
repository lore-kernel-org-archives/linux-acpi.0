From: akpm@osdl.org
Subject: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Sat, 24 Jun 2006 16:36:53 -0700
Message-ID: <200606242336.k5ONarH2008074@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:40348 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751250AbWFXXpR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jun 2006 19:45:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, castet.matthieu@free.fr, ambx1@neo.rr.com, bjorn.helgaas@hp.com, uwe.bugla@gmx.de


From: matthieu castet <castet.matthieu@free.fr>

A patch in -mm kernel correct the parsing of "address resources" of pnpacpi. 
Before we assumed it was memory only, but it could be also IO.

But this change show an hidden bug : some resources could be producer type
that are not handled by pnp layer.  So we should ignore the producer
resources.

This patch fixes bug 6292 (http://bugzilla.kernel.org/show_bug.cgi?id=6292).
Some devices like PNP0A03 have 0xd00-0xffff and 0x0-0xcf7 as IO producer 
resources.

Before correcting "address resources" parsing, it was seen as memory and was
harmless, because nobody tried to reserve this memory range as it should be
IO.

With the correction it become IO resources, and make failed all others device
that want to register IO in this range and use pnp layer (like a ISA sound
card).

The solution is to ignore producer resources

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
Signed-off-by: Uwe Bugla <uwe.bugla@gmx.de>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Adam Belay <ambx1@neo.rr.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/pnp/pnpacpi/rsparser.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN drivers/pnp/pnpacpi/rsparser.c~pnpacpi-reject-acpi_producer-resources drivers/pnp/pnpacpi/rsparser.c
--- a/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-reject-acpi_producer-resources
+++ a/drivers/pnp/pnpacpi/rsparser.c
@@ -170,6 +170,9 @@ pnpacpi_parse_allocated_address_space(st
 		return;
 	}
 
+	if (p->producer_consumer == ACPI_PRODUCER)
+		return;
+
 	if (p->resource_type == ACPI_MEMORY_RANGE)
 		pnpacpi_parse_allocated_memresource(res_table,
 				p->minimum, p->address_length);
@@ -248,9 +251,14 @@ static acpi_status pnpacpi_allocated_res
 		break;
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
+		if (res->data.ext_address64.producer_consumer == ACPI_PRODUCER)
+			return AE_OK;
 		break;
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		if (res->data.extended_irq.producer_consumer == ACPI_PRODUCER)
+			return AE_OK;
+
 		for (i = 0; i < res->data.extended_irq.interrupt_count; i++) {
 			pnpacpi_parse_allocated_irqresource(res_table,
 				res->data.extended_irq.interrupts[i],
_
