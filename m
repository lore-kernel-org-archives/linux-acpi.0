From: Len Brown <lenb@kernel.org>
Subject: [PATCH 51/94] ACPI: PCI: use positive logic to simplify code
Date: Fri, 09 Jan 2009 04:26:53 -0500
Message-ID: <3b1ea18d3b3542b55861d7f968ded705e3bc2aa6.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916AbZAIJ2d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:33 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700EMB6B2P3I2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:15 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This doesn't change anything functionally; it just changes tests
so we test for success instead of failure.  This makes the code
read more easily and allows us to remove the "!entry" in the while
loop condition.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 2833822..e42481f 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -384,16 +384,15 @@ acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
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
@@ -408,7 +407,7 @@ acpi_pci_irq_derive(struct pci_dev *dev, int pin)
 	 * Attempt to derive an IRQ for this device from a parent bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
 	 */
-	while (!entry && bridge->bus->self) {
+	while (bridge->bus->self) {
 		pin = (((pin - 1) + PCI_SLOT(bridge->devfn)) % 4) + 1;
 		bridge = bridge->bus->self;
 
@@ -425,18 +424,18 @@ acpi_pci_irq_derive(struct pci_dev *dev, int pin)
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
-- 
1.5.6.6

