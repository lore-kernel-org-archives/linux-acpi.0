From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: [Patch] IRQ parameters patch #2
Date: Tue, 15 Jul 2003 00:31:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307150031.25604.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_N1zE/tpxegxk6X5"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_N1zE/tpxegxk6X5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch is for 2.5.75. It adds some more fixes for setting correct IRQ 
parameters.


--Boundary-00=_N1zE/tpxegxk6X5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.5.75-acpi-irqparams-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.5.75-acpi-irqparams-2.patch"

diff -Naurb linux-2.5.74.orig/arch/i386/kernel/io_apic.c linux-2.5.74/arch/i386/kernel/io_apic.c
--- linux-2.5.74.orig/arch/i386/kernel/io_apic.c	2003-07-02 21:45:05.000000000 +0100
+++ linux-2.5.74/arch/i386/kernel/io_apic.c	2003-07-13 21:57:58.000000000 +0100
@@ -2313,7 +2313,7 @@
 }
 
 
-int io_apic_set_pci_routing (int ioapic, int pin, int irq)
+int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge_level, int active_high_low)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
@@ -2336,18 +2336,22 @@
 	entry.dest_mode = INT_DEST_MODE;
 	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
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
 
+        if (edge_level) {
 	irq_desc[irq].handler = &ioapic_level_irq_type;
+	} else {
+	        irq_desc[irq].handler = &ioapic_edge_irq_type;
+	}
 
 	set_intr_gate(entry.vector, interrupt[irq]);
 
diff -Naurb linux-2.5.74.orig/arch/i386/kernel/mpparse.c linux-2.5.74/arch/i386/kernel/mpparse.c
--- linux-2.5.74.orig/arch/i386/kernel/mpparse.c	2003-07-02 21:44:31.000000000 +0100
+++ linux-2.5.74/arch/i386/kernel/mpparse.c	2003-07-13 22:02:46.000000000 +0100
@@ -1065,7 +1065,7 @@
 
 	ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
 
-	io_apic_set_pci_routing(ioapic, ioapic_pin, irq);
+	io_apic_set_pci_routing(ioapic, ioapic_pin, irq, 1, 1); // Active low, level triggered
 }
 
 #endif /*CONFIG_ACPI_HT_ONLY*/
@@ -1080,6 +1080,8 @@
 	int			ioapic_pin = 0;
 	int			irq = 0;
 	int			idx, bit = 0;
+        int                     edge_level = 0;
+        int                     active_high_low = 0;
 
 	/*
 	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
@@ -1090,7 +1092,7 @@
 
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
-			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
+			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
 			if (!irq)
 				continue;
 		}
@@ -1130,7 +1132,7 @@
 
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
-		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq))
+		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active_high_low))
 			entry->irq = irq;
 
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
diff -Naurb linux-2.5.74.orig/drivers/acpi/pci_irq.c linux-2.5.74/drivers/acpi/pci_irq.c
--- linux-2.5.74.orig/drivers/acpi/pci_irq.c	2003-07-02 21:46:52.000000000 +0100
+++ linux-2.5.74/drivers/acpi/pci_irq.c	2003-07-13 21:50:53.000000000 +0100
@@ -249,7 +249,7 @@
 	}
 
 	if (!entry->irq && entry->link.handle) {
-		entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
+		entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, NULL, NULL);
 		if (!entry->irq) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
 			return_VALUE(0);
diff -Naurb linux-2.5.74.orig/include/acpi/acpi_drivers.h linux-2.5.74/include/acpi/acpi_drivers.h
--- linux-2.5.74.orig/include/acpi/acpi_drivers.h	2003-07-02 21:51:42.000000000 +0100
+++ linux-2.5.74/include/acpi/acpi_drivers.h	2003-07-13 21:27:40.000000000 +0100
@@ -60,7 +60,7 @@
 /* ACPI PCI Interrupt Link (pci_link.c) */

 int acpi_pci_link_check (void);
-int acpi_pci_link_get_irq (acpi_handle handle, int index);
+int acpi_pci_link_get_irq (acpi_handle handle, int index, int* edge_level, int* active_high_low);

 /* ACPI PCI Interrupt Routing (pci_irq.c) */

diff -Naurb linux-2.5.74.orig/include/asm-i386/io_apic.h linux-2.5.74/include/asm-i386/io_apic.h
--- linux-2.5.74.orig/include/asm-i386/io_apic.h	2003-07-02 21:50:49.000000000 +0100
+++ linux-2.5.74/include/asm-i386/io_apic.h	2003-07-13 21:35:32.000000000 +0100
@@ -170,7 +170,7 @@
 extern int io_apic_get_unique_id (int ioapic, int apic_id);
 extern int io_apic_get_version (int ioapic);
 extern int io_apic_get_redir_entries (int ioapic);
-extern int io_apic_set_pci_routing (int ioapic, int pin, int irq);
+extern int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge_level, int active_high_low);
 #endif /*CONFIG_ACPI_BOOT*/
 
 #else  /* !CONFIG_X86_IO_APIC */
--- linux-2.5.75.orig/drivers/acpi/pci_link.c	2003-07-10 21:04:58.000000000 +0100
+++ linux-2.5.75/drivers/acpi/pci_link.c	2003-07-14 01:47:08.000000000 +0100
@@ -69,6 +69,8 @@
 
 struct acpi_pci_link_irq {
 	u8			active;			/* Current IRQ */
+   	u8			edge_level;		/* All IRQs */
+   	u8			active_high_low;	/* All IRQs */
 	u8			possible_count;
 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
 };
@@ -118,6 +120,8 @@
 			link->irq.possible[i] = p->interrupts[i];
 			link->irq.possible_count++;
 		}
+	        link->irq.edge_level = p->edge_level;
+   	        link->irq.active_high_low = p->active_high_low;
 		break;
 	}
 	case ACPI_RSTYPE_EXT_IRQ:
@@ -136,6 +140,8 @@
 			link->irq.possible[i] = p->interrupts[i];
 			link->irq.possible_count++;
 		}
+	        link->irq.edge_level = p->edge_level;
+   	        link->irq.active_high_low = p->active_high_low;
 		break;
 	}
 	default:
@@ -310,12 +316,14 @@
 
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
@@ -324,8 +332,8 @@
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
@@ -472,7 +480,9 @@
 int
 acpi_pci_link_get_irq (
 	acpi_handle		handle,
-	int			index)
+	int			index,
+	int*                    edge_level,
+       	int*                    active_high_low)
 {
 	int                     result = 0;
 	struct acpi_device	*device = NULL;
@@ -503,6 +513,8 @@
 		return_VALUE(0);
 	}
 
+        if (edge_level) *edge_level = link->irq.edge_level;
+        if (active_high_low) *active_high_low = link->irq.active_high_low;
 	return_VALUE(link->irq.active);
 }
 

--Boundary-00=_N1zE/tpxegxk6X5--



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
