From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: [PATCH] Various ACPI IRQ fixes required for nforce2 chipset -- linux-2.4.22-pre9-acpi-irqparams-final5.patch
Date: Tue, 29 Jul 2003 22:19:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307292219.51986.adq_dvb@lidskialf.net>
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
List-Id: linux-acpi@vger.kernel.org

Hi, this is my patch backported to 2.4.22-pre9. I've left out the /proc/irq/io_apic 
for the moment. I think we do need something like that though, to aid with debugging. Anyone 
got any opinions?

Tested on my nforce2 board: all hardware is functional.


---CUT HERE---
--- linux-2.4.22-pre9.orig/arch/i386/kernel/io_apic.c	2003-07-29 21:42:23.000000000 +0100
+++ linux-2.4.22-pre9/arch/i386/kernel/io_apic.c	2003-07-29 22:00:38.000000000 +0100
@@ -1806,7 +1806,7 @@
 }
 
 
-int io_apic_set_pci_routing (int ioapic, int pin, int irq)
+int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge_level, int active_high_low)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
@@ -1829,18 +1829,22 @@
 	entry.dest_mode = INT_DELIVERY_MODE;
 	entry.dest.logical.logical_dest = target_cpus();
 	entry.mask = 1;					 /* Disabled (masked) */
-	entry.trigger = 1;				   /* Level sensitive */
-	entry.polarity = 1;					/* Low active */
+	entry.trigger = edge_level;
+	entry.polarity = active_high_low;
 
 	add_pin_to_irq(irq, ioapic, pin);
 
 	entry.vector = assign_irq_vector(irq);
 
 	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
-		"IRQ %d)\n", ioapic, 
-		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
+		"IRQ %d Mode:%i Active:%i)\n", ioapic,
+		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq, edge_level, active_high_low);
 
+	if (edge_level) {
 	irq_desc[irq].handler = &ioapic_level_irq_type;
+	} else {
+		irq_desc[irq].handler = &ioapic_edge_irq_type;
+	}
 
 	set_intr_gate(entry.vector, interrupt[irq]);
 
--- linux-2.4.22-pre9.orig/arch/i386/kernel/mpparse.c	2003-07-29 21:42:23.000000000 +0100
+++ linux-2.4.22-pre9/arch/i386/kernel/mpparse.c	2003-07-29 21:44:52.000000000 +0100
@@ -1249,7 +1249,7 @@
 
 	ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
 
-	io_apic_set_pci_routing(ioapic, ioapic_pin, irq);
+	io_apic_set_pci_routing(ioapic, ioapic_pin, irq, 1, 1); // Active low, edge triggered
 }
 
 
@@ -1263,6 +1263,8 @@
 	int			ioapic_pin = 0;
 	int			irq = 0;
 	int			idx, bit = 0;
+	int			edge_level = 0;
+	int			active_high_low = 0;
 
 	/*
 	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
@@ -1273,12 +1275,16 @@
 
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
-			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
+			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
 			if (!irq)
 				continue;
 		}
-		else
+		else {
+			/* Hardwired IRQ. Assume PCI standard settings */
 			irq = entry->link.index;
+			edge_level = 1;
+			active_high_low = 1;
+		}
 
 		/* Don't set up the ACPI SCI because it's already set up */
 		if (acpi_fadt.sci_int == irq)
@@ -1311,7 +1317,7 @@
 
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
-		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq))
+		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active_high_low))
 			entry->irq = irq;
 
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
@@ -1321,6 +1327,9 @@
 			entry->irq);
 	}
 	
+
+        
+   
 	return;
 }
 
--- linux-2.4.22-pre9.orig/drivers/acpi/pci_irq.c	2003-07-29 21:42:28.000000000 +0100
+++ linux-2.4.22-pre9/drivers/acpi/pci_irq.c	2003-07-29 21:44:52.000000000 +0100
@@ -253,7 +253,7 @@
 	}
 
 	if (!entry->irq && entry->link.handle) {
-		entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
+		entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, NULL, NULL);
 		if (!entry->irq) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
 			return_VALUE(0);
@@ -392,7 +392,9 @@
 	}
 
 	/* Make sure all link devices have a valid IRQ. */
-	acpi_pci_link_check();
+	if (acpi_pci_link_check()) {
+		return_VALUE(-ENODEV);
+	}
 
 #ifdef CONFIG_X86_IO_APIC
 	/* Program IOAPICs using data from PRT entries. */
