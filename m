From: Len Brown <lenb@kernel.org>
Subject: [PATCH 62/84] PNPACPI: keep disabled resources when parsing current
 config
Date: Sat, 28 Jun 2008 01:44:06 -0400
Message-ID: <c777a48411a60e6ed37e9b067d7bdbc2a4a3b4a2.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:50822 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbYF1Fpx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:53 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500HACS0GX414@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:53 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
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
1.5.6.1.89.gd544

