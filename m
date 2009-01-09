From: Len Brown <lenb@kernel.org>
Subject: [PATCH 50/94] ACPI: PCI: remove callback from acpi_pci_irq_lookup &
 acpi_pci_irq_derive
Date: Fri, 09 Jan 2009 04:26:52 -0500
Message-ID: <beba8a643d7f774cf27c3c92a51b99cebf787415.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56372 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbZAIJ2Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:25 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD7003W568PZZ86@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:26:50 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

We currently pass a callback function (either acpi_pci_allocate_irq() or
acpi_pci_free_irq()) to acpi_pci_irq_lookup() and acpi_pci_irq_derive().

I think it's simpler to remove the callback and just have the enable/
disable functions make the calls directly.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   93 ++++++++++++++++++-----------------------------
 1 files changed, 36 insertions(+), 57 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 7978c97..2833822 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -339,8 +339,6 @@ void acpi_pci_irq_del_prt(int segment, int bus)
 /* --------------------------------------------------------------------------
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
-typedef int (*irq_lookup_func) (struct acpi_prt_entry *, int *, int *, char **);
-
 static int
 acpi_pci_allocate_irq(struct acpi_prt_entry *entry,
 		      int *triggering, int *polarity, char **link)
@@ -368,8 +366,7 @@ acpi_pci_allocate_irq(struct acpi_prt_entry *entry,
 }
 
 static int
-acpi_pci_free_irq(struct acpi_prt_entry *entry,
-		  int *triggering, int *polarity, char **link)
+acpi_pci_free_irq(struct acpi_prt_entry *entry)
 {
 	int irq;
 
@@ -381,47 +378,29 @@ acpi_pci_free_irq(struct acpi_prt_entry *entry,
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
 
 
@@ -429,7 +408,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 	 * Attempt to derive an IRQ for this device from a parent bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
 	 */
-	while (irq < 0 && bridge->bus->self) {
+	while (!entry && bridge->bus->self) {
 		pin = (((pin - 1) + PCI_SLOT(bridge->devfn)) % 4) + 1;
 		bridge = bridge->bus->self;
 
@@ -440,26 +419,24 @@ acpi_pci_irq_derive(struct pci_dev *dev,
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
@@ -470,6 +447,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 
 int acpi_pci_irq_enable(struct pci_dev *dev)
 {
+	struct acpi_prt_entry *entry;
 	int gsi = 0;
 	u8 pin = 0;
 	int triggering = ACPI_LEVEL_SENSITIVE;
@@ -491,18 +469,20 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
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
@@ -559,10 +539,9 @@ void __attribute__ ((weak)) acpi_unregister_gsi(u32 i)
 
 void acpi_pci_irq_disable(struct pci_dev *dev)
 {
+	struct acpi_prt_entry *entry;
 	int gsi = 0;
 	u8 pin = 0;
-	int triggering = ACPI_LEVEL_SENSITIVE;
-	int polarity = ACPI_ACTIVE_LOW;
 
 
 	pin = dev->pin;
@@ -572,20 +551,20 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
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
-- 
1.5.6.6