--- linux-2.4.22-pre9.orig/drivers/acpi/pci_link.c	2003-07-29 21:42:28.000000000 +0100
+++ linux-2.4.22-pre9/drivers/acpi/pci_link.c	2003-07-29 22:10:04.000000000 +0100
@@ -65,6 +65,9 @@
 
 struct acpi_pci_link_irq {
 	u8			active;			/* Current IRQ */
+	u8			edge_level;		/* All IRQs */
+	u8			active_high_low;	/* All IRQs */
+	u8			setonboot;
 	u8			possible_count;
 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
 };
@@ -114,6 +117,8 @@
 			link->irq.possible[i] = p->interrupts[i];
 			link->irq.possible_count++;
 		}
+		link->irq.edge_level = p->edge_level;
+		link->irq.active_high_low = p->active_high_low;
 		break;
 	}
 	case ACPI_RSTYPE_EXT_IRQ:
@@ -132,6 +137,8 @@
 			link->irq.possible[i] = p->interrupts[i];
 			link->irq.possible_count++;
 		}
+		link->irq.edge_level = p->edge_level;
+		link->irq.active_high_low = p->active_high_low;
 		break;
 	}
 	default:
@@ -260,7 +267,6 @@
 	 * IRQ a boot-enabled Link device is set to is the correct one.
 	 * (Required to support systems such as the Toshiba 5005-S504.)
 	 */
-
 	link->irq.active = irq;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link at IRQ %d \n", link->irq.active));
@@ -290,6 +296,8 @@
 	if (!link || !irq)
 		return_VALUE(-EINVAL);
 
+	/* We don't check irqs the first time round */
+	if (link->irq.setonboot) {
 	/* See if we're already at the target IRQ. */
 	if (irq == link->irq.active)
 		return_VALUE(0);
@@ -303,15 +311,18 @@
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Target IRQ %d invalid\n", irq));
 		return_VALUE(-EINVAL);
 	}
+	}
 
 	memset(&resource, 0, sizeof(resource));
 
-	/* NOTE: PCI interrupts are always level / active_low / shared. */
+	/* NOTE: PCI interrupts are always level / active_low / shared. But not all
+	   interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ definition for 
+	   parameters */
 	if (irq <= 15) {
 		resource.res.id = ACPI_RSTYPE_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
-		resource.res.data.irq.edge_level = ACPI_LEVEL_SENSITIVE;
-		resource.res.data.irq.active_high_low = ACPI_ACTIVE_LOW;
+		resource.res.data.irq.edge_level = link->irq.edge_level;
+		resource.res.data.irq.active_high_low = link->irq.active_high_low;
 		resource.res.data.irq.shared_exclusive = ACPI_SHARED;
 		resource.res.data.irq.number_of_interrupts = 1;
 		resource.res.data.irq.interrupts[0] = irq;
@@ -320,8 +331,8 @@
 		resource.res.id = ACPI_RSTYPE_EXT_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.extended_irq.producer_consumer = ACPI_CONSUMER;
-		resource.res.data.extended_irq.edge_level = ACPI_LEVEL_SENSITIVE;
-		resource.res.data.extended_irq.active_high_low = ACPI_ACTIVE_LOW;
+		resource.res.data.extended_irq.edge_level = link->irq.edge_level;
+		resource.res.data.extended_irq.active_high_low = link->irq.active_high_low;
 		resource.res.data.extended_irq.shared_exclusive = ACPI_SHARED;
 		resource.res.data.extended_irq.number_of_interrupts = 1;
 		resource.res.data.extended_irq.interrupts[0] = irq;
@@ -329,6 +340,7 @@
 	}
 	resource.end.id = ACPI_RSTYPE_END_TAG;
 
+	/* Attempt to set the resource */
 	status = acpi_set_current_resources(link->handle, &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SRS\n"));
@@ -351,11 +363,13 @@
 	if (result) {
 		return_VALUE(result);
 	}
+   
 	if (link->irq.active != irq) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
 			"Attempt to enable at IRQ %d resulted in IRQ %d\n", 
 			irq, link->irq.active));
 		link->irq.active = 0;
+		acpi_ut_evaluate_object (link->handle, "_DIS", 0, NULL);	   
 		return_VALUE(-ENODEV);
 	}
 
