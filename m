From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/23] pnpacpi: fix IRQ flag decoding
Date: Wed, 11 Jun 2008 03:59:12 -0400
Message-ID: <88b568622e7a862519ef306c11500a0b7696f6e0.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:65151 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbYFKH7j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:39 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2A00DTOGV8Y9R4@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:33 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

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
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c |   16 ++++++++++++----
 include/linux/ioport.h         |    6 +++---
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 0201c8a..ab09fe6 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -56,9 +56,11 @@ static int irq_flags(int triggering, int polarity, int shareable)
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
@@ -75,6 +77,12 @@ static void decode_irq_flags(int flag, int *triggering, int *polarity)
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
 
@@ -790,7 +798,7 @@ static void pnpacpi_encode_irq(struct pnp_dev *dev,
 	struct acpi_resource_irq *irq = &resource->data.irq;
 	int triggering, polarity;
 
-	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering, &polarity);
+	decode_irq_flags(dev, p->flags, &triggering, &polarity);
 	irq->triggering = triggering;
 	irq->polarity = polarity;
 	if (triggering == ACPI_EDGE_SENSITIVE)
@@ -813,7 +821,7 @@ static void pnpacpi_encode_ext_irq(struct pnp_dev *dev,
 	struct acpi_resource_extended_irq *extended_irq = &resource->data.extended_irq;
 	int triggering, polarity;
 
-	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering, &polarity);
+	decode_irq_flags(dev, p->flags, &triggering, &polarity);
 	extended_irq->producer_consumer = ACPI_CONSUMER;
 	extended_irq->triggering = triggering;
 	extended_irq->polarity = polarity;
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index d5d40a9..c6801bf 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
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
-- 
1.5.6.rc2.23.gea81e

