From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: [PATCH] ACPI drop back to pic mode -- linux-2.6.0-test2-acpi-picmode.patch
Date: Wed, 30 Jul 2003 21:00:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307302100.01386.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Patrick Dreker <patrick-G8S07CpUG8qzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi, this is my patch which detects problems in APIC mode and drops back to PIC mode. I've 
tested this on my system and my laptop by hacking APIC mode to fail. Seems to be fine.

To apply:
Grab linux-2.6.0-test2
Apply the latest interim ACPI patch from http://sf.net/projects/acpi
Apply linux-2.6.0-test2-acpi-picmode.patch
See if it works!

Any probs, let me know.
I'll do a backport to 2.4 in the next few days. Will be posted to the acpi-devel list.


-- CUT HERE ---
--- linux-2.6.0-test2.acpi-20030730/arch/i386/kernel/io_apic.c	2003-07-30 19:52:13.000000000 +0100
+++ linux-2.6.0-test2/arch/i386/kernel/io_apic.c	2003-07-30 19:58:12.000000000 +0100
@@ -2363,7 +2363,7 @@
 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq, edge_level, active_high_low);
 
 	if (edge_level) {
-	irq_desc[irq].handler = &ioapic_level_irq_type;
+		irq_desc[irq].handler = &ioapic_level_irq_type;
 	} else {
 		irq_desc[irq].handler = &ioapic_edge_irq_type;
 	}
--- linux-2.6.0-test2.acpi-20030730/arch/i386/kernel/mpparse.c	2003-07-30 19:52:13.000000000 +0100
+++ linux-2.6.0-test2/arch/i386/kernel/mpparse.c	2003-07-30 20:24:40.000000000 +0100
@@ -1072,10 +1072,11 @@
 
 #ifdef CONFIG_ACPI_PCI
 
-void __init mp_parse_prt (void)
+int __init mp_parse_prt (void)
 {
 	struct list_head	*node = NULL;
 	struct acpi_prt_entry	*entry = NULL;
+ 	struct acpi_prt_list	*prt_list = NULL;
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
 	int			irq = 0;
@@ -1083,18 +1084,32 @@
 	int			edge_level = 0;
 	int			active_high_low = 0;
 
+ 	/* Get the current PRT */
+ 	prt_list = acpi_pci_get_prt_list();
+   
+ 	if (!prt_list->count) {
+ 		acpi_pci_destroy_prt_list(prt_list);
+ 		printk(KERN_WARNING PREFIX "ACPI tables contain no IO-APIC PCI IRQ "
+ 			"routing entries\n");
+ 		return_VALUE(-ENODEV);
+ 	}
+       
 	/*
 	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
 	 * routing for all entries.
 	 */
-	list_for_each(node, &acpi_prt.entries) {
+	list_for_each(node, &prt_list->entries) {
 		entry = list_entry(node, struct acpi_prt_entry, node);
 
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
 			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
-			if (!irq)
-				continue;
+ 			if (irq < 0) {
+ 				acpi_pci_destroy_prt_list(prt_list);
+ 				return -ENODEV;
+ 			}
+  			if (!irq) 
+  				continue;
 		}
 		else {
 			/* Hardwired IRQ. Assume PCI standard settings */
@@ -1145,6 +1160,11 @@
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin, 
 			entry->irq);
 	}
+
+ 	/* if we get here, the PRT was fine. commit it */
+ 	acpi_pci_commit_prt_list(prt_list);
+    
+ 	return 0;
 }
 
 #endif /*CONFIG_ACPI_PCI*/
