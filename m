From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 12/20] ACPI: PCI: remove callback from acpi_pci_irq_lookup &
	acpi_pci_irq_derive
Date: Mon, 08 Dec 2008 21:31:01 -0700
Message-ID: <20081209043101.26415.6946.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:39297 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbYLIEbC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:31:02 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

We currently pass a callback function (either acpi_pci_allocate_irq() or
acpi_pci_free_irq()) to acpi_pci_irq_lookup() and acpi_pci_irq_derive().

I think it's simpler to remove the callback and just have the enable/
disable functions make the calls directly.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   93 +++++++++++++++++++-----------------------------
 1 files changed, 36 insertions(+), 57 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index c8246c2..ef65c6d 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -341,8 +341,6 @@ void acpi_pci_irq_del_prt(int segment, int bus)
 /* --------------------------------------------------------------------------
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
-typedef int (*irq_lookup_func) (struct acpi_prt_entry *, int *, int *, char **);
-
 static int
 acpi_pci_allocate_irq(struct acpi_prt_entry *entry,
 		      int *triggering, int *polarity, char **link)
@@ -370,8 +368,7 @@ acpi_pci_allocate_irq(struct acpi_prt_entry *entry,
 }
 
 static int
-acpi_pci_free_irq(struct acpi_prt_entry *entry,
-		  int *triggering, int *polarity, char **link)
+acpi_pci_free_irq(struct acpi_prt_entry *entry)
 {
 	int irq;
 
@@ -383,47 +380,29 @@ acpi_pci_free_irq(struct acpi_prt_entry *entry,
 	return irq;
 }
 
-/*
- * acpi_pci_irq_lookup
- * success: return IRQ >= 0
- * failure: return -1
- */
-static int
-acpi_pci_irq_lookup(struct pci_dev *dev, int pin,
-		    int *triggering,
-		    int *polarity, char **link, irq_lookup_func func)
+static struct acpi_prt_entry *
+acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 {
-	struct acpi_prt_entry *entry = NULL;
-	int ret;
-
+	struct acpi_prt_entry *entry;
 
 	entry = acpi_pci_irq_find_prt_entry(dev, pin);
 	if (!entry) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No %s[%c] _PRT entry\n",
 				  pci_name(dev), pin_name(pin)));
-		return -1;
+		return NULL;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %s[%c] _PRT entry\n",
 			  pci_name(dev), pin_name(pin)));
 
-	ret = func(entry, triggering, polarity, link);
-	return ret;
+	return entry;
 }
 
-/*
- * acpi_pci_irq_derive
- * success: return IRQ >= 0
- * failure: return < 0
- */
-static int
-acpi_pci_irq_derive(struct pci_dev *dev,
-		    int pin,
-		    int *triggering,
-		    int *polarity, char **link, irq_lookup_func func)
+static struct acpi_prt_entry *
+acpi_pci_irq_derive(struct pci_dev *dev, int pin)
 {
+	struct acpi_prt_entry *entry = NULL;
 	struct pci_dev *bridge = dev;
-	int irq = -1;
 	u8 bridge_pin = 0, orig_pin = pin;
 
 
@@ -431,7 +410,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 	 * Attempt to derive an IRQ for this device from a parent bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
 	 */
-	while (irq < 0 && bridge->bus->self) {
+	while (!entry && bridge->bus->self) {
 		pin = (((pin - 1) + PCI_SLOT(bridge->devfn)) % 4) + 1;
 		bridge = bridge->bus->self;
 
@@ -442,26 +421,24 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "No interrupt pin configured for device %s\n",
 						  pci_name(bridge)));
-				return -1;
+				return NULL;
 			}
 			pin = bridge_pin;
 		}
 
-		irq = acpi_pci_irq_lookup(bridge,
-					  pin, triggering, polarity,
-					  link, func);
+		entry = acpi_pci_irq_lookup(bridge, pin);
 	}
 
-	if (irq < 0) {
+	if (!entry) {
 		dev_warn(&dev->dev, "can't derive routing for PCI INT %c\n",
 			 pin_name(orig_pin));
-		return -1;
+		return NULL;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derived GSI %d for %s INT %c from %s\n",
-			  irq, pci_name(dev), pin_name(orig_pin), pci_name(bridge)));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derived GSI for %s INT %c from %s\n",
+			  pci_name(dev), pin_name(orig_pin), pci_name(bridge)));
 
-	return irq;
+	return entry;
 }
 
 /*
@@ -472,6 +449,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 
 int acpi_pci_irq_enable(struct pci_dev *dev)
 {
+	struct acpi_prt_entry *entry;
 	int gsi = 0;
 	u8 pin = 0;
 	int triggering = ACPI_LEVEL_SENSITIVE;
@@ -493,18 +471,20 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
 	 * values override any BIOS-assigned IRQs set during boot.
 	 */
-	gsi = acpi_pci_irq_lookup(dev, pin,
-				  &triggering, &polarity, &link,
-				  acpi_pci_allocate_irq);
+	entry = acpi_pci_irq_lookup(dev, pin);
 
 	/*
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
 	 * device's parent bridge.
 	 */
-	if (gsi < 0)
-		gsi = acpi_pci_irq_derive(dev, pin, &triggering,
-					  &polarity, &link,
-					  acpi_pci_allocate_irq);
+	if (!entry)
+		entry = acpi_pci_irq_derive(dev, pin);
+
+	if (entry)
+		gsi = acpi_pci_allocate_irq(entry, &triggering, &polarity,
+					    &link);
+	else
+		gsi = -1;
 
 	if (gsi < 0) {
 		/*
@@ -561,10 +541,9 @@ void __attribute__ ((weak)) acpi_unregister_gsi(u32 i)
 
 void acpi_pci_irq_disable(struct pci_dev *dev)
 {
+	struct acpi_prt_entry *entry;
 	int gsi = 0;
 	u8 pin = 0;
-	int triggering = ACPI_LEVEL_SENSITIVE;
-	int polarity = ACPI_ACTIVE_LOW;
 
 
 	pin = dev->pin;
@@ -574,20 +553,20 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	/*
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.
 	 */
-	gsi = acpi_pci_irq_lookup(dev, pin,
-				  &triggering, &polarity, NULL,
-				  acpi_pci_free_irq);
+	entry = acpi_pci_irq_lookup(dev, pin);
+
 	/*
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
 	 * device's parent bridge.
 	 */
-	if (gsi < 0)
-		gsi = acpi_pci_irq_derive(dev, pin,
-					  &triggering, &polarity, NULL,
-					  acpi_pci_free_irq);
-	if (gsi < 0)
+	if (!entry)
+		entry = acpi_pci_irq_derive(dev, pin);
+
+	if (!entry)
 		return;
 
+	gsi = acpi_pci_free_irq(entry);
+
 	/*
 	 * TBD: It might be worth clearing dev->irq by magic constant
 	 * (e.g. PCI_UNDEFINED_IRQ).

