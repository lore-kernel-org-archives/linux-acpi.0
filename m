From: akpm@linux-foundation.org
Subject: [patch (for 2.6.26?) 2/3] pnpacpi: fix shareable IRQ encode/decode
Date: Mon, 09 Jun 2008 16:52:05 -0700
Message-ID: <200806092352.m59Nq5ak015768@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45599 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754341AbYFIXxt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 19:53:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, bjorn.helgaas@hp.com, ThJaeger@gmail.com

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

When we encode IRQ resources, we should use the "shareable" flag we got
from _PRS rather than guessing based on the IRQ trigger mode.

This is based on a patch by Tom Jaeger:
    http://bugzilla.kernel.org/show_bug.cgi?id=9487#c32

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Tom Jaeger <ThJaeger@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/pnp/pnpacpi/rsparser.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff -puN drivers/pnp/pnpacpi/rsparser.c~pnpacpi-fix-shareable-irq-encode-decode drivers/pnp/pnpacpi/rsparser.c
--- a/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-fix-shareable-irq-encode-decode
+++ a/drivers/pnp/pnpacpi/rsparser.c
@@ -50,14 +50,14 @@ static int irq_flags(int triggering, int
 			flags = IORESOURCE_IRQ_HIGHEDGE;
 	}
 
-	if (shareable)
+	if (shareable == ACPI_SHARED)
 		flags |= IORESOURCE_IRQ_SHAREABLE;
 
 	return flags;
 }
 
 static void decode_irq_flags(struct pnp_dev *dev, int flags, int *triggering,
-			     int *polarity)
+			     int *polarity, int *shareable)
 {
 	switch (flags & (IORESOURCE_IRQ_LOWLEVEL | IORESOURCE_IRQ_HIGHLEVEL |
 			 IORESOURCE_IRQ_LOWEDGE  | IORESOURCE_IRQ_HIGHEDGE)) {
@@ -84,6 +84,11 @@ static void decode_irq_flags(struct pnp_
 		*polarity = ACPI_ACTIVE_HIGH;
 		break;
 	}
+
+	if (flags & IORESOURCE_IRQ_SHAREABLE)
+		*shareable = ACPI_SHARED;
+	else
+		*shareable = ACPI_EXCLUSIVE;
 }
 
 static void pnpacpi_parse_allocated_irqresource(struct pnp_dev *dev,
@@ -796,15 +801,12 @@ static void pnpacpi_encode_irq(struct pn
 			       struct resource *p)
 {
 	struct acpi_resource_irq *irq = &resource->data.irq;
-	int triggering, polarity;
+	int triggering, polarity, shareable;
 
-	decode_irq_flags(dev, p->flags, &triggering, &polarity);
+	decode_irq_flags(dev, p->flags, &triggering, &polarity, &shareable);
 	irq->triggering = triggering;
 	irq->polarity = polarity;
-	if (triggering == ACPI_EDGE_SENSITIVE)
-		irq->sharable = ACPI_EXCLUSIVE;
-	else
-		irq->sharable = ACPI_SHARED;
+	irq->sharable = shareable;
 	irq->interrupt_count = 1;
 	irq->interrupts[0] = p->start;
 
@@ -819,16 +821,13 @@ static void pnpacpi_encode_ext_irq(struc
 				   struct resource *p)
 {
 	struct acpi_resource_extended_irq *extended_irq = &resource->data.extended_irq;
-	int triggering, polarity;
+	int triggering, polarity, shareable;
 
-	decode_irq_flags(dev, p->flags, &triggering, &polarity);
+	decode_irq_flags(dev, p->flags, &triggering, &polarity, &shareable);
 	extended_irq->producer_consumer = ACPI_CONSUMER;
 	extended_irq->triggering = triggering;
 	extended_irq->polarity = polarity;
-	if (triggering == ACPI_EDGE_SENSITIVE)
-		extended_irq->sharable = ACPI_EXCLUSIVE;
-	else
-		extended_irq->sharable = ACPI_SHARED;
+	extended_irq->sharable = shareable;
 	extended_irq->interrupt_count = 1;
 	extended_irq->interrupts[0] = p->start;
 
_
