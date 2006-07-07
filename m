From: akpm@osdl.org
Subject: [patch 2/5] pnpacpi: reject ACPI_PRODUCER resources
Date: Thu, 06 Jul 2006 23:52:56 -0700
Message-ID: <200607070652.k676qu9t030080@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:13504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751212AbWGGGxI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Jul 2006 02:53:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, castet.matthieu@free.fr, ambx1@neo.rr.com, bjorn.helgaas@hp.com, shaohua.li@intel.com, uwe.bugla@gmx.de

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
Acked-by: Shaohua Li <shaohua.li@intel.com>

akpm: previously nacked, as per comment #26.  But am hanging onto it until the
thing gets fixed for real.

July 6 update!  Maybe un-nacked.  Am waiting to hear from Len.
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/pnp/pnpacpi/rsparser.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN drivers/pnp/pnpacpi/rsparser.c~pnpacpi-reject-acpi_producer-resources drivers/pnp/pnpacpi/rsparser.c
--- a/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-reject-acpi_producer-resources
+++ a/drivers/pnp/pnpacpi/rsparser.c
@@ -173,6 +173,9 @@ pnpacpi_parse_allocated_address_space(st
 		return;
 	}
 
+	if (p->producer_consumer == ACPI_PRODUCER)
+		return;
+
 	if (p->resource_type == ACPI_MEMORY_RANGE)
 		pnpacpi_parse_allocated_memresource(res_table,
 				p->minimum, p->address_length);
@@ -252,9 +255,14 @@ static acpi_status pnpacpi_allocated_res
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
