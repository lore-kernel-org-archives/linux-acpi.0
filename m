From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] 3 of 6 use global_irq to refer to ACPI global IRQs
Date: Tue, 9 Mar 2004 16:26:04 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403091626.04892.bjorn.helgaas@hp.com>
References: <200403091619.04333.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200403091619.04333.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

i386, x86_64: Use "global_irq", not "irq", when referring to ACPI global IRQs

In mpparse.c, rename "irq" to "global_irq" to make it clear
these are ACPI global IRQs, not the usual Linux IRQs.

diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Tue Mar  9 15:25:27 2004
+++ b/arch/i386/kernel/mpparse.c	Tue Mar  9 15:25:27 2004
@@ -851,18 +851,18 @@
 
 
 static int __init mp_find_ioapic (
-	int			irq)
+	int			global_irq)
 {
 	int			i = 0;
 
-	/* Find the IOAPIC that manages this IRQ. */
+	/* Find the IOAPIC that manages this global IRQ. */
 	for (i = 0; i < nr_ioapics; i++) {
-		if ((irq >= mp_ioapic_routing[i].irq_start)
-			&& (irq <= mp_ioapic_routing[i].irq_end))
+		if ((global_irq >= mp_ioapic_routing[i].irq_start)
+			&& (global_irq <= mp_ioapic_routing[i].irq_end))
 			return i;
 	}
 
-	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for IRQ %d\n", irq);
+	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for global IRQ %d\n", global_irq);
 
 	return -1;
 }
@@ -906,7 +906,7 @@
 		io_apic_get_redir_entries(idx);
 
 	printk("IOAPIC[%d]: apic_id %d, version %d, address 0x%lx, "
-		"IRQ %d-%d\n", idx, mp_ioapics[idx].mpc_apicid, 
+		"global IRQ %d-%d\n", idx, mp_ioapics[idx].mpc_apicid, 
 		mp_ioapics[idx].mpc_apicver, mp_ioapics[idx].mpc_apicaddr,
 		mp_ioapic_routing[idx].irq_start,
 		mp_ioapic_routing[idx].irq_end);
@@ -1029,7 +1029,7 @@
 
 extern FADT_DESCRIPTOR acpi_fadt;
 
-void __init mp_config_ioapic_for_sci(int irq)
+void __init mp_config_ioapic_for_sci(int global_irq)
 {
 	int ioapic;
 	int ioapic_pin;
@@ -1076,11 +1076,11 @@
 	 */
 	flags = entry->flags;
 	acpi_fadt.sci_int = entry->global_irq;
-	irq = entry->global_irq;
+	global_irq = entry->global_irq;
 
-	ioapic = mp_find_ioapic(irq);
+	ioapic = mp_find_ioapic(global_irq);
 
-	ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
+	ioapic_pin = global_irq - mp_ioapic_routing[ioapic].irq_start;
 
 	/*
 	 * MPS INTI flags:
@@ -1088,7 +1088,7 @@
 	 *  polarity: 0=default, 1=high, 3=low
 	 * Per ACPI spec, default for SCI means level/low.
 	 */
-	io_apic_set_pci_routing(ioapic, ioapic_pin, irq, 
+	io_apic_set_pci_routing(ioapic, ioapic_pin, global_irq, 
 		(flags.trigger == 1 ? 0 : 1), (flags.polarity == 1 ? 0 : 1));
 }
 
@@ -1100,7 +1100,7 @@
 	struct acpi_prt_entry	*entry = NULL;
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
-	int			irq = 0;
+	int			global_irq = 0;
 	int			idx, bit = 0;
 	int			edge_level = 0;
 	int			active_high_low = 0;
@@ -1114,32 +1114,32 @@
 
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
-			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
-			if (!irq)
+			global_irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
+			if (!global_irq)
 				continue;
 		}
 		else {
 			/* Hardwired IRQ. Assume PCI standard settings */
-			irq = entry->link.index;
+			global_irq = entry->link.index;
 			edge_level = 1;
 			active_high_low = 1;
 		}
 
 		/* Don't set up the ACPI SCI because it's already set up */
