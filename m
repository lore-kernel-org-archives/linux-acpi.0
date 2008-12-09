From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 13/20] ACPI: PCI: use positive logic to simplify code
Date: Mon, 08 Dec 2008 21:31:06 -0700
Message-ID: <20081209043106.26415.59230.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:33301 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbYLIEbH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:31:07 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This doesn't change anything functionally; it just changes tests
so we test for success instead of failure.  This makes the code
read more easily and allows us to remove the "!entry" in the while
loop condition.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index ef65c6d..6f54c3a 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -386,16 +386,15 @@ acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 	struct acpi_prt_entry *entry;
 
 	entry = acpi_pci_irq_find_prt_entry(dev, pin);
-	if (!entry) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No %s[%c] _PRT entry\n",
+	if (entry) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %s[%c] _PRT entry\n",
 				  pci_name(dev), pin_name(pin)));
-		return NULL;
+		return entry;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %s[%c] _PRT entry\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No %s[%c] _PRT entry\n",
 			  pci_name(dev), pin_name(pin)));
-
-	return entry;
+	return NULL;
 }
 
 static struct acpi_prt_entry *
@@ -410,7 +409,7 @@ acpi_pci_irq_derive(struct pci_dev *dev, int pin)
 	 * Attempt to derive an IRQ for this device from a parent bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
 	 */
-	while (!entry && bridge->bus->self) {
+	while (bridge->bus->self) {
 		pin = (((pin - 1) + PCI_SLOT(bridge->devfn)) % 4) + 1;
 		bridge = bridge->bus->self;
 
@@ -427,18 +426,18 @@ acpi_pci_irq_derive(struct pci_dev *dev, int pin)
 		}
 
 		entry = acpi_pci_irq_lookup(bridge, pin);
+		if (entry) {
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					 "Derived GSI for %s INT %c from %s\n",
+					 pci_name(dev), pin_name(orig_pin),
+					 pci_name(bridge)));
+			return entry;
+		}
 	}
 
-	if (!entry) {
-		dev_warn(&dev->dev, "can't derive routing for PCI INT %c\n",
-			 pin_name(orig_pin));
-		return NULL;
-	}
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derived GSI for %s INT %c from %s\n",
-			  pci_name(dev), pin_name(orig_pin), pci_name(bridge)));
-
-	return entry;
+	dev_warn(&dev->dev, "can't derive routing for PCI INT %c\n",
+		 pin_name(orig_pin));
+	return NULL;
 }
 
 /*

