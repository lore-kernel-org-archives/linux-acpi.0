From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/98] ACPI: pci_link: simplify list of link devices
Date: Sat, 28 Mar 2009 00:30:45 -0400
Message-ID: <5f0dccaa81e239477413d0def1133850530f1bbe.1238214617.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64533 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbZC1Ecp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:45 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7005VQ8M3EXZZ@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:28 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

We don't need a struct containing a count and a list_head; a simple
list_head is sufficient.  The list iterators handle empty lists
fine.

Furthermore, we don't need to check for null list entries because we
only add non-null entries.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
 
-- 
1.6.0.6

