From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] clean up ACPI GSI/IRQ conversions (i386 part)
Date: Fri, 12 Mar 2004 15:48:39 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403121548.39784.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, David Mosberger <davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

OK, here's a third try.  I had obviously taken leave of my senses when
I posted a whole series of trivial patches that touched three different
architectures, plus ACPI, all in one intertwined mess.  Sorry.

For this round of patches, I have one for each architecture that adds
the new interfaces and uses them in the arch-specific code (as well as
converting arch-specific names from "irq" or "global_irq" to "gsi").

After all the architecture patches are in, I'll post the ACPI patch
to make it use the new interfaces, and finally, I'll clean up the
now-unused old interfaces.

These changes have been compiled on i386, x86_64, and ia64, both with
and without the eventual ACPI patch (and with and without MSI support,
for i386).

(If you're coming in late, the point of this exercise is to remove
the #ifdefs from acpi_os_install_interrupt_handler() by adding a
new acpi_gsi_to_irq() interface that each architecture will implement.)

Here's the i386 patch, against 2.6.4:

Add "acpi_gsi_to_irq()" as a generic replacement for "acpi_irq_to_vector()".
This converts from an ACPI global system interrupt number to a Linux IRQ.
Also, convert i386-specific terminology to use GSI when appropriate.

===== arch/i386/kernel/mpparse.c 1.66 vs edited =====
--- 1.66/arch/i386/kernel/mpparse.c	Wed Feb 25 22:11:46 2004
+++ edited/arch/i386/kernel/mpparse.c	Fri Mar 12 11:46:49 2004
@@ -1,5 +1,5 @@
 /*
- *	Intel Multiprocessor Specificiation 1.1 and 1.4
+ *	Intel Multiprocessor Specification 1.1 and 1.4
  *	compliant MP-table parsing routines.
  *
  *	(c) 1995 Alan Cox, Building #3 <alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
@@ -844,25 +844,25 @@
 
 struct mp_ioapic_routing {
 	int			apic_id;
-	int			irq_start;
-	int			irq_end;
+	int			gsi_base;
+	int			gsi_end;
 	u32			pin_programmed[4];
 } mp_ioapic_routing[MAX_IO_APICS];
 
 
 static int __init mp_find_ioapic (
-	int			irq)
+	int			gsi)
 {
 	int			i = 0;
 
-	/* Find the IOAPIC that manages this IRQ. */
+	/* Find the IOAPIC that manages this GSI. */
 	for (i = 0; i < nr_ioapics; i++) {
-		if ((irq >= mp_ioapic_routing[i].irq_start)
-			&& (irq <= mp_ioapic_routing[i].irq_end))
+		if ((gsi >= mp_ioapic_routing[i].gsi_base)
+			&& (gsi <= mp_ioapic_routing[i].gsi_end))
 			return i;
 	}
 
-	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for IRQ %d\n", irq);
+	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for GSI %d\n", gsi);
 
 	return -1;
 }
@@ -871,7 +871,7 @@
 void __init mp_register_ioapic (
 	u8			id, 
 	u32			address,
-	u32			irq_base)
+	u32			gsi_base)
 {
 	int			idx = 0;
 
@@ -897,19 +897,19 @@
 	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
 	
 	/* 
-	 * Build basic IRQ lookup table to facilitate irq->io_apic lookups
-	 * and to prevent reprogramming of IOAPIC pins (PCI IRQs).
+	 * Build basic GSI lookup table to facilitate gsi->io_apic lookups
+	 * and to prevent reprogramming of IOAPIC pins (PCI GSIs).
 	 */
 	mp_ioapic_routing[idx].apic_id = mp_ioapics[idx].mpc_apicid;
-	mp_ioapic_routing[idx].irq_start = irq_base;
-	mp_ioapic_routing[idx].irq_end = irq_base + 
+	mp_ioapic_routing[idx].gsi_base = gsi_base;
+	mp_ioapic_routing[idx].gsi_end = gsi_base + 
 		io_apic_get_redir_entries(idx);
 
 	printk("IOAPIC[%d]: apic_id %d, version %d, address 0x%lx, "
-		"IRQ %d-%d\n", idx, mp_ioapics[idx].mpc_apicid, 
+		"GSI %d-%d\n", idx, mp_ioapics[idx].mpc_apicid, 
 		mp_ioapics[idx].mpc_apicver, mp_ioapics[idx].mpc_apicaddr,
-		mp_ioapic_routing[idx].irq_start,
-		mp_ioapic_routing[idx].irq_end);
+		mp_ioapic_routing[idx].gsi_base,
+		mp_ioapic_routing[idx].gsi_end);
 
 	return;
 }
