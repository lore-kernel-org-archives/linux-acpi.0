From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: i386 PCI IRQ parameters patch #3
Date: Tue, 15 Jul 2003 10:28:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307151028.28017.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8k8E/X8lncxzpv4"
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


--Boundary-00=_8k8E/X8lncxzpv4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, this is the next in my iteration of PCI IRQ parameters patches.

This one adds:
1) Correct setting of IRQ parameters
2) Enforces strict checks during ACPI-based PCI link device setup. If anything 
odd is found, it aborts ACPI-based IRQ routing (drops back to the default 
strategy).

Basically, there are several calls used during pci link setup which I'm now 
checking for failure on:
 
I'm now calling acpi_pci_link_get_current() before calling _SRS from 
pci_link.c/acpi_pci_link_set(). This is to check if the ACPI has somehow 
disabled a device, but not assigned it an IRQ.... (pci_link_get_current() 
already returns an error in this case). Now, for some BIOSes, this may work 
fine, but for others (e.g. Jurriaan's KT400 board), this is the only warning 
we get that ACPI-based routing is duff. Probably best to play it safe.

I've enforced the check in pci_link.c/acpi_pci_link_check() so that if the IRQ 
that was set is not the IRQ that was requested ACPI-based IRQ routing is 
aborted.

Oh, it also prints a nice error message warning about a potential buggy BIOS 
so we can track down problem boards from user feedback.

I also had experimented with trying to reprogram any IRQs I setup before 
detecting a problem... but on my board, this proved impossible.

So with this patch, it should detect more buggy BIOSes, and drop back to 
non-ACPI routing if it finds one.

I agree that these buggy boards should be blacklisted, but from the user's 
point of view, thats kinda after the fact if their board is not yet in the 
list; its already crashed for "mysterious" reasons.

--Boundary-00=_8k8E/X8lncxzpv4
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.5.75-acpi-irqparams-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.5.75-acpi-irqparams-3.patch"

diff -Naurb linux-2.5.75.orig/arch/i386/kernel/io_apic.c linux-2.5.75/arch/i386/kernel/io_apic.c
--- linux-2.5.75.orig/arch/i386/kernel/io_apic.c	2003-07-10 21:07:34.000000000 +0100
+++ linux-2.5.75/arch/i386/kernel/io_apic.c	2003-07-13 23:53:12.000000000 +0100
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
 
diff -Naurb linux-2.5.75.orig/arch/i386/kernel/mpparse.c linux-2.5.75/arch/i386/kernel/mpparse.c
--- linux-2.5.75.orig/arch/i386/kernel/mpparse.c	2003-07-10 21:06:59.000000000 +0100
+++ linux-2.5.75/arch/i386/kernel/mpparse.c	2003-07-14 22:31:00.000000000 +0100
@@ -1065,7 +1065,7 @@
 
 	ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
 
-	io_apic_set_pci_routing(ioapic, ioapic_pin, irq);
+	io_apic_set_pci_routing(ioapic, ioapic_pin, irq, 1, 1); // Active low, edge triggered
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
diff -Naurb linux-2.5.75.orig/drivers/acpi/pci_irq.c linux-2.5.75/drivers/acpi/pci_irq.c
--- linux-2.5.75.orig/drivers/acpi/pci_irq.c	2003-07-10 21:08:54.000000000 +0100
+++ linux-2.5.75/drivers/acpi/pci_irq.c	2003-07-15 02:56:11.000000000 +0100
@@ -249,7 +249,7 @@
 	}
 
 	if (!entry->irq && entry->link.handle) {
-		entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
+		entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, NULL, NULL);
 		if (!entry->irq) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
 			return_VALUE(0);
@@ -389,7 +389,9 @@
 	}
 
 	/* Make sure all link devices have a valid IRQ. */
-	acpi_pci_link_check();
+	if (acpi_pci_link_check()) {
+		return_VALUE(-ENODEV);
+	}
 
 #ifdef CONFIG_X86_IO_APIC
 	/* Program IOAPICs using data from PRT entries. */