-                if (acpi_fadt.sci_int == irq) {
-			irq = acpi_irq_to_vector(irq);
-			entry->irq = irq; /* we still need to set entry's irq */
+                if (acpi_fadt.sci_int == global_irq) {
+			global_irq = acpi_irq_to_vector(global_irq);
+			entry->irq = global_irq; /* we still need to set entry's irq */
 			continue;
                 }
 	
-		ioapic = mp_find_ioapic(irq);
+		ioapic = mp_find_ioapic(global_irq);
 		if (ioapic < 0)
 			continue;
-		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
+		ioapic_pin = global_irq - mp_ioapic_routing[ioapic].irq_start;
 
 		if (es7000_plat) {
-			if (!ioapic && (irq < 16))
-				irq += 16;
+			if (!ioapic && (global_irq < 16))
+				global_irq += 16;
 		}
 
 		/* 
@@ -1158,14 +1158,14 @@
 		if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 			Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 				mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
-			entry->irq = acpi_irq_to_vector(irq);
+			entry->irq = acpi_irq_to_vector(global_irq);
 			continue;
 		}
 
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
-		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active_high_low)) {
-			entry->irq = acpi_irq_to_vector(irq);
+		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, global_irq, edge_level, active_high_low)) {
+			entry->irq = acpi_irq_to_vector(global_irq);
 		}
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
 			entry->id.segment, entry->id.bus,
diff -Nru a/arch/x86_64/kernel/mpparse.c b/arch/x86_64/kernel/mpparse.c
--- a/arch/x86_64/kernel/mpparse.c	Tue Mar  9 15:25:27 2004
+++ b/arch/x86_64/kernel/mpparse.c	Tue Mar  9 15:25:27 2004
@@ -697,18 +697,18 @@
 
 
 static int __init mp_find_ioapic (
-	int			irq)
+	int			global_irq)
 {
 	int			i = 0;
 
-	/* Find the IOAPIC that manages this IRQ. */
+	/* Find the IOAPIC that manages this global IRQ. */
 	for (i = 0; i < nr_ioapics; i++) {
-		if ((irq >= mp_ioapic_routing[i].irq_start)
-			&& (irq <= mp_ioapic_routing[i].irq_end))
+		if ((global_irq >= mp_ioapic_routing[i].irq_start)
+			&& (global_irq <= mp_ioapic_routing[i].irq_end))
 			return i;
 	}
 
-	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for IRQ %d\n", irq);
+	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for global IRQ %d\n", global_irq);
 
 	return -1;
 }
@@ -752,7 +752,7 @@
 		io_apic_get_redir_entries(idx);
 
 	printk(KERN_INFO "IOAPIC[%d]: apic_id %d, version %d, address 0x%x, "
-		"IRQ %d-%d\n", idx, mp_ioapics[idx].mpc_apicid, 
+		"global IRQ %d-%d\n", idx, mp_ioapics[idx].mpc_apicid, 
 		mp_ioapics[idx].mpc_apicver, mp_ioapics[idx].mpc_apicaddr,
 		mp_ioapic_routing[idx].irq_start,
 		mp_ioapic_routing[idx].irq_end);
@@ -878,7 +878,7 @@
 
 extern FADT_DESCRIPTOR acpi_fadt;
 
-void __init mp_config_ioapic_for_sci(int irq)
+void __init mp_config_ioapic_for_sci(int global_irq)
 {
 	int ioapic;
 	int ioapic_pin;
@@ -925,11 +925,11 @@
 	 */
 	flags = entry->flags;
 	acpi_fadt.sci_int = entry->global_irq;
-	irq = entry->global_irq;
+	global_irq = entry->global_irq;
 
-	ioapic = mp_find_ioapic(irq);
+	ioapic = mp_find_ioapic(global_irq);
 
-	ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
+	ioapic_pin = global_irq - mp_ioapic_routing[ioapic].irq_start;
 
 	/*
 	 * MPS INTI flags:
@@ -937,7 +937,7 @@
 	 *  polarity: 0=default, 1=high, 3=low
 	 * Per ACPI spec, default for SCI means level/low.
 	 */
-	io_apic_set_pci_routing(ioapic, ioapic_pin, irq, 
+	io_apic_set_pci_routing(ioapic, ioapic_pin, global_irq, 
 		(flags.trigger == 1 ? 0 : 1), (flags.polarity == 1 ? 0 : 1));
 }
 
@@ -949,7 +949,7 @@
 	struct acpi_prt_entry	*entry = NULL;
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
-	int			irq = 0;
+	int			global_irq = 0;
 	int			idx, bit = 0;
 	int			edge_level = 0;
 	int			active_high_low = 0;
@@ -963,24 +963,24 @@
 
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
-			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
-			if (!irq)
+			global_irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
+			if (!global_irq)
 				continue;
 		} else {
 			/* Hardwired IRQ. Assume PCI standard settings */
-			irq = entry->link.index;
+			global_irq = entry->link.index;
 			edge_level = 1;
 			active_high_low = 1;
 		}
 
 		/* Don't set up the ACPI SCI because it's already set up */
-		if (acpi_fadt.sci_int == irq)
+		if (acpi_fadt.sci_int == global_irq)
 			continue;
 
-		ioapic = mp_find_ioapic(irq);
+		ioapic = mp_find_ioapic(global_irq);
 		if (ioapic < 0)
 			continue;
-		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
+		ioapic_pin = global_irq - mp_ioapic_routing[ioapic].irq_start;
 
 		/* 
 		 * Avoid pin reprogramming.  PRTs typically include entries  
@@ -998,13 +998,13 @@
 		if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 			Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 				mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
-			entry->irq = acpi_irq_to_vector(irq);
+			entry->irq = acpi_irq_to_vector(global_irq);
 			continue;
 		}
 
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
-		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active_high_low)) {
-			entry->irq = acpi_irq_to_vector(irq);
+		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, global_irq, edge_level, active_high_low)) {
+			entry->irq = acpi_irq_to_vector(global_irq);
 		}
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
 			entry->id.segment, entry->id.bus,



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
