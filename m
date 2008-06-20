From: Len Brown <lenb@kernel.org>
Subject: [PATCH 45/70] PNPACPI: keep disabled resources when parsing current
 config
Date: Fri, 20 Jun 2008 03:43:47 -0400
Message-ID: <10f4919d40a4d7d0b061b4c55ba26645acf52378.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:35177 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbYFTHon (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:43 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R003NI46I7I83@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:43 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

When we parse a device's _CRS data (the current resource settings),
we should keep track of everything we find, even if it's currently
disabled or invalid.

This is what we already do for ISAPNP and PNPBIOS, and it helps
keep things matched up when we subsequently re-encode resources.
For example, consider a device with (mem, irq0, irq1, io), where
irq0 is disabled.  If we drop irq0 when parsing the _CRS, we will
mistakenly put irq1 in the irq0 slot when we encode resources
for an _SRS call.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c |   70 +++++++++++++++++++++++++++++----------
 1 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 9a45c25..595252b 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -98,8 +98,10 @@ static void pnpacpi_parse_allocated_irqresource(struct pnp_dev *dev,
 	int irq, flags;
 	int p, t;
 
-	if (!valid_IRQ(gsi))
+	if (!valid_IRQ(gsi)) {
+		pnp_add_irq_resource(dev, gsi, IORESOURCE_DISABLED);
 		return;
+	}
 
 	/*
 	 * in IO-APIC mode, use overrided attribute. Two reasons:
@@ -248,24 +250,39 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 		 * _CRS, but some firmware violates this, so parse them all.
 		 */
 		irq = &res->data.irq;
-		for (i = 0; i < irq->interrupt_count; i++) {
-			pnpacpi_parse_allocated_irqresource(dev,
-				irq->interrupts[i],
-				irq->triggering,
-				irq->polarity,
-				irq->sharable);
+		if (irq->interrupt_count == 0)
+			pnp_add_irq_resource(dev, 0, IORESOURCE_DISABLED);
+		else {
+			for (i = 0; i < irq->interrupt_count; i++) {
+				pnpacpi_parse_allocated_irqresource(dev,
+					irq->interrupts[i],
+					irq->triggering,
+					irq->polarity,
+				    irq->sharable);
+			}
+
+			/*
+			 * The IRQ encoder puts a single interrupt in each
+			 * descriptor, so if a _CRS descriptor has more than
+			 * one interrupt, we won't be able to re-encode it.
+			 */
+			if (pnp_can_write(dev) && irq->interrupt_count > 1) {
+				dev_warn(&dev->dev, "multiple interrupts in "
+					 "_CRS descriptor; configuration can't "
+					 "be changed\n");
+				dev->capabilities &= ~PNP_WRITE;
+			}
 		}
 		break;
 
 	case ACPI_RESOURCE_TYPE_DMA:
 		dma = &res->data.dma;
-		if (dma->channel_count > 0) {
+		if (dma->channel_count > 0 && dma->channels[0] != (u8) -1)
 			flags = dma_flags(dma->type, dma->bus_master,
 					  dma->transfer);
-			if (dma->channels[0] == (u8) -1)
-				flags |= IORESOURCE_DISABLED;
-			pnp_add_dma_resource(dev, dma->channels[0], flags);
-		}
+		else
+			flags = IORESOURCE_DISABLED;
+		pnp_add_dma_resource(dev, dma->channels[0], flags);
 		break;
 
 	case ACPI_RESOURCE_TYPE_IO:
@@ -331,12 +348,29 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 		if (extended_irq->producer_consumer == ACPI_PRODUCER)
 			return AE_OK;
 
-		for (i = 0; i < extended_irq->interrupt_count; i++) {
-			pnpacpi_parse_allocated_irqresource(dev,
-				extended_irq->interrupts[i],
-				extended_irq->triggering,
-				extended_irq->polarity,
-				extended_irq->sharable);
+		if (extended_irq->interrupt_count == 0)
+			pnp_add_irq_resource(dev, 0, IORESOURCE_DISABLED);
+		else {
+			for (i = 0; i < extended_irq->interrupt_count; i++) {
+				pnpacpi_parse_allocated_irqresource(dev,
+					extended_irq->interrupts[i],
+					extended_irq->triggering,
+					extended_irq->polarity,
+					extended_irq->sharable);
+			}
+
+			/*
+			 * The IRQ encoder puts a single interrupt in each
+			 * descriptor, so if a _CRS descriptor has more than
+			 * one interrupt, we won't be able to re-encode it.
+			 */
+			if (pnp_can_write(dev) &&
+			    extended_irq->interrupt_count > 1) {
+				dev_warn(&dev->dev, "multiple interrupts in "
+					 "_CRS descriptor; configuration can't "
+					 "be changed\n");
+				dev->capabilities &= ~PNP_WRITE;
+			}
 		}
 		break;
 
-- 
1.5.6

