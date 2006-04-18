From: mochel@linux.intel.com
Subject: [PATCH 15/24] Remove unneeded debugging macros in drivers/acpi/pci_link.c
Date: Mon, 17 Apr 2006 18:21:54 -0700
Message-ID: <11453233142184-git-send-email-mochel@linux.intel.com>
References: <1145323314280-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:45469 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932126AbWDRBZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:26 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr003.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PPer030529
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:25 GMT
In-Reply-To: <1145323314280-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/pci_link.c |  120 ++++++++++++++++++-----------------------------
 1 files changed, 45 insertions(+), 75 deletions(-)

applies-to: f90c808ca530e4a808646669157e7de12de866c4
2e4b45abdc58e96acc0005335575ffc11a4a768b
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index d4ea9da..fbfe24e 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -106,17 +106,15 @@ acpi_pci_link_check_possible(struct acpi
 	struct acpi_pci_link *link = (struct acpi_pci_link *)context;
 	u32 i = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_check_possible");
-
 	switch (resource->type) {
 	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
-		return_ACPI_STATUS(AE_OK);
+		return AE_OK;
 	case ACPI_RESOURCE_TYPE_IRQ:
 		{
 			struct acpi_resource_irq *p = &resource->data.irq;
 			if (!p || !p->interrupt_count) {
 				ACPI_WARNING((AE_INFO, "Blank IRQ resource"));
-				return_ACPI_STATUS(AE_OK);
+				return AE_OK;
 			}
 			for (i = 0;
 			     (i < p->interrupt_count
@@ -141,7 +139,7 @@ acpi_pci_link_check_possible(struct acpi
 			if (!p || !p->interrupt_count) {
 				ACPI_WARNING((AE_INFO,
 					      "Blank EXT IRQ resource"));
-				return_ACPI_STATUS(AE_OK);
+				return AE_OK;
 			}
 			for (i = 0;
 			     (i < p->interrupt_count
@@ -161,33 +159,31 @@ acpi_pci_link_check_possible(struct acpi
 		}
 	default:
 		ACPI_ERROR((AE_INFO, "Resource is not an IRQ entry\n"));
-		return_ACPI_STATUS(AE_OK);
+		return AE_OK;
 	}
 
-	return_ACPI_STATUS(AE_CTRL_TERMINATE);
+	return AE_CTRL_TERMINATE;
 }
 
 static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
 {
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_get_possible");
-
 	if (!link)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	status = acpi_walk_resources(link->handle, METHOD_NAME__PRS,
 				     acpi_pci_link_check_possible, link);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRS"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Found %d possible IRQs\n",
 			  link->irq.possible_count));
 
-	return_VALUE(0);
+	return 0;
 }
 
 static acpi_status
@@ -195,8 +191,6 @@ acpi_pci_link_check_current(struct acpi_
 {
 	int *irq = (int *)context;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_check_current");
-
 	switch (resource->type) {
 	case ACPI_RESOURCE_TYPE_IRQ:
 		{
@@ -208,7 +202,7 @@ acpi_pci_link_check_current(struct acpi_
 				 */
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "Blank IRQ resource\n"));
-				return_ACPI_STATUS(AE_OK);
+				return AE_OK;
 			}
 			*irq = p->interrupts[0];
 			break;
@@ -224,7 +218,7 @@ acpi_pci_link_check_current(struct acpi_
 				 */
 				ACPI_WARNING((AE_INFO,
 					      "Blank EXT IRQ resource"));
-				return_ACPI_STATUS(AE_OK);
+				return AE_OK;
 			}
 			*irq = p->interrupts[0];
 			break;
@@ -233,9 +227,9 @@ acpi_pci_link_check_current(struct acpi_
 	default:
 		ACPI_ERROR((AE_INFO, "Resource %d isn't an IRQ", resource->type));
 	case ACPI_RESOURCE_TYPE_END_TAG:
-		return_ACPI_STATUS(AE_OK);
+		return AE_OK;
 	}
-	return_ACPI_STATUS(AE_CTRL_TERMINATE);
+	return AE_CTRL_TERMINATE;
 }
 
 /*
@@ -251,10 +245,8 @@ static int acpi_pci_link_get_current(str
 	acpi_status status = AE_OK;
 	int irq = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_get_current");
-
 	if (!link || !link->handle)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	link->irq.active = 0;
 
@@ -269,7 +261,7 @@ static int acpi_pci_link_get_current(str
 
 		if (!link->device->status.enabled) {
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link disabled\n"));
-			return_VALUE(0);
+			return 0;
 		}
 	}
 
@@ -295,7 +287,7 @@ static int acpi_pci_link_get_current(str
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link at IRQ %d \n", link->irq.active));
 
       end:
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
@@ -308,14 +300,12 @@ static int acpi_pci_link_set(struct acpi
 	} *resource;
 	struct acpi_buffer buffer = { 0, NULL };
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_set");
-
 	if (!link || !irq)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
 	if (!resource)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 
 	memset(resource, 0, sizeof(*resource) + 1);
 	buffer.length = sizeof(*resource) + 1;
@@ -412,7 +402,7 @@ static int acpi_pci_link_set(struct acpi
 
       end:
 	kfree(resource);
-	return_VALUE(result);
+	return result;
 }
 
 /* --------------------------------------------------------------------------
@@ -486,8 +476,6 @@ int __init acpi_irq_penalty_init(void)
 	struct acpi_pci_link *link = NULL;
 	int i = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_irq_penalty_init");
-
 	/*
 	 * Update penalties to facilitate IRQ balancing.
 	 */
@@ -523,7 +511,7 @@ int __init acpi_irq_penalty_init(void)
 	/* Add a penalty for the SCI */
 	acpi_irq_penalty[acpi_fadt.sci_int] += PIRQ_PENALTY_PCI_USING;
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_irq_balance;	/* 0: static, 1: balance */
@@ -533,13 +521,11 @@ static int acpi_pci_link_allocate(struct
 	int irq;
 	int i;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
-
 	if (link->irq.initialized) {
 		if (link->refcnt == 0)
 			/* This means the link is disabled but initialized */
 			acpi_pci_link_set(link, link->irq.active);
-		return_VALUE(0);
+		return 0;
 	}
 
 	/*
@@ -586,7 +572,7 @@ static int acpi_pci_link_allocate(struct
 			    "Try pci=noacpi or acpi=off",
 			    acpi_device_name(link->device),
 			    acpi_device_bid(link->device)));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	} else {
 		acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
 		printk(PREFIX "%s [%s] enabled at IRQ %d\n",
@@ -596,7 +582,7 @@ static int acpi_pci_link_allocate(struct
 
 	link->irq.initialized = 1;
 
-	return_VALUE(0);
+	return 0;
 }
 
 /*
@@ -614,36 +600,34 @@ acpi_pci_link_allocate_irq(acpi_handle h
 	struct acpi_device *device = NULL;
 	struct acpi_pci_link *link = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate_irq");
-
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
 		ACPI_ERROR((AE_INFO, "Invalid link device"));
-		return_VALUE(-1);
+		return -1;
 	}
 
 	link = (struct acpi_pci_link *)acpi_driver_data(device);
 	if (!link) {
 		ACPI_ERROR((AE_INFO, "Invalid link context"));
-		return_VALUE(-1);
+		return -1;
 	}
 
 	/* TBD: Support multiple index (IRQ) entries per Link Device */
 	if (index) {
 		ACPI_ERROR((AE_INFO, "Invalid index %d", index));
-		return_VALUE(-1);
+		return -1;
 	}
 
 	down(&acpi_link_lock);
 	if (acpi_pci_link_allocate(link)) {
 		up(&acpi_link_lock);
-		return_VALUE(-1);
+		return -1;
 	}
 
 	if (!link->irq.active) {
 		up(&acpi_link_lock);
 		ACPI_ERROR((AE_INFO, "Link active IRQ is 0!"));
-		return_VALUE(-1);
+		return -1;
 	}
 	link->refcnt++;
 	up(&acpi_link_lock);
@@ -657,7 +641,7 @@ acpi_pci_link_allocate_irq(acpi_handle h
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Link %s is referenced\n",
 			  acpi_device_bid(link->device)));
-	return_VALUE(link->irq.active);
+	return link->irq.active;
 }
 
 /*
@@ -670,25 +654,23 @@ int acpi_pci_link_free_irq(acpi_handle h
 	struct acpi_pci_link *link = NULL;
 	acpi_status result;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_free_irq");
-
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
 		ACPI_ERROR((AE_INFO, "Invalid link device"));
-		return_VALUE(-1);
+		return -1;
 	}
 
 	link = (struct acpi_pci_link *)acpi_driver_data(device);
 	if (!link) {
 		ACPI_ERROR((AE_INFO, "Invalid link context"));
-		return_VALUE(-1);
+		return -1;
 	}
 
 	down(&acpi_link_lock);
 	if (!link->irq.initialized) {
 		up(&acpi_link_lock);
 		ACPI_ERROR((AE_INFO, "Link isn't initialized"));
-		return_VALUE(-1);
+		return -1;
 	}
 #ifdef	FUTURE_USE
 	/*
@@ -710,7 +692,7 @@ int acpi_pci_link_free_irq(acpi_handle h
 		acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
 	}
 	up(&acpi_link_lock);
-	return_VALUE(link->irq.active);
+	return link->irq.active;
 }
 
 /* --------------------------------------------------------------------------
@@ -724,14 +706,12 @@ static int acpi_pci_link_add(struct acpi
 	int i = 0;
 	int found = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_add");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	link = kmalloc(sizeof(struct acpi_pci_link), GFP_KERNEL);
 	if (!link)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(link, 0, sizeof(struct acpi_pci_link));
 
 	link->device = device;
@@ -780,17 +760,15 @@ static int acpi_pci_link_add(struct acpi
 	if (result)
 		kfree(link);
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_pci_link_resume(struct acpi_pci_link *link)
 {
-	ACPI_FUNCTION_TRACE("acpi_pci_link_resume");
-
 	if (link->refcnt && link->irq.active && link->irq.initialized)
-		return_VALUE(acpi_pci_link_set(link, link->irq.active));
+		return acpi_pci_link_set(link, link->irq.active);
 	else
-		return_VALUE(0);
+		return 0;
 }
 
 /*
@@ -803,8 +781,6 @@ static int irqrouter_resume(struct sys_d
 	struct list_head *node = NULL;
 	struct acpi_pci_link *link = NULL;
 
-	ACPI_FUNCTION_TRACE("irqrouter_resume");
-
 	acpi_in_resume = 1;
 	list_for_each(node, &acpi_link.entries) {
 		link = list_entry(node, struct acpi_pci_link, node);
@@ -815,17 +791,15 @@ static int irqrouter_resume(struct sys_d
 		acpi_pci_link_resume(link);
 	}
 	acpi_in_resume = 0;
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_pci_link_remove(struct acpi_device *device, int type)
 {
 	struct acpi_pci_link *link = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_remove");
-
 	if (!device || !acpi_driver_data(device))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	link = (struct acpi_pci_link *)acpi_driver_data(device);
 
@@ -835,7 +809,7 @@ static int acpi_pci_link_remove(struct a
 
 	kfree(link);
 
-	return_VALUE(0);
+	return 0;
 }
 
 /*
@@ -941,34 +915,30 @@ static int __init irqrouter_init_sysfs(v
 {
 	int error;
 
-	ACPI_FUNCTION_TRACE("irqrouter_init_sysfs");
-
 	if (acpi_disabled || acpi_noirq)
-		return_VALUE(0);
+		return 0;
 
 	error = sysdev_class_register(&irqrouter_sysdev_class);
 	if (!error)
 		error = sysdev_register(&device_irqrouter);
 
-	return_VALUE(error);
+	return error;
 }
 
 device_initcall(irqrouter_init_sysfs);
 
 static int __init acpi_pci_link_init(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_pci_link_init");
-
 	if (acpi_noirq)
-		return_VALUE(0);
+		return 0;
 
 	acpi_link.count = 0;
 	INIT_LIST_HEAD(&acpi_link.entries);
 
 	if (acpi_bus_register_driver(&acpi_pci_link_driver) < 0)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
-	return_VALUE(0);
+	return 0;
 }
 
 subsys_initcall(acpi_pci_link_init);
---
0.99.9.GIT


