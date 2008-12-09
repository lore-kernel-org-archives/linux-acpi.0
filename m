From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 18/20] ACPI: PCI: expand acpi_pci_allocate_irq() and
	acpi_pci_free_irq() inline
Date: Mon, 08 Dec 2008 21:31:32 -0700
Message-ID: <20081209043132.26415.64420.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:36220 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbYLIEbc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:31:32 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

acpi_pci_allocate_irq() and acpi_pci_free_irq() are trivial and
only used once, so just open-code them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   56 +++++++++++-------------------------------------
 1 files changed, 13 insertions(+), 43 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 288583b..5a07d48 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -301,44 +301,6 @@ void acpi_pci_irq_del_prt(int segment, int bus)
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
@@ -428,10 +390,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
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
@@ -493,7 +460,10 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	if (!entry)
 		return;
 
-	gsi = acpi_pci_free_irq(entry);
+	if (entry->link)
+		gsi = acpi_pci_link_free_irq(entry->link);
+	else
+		gsi = entry->index;
 
 	/*
 	 * TBD: It might be worth clearing dev->irq by magic constant

