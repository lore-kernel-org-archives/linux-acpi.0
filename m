From: Len Brown <lenb@kernel.org>
Subject: [PATCH 53/94] ACPI: PCI: combine lookup and derive
Date: Fri, 09 Jan 2009 04:26:55 -0500
Message-ID: <5697b7ca406b4ee0afeef6d9a29b823767716cab.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:51637 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbZAIJ2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:16 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700A0C6B3WE3A@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:16 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This folds acpi_pci_irq_derive() into acpi_pci_irq_lookup() so it
can be easily used by both acpi_pci_irq_enable() and acpi_pci_irq_disable().

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   55 +++++++++--------------------------------------
 1 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index b35e64d..b03bb84 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -382,6 +382,8 @@ static struct acpi_prt_entry *
 acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 {
 	struct acpi_prt_entry *entry;
+	struct pci_dev *bridge;
+	u8 bridge_pin, orig_pin = pin;
 
 	entry = acpi_pci_irq_find_prt_entry(dev, pin);
 	if (entry) {
@@ -390,19 +392,6 @@ acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 		return entry;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No %s[%c] _PRT entry\n",
-			  pci_name(dev), pin_name(pin)));
-	return NULL;
-}
-
-static struct acpi_prt_entry *
-acpi_pci_irq_derive(struct pci_dev *dev, int pin)
-{
-	struct acpi_prt_entry *entry = NULL;
-	struct pci_dev *bridge;
-	u8 bridge_pin = 0, orig_pin = pin;
-
-
 	/* 
 	 * Attempt to derive an IRQ for this device from a parent bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
@@ -423,7 +412,7 @@ acpi_pci_irq_derive(struct pci_dev *dev, int pin)
 			pin = bridge_pin;
 		}
 
-		entry = acpi_pci_irq_lookup(bridge, pin);
+		entry = acpi_pci_irq_find_prt_entry(bridge, pin);
 		if (entry) {
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					 "Derived GSI for %s INT %c from %s\n",
@@ -467,26 +456,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		return 0;
 	}
 
-	/* 
-	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
-	 * values override any BIOS-assigned IRQs set during boot.
-	 */
 	entry = acpi_pci_irq_lookup(dev, pin);
-
-	/*
-	 * If no PRT entry was found, we'll try to derive an IRQ from the
-	 * device's parent bridge.
-	 */
-	if (!entry)
-		entry = acpi_pci_irq_derive(dev, pin);
-
-	if (entry)
-		gsi = acpi_pci_allocate_irq(entry, &triggering, &polarity,
-					    &link);
-	else
-		gsi = -1;
-
-	if (gsi < 0) {
+	if (!entry) {
 		/*
 		 * IDE legacy mode controller IRQs are magic. Why do compat
 		 * extensions always make such a nasty mess.
@@ -495,6 +466,13 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 				(dev->class & 0x05) == 0)
 			return 0;
 	}
+
+	if (entry)
+		gsi = acpi_pci_allocate_irq(entry, &triggering, &polarity,
+					    &link);
+	else
+		gsi = -1;
+
 	/*
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
 	 * driver reported one, then use it. Exit in any case.
@@ -550,18 +528,7 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	if (!pin)
 		return;
 
-	/*
-	 * First we check the PCI IRQ routing table (PRT) for an IRQ.
-	 */
 	entry = acpi_pci_irq_lookup(dev, pin);
-
-	/*
-	 * If no PRT entry was found, we'll try to derive an IRQ from the
-	 * device's parent bridge.
-	 */
-	if (!entry)
-		entry = acpi_pci_irq_derive(dev, pin);
-
 	if (!entry)
 		return;
 
-- 
1.5.6.6

