From: Len Brown <lenb@kernel.org>
Subject: [PATCH 48/94] ACPI: PCI: lookup _PRT entry by PCI dev and pin,
 not segment/bus/dev/pin
Date: Fri, 09 Jan 2009 04:26:50 -0500
Message-ID: <063563b4b8f87e2be0e127ccf3a8e6eef6309ff4.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:62823 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbZAIJ2U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:20 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD7005LS6B0CYA4@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:13 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

There's no reason to pass around segment, bus, and device independently
when we can just pass the pci_dev pointer, which carries all those
already.

The pci_dev contains an interrupt pin, too, but we still have to pass both
the pci_dev and the pin because when we use a bridge to derive an IRQ, we
need the pin from the downstream device, not the bridge.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   27 ++++++++++++---------------
 1 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index c4a5c49..aabf8a9 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -69,11 +69,13 @@ static inline char pin_name(int pin)
                          PCI IRQ Routing Table (PRT) Support
    -------------------------------------------------------------------------- */
 
-static struct acpi_prt_entry *acpi_pci_irq_find_prt_entry(int segment,
-							  int bus,
-							  int device, int pin)
+static struct acpi_prt_entry *acpi_pci_irq_find_prt_entry(struct pci_dev *dev,
+							  int pin)
 {
 	struct acpi_prt_entry *entry = NULL;
+	int segment = pci_domain_nr(dev->bus);
+	int bus = dev->bus->number;
+	int device = PCI_SLOT(dev->devfn);
 
 	if (!acpi_prt.count)
 		return NULL;
@@ -385,23 +387,18 @@ acpi_pci_free_irq(struct acpi_prt_entry *entry,
  * failure: return -1
  */
 static int
-acpi_pci_irq_lookup(struct pci_bus *bus,
-		    int device,
-		    int pin,
+acpi_pci_irq_lookup(struct pci_dev *dev, int pin,
 		    int *triggering,
 		    int *polarity, char **link, irq_lookup_func func)
 {
 	struct acpi_prt_entry *entry = NULL;
-	int segment = pci_domain_nr(bus);
-	int bus_nr = bus->number;
 	int ret;
 
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Searching for _PRT entry for %04x:%02x:%02x[%c]\n",
-			  segment, bus_nr, device, pin_name(pin)));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Searching for _PRT entry for %s[%c]\n",
+			  pci_name(dev), pin_name(pin)));
 
-	entry = acpi_pci_irq_find_prt_entry(segment, bus_nr, device, pin);
+	entry = acpi_pci_irq_find_prt_entry(dev, pin);
 	if (!entry) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_PRT entry not found\n"));
 		return -1;
@@ -447,7 +444,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 			pin = bridge_pin;
 		}
 
-		irq = acpi_pci_irq_lookup(bridge->bus, PCI_SLOT(bridge->devfn),
+		irq = acpi_pci_irq_lookup(bridge,
 					  pin, triggering, polarity,
 					  link, func);
 	}
@@ -493,7 +490,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
 	 * values override any BIOS-assigned IRQs set during boot.
 	 */
-	gsi = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
+	gsi = acpi_pci_irq_lookup(dev, pin,
 				  &triggering, &polarity, &link,
 				  acpi_pci_allocate_irq);
 
@@ -574,7 +571,7 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	/*
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.
 	 */
-	gsi = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
+	gsi = acpi_pci_irq_lookup(dev, pin,
 				  &triggering, &polarity, NULL,
 				  acpi_pci_free_irq);
 	/*
-- 
1.5.6.6

