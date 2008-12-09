From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 14/20] ACPI: PCI: follow typical PCI INTx swizzling pattern
Date: Mon, 08 Dec 2008 21:31:11 -0700
Message-ID: <20081209043111.26415.88008.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:43732 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbYLIEbM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:31:12 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

No functional change; this just uses the typical pattern of
PCI INTx swizzling done on other architectures.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 6f54c3a..b2885ce 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -401,7 +401,7 @@ static struct acpi_prt_entry *
 acpi_pci_irq_derive(struct pci_dev *dev, int pin)
 {
 	struct acpi_prt_entry *entry = NULL;
-	struct pci_dev *bridge = dev;
+	struct pci_dev *bridge;
 	u8 bridge_pin = 0, orig_pin = pin;
 
 
@@ -409,9 +409,9 @@ acpi_pci_irq_derive(struct pci_dev *dev, int pin)
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
@@ -433,6 +433,9 @@ acpi_pci_irq_derive(struct pci_dev *dev, int pin)
 					 pci_name(bridge)));
 			return entry;
 		}
+
+		dev = bridge;
+		bridge = dev->bus->self;
 	}
 
 	dev_warn(&dev->dev, "can't derive routing for PCI INT %c\n",

