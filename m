From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 08/20] ACPI: PCI: always use the PCI INTx pin values,
	not the _PRT ones
Date: Mon, 08 Dec 2008 21:30:41 -0700
Message-ID: <20081209043041.26415.59498.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:11145 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbYLIEal (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:30:41 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This patch changes pci_irq.c to always use PCI INTx pin encodings
instead of a mix of PCI and _PRT encodings.

The PCI INTx pin numbers from the PCI_INTERRUPT_PIN config register
are 0=device doesn't use interrupts, 1=INTA, ..., 4=INTD.  But the
_PRT table uses 0=INTA, ..., 3=INTD.

This patch converts the _PRT encoding to the PCI encoding immediately
when we add a _PRT entry to the global list.  All the rest of the
code can then use the PCI encoding consistently.

The point of this is to make the interrupt swizzling look the same
as on other architectures, so someday we can unify them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index ccbb163..0036055 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -64,7 +64,7 @@ static DEFINE_SPINLOCK(acpi_prt_lock);
 
 static inline char pin_name(int pin)
 {
-	return 'A' + pin;
+	return 'A' + pin - 1;
 }
 
 /* --------------------------------------------------------------------------
@@ -205,10 +205,15 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 	if (!entry)
 		return -ENOMEM;
 
+	/*
+	 * Note that the _PRT uses 0=INTA, 1=INTB, etc, while PCI uses
+	 * 1=INTA, 2=INTB.  We use the PCI encoding throughout, so convert
+	 * it here.
+	 */
 	entry->id.segment = segment;
 	entry->id.bus = bus;
 	entry->id.device = (prt->address >> 16) & 0xFFFF;
-	entry->pin = prt->pin;
+	entry->pin = prt->pin + 1;
 
 	do_prt_fixups(entry, prt);
 
@@ -427,7 +432,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
 	 */
 	while (irq < 0 && bridge->bus->self) {
-		pin = (pin + PCI_SLOT(bridge->devfn)) % 4;
+		pin = (((pin - 1) + PCI_SLOT(bridge->devfn)) % 4) + 1;
 		bridge = bridge->bus->self;
 
 		if ((bridge->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
@@ -439,8 +444,6 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 						  pci_name(bridge)));
 				return -1;
 			}
-			/* Pin is from 0 to 3 */
-			bridge_pin--;
 			pin = bridge_pin;
 		}
 
@@ -485,7 +488,6 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 				  pci_name(dev)));
 		return 0;
 	}
-	pin--;
 
 	/* 
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
@@ -568,7 +570,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	pin = dev->pin;
 	if (!pin)
 		return;
-	pin--;
 
 	/*
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.

