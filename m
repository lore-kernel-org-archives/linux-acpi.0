From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 15/20] ACPI: PCI: combine lookup and derive
Date: Mon, 08 Dec 2008 21:31:16 -0700
Message-ID: <20081209043116.26415.69210.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:33335 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbYLIEbR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:31:17 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This folds acpi_pci_irq_derive() into acpi_pci_irq_lookup() so it
can be easily used by both acpi_pci_irq_enable() and acpi_pci_irq_disable().

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   55 ++++++++++--------------------------------------
 1 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index b2885ce..431d00b 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -384,6 +384,8 @@ static struct acpi_prt_entry *
 acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 {
 	struct acpi_prt_entry *entry;
+	struct pci_dev *bridge;
+	u8 bridge_pin, orig_pin = pin;
 
 	entry = acpi_pci_irq_find_prt_entry(dev, pin);
 	if (entry) {
@@ -392,19 +394,6 @@ acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
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
@@ -425,7 +414,7 @@ acpi_pci_irq_derive(struct pci_dev *dev, int pin)
 			pin = bridge_pin;
 		}
 
-		entry = acpi_pci_irq_lookup(bridge, pin);
+		entry = acpi_pci_irq_find_prt_entry(bridge, pin);
 		if (entry) {
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					 "Derived GSI for %s INT %c from %s\n",
@@ -469,26 +458,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
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
@@ -497,6 +468,13 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
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
@@ -552,18 +530,7 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
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
 