@@ -919,7 +919,7 @@
 	u8			bus_irq,
 	u8			polarity, 
 	u8			trigger, 
-	u32			global_irq)
+	u32			gsi)
 {
 	struct mpc_config_intsrc intsrc;
 	int			i = 0;
@@ -928,12 +928,12 @@
 	int			pin = -1;
 
 	/* 
-	 * Convert 'global_irq' to 'ioapic.pin'.
+	 * Convert 'gsi' to 'ioapic.pin'.
 	 */
-	ioapic = mp_find_ioapic(global_irq);
+	ioapic = mp_find_ioapic(gsi);
 	if (ioapic < 0)
 		return;
-	pin = global_irq - mp_ioapic_routing[ioapic].irq_start;
+	pin = gsi - mp_ioapic_routing[ioapic].gsi_base;
 
 	/*
 	 * TBD: This check is for faulty timer entries, where the override
@@ -958,7 +958,7 @@
 
 	/* 
 	 * If an existing [IOAPIC.PIN -> IRQ] routing entry exists we override it.
-	 * Otherwise create a new entry (e.g. global_irq == 2).
+	 * Otherwise create a new entry (e.g. gsi == 2).
 	 */
 	for (i = 0; i < mp_irq_entries; i++) {
 		if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus) 
@@ -1029,7 +1029,7 @@
 
 extern FADT_DESCRIPTOR acpi_fadt;
 
-void __init mp_config_ioapic_for_sci(int irq)
+void __init mp_config_ioapic_for_sci(u32 gsi)
 {
 	int ioapic;
 	int ioapic_pin;
@@ -1076,11 +1076,11 @@
 	 */
 	flags = entry->flags;
 	acpi_fadt.sci_int = entry->global_irq;
-	irq = entry->global_irq;
+	gsi = entry->global_irq;
 
-	ioapic = mp_find_ioapic(irq);
+	ioapic = mp_find_ioapic(gsi);
 
-	ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
+	ioapic_pin = gsi - mp_ioapic_routing[ioapic].gsi_base;
 
 	/*
 	 * MPS INTI flags:
@@ -1088,7 +1088,7 @@
 	 *  polarity: 0=default, 1=high, 3=low
 	 * Per ACPI spec, default for SCI means level/low.
 	 */
-	io_apic_set_pci_routing(ioapic, ioapic_pin, irq, 
+	io_apic_set_pci_routing(ioapic, ioapic_pin, gsi, 
 		(flags.trigger == 1 ? 0 : 1), (flags.polarity == 1 ? 0 : 1));
 }
 
@@ -1100,7 +1100,7 @@
 	struct acpi_prt_entry	*entry = NULL;
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
-	int			irq = 0;
+	int			gsi = 0;
 	int			idx, bit = 0;
 	int			edge_level = 0;
 	int			active_high_low = 0;
@@ -1112,39 +1112,39 @@
 	list_for_each(node, &acpi_prt.entries) {
 		entry = list_entry(node, struct acpi_prt_entry, node);
 
-		/* Need to get irq for dynamic entry */
+		/* Need to get gsi for dynamic entry */
 		if (entry->link.handle) {
-			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
-			if (!irq)
+			gsi = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
+			if (!gsi)
 				continue;
 		}
 		else {
-			/* Hardwired IRQ. Assume PCI standard settings */
-			irq = entry->link.index;
+			/* Hardwired GSI. Assume PCI standard settings */
+			gsi = entry->link.index;
 			edge_level = 1;
 			active_high_low = 1;
 		}
 
 		/* Don't set up the ACPI SCI because it's already set up */
-                if (acpi_fadt.sci_int == irq) {
-			irq = acpi_irq_to_vector(irq);
-			entry->irq = irq; /* we still need to set entry's irq */
+                if (acpi_fadt.sci_int == gsi) {
+			/* we still need to set entry's irq */
+			acpi_gsi_to_irq(gsi, &entry->irq);
 			continue;
                 }
 	
-		ioapic = mp_find_ioapic(irq);
+		ioapic = mp_find_ioapic(gsi);
 		if (ioapic < 0)
 			continue;
-		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
+		ioapic_pin = gsi - mp_ioapic_routing[ioapic].gsi_base;
 
 		if (es7000_plat) {
-			if (!ioapic && (irq < 16))
-				irq += 16;
+			if (!ioapic && (gsi < 16))
+				gsi += 16;
 		}
 
 		/* 
 		 * Avoid pin reprogramming.  PRTs typically include entries  
-		 * with redundant pin->irq mappings (but unique PCI devices);
+		 * with redundant pin->gsi mappings (but unique PCI devices);
 		 * we only only program the IOAPIC on the first.
 		 */
 		bit = ioapic_pin % 32;
@@ -1158,19 +1158,19 @@
 		if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 			Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 				mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
- 			entry->irq = acpi_irq_to_vector(irq);
+			acpi_gsi_to_irq(gsi, &entry->irq);
 			continue;
 		}
 
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
-		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active_high_low)) {
- 			entry->irq = acpi_irq_to_vector(irq);
- 		}
+		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, gsi, edge_level, active_high_low)) {
+			acpi_gsi_to_irq(gsi, &entry->irq);
+		}
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
-			entry->id.segment, entry->id.bus, 
-			entry->id.device, ('A' + entry->pin), 
-			mp_ioapic_routing[ioapic].apic_id, ioapic_pin, 
+			entry->id.segment, entry->id.bus,
+			entry->id.device, ('A' + entry->pin),
+			mp_ioapic_routing[ioapic].apic_id, ioapic_pin,
 			entry->irq);
 	}
 