--- linux-2.6.0-test2.acpi-20030730/arch/i386/kernel/pic.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test2/arch/i386/kernel/pic.c	2003-07-30 19:53:58.000000000 +0100
@@ -0,0 +1,77 @@
+/* ----------------------------------------------------------------------- *
+ *   
+ *   Copyright 2003 Andrew de Quincey - All Rights Reserved
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version; incorporated herein by reference.
+ *
+ * ----------------------------------------------------------------------- */
+
+#include <linux/mm.h>
+#include <linux/irq.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/config.h>
+#include <linux/bootmem.h>
+#include <linux/smp_lock.h>
+#include <linux/kernel_stat.h>
+
+#include <asm/acpi.h>
+
+#ifdef CONFIG_ACPI_PCI
+
+int __init pic_parse_prt (void)
+{
+	struct list_head	*node = NULL;
+	struct acpi_prt_entry	*entry = NULL;
+	struct acpi_prt_list	*prt_list = NULL;
+	int			edge_level = 0;
+	int			active_high_low = 0;
+	int			irq = 0;
+
+	/* Get the current PRT */
+	prt_list = acpi_pci_get_prt_list();
+   
+	if (!prt_list->count) {
+		acpi_pci_destroy_prt_list(prt_list);
+		printk(KERN_WARNING PREFIX "ACPI tables contain no PIC PCI IRQ "
+			"routing entries\n");
+		return_VALUE(-ENODEV);
+	}
+   
+	/*
+	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
+	 * IRQs if necessary.
+	 */
+	list_for_each(node, &prt_list->entries) {
+		entry = list_entry(node, struct acpi_prt_entry, node);
+
+		/* Need to get irq for dynamic entry */
+		if (entry->link.handle) {
+			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
+			if (irq < 0) {
+				acpi_pci_destroy_prt_list(prt_list);
+				return -ENODEV;
+			}
+ 			if (!irq) 
+				continue;
+		}
+		entry->irq = irq;
+
+		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> IRQ %d\n",
+			entry->id.segment, entry->id.bus, 
+			entry->id.device, ('A' + entry->pin), 
+			entry->irq);
+	}
+	
+	/* if we get here, the PRT was fine. commit it */
+	acpi_pci_commit_prt_list(prt_list);
+   
+	return 0;
+}
+
+#endif /*CONFIG_ACPI_PCI*/
--- linux-2.6.0-test2.acpi-20030730/drivers/acpi/pci_irq.c	2003-07-30 19:52:13.000000000 +0100
+++ linux-2.6.0-test2/drivers/acpi/pci_irq.c	2003-07-30 20:43:29.000000000 +0100
@@ -48,7 +48,23 @@
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME		("pci_irq")
 
-struct acpi_prt_list		acpi_prt;
+struct acpi_prt_list*		acpi_prt = NULL;
+
+
+struct acpi_prt_ref {
+	struct list_head	node;
+	struct acpi_device	*device;
+	acpi_handle		handle;
+	int segment;
+	int bus;
+};
+
+struct acpi_prt_ref_list {
+	int			count;
+	struct list_head	entries;
+};				
+
+struct acpi_prt_ref_list acpi_prt_ref_list;
 
 #ifdef CONFIG_X86
 extern void eisa_set_level_irq(unsigned int irq);
@@ -71,13 +87,19 @@
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_find_prt_entry");
 
+	/* ensure we're not called before the routing table has been determined */
+	if (acpi_prt == NULL) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Called before acpi_prt determined"));
+		return_PTR(NULL);
+ 	}	
+   
 	/*
 	 * Parse through all PRT entries looking for a match on the specified
 	 * PCI device's segment, bus, device, and pin (don't care about func).
 	 *
 	 * TBD: Acquire/release lock
 	 */
