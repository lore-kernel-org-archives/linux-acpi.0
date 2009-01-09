From: Len Brown <lenb@kernel.org>
Subject: [PATCH 40/94] ACPI: PCI: remove unnecessary null pointer checks
Date: Fri, 09 Jan 2009 04:26:42 -0500
Message-ID: <3b8249de43ecf05407888c1ca6ca6e4945ff823c.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56372 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbZAIJ2J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:09 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700G5G68JXTH5@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:26:44 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Better to oops and learn about a bug than to silently cover it up.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 63a1326..6c04060 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -178,10 +178,6 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 {
 	struct acpi_prt_entry *entry = NULL;
 
-
-	if (!prt)
-		return -EINVAL;
-
 	entry = kzalloc(sizeof(struct acpi_prt_entry), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
@@ -432,9 +428,6 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 	u8 bridge_pin = 0, orig_pin = pin;
 
 
-	if (!dev)
-		return -EINVAL;
-
 	/* 
 	 * Attempt to derive an IRQ for this device from a parent bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
@@ -491,9 +484,6 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	int rc;
 
 
-	if (!dev)
-		return -EINVAL;
-
 	pin = dev->pin;
 	if (!pin) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -503,11 +493,6 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
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
@@ -586,9 +571,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	int polarity = ACPI_ACTIVE_LOW;
 
 
-	if (!dev || !dev->bus)
-		return;
-
 	pin = dev->pin;
 	if (!pin)
 		return;
-- 
1.5.6.6

