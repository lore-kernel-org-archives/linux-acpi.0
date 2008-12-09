From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 17/20] ACPI: PCI: simplify struct acpi_prt_entry
Date: Mon, 08 Dec 2008 21:31:27 -0700
Message-ID: <20081209043126.26415.7878.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:34071 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYLIEb1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:31:27 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Remove unused "irq" field, remove unnecessary struct,
rename "handle" to "link".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   35 +++++++++++++++--------------------
 1 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index b1cfd39..288583b 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -47,11 +47,8 @@ struct acpi_prt_entry {
 	struct list_head	list;
 	struct acpi_pci_id	id;
 	u8			pin;
-	struct {
-		acpi_handle		handle;
-		u32			index;
-	}			link;
-	u32			irq;
+	acpi_handle		link;
+	u32			index;		/* GSI, or link _CRS index */
 };
 
 static LIST_HEAD(acpi_prt_list);
@@ -207,6 +204,8 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 
 	do_prt_fixups(entry, prt);
 
+	entry->index = prt->source_index;
+
 	/*
 	 * Type 1: Dynamic
 	 * ---------------
@@ -220,10 +219,9 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 	 *       (e.g. exists somewhere 'below' this _PRT entry in the ACPI
 	 *       namespace).
 	 */
-	if (prt->source[0]) {
-		acpi_get_handle(handle, prt->source, &entry->link.handle);
-		entry->link.index = prt->source_index;
-	}
+	if (prt->source[0])
+		acpi_get_handle(handle, prt->source, &entry->link);
+
 	/*
 	 * Type 2: Static
 	 * --------------
@@ -231,14 +229,12 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 	 * the IRQ value, which is hardwired to specific interrupt inputs on
 	 * the interrupt controller.
 	 */
-	else
-		entry->link.index = prt->source_index;
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INFO,
 			      "      %04x:%02x:%02x[%c] -> %s[%d]\n",
 			      entry->id.segment, entry->id.bus,
 			      entry->id.device, pin_name(entry->pin),
-			      prt->source, entry->link.index));
+			      prt->source, entry->index));
 
 	spin_lock(&acpi_prt_lock);
 	list_add_tail(&entry->list, &acpi_prt_list);
@@ -312,17 +308,16 @@ acpi_pci_allocate_irq(struct acpi_prt_entry *entry,
 	int irq;
 
 
-	if (entry->link.handle) {
-		irq = acpi_pci_link_allocate_irq(entry->link.handle,
-						 entry->link.index, triggering,
-						 polarity, link);
+	if (entry->link) {
+		irq = acpi_pci_link_allocate_irq(entry->link, entry->index,
+						 triggering, polarity, link);
 		if (irq < 0) {
 			printk(KERN_WARNING PREFIX
 				      "Invalid IRQ link routing entry\n");
 			return -1;
 		}
 	} else {
-		irq = entry->link.index;
+		irq = entry->index;
 		*triggering = ACPI_LEVEL_SENSITIVE;
 		*polarity = ACPI_ACTIVE_LOW;
 	}
@@ -336,10 +331,10 @@ acpi_pci_free_irq(struct acpi_prt_entry *entry)
 {
 	int irq;
 
-	if (entry->link.handle) {
-		irq = acpi_pci_link_free_irq(entry->link.handle);
+	if (entry->link) {
+		irq = acpi_pci_link_free_irq(entry->link);
 	} else {
-		irq = entry->link.index;
+		irq = entry->index;
 	}
 	return irq;
 }

