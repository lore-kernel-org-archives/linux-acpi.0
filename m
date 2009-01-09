From: Len Brown <lenb@kernel.org>
Subject: [PATCH 52/94] ACPI: PCI: follow typical PCI INTx swizzling pattern
Date: Fri, 09 Jan 2009 04:26:54 -0500
Message-ID: <ee40136313323db1096b17df7b436d22a24ef2be.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56372 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbZAIJ23 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:29 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD70042B68R15D6@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:26:51 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

No functional change; this just uses the typical pattern of
PCI INTx swizzling done on other architectures.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index e42481f..b35e64d 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -399,7 +399,7 @@ static struct acpi_prt_entry *
 acpi_pci_irq_derive(struct pci_dev *dev, int pin)
 {
 	struct acpi_prt_entry *entry = NULL;
-	struct pci_dev *bridge = dev;
+	struct pci_dev *bridge;
 	u8 bridge_pin = 0, orig_pin = pin;
 
 
@@ -407,9 +407,9 @@ acpi_pci_irq_derive(struct pci_dev *dev, int pin)
 	 * Attempt to derive an IRQ for this device from a parent bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
 	 */
-	while (bridge->bus->self) {
-		pin = (((pin - 1) + PCI_SLOT(bridge->devfn)) % 4) + 1;
-		bridge = bridge->bus->self;
+	bridge = dev->bus->self;
+	while (bridge) {
+		pin = (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
 
 		if ((bridge->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
 			/* PC card has the same IRQ as its cardbridge */
@@ -431,6 +431,9 @@ acpi_pci_irq_derive(struct pci_dev *dev, int pin)
 					 pci_name(bridge)));
 			return entry;
 		}
+
+		dev = bridge;
+		bridge = dev->bus->self;
 	}
 
 	dev_warn(&dev->dev, "can't derive routing for PCI INT %c\n",
-- 
1.5.6.6

