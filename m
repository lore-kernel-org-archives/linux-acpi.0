From: Len Brown <lenb@kernel.org>
Subject: [PATCH 46/94] ACPI: PCI: always use the PCI INTx pin values,
 not the _PRT ones
Date: Fri, 09 Jan 2009 04:26:48 -0500
Message-ID: <e64e9db53ab78d20dff4cc1aec8a6b0e4e70ce8c.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44602 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbZAIJ2T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:19 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD7004L36AY3Y4D@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:12 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 5ce1fcf..2c52cf0 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -62,7 +62,7 @@ static DEFINE_SPINLOCK(acpi_prt_lock);
 
 static inline char pin_name(int pin)
 {
-	return 'A' + pin;
+	return 'A' + pin - 1;
 }
 
 /* --------------------------------------------------------------------------
@@ -203,10 +203,15 @@ acpi_pci_irq_add_entry(acpi_handle handle,
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
 
@@ -425,7 +430,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
 	 */
 	while (irq < 0 && bridge->bus->self) {
-		pin = (pin + PCI_SLOT(bridge->devfn)) % 4;
+		pin = (((pin - 1) + PCI_SLOT(bridge->devfn)) % 4) + 1;
 		bridge = bridge->bus->self;
 
 		if ((bridge->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
@@ -437,8 +442,6 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 						  pci_name(bridge)));
 				return -1;
 			}
-			/* Pin is from 0 to 3 */
-			bridge_pin--;
 			pin = bridge_pin;
 		}
 
@@ -483,7 +486,6 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 				  pci_name(dev)));
 		return 0;
 	}
-	pin--;
 
 	/* 
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
@@ -566,7 +568,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	pin = dev->pin;
 	if (!pin)
 		return;
-	pin--;
 
 	/*
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.
-- 
1.5.6.6

