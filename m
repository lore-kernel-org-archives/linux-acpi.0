From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 1/2] PNPACPI: fix IRQ flag decoding
Date: Tue, 27 May 2008 16:49:16 -0600
Message-ID: <20080527224938.356177274@ldl.fc.hp.com>
References: <20080527224915.412211349@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:13549 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397AbYE0Wtg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 May 2008 18:49:36 -0400
Content-Disposition: inline; filename=pnpacpi-fix-decode-irq
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Andrew Morton <akpm@linux-foundation.org>, Tom Jaeger <ThJaeger@gmail.com>

When decoding IRQ trigger mode and polarity, it is not enough
to mask by IORESOURCE_BITS because there are now additional
bits defined.  For example, if IORESOURCE_IRQ_SHAREABLE
was set, we failed to set *triggering and *polarity at all.

I can't point to a failure that this patch fixes, but
bugs in this area have caused problems when resuming after
suspend, for example:
    http://bugzilla.kernel.org/show_bug.cgi?id=6316
    http://bugzilla.kernel.org/show_bug.cgi?id=9487
    https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.22/+bug/152187

This is based on a patch by Tom Jaeger <ThJaeger@gmail.com>:
    http://bugzilla.kernel.org/show_bug.cgi?id=9487#c32

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work11/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work11.orig/drivers/pnp/pnpacpi/rsparser.c	2008-05-27 15:50:04.000000000 -0600
+++ work11/drivers/pnp/pnpacpi/rsparser.c	2008-05-27 15:53:21.000000000 -0600
@@ -56,9 +56,11 @@ static int irq_flags(int triggering, int
 	return flags;
 }
 
-static void decode_irq_flags(int flag, int *triggering, int *polarity)
+static void decode_irq_flags(struct pnp_dev *dev, int flags, int *triggering,
+			     int *polarity)
 {
-	switch (flag) {
+	switch (flags & (IORESOURCE_IRQ_LOWLEVEL | IORESOURCE_IRQ_HIGHLEVEL |
+			 IORESOURCE_IRQ_LOWEDGE  | IORESOURCE_IRQ_HIGHEDGE)) {
 	case IORESOURCE_IRQ_LOWLEVEL:
 		*triggering = ACPI_LEVEL_SENSITIVE;
 		*polarity = ACPI_ACTIVE_LOW;
@@ -75,6 +77,12 @@ static void decode_irq_flags(int flag, i
 		*triggering = ACPI_EDGE_SENSITIVE;
 		*polarity = ACPI_ACTIVE_HIGH;
 		break;
+	default:
+		dev_err(&dev->dev, "can't encode invalid IRQ mode %#x\n",
+			flags);
+		*triggering = ACPI_EDGE_SENSITIVE;
+		*polarity = ACPI_ACTIVE_HIGH;
+		break;
 	}
 }
 
@@ -793,7 +801,7 @@ static void pnpacpi_encode_irq(struct pn
 	struct acpi_resource_irq *irq = &resource->data.irq;
 	int triggering, polarity;
 
-	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering, &polarity);
+	decode_irq_flags(dev, p->flags, &triggering, &polarity);
 	irq->triggering = triggering;
 	irq->polarity = polarity;
 	if (triggering == ACPI_EDGE_SENSITIVE)
@@ -818,7 +826,7 @@ static void pnpacpi_encode_ext_irq(struc
 	struct acpi_resource_extended_irq *extended_irq = &resource->data.extended_irq;
 	int triggering, polarity;
 
-	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering, &polarity);
+	decode_irq_flags(dev, p->flags, &triggering, &polarity);
 	extended_irq->producer_consumer = ACPI_CONSUMER;
 	extended_irq->triggering = triggering;
 	extended_irq->polarity = polarity;

-- 
