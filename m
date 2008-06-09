From: akpm@linux-foundation.org
Subject: [patch (for 2.6.26?) 1/3] pnpacpi: fix IRQ flag decoding
Date: Mon, 09 Jun 2008 16:52:04 -0700
Message-ID: <200806092352.m59Nq46D015765@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36814 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754298AbYFIXx0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 19:53:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, bjorn.helgaas@hp.com, ThJaeger@gmail.com

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

When decoding IRQ trigger mode and polarity, it is not enough to mask by
IORESOURCE_BITS because there are now additional bits defined.  For
example, if IORESOURCE_IRQ_SHAREABLE was set, we failed to set *triggering
and *polarity at all.

I can't point to a failure that this patch fixes, but
bugs in this area have caused problems when resuming after
suspend, for example:

    http://bugzilla.kernel.org/show_bug.cgi?id=6316
    http://bugzilla.kernel.org/show_bug.cgi?id=9487
    https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.22/+bug/152187

This is based on a patch by Tom Jaeger:
    http://bugzilla.kernel.org/show_bug.cgi?id=9487#c32

[rene.herman@keyaccess.nl: fix comment]
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Tom Jaeger <ThJaeger@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/pnp/pnpacpi/rsparser.c |   16 ++++++++++++----
 include/linux/ioport.h         |    6 +++---
 2 files changed, 15 insertions(+), 7 deletions(-)

diff -puN drivers/pnp/pnpacpi/rsparser.c~pnpacpi-fix-irq-flag-decoding drivers/pnp/pnpacpi/rsparser.c
--- a/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-fix-irq-flag-decoding
+++ a/drivers/pnp/pnpacpi/rsparser.c
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
 
@@ -790,7 +798,7 @@ static void pnpacpi_encode_irq(struct pn
 	struct acpi_resource_irq *irq = &resource->data.irq;
 	int triggering, polarity;
 
-	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering, &polarity);
+	decode_irq_flags(dev, p->flags, &triggering, &polarity);
 	irq->triggering = triggering;
 	irq->polarity = polarity;
 	if (triggering == ACPI_EDGE_SENSITIVE)
@@ -813,7 +821,7 @@ static void pnpacpi_encode_ext_irq(struc
 	struct acpi_resource_extended_irq *extended_irq = &resource->data.extended_irq;
 	int triggering, polarity;
 
-	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering, &polarity);
+	decode_irq_flags(dev, p->flags, &triggering, &polarity);
 	extended_irq->producer_consumer = ACPI_CONSUMER;
 	extended_irq->triggering = triggering;
 	extended_irq->polarity = polarity;
diff -puN include/linux/ioport.h~pnpacpi-fix-irq-flag-decoding include/linux/ioport.h
--- a/include/linux/ioport.h~pnpacpi-fix-irq-flag-decoding
+++ a/include/linux/ioport.h
@@ -53,14 +53,14 @@ struct resource_list {
 #define IORESOURCE_AUTO		0x40000000
 #define IORESOURCE_BUSY		0x80000000	/* Driver has marked this resource busy */
 
-/* ISA PnP IRQ specific bits (IORESOURCE_BITS) */
+/* PnP IRQ specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_IRQ_HIGHEDGE		(1<<0)
 #define IORESOURCE_IRQ_LOWEDGE		(1<<1)
 #define IORESOURCE_IRQ_HIGHLEVEL	(1<<2)
 #define IORESOURCE_IRQ_LOWLEVEL		(1<<3)
 #define IORESOURCE_IRQ_SHAREABLE	(1<<4)
 
-/* ISA PnP DMA specific bits (IORESOURCE_BITS) */
+/* PnP DMA specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_DMA_TYPE_MASK	(3<<0)
 #define IORESOURCE_DMA_8BIT		(0<<0)
 #define IORESOURCE_DMA_8AND16BIT	(1<<0)
@@ -76,7 +76,7 @@ struct resource_list {
 #define IORESOURCE_DMA_TYPEB		(2<<6)
 #define IORESOURCE_DMA_TYPEF		(3<<6)
 
-/* ISA PnP memory I/O specific bits (IORESOURCE_BITS) */
+/* PnP memory I/O specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_MEM_WRITEABLE	(1<<0)	/* dup: IORESOURCE_READONLY */
 #define IORESOURCE_MEM_CACHEABLE	(1<<1)	/* dup: IORESOURCE_CACHEABLE */
 #define IORESOURCE_MEM_RANGELENGTH	(1<<2)	/* dup: IORESOURCE_RANGELENGTH */
_
