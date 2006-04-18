From: mochel@linux.intel.com
Subject: [PATCH 14/24] Remove unneeded debugging macros in drivers/acpi/pci_irq.c
Date: Mon, 17 Apr 2006 18:21:54 -0700
Message-ID: <1145323314280-git-send-email-mochel@linux.intel.com>
References: <1145323314724-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:64696 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932122AbWDRBZZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:25 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PPlA026789
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:25 GMT
In-Reply-To: <1145323314724-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/pci_irq.c |   72 ++++++++++++++++++------------------------------
 1 files changed, 27 insertions(+), 45 deletions(-)

applies-to: a00ab78b8bcab09c3d99811aa5e191da2026aea1
fb4fe7cf714659783f58ea8512d458f92ccc2a58
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 4cabc51..f8ceab6 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -55,8 +55,6 @@ static struct acpi_prt_entry *acpi_pci_i
 	struct list_head *node = NULL;
 	struct acpi_prt_entry *entry = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_irq_find_prt_entry");
-
 	if (!acpi_prt.count)
 		return_PTR(NULL);
 
@@ -87,14 +85,12 @@ acpi_pci_irq_add_entry(acpi_handle handl
 {
 	struct acpi_prt_entry *entry = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_irq_add_entry");
-
 	if (!prt)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	entry = kmalloc(sizeof(struct acpi_prt_entry), GFP_KERNEL);
 	if (!entry)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(entry, 0, sizeof(struct acpi_prt_entry));
 
 	entry->id.segment = segment;
@@ -141,7 +137,7 @@ acpi_pci_irq_add_entry(acpi_handle handl
 	acpi_prt.count++;
 	spin_unlock(&acpi_prt_lock);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void
@@ -163,11 +159,9 @@ int acpi_pci_irq_add_prt(acpi_handle han
 	struct acpi_pci_routing_table *entry = NULL;
 	static int first_time = 1;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_irq_add_prt");
-
 	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(pathname, 0, ACPI_PATHNAME_MAX);
 
 	if (first_time) {
@@ -199,12 +193,12 @@ int acpi_pci_irq_add_prt(acpi_handle han
 	if (status != AE_BUFFER_OVERFLOW) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRT [%s]",
 				acpi_format_exception(status)));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	prt = kmalloc(buffer.length, GFP_KERNEL);
 	if (!prt) {
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	}
 	memset(prt, 0, buffer.length);
 	buffer.pointer = prt;
@@ -214,7 +208,7 @@ int acpi_pci_irq_add_prt(acpi_handle han
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRT [%s]",
 				acpi_format_exception(status)));
 		kfree(buffer.pointer);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	entry = prt;
@@ -227,7 +221,7 @@ int acpi_pci_irq_add_prt(acpi_handle han
 
 	kfree(prt);
 
-	return_VALUE(0);
+	return 0;
 }
 
 void acpi_pci_irq_del_prt(int segment, int bus)
@@ -262,8 +256,6 @@ acpi_pci_allocate_irq(struct acpi_prt_en
 {
 	int irq;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_allocate_irq");
-
 	if (entry->link.handle) {
 		irq = acpi_pci_link_allocate_irq(entry->link.handle,
 						 entry->link.index, triggering,
@@ -271,7 +263,7 @@ acpi_pci_allocate_irq(struct acpi_prt_en
 		if (irq < 0) {
 			ACPI_WARNING((AE_INFO,
 				      "Invalid IRQ link routing entry"));
-			return_VALUE(-1);
+			return -1;
 		}
 	} else {
 		irq = entry->link.index;
@@ -280,7 +272,7 @@ acpi_pci_allocate_irq(struct acpi_prt_en
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found IRQ %d\n", irq));
-	return_VALUE(irq);
+	return irq;
 }
 
 static int
@@ -289,13 +281,12 @@ acpi_pci_free_irq(struct acpi_prt_entry 
 {
 	int irq;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_free_irq");
 	if (entry->link.handle) {
 		irq = acpi_pci_link_free_irq(entry->link.handle);
 	} else {
 		irq = entry->link.index;
 	}
-	return_VALUE(irq);
+	return irq;
 }
 
 /*
@@ -315,8 +306,6 @@ acpi_pci_irq_lookup(struct pci_bus *bus,
 	int bus_nr = bus->number;
 	int ret;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_irq_lookup");
-
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Searching for PRT entry for %02x:%02x:%02x[%c]\n",
 			  segment, bus_nr, device, ('A' + pin)));
@@ -324,11 +313,11 @@ acpi_pci_irq_lookup(struct pci_bus *bus,
 	entry = acpi_pci_irq_find_prt_entry(segment, bus_nr, device, pin);
 	if (!entry) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PRT entry not found\n"));
-		return_VALUE(-1);
+		return -1;
 	}
 
 	ret = func(entry, triggering, polarity, link);
-	return_VALUE(ret);
+	return ret;
 }
 
 /*
@@ -346,10 +335,8 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 	int irq = -1;
 	u8 bridge_pin = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_irq_derive");
-
 	if (!dev)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/* 
 	 * Attempt to derive an IRQ for this device from a parent bridge's
@@ -366,7 +353,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "No interrupt pin configured for device %s\n",
 						  pci_name(bridge)));
-				return_VALUE(-1);
+				return -1;
 			}
 			/* Pin is from 0 to 3 */
 			bridge_pin--;
@@ -381,13 +368,13 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 	if (irq < 0) {
 		ACPI_WARNING((AE_INFO, "Unable to derive IRQ for device %s",
 			      pci_name(dev)));
-		return_VALUE(-1);
+		return -1;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derive IRQ %d for device %s from %s\n",
 			  irq, pci_name(dev), pci_name(bridge)));
 
-	return_VALUE(irq);
+	return irq;
 }
 
 /*
@@ -405,23 +392,21 @@ int acpi_pci_irq_enable(struct pci_dev *
 	char *link = NULL;
 	int rc;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_irq_enable");
-
 	if (!dev)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	pin = dev->pin;
 	if (!pin) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "No interrupt pin configured for device %s\n",
 				  pci_name(dev)));
-		return_VALUE(0);
+		return 0;
 	}
 	pin--;
 
 	if (!dev->bus) {
 		ACPI_ERROR((AE_INFO, "Invalid (NULL) 'bus' field"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	/* 
@@ -453,10 +438,10 @@ int acpi_pci_irq_enable(struct pci_dev *
 			printk(" - using IRQ %d\n", dev->irq);
 			acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE,
 					  ACPI_ACTIVE_LOW);
-			return_VALUE(0);
+			return 0;
 		} else {
 			printk("\n");
-			return_VALUE(0);
+			return 0;
 		}
 	}
 
@@ -464,7 +449,7 @@ int acpi_pci_irq_enable(struct pci_dev *
 	if (rc < 0) {
 		printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: failed "
 		       "to register GSI\n", pci_name(dev), ('A' + pin));
-		return_VALUE(rc);
+		return rc;
 	}
 	dev->irq = rc;
 
@@ -478,7 +463,7 @@ int acpi_pci_irq_enable(struct pci_dev *
 	       (triggering == ACPI_LEVEL_SENSITIVE) ? "level" : "edge",
 	       (polarity == ACPI_ACTIVE_LOW) ? "low" : "high", dev->irq);
 
-	return_VALUE(0);
+	return 0;
 }
 
 EXPORT_SYMBOL(acpi_pci_irq_enable);
@@ -495,14 +480,12 @@ void acpi_pci_irq_disable(struct pci_dev
 	int triggering = ACPI_LEVEL_SENSITIVE;
 	int polarity = ACPI_ACTIVE_LOW;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_irq_disable");
-
 	if (!dev || !dev->bus)
-		return_VOID;
+		return;
 
 	pin = dev->pin;
 	if (!pin)
-		return_VOID;
+		return;
 	pin--;
 
 	/*
@@ -520,7 +503,7 @@ void acpi_pci_irq_disable(struct pci_dev
 					  &triggering, &polarity, NULL,
 					  acpi_pci_free_irq);
 	if (gsi < 0)
-		return_VOID;
+		return;
 
 	/*
 	 * TBD: It might be worth clearing dev->irq by magic constant
@@ -532,5 +515,4 @@ void acpi_pci_irq_disable(struct pci_dev
 
 	acpi_unregister_gsi(gsi);
 
-	return_VOID;
 }
---
0.99.9.GIT


