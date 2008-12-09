From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 16/20] ACPI: PCI: simplify list of _PRT entries
Date: Mon, 08 Dec 2008 21:31:21 -0700
Message-ID: <20081209043121.26415.41882.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:33354 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbYLIEbW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:31:22 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

We don't need a struct containing a count and a list_head; a simple
list_head is sufficient.  The list iterators handle empty lists
fine.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   60 ++++++++++--------------------------------------
 1 files changed, 12 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 431d00b..b1cfd39 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -44,7 +44,7 @@
 ACPI_MODULE_NAME("pci_irq");
 
 struct acpi_prt_entry {
-	struct list_head	node;
+	struct list_head	list;
 	struct acpi_pci_id	id;
 	u8			pin;
 	struct {
@@ -54,12 +54,7 @@ struct acpi_prt_entry {
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
@@ -74,21 +69,13 @@ static inline char pin_name(int pin)
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
@@ -97,7 +84,6 @@ static struct acpi_prt_entry *acpi_pci_irq_find_prt_entry(struct pci_dev *dev,
 			return entry;
 		}
 	}
-
 	spin_unlock(&acpi_prt_lock);
 	return NULL;
 }
@@ -203,7 +189,7 @@ static int
 acpi_pci_irq_add_entry(acpi_handle handle,
 		       int segment, int bus, struct acpi_pci_routing_table *prt)
 {
-	struct acpi_prt_entry *entry = NULL;
+	struct acpi_prt_entry *entry;
 
 	entry = kzalloc(sizeof(struct acpi_prt_entry), GFP_KERNEL);
 	if (!entry)
@@ -255,35 +241,17 @@ acpi_pci_irq_add_entry(acpi_handle handle,
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
@@ -319,21 +287,17 @@ int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus)
 
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

