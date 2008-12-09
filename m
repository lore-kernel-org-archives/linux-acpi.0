From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 10/20] ACPI: PCI: lookup _PRT entry by PCI dev and pin,
	not segment/bus/dev/pin
Date: Mon, 08 Dec 2008 21:30:51 -0700
Message-ID: <20081209043051.26415.44981.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:11190 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbYLIEaw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:30:52 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

There's no reason to pass around segment, bus, and device independently
when we can just pass the pci_dev pointer, which carries all those
already.

The pci_dev contains an interrupt pin, too, but we still have to pass both
the pci_dev and the pin because when we use a bridge to derive an IRQ, we
need the pin from the downstream device, not the bridge.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   27 ++++++++++++---------------
 1 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index eea15fd..6f4c5f3 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -71,11 +71,13 @@ static inline char pin_name(int pin)
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
@@ -387,23 +389,18 @@ acpi_pci_free_irq(struct acpi_prt_entry *entry,
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
@@ -449,7 +446,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 			pin = bridge_pin;
 		}
 
-		irq = acpi_pci_irq_lookup(bridge->bus, PCI_SLOT(bridge->devfn),
+		irq = acpi_pci_irq_lookup(bridge,
 					  pin, triggering, polarity,
 					  link, func);
 	}
@@ -495,7 +492,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
 	 * values override any BIOS-assigned IRQs set during boot.
 	 */
-	gsi = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
+	gsi = acpi_pci_irq_lookup(dev, pin,
 				  &triggering, &polarity, &link,
 				  acpi_pci_allocate_irq);
 
@@ -576,7 +573,7 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	/*
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.
 	 */
-	gsi = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
+	gsi = acpi_pci_irq_lookup(dev, pin,
 				  &triggering, &polarity, NULL,
 				  acpi_pci_free_irq);
 	/*

