From: Len Brown <lenb@kernel.org>
Subject: [PATCH 45/94] ACPI: PCI: add a helper to convert _PRT INTx pin number
 to name
Date: Fri, 09 Jan 2009 04:26:47 -0500
Message-ID: <cf68b80b0e0cbc6a0d7bbb36b07ce94779ef5f1f.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857AbZAIJ2a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:30 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700EKH6AYP603@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:11 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This adds a helper function to convert INTx pin numbers from the _PRT
(0, 1, 2, 3) to the pin name ('A', 'B', 'C', 'D').

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index ea003ba..5ce1fcf 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -60,6 +60,11 @@ struct acpi_prt_list {
 static struct acpi_prt_list acpi_prt;
 static DEFINE_SPINLOCK(acpi_prt_lock);
 
+static inline char pin_name(int pin)
+{
+	return 'A' + pin;
+}
+
 /* --------------------------------------------------------------------------
                          PCI IRQ Routing Table (PRT) Support
    -------------------------------------------------------------------------- */
@@ -174,14 +179,14 @@ do_prt_fixups(struct acpi_prt_entry *entry, struct acpi_pci_routing_table *prt)
 		    entry->id.segment == quirk->segment &&
 		    entry->id.bus == quirk->bus &&
 		    entry->id.device == quirk->device &&
-		    entry->pin + 'A' == quirk->pin &&
+		    pin_name(entry->pin) == quirk->pin &&
 		    !strcmp(prt->source, quirk->source) &&
 		    strlen(prt->source) >= strlen(quirk->actual_source)) {
 			printk(KERN_WARNING PREFIX "firmware reports "
 				"%04x:%02x:%02x PCI INT %c connected to %s; "
 				"changing to %s\n",
 				entry->id.segment, entry->id.bus,
-				entry->id.device, 'A' + entry->pin,
+				entry->id.device, pin_name(entry->pin),
 				prt->source, quirk->actual_source);
 			strcpy(prt->source, quirk->actual_source);
 		}
@@ -235,8 +240,8 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INFO,
 			      "      %04x:%02x:%02x[%c] -> %s[%d]\n",
 			      entry->id.segment, entry->id.bus,
-			      entry->id.device, ('A' + entry->pin), prt->source,
-			      entry->link.index));
+			      entry->id.device, pin_name(entry->pin),
+			      prt->source, entry->link.index));
 
 	spin_lock(&acpi_prt_lock);
 	list_add_tail(&entry->node, &acpi_prt.entries);
@@ -387,7 +392,7 @@ acpi_pci_irq_lookup(struct pci_bus *bus,
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Searching for _PRT entry for %04x:%02x:%02x[%c]\n",
-			  segment, bus_nr, device, ('A' + pin)));
+			  segment, bus_nr, device, pin_name(pin)));
 
 	entry = acpi_pci_irq_find_prt_entry(segment, bus_nr, device, pin);
 	if (!entry) {
@@ -444,7 +449,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 
 	if (irq < 0) {
 		dev_warn(&dev->dev, "can't derive routing for PCI INT %c\n",
-			 'A' + orig_pin);
+			 pin_name(orig_pin));
 		return -1;
 	}
 
@@ -511,7 +516,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * driver reported one, then use it. Exit in any case.
 	 */
 	if (gsi < 0) {
-		dev_warn(&dev->dev, "PCI INT %c: no GSI", 'A' + pin);
+		dev_warn(&dev->dev, "PCI INT %c: no GSI", pin_name(pin));
 		/* Interrupt Line values above 0xF are forbidden */
 		if (dev->irq > 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
@@ -527,7 +532,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	rc = acpi_register_gsi(gsi, triggering, polarity);
 	if (rc < 0) {
 		dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
-			 'A' + pin);
+			 pin_name(pin));
 		return rc;
 	}
 	dev->irq = rc;
@@ -538,7 +543,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		link_desc[0] = '\0';
 
 	dev_info(&dev->dev, "PCI INT %c%s -> GSI %u (%s, %s) -> IRQ %d\n",
-		 'A' + pin, link_desc, gsi,
+		 pin_name(pin), link_desc, gsi,
 		 (triggering == ACPI_LEVEL_SENSITIVE) ? "level" : "edge",
 		 (polarity == ACPI_ACTIVE_LOW) ? "low" : "high", dev->irq);
 
@@ -585,6 +590,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	 * (e.g. PCI_UNDEFINED_IRQ).
 	 */
 
-	dev_info(&dev->dev, "PCI INT %c disabled\n", 'A' + pin);
+	dev_info(&dev->dev, "PCI INT %c disabled\n", pin_name(pin));
 	acpi_unregister_gsi(gsi);
 }
-- 
1.5.6.6