-	list_for_each(node, &acpi_prt.entries) {
+	list_for_each(node, &acpi_prt->entries) {
 		entry = list_entry(node, struct acpi_prt_entry, node);
 		if ((segment == entry->id.segment) 
 			&& (bus == entry->id.bus) 
@@ -93,6 +115,7 @@
 
 static int
 acpi_pci_irq_add_entry (
+	struct acpi_prt_list*		prt_list,
 	acpi_handle			handle,
 	int				segment,
 	int				bus,
@@ -149,34 +172,137 @@
 		('A' + entry->pin), prt->source, entry->link.index));
 
 	/* TBD: Acquire/release lock */
-	list_add_tail(&entry->node, &acpi_prt.entries);
-	acpi_prt.count++;
+	list_add_tail(&entry->node, &prt_list->entries);
+	prt_list->count++;
 
 	return_VALUE(0);
 }
 
 
+struct acpi_prt_list*
+acpi_pci_get_prt_list (void)
+{
+	acpi_status			status = AE_OK;
+	struct acpi_buffer		buffer = {0, NULL};
+	struct acpi_pci_routing_table	*prt = NULL;
+	struct acpi_pci_routing_table	*entry = NULL;
+	struct acpi_prt_list		*prt_list = NULL;
+	struct acpi_prt_ref		*prt_ref_entry = NULL;
+	struct list_head		*node = NULL;
+   
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_get_prt_list");
+   
+	/* Create a brand new acpi_prt_list */
+	prt_list = kmalloc(sizeof(struct acpi_prt_list), GFP_KERNEL);
+	if (!prt_list)
+		return_PTR(NULL);
+	memset(prt_list, 0, sizeof(struct acpi_prt_list));
+   
+	prt_list->count = 0;
+	INIT_LIST_HEAD(&prt_list->entries);
+   
+	/* iterate over all entries in acpi_prt_ref_list, extracting the current _PRT entries */
+	list_for_each(node, &acpi_prt_ref_list.entries) {
+		prt_ref_entry = list_entry(node, struct acpi_prt_ref, node);
+   
+		/* 
+		 * Evaluate this _PRT and add its entries to our local list (prt_list).
+		 */
+
+		buffer.length = 0;
+		buffer.pointer = NULL;
+		status = acpi_get_irq_routing_table(prt_ref_entry->handle, &buffer);
+		if (status != AE_BUFFER_OVERFLOW) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
+				acpi_format_exception(status)));
+			kfree(prt_list);
+			return_PTR(NULL);
+		}
+
+		prt = kmalloc(buffer.length, GFP_KERNEL);
+		if (!prt) {
+			kfree(prt_list);
+			return_VALUE(NULL);
+		}
+		memset(prt, 0, buffer.length);
+		buffer.pointer = prt;
+
+		status = acpi_get_irq_routing_table(prt_ref_entry->handle, &buffer);
+		if (ACPI_FAILURE(status)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
+				acpi_format_exception(status)));
+			kfree(buffer.pointer);
+			kfree(prt_list);
+			return_PTR(NULL);
+		}
+
+		entry = prt;
+
+		while (entry && (entry->length > 0)) {
+			acpi_pci_irq_add_entry(prt_list, prt_ref_entry->handle, prt_ref_entry->segment, 
+				prt_ref_entry->bus, entry);
+			entry = (struct acpi_pci_routing_table *)
+				((unsigned long) entry + entry->length);
+		}
+
+		kfree(prt);
+	}
+
+	return_PTR(prt_list);
+}
+
+int 
+acpi_pci_destroy_prt_list (struct acpi_prt_list* prt_list) {
+	struct list_head	*node = NULL;
+	struct list_head	*tmp = NULL;
+	struct acpi_prt_entry	*entry = NULL;
+   
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_destroy_prt_list");
+
+	list_for_each_safe(node, tmp, &prt_list->entries) {
+		entry = list_entry(node, struct acpi_prt_entry, node);
+		list_del(node);
+		kfree(entry);
+	}
+	kfree(prt_list);
+   
+	return_VALUE(0);
+}	  
+  
+int
+acpi_pci_commit_prt_list (struct acpi_prt_list* prt_list) {
+
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_commit_prt_list");
+   
+	if (acpi_prt != NULL) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Attempt to commit acpi_prt twice\n"));
+		return_VALUE(-ENODEV);
+	}
+
+	acpi_prt = prt_list;
+	return_VALUE(0);
+}	  
+   
 int
 acpi_pci_irq_add_prt (
 	acpi_handle		handle,
 	int			segment,
 	int			bus)
 {
-	acpi_status			status = AE_OK;
-	char				pathname[ACPI_PATHNAME_MAX] = {0};
-	struct acpi_buffer		buffer = {0, NULL};
-	struct acpi_pci_routing_table	*prt = NULL;
-	struct acpi_pci_routing_table	*entry = NULL;
-	static int			first_time = 1;
+	static int		first_time = 1;
+	struct acpi_prt_ref	*entry = NULL;
+	struct acpi_buffer	buffer = {0, NULL};
+	char			pathname[ACPI_PATHNAME_MAX] = {0};
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_add_prt");
 
 	if (first_time) {
-		acpi_prt.count = 0;
-		INIT_LIST_HEAD(&acpi_prt.entries);
+		acpi_prt_ref_list.count = 0;
+		INIT_LIST_HEAD(&acpi_prt_ref_list.entries);
 		first_time = 0;
 	}
 
+   
 	/* 
 	 * NOTE: We're given a 'handle' to the _PRT object's parent device
 	 *       (either a PCI root bridge or PCI-PCI bridge).
@@ -189,47 +315,23 @@
 	printk(KERN_DEBUG "ACPI: PCI Interrupt Routing Table [%s._PRT]\n",
 		pathname);
 
-	/* 
-	 * Evaluate this _PRT and add its entries to our global list (acpi_prt).
-	 */
-
-	buffer.length = 0;
-	buffer.pointer = NULL;
-	status = acpi_get_irq_routing_table(handle, &buffer);
-	if (status != AE_BUFFER_OVERFLOW) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
-			acpi_format_exception(status)));
-		return_VALUE(-ENODEV);
-	}
-
-	prt = kmalloc(buffer.length, GFP_KERNEL);
-	if (!prt)
+   
+   
+	entry = kmalloc(sizeof(struct acpi_prt_ref), GFP_KERNEL);
+	if (!entry)
 		return_VALUE(-ENOMEM);
