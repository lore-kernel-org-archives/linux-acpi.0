From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 07/20] ACPI: PCI: add a helper to convert _PRT INTx pin number
	to name
Date: Mon, 08 Dec 2008 21:30:36 -0700
Message-ID: <20081209043036.26415.23011.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:13912 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbYLIEag (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:30:36 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This adds a helper function to convert INTx pin numbers from the _PRT
(0, 1, 2, 3) to the pin name ('A', 'B', 'C', 'D').

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 04b9df4..ccbb163 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -62,6 +62,11 @@ struct acpi_prt_list {
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
@@ -176,14 +181,14 @@ do_prt_fixups(struct acpi_prt_entry *entry, struct acpi_pci_routing_table *prt)
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
@@ -237,8 +242,8 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INFO,
 			      "      %04x:%02x:%02x[%c] -> %s[%d]\n",
 			      entry->id.segment, entry->id.bus,
-			      entry->id.device, ('A' + entry->pin), prt->source,
-			      entry->link.index));
+			      entry->id.device, pin_name(entry->pin),
+			      prt->source, entry->link.index));
 
 	spin_lock(&acpi_prt_lock);
 	list_add_tail(&entry->node, &acpi_prt.entries);
@@ -389,7 +394,7 @@ acpi_pci_irq_lookup(struct pci_bus *bus,
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Searching for _PRT entry for %04x:%02x:%02x[%c]\n",
-			  segment, bus_nr, device, ('A' + pin)));
+			  segment, bus_nr, device, pin_name(pin)));
 
 	entry = acpi_pci_irq_find_prt_entry(segment, bus_nr, device, pin);
 	if (!entry) {
@@ -446,7 +451,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 
 	if (irq < 0) {
 		dev_warn(&dev->dev, "can't derive routing for PCI INT %c\n",
-			 'A' + orig_pin);
+			 pin_name(orig_pin));
 		return -1;
 	}
 
@@ -513,7 +518,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * driver reported one, then use it. Exit in any case.
 	 */
 	if (gsi < 0) {
-		dev_warn(&dev->dev, "PCI INT %c: no GSI", 'A' + pin);
+		dev_warn(&dev->dev, "PCI INT %c: no GSI", pin_name(pin));
 		/* Interrupt Line values above 0xF are forbidden */
 		if (dev->irq > 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
@@ -529,7 +534,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	rc = acpi_register_gsi(gsi, triggering, polarity);
 	if (rc < 0) {
 		dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
-			 'A' + pin);
+			 pin_name(pin));
 		return rc;
 	}
 	dev->irq = rc;
@@ -540,7 +545,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		link_desc[0] = '\0';
 
 	dev_info(&dev->dev, "PCI INT %c%s -> GSI %u (%s, %s) -> IRQ %d\n",
-		 'A' + pin, link_desc, gsi,
+		 pin_name(pin), link_desc, gsi,
 		 (triggering == ACPI_LEVEL_SENSITIVE) ? "level" : "edge",
 		 (polarity == ACPI_ACTIVE_LOW) ? "low" : "high", dev->irq);
 
@@ -587,6 +592,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	 * (e.g. PCI_UNDEFINED_IRQ).
 	 */
 
-	dev_info(&dev->dev, "PCI INT %c disabled\n", 'A' + pin);
+	dev_info(&dev->dev, "PCI INT %c disabled\n", pin_name(pin));
 	acpi_unregister_gsi(gsi);
 }

