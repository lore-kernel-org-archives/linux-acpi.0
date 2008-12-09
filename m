From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 05/20] ACPI: PCI: fix GSI/IRQ naming confusion
Date: Mon, 08 Dec 2008 21:30:26 -0700
Message-ID: <20081209043025.26415.36906.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:14443 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbYLIEa1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:30:27 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

The interrupt numbers from _PRT entries are GSIs, not Linux IRQs.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 579bf17..f80b8a2 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -335,7 +335,7 @@ acpi_pci_allocate_irq(struct acpi_prt_entry *entry,
 		*polarity = ACPI_ACTIVE_LOW;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found IRQ %d\n", irq));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found GSI %d\n", irq));
 	return irq;
 }
 
@@ -434,7 +434,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 		return -1;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derive IRQ %d for device %s from %s\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derive GSI %d for device %s from %s\n",
 			  irq, pci_name(dev), pci_name(bridge)));
 
 	return irq;
@@ -448,7 +448,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 
 int acpi_pci_irq_enable(struct pci_dev *dev)
 {
-	int irq = 0;
+	int gsi = 0;
 	u8 pin = 0;
 	int triggering = ACPI_LEVEL_SENSITIVE;
 	int polarity = ACPI_ACTIVE_LOW;
@@ -470,7 +470,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
 	 * values override any BIOS-assigned IRQs set during boot.
 	 */
-	irq = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
+	gsi = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
 				  &triggering, &polarity, &link,
 				  acpi_pci_allocate_irq);
 
@@ -478,12 +478,12 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
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
@@ -496,7 +496,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
 	 * driver reported one, then use it. Exit in any case.
 	 */
-	if (irq < 0) {
+	if (gsi < 0) {
 		dev_warn(&dev->dev, "PCI INT %c: no GSI", 'A' + pin);
 		/* Interrupt Line values above 0xF are forbidden */
 		if (dev->irq > 0 && (dev->irq <= 0xF)) {
@@ -510,7 +510,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		}
 	}
 
-	rc = acpi_register_gsi(irq, triggering, polarity);
+	rc = acpi_register_gsi(gsi, triggering, polarity);
 	if (rc < 0) {
 		dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
 			 'A' + pin);
@@ -524,7 +524,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		link_desc[0] = '\0';
 
 	dev_info(&dev->dev, "PCI INT %c%s -> GSI %u (%s, %s) -> IRQ %d\n",
-		 'A' + pin, link_desc, irq,
+		 'A' + pin, link_desc, gsi,
 		 (triggering == ACPI_LEVEL_SENSITIVE) ? "level" : "edge",
 		 (polarity == ACPI_ACTIVE_LOW) ? "low" : "high", dev->irq);
 

