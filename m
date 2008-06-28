From: Len Brown <lenb@kernel.org>
Subject: [PATCH 84/84] ACPI: use dev_printk when possible
Date: Sat, 28 Jun 2008 01:44:28 -0400
Message-ID: <491b056a4d5f4bd176eab50f75159f7e1aa16c60.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51430 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209AbYF1Fsk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:48:40 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500BOGS4YAK22@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:48:35 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Convert printks to use dev_printk().  The most obvious change will
be messages like this:

   -ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 31 (level, low) -> IRQ 31
   +cciss 0000:00:04.0: PCI INT A -> GSI 31 (level, low) -> IRQ 31

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   38 +++++++++++++++++---------------------
 1 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 89022a7..11acaee 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -162,7 +162,7 @@ do_prt_fixups(struct acpi_prt_entry *entry, struct acpi_pci_routing_table *prt)
 		    !strcmp(prt->source, quirk->source) &&
 		    strlen(prt->source) >= strlen(quirk->actual_source)) {
 			printk(KERN_WARNING PREFIX "firmware reports "
-				"%04x:%02x:%02x[%c] connected to %s; "
+				"%04x:%02x:%02x PCI INT %c connected to %s; "
 				"changing to %s\n",
 				entry->id.segment, entry->id.bus,
 				entry->id.device, 'A' + entry->pin,
@@ -429,7 +429,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 {
 	struct pci_dev *bridge = dev;
 	int irq = -1;
-	u8 bridge_pin = 0;
+	u8 bridge_pin = 0, orig_pin = pin;
 
 
 	if (!dev)
@@ -463,8 +463,8 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 	}
 
 	if (irq < 0) {
-		printk(KERN_WARNING PREFIX "Unable to derive IRQ for device %s\n",
-			      pci_name(dev));
+		dev_warn(&dev->dev, "can't derive routing for PCI INT %c\n",
+			 'A' + orig_pin);
 		return -1;
 	}
 
@@ -487,6 +487,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	int triggering = ACPI_LEVEL_SENSITIVE;
 	int polarity = ACPI_ACTIVE_LOW;
 	char *link = NULL;
+	char link_desc[16];
 	int rc;
 
 
@@ -503,7 +504,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	pin--;
 
 	if (!dev->bus) {
-		printk(KERN_ERR PREFIX "Invalid (NULL) 'bus' field\n");
+		dev_err(&dev->dev, "invalid (NULL) 'bus' field\n");
 		return -ENODEV;
 	}
 
@@ -538,8 +539,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * driver reported one, then use it. Exit in any case.
 	 */
 	if (irq < 0) {
-		printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: no GSI",
-		       pci_name(dev), ('A' + pin));
+		dev_warn(&dev->dev, "PCI INT %c: no GSI", 'A' + pin);
 		/* Interrupt Line values above 0xF are forbidden */
 		if (dev->irq > 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
@@ -554,21 +554,21 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 
 	rc = acpi_register_gsi(irq, triggering, polarity);
 	if (rc < 0) {
-		printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: failed "
-		       "to register GSI\n", pci_name(dev), ('A' + pin));
+		dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
+			 'A' + pin);
 		return rc;
 	}
 	dev->irq = rc;
 
-	printk(KERN_INFO PREFIX "PCI Interrupt %s[%c] -> ",
-	       pci_name(dev), 'A' + pin);
-
 	if (link)
-		printk("Link [%s] -> ", link);
+		snprintf(link_desc, sizeof(link_desc), " -> Link[%s]", link);
+	else
+		link_desc[0] = '\0';
 
-	printk("GSI %u (%s, %s) -> IRQ %d\n", irq,
-	       (triggering == ACPI_LEVEL_SENSITIVE) ? "level" : "edge",
-	       (polarity == ACPI_ACTIVE_LOW) ? "low" : "high", dev->irq);
+	dev_info(&dev->dev, "PCI INT %c%s -> GSI %u (%s, %s) -> IRQ %d\n",
+		 'A' + pin, link_desc, irq,
+		 (triggering == ACPI_LEVEL_SENSITIVE) ? "level" : "edge",
+		 (polarity == ACPI_ACTIVE_LOW) ? "low" : "high", dev->irq);
 
 	return 0;
 }
@@ -616,10 +616,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	 * (e.g. PCI_UNDEFINED_IRQ).
 	 */
 
-	printk(KERN_INFO PREFIX "PCI interrupt for device %s disabled\n",
-	       pci_name(dev));
-
+	dev_info(&dev->dev, "PCI INT %c disabled\n", 'A' + pin);
 	acpi_unregister_gsi(gsi);
-
-	return;
 }
-- 
1.5.6.1.89.gd544

