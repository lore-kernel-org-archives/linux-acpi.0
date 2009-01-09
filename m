From: Len Brown <lenb@kernel.org>
Subject: [PATCH 54/94] ACPI: PCI: simplify list of _PRT entries
Date: Fri, 09 Jan 2009 04:26:56 -0500
Message-ID: <3604a9f445afde2801b8c24b63dd289c33e290a6.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44602 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688AbZAIJ2W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:22 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD70042I6B339ID@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:17 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

We don't need a struct containing a count and a list_head; a simple
list_head is sufficient.  The list iterators handle empty lists
fine.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   60 +++++++++--------------------------------------
 1 files changed, 12 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index b03bb84..42b195e 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -42,7 +42,7 @@
 ACPI_MODULE_NAME("pci_irq");
 
 struct acpi_prt_entry {
-	struct list_head	node;
+	struct list_head	list;
 	struct acpi_pci_id	id;
 	u8			pin;
 	struct {
@@ -52,12 +52,7 @@ struct acpi_prt_entry {
 	u32			irq;
 };
 
-struct acpi_prt_list {
-	int			count;
-	struct list_head	entries;
-};
-
-static struct acpi_prt_list acpi_prt;
+static LIST_HEAD(acpi_prt_list);
 static DEFINE_SPINLOCK(acpi_prt_lock);
 
 static inline char pin_name(int pin)
@@ -72,21 +67,13 @@ static inline char pin_name(int pin)
 static struct acpi_prt_entry *acpi_pci_irq_find_prt_entry(struct pci_dev *dev,
 							  int pin)
 {
-	struct acpi_prt_entry *entry = NULL;
+	struct acpi_prt_entry *entry;
 	int segment = pci_domain_nr(dev->bus);
 	int bus = dev->bus->number;
 	int device = PCI_SLOT(dev->devfn);
 
-	if (!acpi_prt.count)
-		return NULL;
-
-	/*
-	 * Parse through all PRT entries looking for a match on the specified
-	 * PCI device's segment, bus, device, and pin (don't care about func).
-	 *
-	 */
 	spin_lock(&acpi_prt_lock);
-	list_for_each_entry(entry, &acpi_prt.entries, node) {
+	list_for_each_entry(entry, &acpi_prt_list, list) {
 		if ((segment == entry->id.segment)
 		    && (bus == entry->id.bus)
 		    && (device == entry->id.device)
@@ -95,7 +82,6 @@ static struct acpi_prt_entry *acpi_pci_irq_find_prt_entry(struct pci_dev *dev,
 			return entry;
 		}
 	}
-
 	spin_unlock(&acpi_prt_lock);
 	return NULL;
 }
@@ -201,7 +187,7 @@ static int
 acpi_pci_irq_add_entry(acpi_handle handle,
 		       int segment, int bus, struct acpi_pci_routing_table *prt)
 {
-	struct acpi_prt_entry *entry = NULL;
+	struct acpi_prt_entry *entry;
 
 	entry = kzalloc(sizeof(struct acpi_prt_entry), GFP_KERNEL);
 	if (!entry)
@@ -253,35 +239,17 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 			      prt->source, entry->link.index));
 
 	spin_lock(&acpi_prt_lock);
-	list_add_tail(&entry->node, &acpi_prt.entries);
-	acpi_prt.count++;
+	list_add_tail(&entry->list, &acpi_prt_list);
 	spin_unlock(&acpi_prt_lock);
 
 	return 0;
 }
 
-static void
-acpi_pci_irq_del_entry(int segment, int bus, struct acpi_prt_entry *entry)
-{
-	if (segment == entry->id.segment && bus == entry->id.bus) {
-		acpi_prt.count--;
-		list_del(&entry->node);
-		kfree(entry);
-	}
-}
-
 int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus)
 {
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_pci_routing_table *entry;
-	static int first_time = 1;
-
-	if (first_time) {
-		acpi_prt.count = 0;
-		INIT_LIST_HEAD(&acpi_prt.entries);
-		first_time = 0;
-	}
 
 	/* 'handle' is the _PRT's parent (root bridge or PCI-PCI bridge) */
 	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
@@ -317,21 +285,17 @@ int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus)
 
 void acpi_pci_irq_del_prt(int segment, int bus)
 {
-	struct list_head *node = NULL, *n = NULL;
-	struct acpi_prt_entry *entry = NULL;
-
-	if (!acpi_prt.count) {
-		return;
-	}
+	struct acpi_prt_entry *entry, *tmp;
 
 	printk(KERN_DEBUG
 	       "ACPI: Delete PCI Interrupt Routing Table for %04x:%02x\n",
 	       segment, bus);
 	spin_lock(&acpi_prt_lock);
-	list_for_each_safe(node, n, &acpi_prt.entries) {
-		entry = list_entry(node, struct acpi_prt_entry, node);
-
-		acpi_pci_irq_del_entry(segment, bus, entry);
+	list_for_each_entry_safe(entry, tmp, &acpi_prt_list, list) {
+		if (segment == entry->id.segment && bus == entry->id.bus) {
+			list_del(&entry->list);
+			kfree(entry);
+		}
 	}
 	spin_unlock(&acpi_prt_lock);
 }
-- 
1.5.6.6