@@ -403,7 +417,7 @@
 	ACPI_FUNCTION_TRACE("acpi_pci_link_check");
 
 	/*
-	 * Pass #1: Update penalties to facilitate IRQ balancing.
+	 * Update penalties to facilitate IRQ balancing.
 	 */
 	list_for_each(node, &acpi_link.entries) {
 
@@ -424,23 +438,23 @@
 		}
 	}
 
-	/*
-	 * Pass #2: Enable boot-disabled Links at 'best' IRQ.
-	 */
-	list_for_each(node, &acpi_link.entries) {
-		int		irq = 0;
-		int		i = 0;
+	return_VALUE(0);
+}
 
-		link = list_entry(node, struct acpi_pci_link, node);
-		if (!link || !link->irq.possible_count) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
-			continue;
-		}
+static int acpi_pci_link_allocate(struct acpi_pci_link* link) {
+	int irq;
+	int i;
 
-		if (link->irq.active)
-			continue;
+	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
 
+	if (link->irq.setonboot)
+		return_VALUE(0);
+
+	if (link->irq.active) {
+		irq = link->irq.active;
+	} else {
 		irq = link->irq.possible[0];
+	}
 
 		/* 
 		 * Select the best IRQ.  This is done in reverse to promote 
@@ -451,16 +465,20 @@
 				irq = link->irq.possible[i];
 		}
 
-		/* Enable the link device at this IRQ. */
-		acpi_pci_link_set(link, irq);
-
+	/* Attempt to enable the link device at this IRQ. */
+	if (acpi_pci_link_set(link, irq)) {
+		printk(PREFIX "Unable to set IRQ for %s [%s] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off\n",
+			acpi_device_name(link->device),
+			acpi_device_bid(link->device));
+		return_VALUE(-ENODEV);
+	} else {
 		acpi_irq_penalty[link->irq.active] += 100;
-
 		printk(PREFIX "%s [%s] enabled at IRQ %d\n", 
 			acpi_device_name(link->device),
 			acpi_device_bid(link->device), link->irq.active);
 	}
 
+	link->irq.setonboot = 1;
 	return_VALUE(0);
 }
 
@@ -468,7 +486,9 @@
 int
 acpi_pci_link_get_irq (
 	acpi_handle		handle,
-	int			index)
+	int			index,
+	int*			edge_level,
+	int*			active_high_low)
 {
 	int                     result = 0;
 	struct acpi_device	*device = NULL;
@@ -494,11 +514,17 @@
 		return_VALUE(0);
 	}
 
+	if (acpi_pci_link_allocate(link)) {
+		return -ENODEV;
+	}
+	   
 	if (!link->irq.active) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link disabled\n"));
 		return_VALUE(0);
 	}
 
+	if (edge_level) *edge_level = link->irq.edge_level;
+	if (active_high_low) *active_high_low = link->irq.active_high_low;
 	return_VALUE(link->irq.active);
 }
 
--- linux-2.4.22-pre9.orig/include/acpi/acpi_drivers.h	2003-07-29 21:42:34.000000000 +0100
+++ linux-2.4.22-pre9/include/acpi/acpi_drivers.h	2003-07-29 21:49:01.000000000 +0100
@@ -174,7 +174,7 @@
 #define ACPI_PCI_LINK_FILE_STATUS	"state"
 
 int acpi_pci_link_check (void);
-int acpi_pci_link_get_irq (acpi_handle handle, int index);
+int acpi_pci_link_get_irq (acpi_handle handle, int index, int* edge_level, int* active_high_low);
 int acpi_pci_link_init (void);
 void acpi_pci_link_exit (void);
 
--- linux-2.4.22-pre9.orig/include/asm-i386/io_apic.h	2003-07-29 21:42:35.000000000 +0100
+++ linux-2.4.22-pre9/include/asm-i386/io_apic.h	2003-07-29 21:57:10.000000000 +0100
@@ -144,7 +144,7 @@
 extern int io_apic_get_unique_id (int ioapic, int apic_id);
 extern int io_apic_get_version (int ioapic);
 extern int io_apic_get_redir_entries (int ioapic);
-extern int io_apic_set_pci_routing (int ioapic, int pin, int irq);
+extern int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge_level, int active_high_low);
 #endif
 
 #else  /* !CONFIG_X86_IO_APIC */
---CUT HERE---



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