-	memset(prt, 0, buffer.length);
-	buffer.pointer = prt;
+	memset(entry, 0, sizeof(struct acpi_prt_ref));
+   
+	entry->handle = handle;
+	entry->segment = segment;
+	entry->bus = bus;
 
-	status = acpi_get_irq_routing_table(handle, &buffer);
-	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
-			acpi_format_exception(status)));
-		kfree(buffer.pointer);
-		return_VALUE(-ENODEV);
-	}
-
-	entry = prt;
-
-	while (entry && (entry->length > 0)) {
-		acpi_pci_irq_add_entry(handle, segment, bus, entry);
-		entry = (struct acpi_pci_routing_table *)
-			((unsigned long) entry + entry->length);
-	}
-
-	kfree(prt);
+	list_add_tail(&entry->node, &acpi_prt_ref_list.entries);
+	acpi_prt_ref_list.count++;
 
 	return_VALUE(0);
 }
 
-
 /* --------------------------------------------------------------------------
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
@@ -383,6 +485,12 @@
 	return_VALUE(dev->irq);
 }
 
+static void __init acpi_irq_pic_mode(void)
+{
+	acpi_irq_model = ACPI_IRQ_MODEL_PIC;
+	acpi_bus_init_irq();
+}
+   
 
 int __init
 acpi_pci_irq_init (void)
@@ -391,27 +499,26 @@
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_init");
 
-	if (!acpi_prt.count) {
-		printk(KERN_WARNING PREFIX "ACPI tables contain no PCI IRQ "
-			"routing entries\n");
-		return_VALUE(-ENODEV);
-	}
-
-	/* Make sure all link devices have a valid IRQ. */
-	if (acpi_pci_link_check()) {
-		return_VALUE(-ENODEV);
-	}
+ 	/* Calculate IRQ penalties for each link device */
+ 	acpi_pci_link_calc_penalties();
 
 #ifdef CONFIG_X86_IO_APIC
 	/* Program IOAPICs using data from PRT entries. */
 	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC)
-		mp_parse_prt();
+ 		if (mp_parse_prt()) 
+ 			acpi_irq_pic_mode();
 #endif
 #ifdef CONFIG_IOSAPIC
 	if (acpi_irq_model == ACPI_IRQ_MODEL_IOSAPIC)
-		iosapic_parse_prt();
+ 		if (iosapic_parse_prt())
+ 			acpi_irq_pic_mode();
 #endif
 
+ 	/* This one is last, as a catchall */
+ 	if (acpi_irq_model == ACPI_IRQ_MODEL_PIC)
+ 		if (pic_parse_prt()) 
+ 			return_VALUE(-ENODEV);
+ 
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 		acpi_pci_irq_enable(dev);
 
