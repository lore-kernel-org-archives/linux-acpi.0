From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/98] ACPI: pci_link: clean up whitespace
Date: Sat, 28 Mar 2009 00:30:42 -0400
Message-ID: <1c9ca3a7d41b5db884033900b539b9aeb61a399e.1238214617.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:8294 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbZC1EdM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:12 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7006RX8M1DDIJ@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:26 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch makes whitespace and indentation more consistent.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_link.c |   73 +++++++++++++++++-----------------------------
 1 files changed, 27 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 6c772ca..19bc3bc 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -43,13 +43,14 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
-#define _COMPONENT		ACPI_PCI_COMPONENT
+#define _COMPONENT			ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_link");
 #define ACPI_PCI_LINK_CLASS		"pci_irq_routing"
 #define ACPI_PCI_LINK_DEVICE_NAME	"PCI Interrupt Link"
 #define ACPI_PCI_LINK_FILE_INFO		"info"
 #define ACPI_PCI_LINK_FILE_STATUS	"state"
-#define ACPI_PCI_LINK_MAX_POSSIBLE 16
+#define ACPI_PCI_LINK_MAX_POSSIBLE	16
+
 static int acpi_pci_link_add(struct acpi_device *device);
 static int acpi_pci_link_remove(struct acpi_device *device, int type);
 
@@ -66,7 +67,7 @@ static struct acpi_driver acpi_pci_link_driver = {
 	.ops = {
 		.add = acpi_pci_link_add,
 		.remove = acpi_pci_link_remove,
-		},
+	},
 };
 
 /*
@@ -76,7 +77,7 @@ static struct acpi_driver acpi_pci_link_driver = {
 struct acpi_pci_link_irq {
 	u8 active;		/* Current IRQ */
 	u8 triggering;		/* All IRQs */
-	u8 polarity;	/* All IRQs */
+	u8 polarity;		/* All IRQs */
 	u8 resource_type;
 	u8 possible_count;
 	u8 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
@@ -85,15 +86,15 @@ struct acpi_pci_link_irq {
 };
 
 struct acpi_pci_link {
-	struct list_head node;
-	struct acpi_device *device;
-	struct acpi_pci_link_irq irq;
-	int refcnt;
+	struct list_head		node;
+	struct acpi_device		*device;
+	struct acpi_pci_link_irq	irq;
+	int				refcnt;
 };
 
 static struct {
-	int count;
-	struct list_head entries;
+	int			count;
+	struct list_head	entries;
 } acpi_link;
 static DEFINE_MUTEX(acpi_link_lock);
 
@@ -104,13 +105,12 @@ static DEFINE_MUTEX(acpi_link_lock);
 /*
  * set context (link) possible list from resource list
  */
-static acpi_status
-acpi_pci_link_check_possible(struct acpi_resource *resource, void *context)
+static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
+						void *context)
 {
 	struct acpi_pci_link *link = context;
 	u32 i = 0;
 
-
 	switch (resource->type) {
 	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
 	case ACPI_RESOURCE_TYPE_END_TAG:
@@ -179,7 +179,6 @@ static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
 {
 	acpi_status status;
 
-
 	if (!link)
 		return -EINVAL;
 
@@ -197,12 +196,11 @@ static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
 	return 0;
 }
 
-static acpi_status
-acpi_pci_link_check_current(struct acpi_resource *resource, void *context)
+static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
+					       void *context)
 {
 	int *irq = (int *)context;
 
-
 	switch (resource->type) {
 	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
 	case ACPI_RESOURCE_TYPE_END_TAG:
@@ -316,7 +314,6 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 	} *resource;
 	struct acpi_buffer buffer = { 0, NULL };
 
-
 	if (!link || !irq)
 		return -EINVAL;
 
@@ -479,10 +476,10 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
 	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ9  PCI, often acpi */
 	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ10 PCI */
 	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ11 PCI */
-	PIRQ_PENALTY_ISA_USED,	/* IRQ12 mouse */
-	PIRQ_PENALTY_ISA_USED,	/* IRQ13 fpe, sometimes */
-	PIRQ_PENALTY_ISA_USED,	/* IRQ14 ide0 */
-	PIRQ_PENALTY_ISA_USED,	/* IRQ15 ide1 */
+	PIRQ_PENALTY_ISA_USED,		/* IRQ12 mouse */
+	PIRQ_PENALTY_ISA_USED,		/* IRQ13 fpe, sometimes */
+	PIRQ_PENALTY_ISA_USED,		/* IRQ14 ide0 */
+	PIRQ_PENALTY_ISA_USED,		/* IRQ15 ide1 */
 	/* >IRQ15 */
 };
 
@@ -492,12 +489,10 @@ int __init acpi_irq_penalty_init(void)
 	struct acpi_pci_link *link = NULL;
 	int i = 0;
 
-
 	/*
 	 * Update penalties to facilitate IRQ balancing.
 	 */
 	list_for_each(node, &acpi_link.entries) {
-
 		link = list_entry(node, struct acpi_pci_link, node);
 		if (!link) {
 			printk(KERN_ERR PREFIX "Invalid link context\n");
@@ -527,7 +522,6 @@ int __init acpi_irq_penalty_init(void)
 	}
 	/* Add a penalty for the SCI */
 	acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] += PIRQ_PENALTY_PCI_USING;
-
 	return 0;
 }
 
