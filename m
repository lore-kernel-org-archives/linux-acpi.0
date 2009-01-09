From: Len Brown <lenb@kernel.org>
Subject: [PATCH 43/94] ACPI: PCI: fix GSI/IRQ naming confusion
Date: Fri, 09 Jan 2009 04:26:45 -0500
Message-ID: <c13f889a24e6ced50abb582dab3ee4b7c79b038e.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40934 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbZAIJ2g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:36 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD7007Q26AX27RA@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:10 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

The interrupt numbers from _PRT entries are GSIs, not Linux IRQs.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index c6a0364..9302f4b 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -333,7 +333,7 @@ acpi_pci_allocate_irq(struct acpi_prt_entry *entry,
 		*polarity = ACPI_ACTIVE_LOW;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found IRQ %d\n", irq));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found GSI %d\n", irq));
 	return irq;
 }
 
@@ -432,7 +432,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 		return -1;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derive IRQ %d for device %s from %s\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derive GSI %d for device %s from %s\n",
 			  irq, pci_name(dev), pci_name(bridge)));
 
 	return irq;
@@ -446,7 +446,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 
 int acpi_pci_irq_enable(struct pci_dev *dev)
 {
-	int irq = 0;
+	int gsi = 0;
 	u8 pin = 0;
 	int triggering = ACPI_LEVEL_SENSITIVE;
 	int polarity = ACPI_ACTIVE_LOW;
@@ -468,7 +468,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
 	 * values override any BIOS-assigned IRQs set during boot.
 	 */
-	irq = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
+	gsi = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
 				  &triggering, &polarity, &link,
 				  acpi_pci_allocate_irq);
 
@@ -476,12 +476,12 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
 	 * device's parent bridge.
 	 */
-	if (irq < 0)
-		irq = acpi_pci_irq_derive(dev, pin, &triggering,
+	if (gsi < 0)
+		gsi = acpi_pci_irq_derive(dev, pin, &triggering,
 					  &polarity, &link,
 					  acpi_pci_allocate_irq);
 
-	if (irq < 0) {
+	if (gsi < 0) {
 		/*
 		 * IDE legacy mode controller IRQs are magic. Why do compat
 		 * extensions always make such a nasty mess.
@@ -494,7 +494,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
 	 * driver reported one, then use it. Exit in any case.
 	 */
-	if (irq < 0) {
+	if (gsi < 0) {
 		dev_warn(&dev->dev, "PCI INT %c: no GSI", 'A' + pin);
 		/* Interrupt Line values above 0xF are forbidden */
 		if (dev->irq > 0 && (dev->irq <= 0xF)) {
@@ -508,7 +508,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		}
 	}
 
-	rc = acpi_register_gsi(irq, triggering, polarity);
+	rc = acpi_register_gsi(gsi, triggering, polarity);
 	if (rc < 0) {
 		dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
 			 'A' + pin);
@@ -522,7 +522,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		link_desc[0] = '\0';
 
 	dev_info(&dev->dev, "PCI INT %c%s -> GSI %u (%s, %s) -> IRQ %d\n",
-		 'A' + pin, link_desc, irq,
+		 'A' + pin, link_desc, gsi,
 		 (triggering == ACPI_LEVEL_SENSITIVE) ? "level" : "edge",
 		 (polarity == ACPI_ACTIVE_LOW) ? "low" : "high", dev->irq);
 
-- 
1.5.6.6