===== arch/i386/kernel/acpi/boot.c 1.50 vs edited =====
--- 1.50/arch/i386/kernel/acpi/boot.c	Mon Mar  1 01:30:55 2004
+++ edited/arch/i386/kernel/acpi/boot.c	Fri Mar 12 12:31:49 2004
@@ -349,6 +349,7 @@
 #endif /* CONFIG_ACPI_BUS */
 
 #ifdef CONFIG_X86_IO_APIC
+/* deprecated in favor of acpi_gsi_to_irq */
 int acpi_irq_to_vector(u32 irq)
 {
 	if (use_pci_vector() && !platform_legacy_irq(irq))
@@ -356,6 +357,15 @@
 	return irq;
 }
 #endif
+
+int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
+{
+	if (use_pci_vector() && !platform_legacy_irq(gsi))
+ 		*irq = IO_APIC_VECTOR(gsi);
+	else
+		*irq = gsi;
+	return 0;
+}
 
 static unsigned long __init
 acpi_scan_rsdp (
===== include/asm-i386/acpi.h 1.13 vs edited =====
--- 1.13/include/asm-i386/acpi.h	Thu Feb 26 23:53:16 2004
+++ edited/include/asm-i386/acpi.h	Fri Mar 12 12:32:24 2004
@@ -115,9 +115,10 @@
 /* Fixmap pages to reserve for ACPI boot-time tables (see fixmap.h) */
 #define FIX_ACPI_PAGES 4
 
+extern int acpi_gsi_to_irq(u32 gsi, unsigned int *irq);
 #ifdef CONFIG_X86_IO_APIC
 extern int skip_ioapic_setup;
-extern int acpi_irq_to_vector(u32 irq);
+extern int acpi_irq_to_vector(u32 irq);	/* deprecated in favor of acpi_gsi_to_irq */
 
 static inline void disable_ioapic_setup(void)
 {
===== include/asm-i386/mpspec.h 1.17 vs edited =====
--- 1.17/include/asm-i386/mpspec.h	Tue Dec 30 01:41:12 2003
+++ edited/include/asm-i386/mpspec.h	Fri Mar 12 11:46:29 2004
@@ -30,15 +30,15 @@
 #ifdef CONFIG_ACPI_BOOT
 extern void mp_register_lapic (u8 id, u8 enabled);
 extern void mp_register_lapic_address (u64 address);
-extern void mp_register_ioapic (u8 id, u32 address, u32 irq_base);
-extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 global_irq);
+extern void mp_register_ioapic (u8 id, u32 address, u32 gsi_base);
+extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 gsi);
 extern void mp_config_acpi_legacy_irqs (void);
 extern void mp_parse_prt (void);
 
 #ifdef CONFIG_X86_IO_APIC
-extern void mp_config_ioapic_for_sci(int irq);
+extern void mp_config_ioapic_for_sci(u32 gsi);
 #else
-static inline void mp_config_ioapic_for_sci(int irq)
+static inline void mp_config_ioapic_for_sci(u32 gsi)
 { }
 #endif
 #endif /*CONFIG_ACPI_BOOT*/



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