diff -Naurb linux-2.5.75.orig/drivers/acpi/pci_link.c linux-2.5.75/drivers/acpi/pci_link.c
--- linux-2.5.75.orig/drivers/acpi/pci_link.c	2003-07-10 21:04:58.000000000 +0100
+++ linux-2.5.75/drivers/acpi/pci_link.c	2003-07-15 10:04:35.000000000 +0100
@@ -69,6 +69,8 @@
 
 struct acpi_pci_link_irq {
 	u8			active;			/* Current IRQ */
+	u8			edge_level;		/* All IRQs */
+	u8			active_high_low;	/* All IRQs */
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
@@ -333,6 +341,14 @@
 	}
 	resource.end.id = ACPI_RSTYPE_END_TAG;
 
+	/* Try and get the current assignment. If there is an error here, this implies there are bugs in the ACPI implementation
+	   We're going to opt for the safest option, and abort using ACPI as a PCI routing mechanism */
+	result = acpi_pci_link_get_current(link);
+	if (result) {
+		return_VALUE(result);
+	}
+
+	/* Attempt to set the resource */
 	status = acpi_set_current_resources(link->handle, &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SRS\n"));
@@ -455,15 +471,20 @@
 				irq = link->irq.possible[i];
 		}
 
-		/* Enable the link device at this IRQ. */
-		acpi_pci_link_set(link, irq);
-
+		/* Attempt to enable the link device at this IRQ. */
+		if (acpi_pci_link_set(link, irq)) {
+			printk(PREFIX "Unable to set IRQ for %s [%s] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing.\n",
+				acpi_device_name(link->device),
+				acpi_device_bid(link->device));
+			return_VALUE(-ENODEV);
+		} else {
 		acpi_irq_penalty[link->irq.active] += 100;
 
 		printk(PREFIX "%s [%s] enabled at IRQ %d\n", 
 			acpi_device_name(link->device),
 			acpi_device_bid(link->device), link->irq.active);
 	}
+	}
 
 	return_VALUE(0);
 }
@@ -472,7 +493,9 @@
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
@@ -503,6 +526,8 @@
 		return_VALUE(0);
 	}

+        if (edge_level) *edge_level = link->irq.edge_level;
+        if (active_high_low) *active_high_low = link->irq.active_high_low;
 	return_VALUE(link->irq.active);
 }

diff -Naurb linux-2.5.75.orig/include/acpi/acpi_drivers.h linux-2.5.75/include/acpi/acpi_drivers.h
--- linux-2.5.75.orig/include/acpi/acpi_drivers.h	2003-07-10 21:12:26.000000000 +0100
+++ linux-2.5.75/include/acpi/acpi_drivers.h	2003-07-13 22:21:05.000000000 +0100
@@ -60,7 +60,7 @@
 /* ACPI PCI Interrupt Link (pci_link.c) */

 int acpi_pci_link_check (void);
-int acpi_pci_link_get_irq (acpi_handle handle, int index);
+int acpi_pci_link_get_irq (acpi_handle handle, int index, int* edge_level, int* active_high_low);

 /* ACPI PCI Interrupt Routing (pci_irq.c) */

diff -Naurb linux-2.5.75.orig/include/asm-i386/io_apic.h linux-2.5.75/include/asm-i386/io_apic.h
--- linux-2.5.75.orig/include/asm-i386/io_apic.h	2003-07-10 21:12:15.000000000 +0100
+++ linux-2.5.75/include/asm-i386/io_apic.h	2003-07-13 22:21:05.000000000 +0100
@@ -170,7 +170,7 @@
 extern int io_apic_get_unique_id (int ioapic, int apic_id);
 extern int io_apic_get_version (int ioapic);
 extern int io_apic_get_redir_entries (int ioapic);
-extern int io_apic_set_pci_routing (int ioapic, int pin, int irq);
+extern int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge_level, int active_high_low);
 #endif /*CONFIG_ACPI_BOOT*/

 #else  /* !CONFIG_X86_IO_APIC */

--Boundary-00=_8k8E/X8lncxzpv4--



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
