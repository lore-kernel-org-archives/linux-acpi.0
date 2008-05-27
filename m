From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 2/2] PNPACPI: fix shareable IRQ encode/decode
Date: Tue, 27 May 2008 16:49:17 -0600
Message-ID: <20080527224938.681457358@ldl.fc.hp.com>
References: <20080527224915.412211349@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:8873 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757418AbYE0Wtf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 May 2008 18:49:35 -0400
Content-Disposition: inline; filename=pnpacpi-encode-irq
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Andrew Morton <akpm@linux-foundation.org>, Tom Jaeger <ThJaeger@gmail.com>

When we encode IRQ resources, we should use the "shareable"
flag we got from _PRS rather than guessing based on the
IRQ trigger mode.

This is based on a patch by Tom Jaeger <ThJaeger@gmail.com>:
    http://bugzilla.kernel.org/show_bug.cgi?id=9487#c32

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work11/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work11.orig/drivers/pnp/pnpacpi/rsparser.c	2008-05-27 15:53:21.000000000 -0600
+++ work11/drivers/pnp/pnpacpi/rsparser.c	2008-05-27 15:58:29.000000000 -0600
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
@@ -799,15 +804,12 @@ static void pnpacpi_encode_irq(struct pn
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
 
@@ -824,16 +826,13 @@ static void pnpacpi_encode_ext_irq(struc
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
 

-- 
