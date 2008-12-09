From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 02/20] ACPI: PCI: remove unnecessary null pointer checks
Date: Mon, 08 Dec 2008 21:30:10 -0700
Message-ID: <20081209043010.26415.19512.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:45916 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbYLIEaL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:30:11 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Better to oops and learn about a bug than to silently cover it up.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 6666f74..8250c55 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -180,10 +180,6 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 {
 	struct acpi_prt_entry *entry = NULL;
 
-
-	if (!prt)
-		return -EINVAL;
-
 	entry = kzalloc(sizeof(struct acpi_prt_entry), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
@@ -434,9 +430,6 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 	u8 bridge_pin = 0, orig_pin = pin;
 
 
-	if (!dev)
-		return -EINVAL;
-
 	/* 
 	 * Attempt to derive an IRQ for this device from a parent bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
@@ -493,9 +486,6 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	int rc;
 
 
-	if (!dev)
-		return -EINVAL;
-
 	pin = dev->pin;
 	if (!pin) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -505,11 +495,6 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	}
 	pin--;
 
-	if (!dev->bus) {
-		dev_err(&dev->dev, "invalid (NULL) 'bus' field\n");
-		return -ENODEV;
-	}
-
 	/* 
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
 	 * values override any BIOS-assigned IRQs set during boot.
@@ -588,9 +573,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	int polarity = ACPI_ACTIVE_LOW;
 
 
-	if (!dev || !dev->bus)
-		return;
-
 	pin = dev->pin;
 	if (!pin)
 		return;