--- linux-2.6.0-test2.acpi-20030730/drivers/acpi/pci_link.c	2003-07-30 19:52:13.000000000 +0100
+++ linux-2.6.0-test2/drivers/acpi/pci_link.c	2003-07-30 20:47:43.000000000 +0100
@@ -325,6 +325,7 @@
 	if (irq <= 15) {
 		resource.res.id = ACPI_RSTYPE_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
+  		resource.res.data.irq.shared_exclusive = ACPI_SHARED;
 		resource.res.data.irq.edge_level = link->irq.edge_level;
 		resource.res.data.irq.active_high_low = link->irq.active_high_low;
 		resource.res.data.irq.number_of_interrupts = 1;
@@ -334,6 +335,7 @@
 		resource.res.id = ACPI_RSTYPE_EXT_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.extended_irq.producer_consumer = ACPI_CONSUMER;
+  		resource.res.data.extended_irq.shared_exclusive = ACPI_SHARED;
 		resource.res.data.extended_irq.edge_level = link->irq.edge_level;
 		resource.res.data.extended_irq.active_high_low = link->irq.active_high_low;
 		resource.res.data.extended_irq.number_of_interrupts = 1;
@@ -410,7 +412,7 @@
 
 
 int
-acpi_pci_link_check (void)
+acpi_pci_link_calc_penalties (void)
 {
 	struct list_head	*node = NULL;
 	struct acpi_pci_link    *link = NULL;
@@ -458,18 +460,18 @@
 		irq = link->irq.possible[0];
 	}
 
-		/* 
-		 * Select the best IRQ.  This is done in reverse to promote 
-		 * the use of IRQs 9, 10, 11, and >15.
-		 */
-		for (i=(link->irq.possible_count-1); i>0; i--) {
-			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
-				irq = link->irq.possible[i];
-		}
+	/* 
+	 * Select the best IRQ.  This is done in reverse to promote 
+	 * the use of IRQs 9, 10, 11, and >15.
+	 */
+	for (i=(link->irq.possible_count-1); i>0; i--) {
+		if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
+			irq = link->irq.possible[i];
+	}
 
 	/* Attempt to enable the link device at this IRQ. */
 	if (acpi_pci_link_set(link, irq)) {
-		printk(PREFIX "Unable to set IRQ for %s [%s] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off\n",
+		printk(PREFIX "Unable to set IRQ for %s [%s] (likely buggy ACPI BIOS, please report!).\n",
 			acpi_device_name(link->device),
 			acpi_device_bid(link->device));
 		return_VALUE(-ENODEV);
--- linux-2.6.0-test2.acpi-20030730/include/acpi/acpi_drivers.h	2003-07-30 19:52:13.000000000 +0100
+++ linux-2.6.0-test2/include/acpi/acpi_drivers.h	2003-07-30 20:05:38.000000000 +0100
@@ -26,6 +26,9 @@
 #ifndef __ACPI_DRIVERS_H__
 #define __ACPI_DRIVERS_H__
 
+/* forward definitions */
+struct acpi_prt_list;
+
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 
@@ -59,12 +62,15 @@
 
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
-int acpi_pci_link_check (void);
+int acpi_pci_link_calc_penalties (void);
 int acpi_pci_link_get_irq (acpi_handle handle, int index, int* edge_level, int* active_high_low);
 
 /* ACPI PCI Interrupt Routing (pci_irq.c) */
 
 int acpi_pci_irq_add_prt (acpi_handle handle, int segment, int bus);
+int acpi_pci_commit_prt_list (struct acpi_prt_list* prt_list);
+int acpi_pci_destroy_prt_list (struct acpi_prt_list* prt_list);
+struct acpi_prt_list* acpi_pci_get_prt_list (void);
 
 /* ACPI PCI Device Binding (pci_bind.c) */
 
--- linux-2.6.0-test2.acpi-20030730/include/asm-i386/mpspec.h	2003-07-27 17:55:53.000000000 +0100
+++ linux-2.6.0-test2/include/asm-i386/mpspec.h	2003-07-30 19:54:00.000000000 +0100
@@ -38,7 +38,7 @@
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 global_irq);
 extern void mp_config_acpi_legacy_irqs (void);
 extern void mp_config_ioapic_for_sci(int irq);
-extern void mp_parse_prt (void);
+extern int mp_parse_prt (void);
 #endif /*CONFIG_ACPI_BOOT*/
 
 #endif
--- linux-2.6.0-test2.acpi-20030730/include/linux/acpi.h	2003-07-27 17:55:56.000000000 +0100
+++ linux-2.6.0-test2/include/linux/acpi.h	2003-07-30 19:54:00.000000000 +0100
@@ -394,7 +394,7 @@
 	struct list_head	entries;
 };
 
-extern struct acpi_prt_list	acpi_prt;
+extern struct acpi_prt_list*	acpi_prt;
 
 struct pci_dev;
 
--- linux-2.6.0-test2.acpi-20030730/include/acpi/acpi_bus.h	2003-07-27 18:01:06.000000000 +0100
+++ linux-2.6.0-test2/include/acpi/acpi_bus.h	2003-07-30 19:54:00.000000000 +0100
@@ -308,6 +308,8 @@
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
+int acpi_bus_init_irq (void);
+
 #endif /*CONFIG_ACPI_BUS*/
 
 #endif /*__ACPI_BUS_H__*/
--- linux-2.6.0-test2.acpi-20030730/drivers/acpi/bus.c	2003-07-27 18:03:55.000000000 +0100
+++ linux-2.6.0-test2/drivers/acpi/bus.c	2003-07-30 19:54:00.000000000 +0100
@@ -536,7 +536,7 @@
                              Initialization/Cleanup
    -------------------------------------------------------------------------- */
 
-static int __init
+int 
 acpi_bus_init_irq (void)
 {
 	acpi_status		status = AE_OK;
--- linux-2.6.0-test2.acpi-20030730/arch/i386/kernel/Makefile	2003-07-27 17:57:50.000000000 +0100
+++ linux-2.6.0-test2/arch/i386/kernel/Makefile	2003-07-30 19:54:00.000000000 +0100
@@ -7,7 +7,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o
+		doublefault.o pic.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
-- CUT HERE ---



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
