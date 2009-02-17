From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] ACPI: PCI: use generic pci_swizzle_interrupt_pin()
Date: Tue, 17 Feb 2009 13:49:10 -0700
Message-ID: <20090217204910.4213.77580.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:28016 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbZBQUtN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Feb 2009 15:49:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Use the generic pci_swizzle_interrupt_pin() instead of ACPI-specific code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 891bdf6..be6b909 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -319,7 +319,7 @@ static struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 	 */
 	bridge = dev->bus->self;
 	while (bridge) {
-		pin = (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
+		pin = pci_swizzle_interrupt_pin(dev, pin);
 
 		if ((bridge->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
 			/* PC card has the same IRQ as its cardbridge */

