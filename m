From: Len Brown <lenb@kernel.org>
Subject: [PATCH 55/94] ACPI: PCI: simplify struct acpi_prt_entry
Date: Fri, 09 Jan 2009 04:26:57 -0500
Message-ID: <4eaf6db3ea0edf7e011a613b5a15360444e58fec.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:59678 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149AbZAIJ2s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:48 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700M5I6B4VR63@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:18 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Remove unused "irq" field, remove unnecessary struct,
rename "handle" to "link".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   35 +++++++++++++++--------------------
 1 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 42b195e..643c4e8 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -45,11 +45,8 @@ struct acpi_prt_entry {
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
@@ -205,6 +202,8 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 
 	do_prt_fixups(entry, prt);
 
+	entry->index = prt->source_index;
+
 	/*
 	 * Type 1: Dynamic
 	 * ---------------
@@ -218,10 +217,9 @@ acpi_pci_irq_add_entry(acpi_handle handle,
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
@@ -229,14 +227,12 @@ acpi_pci_irq_add_entry(acpi_handle handle,
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
@@ -310,17 +306,16 @@ acpi_pci_allocate_irq(struct acpi_prt_entry *entry,
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
@@ -334,10 +329,10 @@ acpi_pci_free_irq(struct acpi_prt_entry *entry)
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
-- 
1.5.6.6