@@ -538,7 +532,6 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 	int irq;
 	int i;
 
-
 	if (link->irq.initialized) {
 		if (link->refcnt == 0)
 			/* This means the link is disabled but initialized */
@@ -566,11 +559,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 	/*
 	 * if active found, use it; else pick entry from end of possible list.
 	 */
-	if (link->irq.active) {
+	if (link->irq.active)
 		irq = link->irq.active;
-	} else {
+	else
 		irq = link->irq.possible[link->irq.possible_count - 1];
-	}
 
 	if (acpi_irq_balance || !link->irq.active) {
 		/*
@@ -599,7 +591,6 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 	}
 
 	link->irq.initialized = 1;
-
 	return 0;
 }
 
@@ -608,17 +599,13 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
  * success: return IRQ >= 0
  * failure: return -1
  */
-
-int
-acpi_pci_link_allocate_irq(acpi_handle handle,
-			   int index,
-			   int *triggering, int *polarity, char **name)
+int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
+			       int *polarity, char **name)
 {
 	int result = 0;
 	struct acpi_device *device = NULL;
 	struct acpi_pci_link *link = NULL;
 
-
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
 		printk(KERN_ERR PREFIX "Invalid link device\n");
@@ -673,7 +660,6 @@ int acpi_pci_link_free_irq(acpi_handle handle)
 	struct acpi_pci_link *link = NULL;
 	acpi_status result;
 
-
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
 		printk(KERN_ERR PREFIX "Invalid link device\n");
@@ -708,9 +694,9 @@ int acpi_pci_link_free_irq(acpi_handle handle)
 			  "Link %s is dereferenced\n",
 			  acpi_device_bid(link->device)));
 
-	if (link->refcnt == 0) {
+	if (link->refcnt == 0)
 		acpi_evaluate_object(link->device->handle, "_DIS", NULL, NULL);
-	}
+
 	mutex_unlock(&acpi_link_lock);
 	return (link->irq.active);
 }
@@ -726,7 +712,6 @@ static int acpi_pci_link_add(struct acpi_device *device)
 	int i = 0;
 	int found = 0;
 
-
 	if (!device)
 		return -EINVAL;
 
@@ -784,11 +769,10 @@ static int acpi_pci_link_add(struct acpi_device *device)
 
 static int acpi_pci_link_resume(struct acpi_pci_link *link)
 {
-
 	if (link->refcnt && link->irq.active && link->irq.initialized)
 		return (acpi_pci_link_set(link, link->irq.active));
-	else
-		return 0;
+
+	return 0;
 }
 
 static int irqrouter_resume(struct sys_device *dev)
@@ -811,7 +795,6 @@ static int acpi_pci_link_remove(struct acpi_device *device, int type)
 {
 	struct acpi_pci_link *link = NULL;
 
-
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
@@ -822,7 +805,6 @@ static int acpi_pci_link_remove(struct acpi_device *device, int type)
 	mutex_unlock(&acpi_link_lock);
 
 	kfree(link);
-
 	return 0;
 }
 
@@ -931,7 +913,6 @@ static int __init irqrouter_init_sysfs(void)
 {
 	int error;
 
-
 	if (acpi_disabled || acpi_noirq)
 		return 0;
 
-- 
1.6.0.6

