From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 4/4] ACPI: pci_link: simplify list of link devices
Date: Tue, 17 Feb 2009 14:00:55 -0700
Message-ID: <20090217210055.4506.82925.stgit@bob.kio>
References: <20090217205906.4506.95815.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:24613 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbZBQVA4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Feb 2009 16:00:56 -0500
In-Reply-To: <20090217205906.4506.95815.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

We don't need a struct containing a count and a list_head; a simple
list_head is sufficient.  The list iterators handle empty lists
fine.

Furthermore, we don't need to check for null list entries because we
only add non-null entries.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_link.c |   32 ++++++--------------------------
 1 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index dd9ebb9..16e0f9d 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -86,16 +86,13 @@ struct acpi_pci_link_irq {
 };
 
 struct acpi_pci_link {
-	struct list_head		node;
+	struct list_head		list;
 	struct acpi_device		*device;
 	struct acpi_pci_link_irq	irq;
 	int				refcnt;
 };
 
-static struct {
-	int			count;
-	struct list_head	entries;
-} acpi_link;
+static LIST_HEAD(acpi_link_list);
 static DEFINE_MUTEX(acpi_link_lock);
 
 /* --------------------------------------------------------------------------
@@ -479,19 +476,13 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
 
 int __init acpi_irq_penalty_init(void)
 {
-	struct list_head *node;
 	struct acpi_pci_link *link;
 	int i;
 
 	/*
 	 * Update penalties to facilitate IRQ balancing.
 	 */
-	list_for_each(node, &acpi_link.entries) {
-		link = list_entry(node, struct acpi_pci_link, node);
-		if (!link) {
-			printk(KERN_ERR PREFIX "Invalid link context\n");
-			continue;
-		}
+	list_for_each_entry(link, &acpi_link_list, list) {
 
 		/*
 		 * reflect the possible and active irqs in the penalty table --
@@ -743,9 +734,7 @@ static int acpi_pci_link_add(struct acpi_device *device)
 
 	printk("\n");
 
-	/* TBD: Acquire/release lock */
-	list_add_tail(&link->node, &acpi_link.entries);
-	acpi_link.count++;
+	list_add_tail(&link->list, &acpi_link_list);
 
       end:
 	/* disable all links -- to be activated on use */
@@ -768,15 +757,9 @@ static int acpi_pci_link_resume(struct acpi_pci_link *link)
 
 static int irqrouter_resume(struct sys_device *dev)
 {
-	struct list_head *node;
 	struct acpi_pci_link *link;
 
-	list_for_each(node, &acpi_link.entries) {
-		link = list_entry(node, struct acpi_pci_link, node);
-		if (!link) {
-			printk(KERN_ERR PREFIX "Invalid link context\n");
-			continue;
-		}
+	list_for_each_entry(link, &acpi_link_list, list) {
 		acpi_pci_link_resume(link);
 	}
 	return 0;
@@ -789,7 +772,7 @@ static int acpi_pci_link_remove(struct acpi_device *device, int type)
 	link = acpi_driver_data(device);
 
 	mutex_lock(&acpi_link_lock);
-	list_del(&link->node);
+	list_del(&link->list);
 	mutex_unlock(&acpi_link_lock);
 
 	kfree(link);
@@ -926,9 +909,6 @@ static int __init acpi_pci_link_init(void)
 			acpi_irq_balance = 0;
 	}
 
-	acpi_link.count = 0;
-	INIT_LIST_HEAD(&acpi_link.entries);
-
 	if (acpi_bus_register_driver(&acpi_pci_link_driver) < 0)
 		return -ENODEV;
 

