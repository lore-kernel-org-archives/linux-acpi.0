From: Len Brown <lenb@kernel.org>
Subject: [PATCH 56/94] ACPI: PCI: expand acpi_pci_allocate_irq() and
 acpi_pci_free_irq() inline
Date: Fri, 09 Jan 2009 04:26:58 -0500
Message-ID: <74f82af1eda39c26c17f8030e4f60c00929ec9df.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56372 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbZAIJ2c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:32 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700HTF68UX1F2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:26:55 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

acpi_pci_allocate_irq() and acpi_pci_free_irq() are trivial and
only used once, so just open-code them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   56 +++++++++++------------------------------------
 1 files changed, 13 insertions(+), 43 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 643c4e8..03d528e 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -299,44 +299,6 @@ void acpi_pci_irq_del_prt(int segment, int bus)
 /* --------------------------------------------------------------------------
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
-static int
-acpi_pci_allocate_irq(struct acpi_prt_entry *entry,
-		      int *triggering, int *polarity, char **link)
-{
-	int irq;
-
-
-	if (entry->link) {
-		irq = acpi_pci_link_allocate_irq(entry->link, entry->index,
-						 triggering, polarity, link);
-		if (irq < 0) {
-			printk(KERN_WARNING PREFIX
-				      "Invalid IRQ link routing entry\n");
-			return -1;
-		}
-	} else {
-		irq = entry->index;
-		*triggering = ACPI_LEVEL_SENSITIVE;
-		*polarity = ACPI_ACTIVE_LOW;
-	}
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found GSI %d\n", irq));
-	return irq;
-}
-
-static int
-acpi_pci_free_irq(struct acpi_prt_entry *entry)
-{
-	int irq;
-
-	if (entry->link) {
-		irq = acpi_pci_link_free_irq(entry->link);
-	} else {
-		irq = entry->index;
-	}
-	return irq;
-}
-
 static struct acpi_prt_entry *
 acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 {
@@ -426,10 +388,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 			return 0;
 	}
 
-	if (entry)
-		gsi = acpi_pci_allocate_irq(entry, &triggering, &polarity,
-					    &link);
-	else
+	if (entry) {
+		if (entry->link)
+			gsi = acpi_pci_link_allocate_irq(entry->link,
+							 entry->index,
+							 &triggering, &polarity,
+							 &link);
+		else
+			gsi = entry->index;
+	} else
 		gsi = -1;
 
 	/*
@@ -491,7 +458,10 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	if (!entry)
 		return;
 
-	gsi = acpi_pci_free_irq(entry);
+	if (entry->link)
+		gsi = acpi_pci_link_free_irq(entry->link);
+	else
+		gsi = entry->index;
 
 	/*
 	 * TBD: It might be worth clearing dev->irq by magic constant
-- 
1.5.6.6

