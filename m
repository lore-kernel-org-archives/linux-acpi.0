From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] clean up ACPI GSI/IRQ conversions (x86_64 part)
Date: Fri, 12 Mar 2004 15:51:11 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403121551.11924.bjorn.helgaas@hp.com>
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
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andi,

Here's the x86_64 part, again based on 2.6.4.  This should be safe to
apply by itself.  I cross-compiled it with just this patch, and also with
the ACPI patch that will follow (to make it use acpi_gsi_to_irq()).

Changelog:

Add "acpi_gsi_to_irq()" as a generic replacement for "acpi_irq_to_vector()".
This converts from an ACPI global system interrupt number to a Linux IRQ.
Also, convert x86_64-specific terminology to use GSI when appropriate.

===== arch/x86_64/kernel/mpparse.c 1.21 vs edited =====
--- 1.21/arch/x86_64/kernel/mpparse.c	Tue Mar 16 11:22:18 2004
+++ edited/arch/x86_64/kernel/mpparse.c	Fri Mar 12 11:47:25 2004
@@ -9,7 +9,7 @@
  *		Erich Boleyn	:	MP v1.4 and additional changes.
  *		Alan Cox	:	Added EBDA scanning
  *		Ingo Molnar	:	various cleanups and rewrites
- *	Maciej W. Rozycki	:	Bits for default MP configurations
+ *		Maciej W. Rozycki:	Bits for default MP configurations
  *		Paul Diefenbaugh:	Added full ACPI support
  */
 
@@ -690,25 +690,25 @@
 
 struct mp_ioapic_routing {
 	int			apic_id;
-	int			irq_start;
-	int			irq_end;
+	int			gsi_start;
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
+		if ((gsi >= mp_ioapic_routing[i].gsi_start)
+			&& (gsi <= mp_ioapic_routing[i].gsi_end))
 			return i;
 	}
 
-	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for IRQ %d\n", irq);
+	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for GSI %d\n", gsi);
 
 	return -1;
 }
@@ -717,7 +717,7 @@
 void __init mp_register_ioapic (
 	u8			id, 
 	u32			address,
-	u32			irq_base)
+	u32			gsi_base)
 {
 	int			idx = 0;
 
@@ -743,19 +743,19 @@
 	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
 	
 	/* 
-	 * Build basic IRQ lookup table to facilitate irq->io_apic lookups
+	 * Build basic IRQ lookup table to facilitate gsi->io_apic lookups
 	 * and to prevent reprogramming of IOAPIC pins (PCI IRQs).
 	 */
 	mp_ioapic_routing[idx].apic_id = mp_ioapics[idx].mpc_apicid;
-	mp_ioapic_routing[idx].irq_start = irq_base;
-	mp_ioapic_routing[idx].irq_end = irq_base + 
+	mp_ioapic_routing[idx].gsi_start = gsi_base;
+	mp_ioapic_routing[idx].gsi_end = gsi_base + 
 		io_apic_get_redir_entries(idx);
 
 	printk(KERN_INFO "IOAPIC[%d]: apic_id %d, version %d, address 0x%x, "
-		"IRQ %d-%d\n", idx, mp_ioapics[idx].mpc_apicid, 
+		"GSI %d-%d\n", idx, mp_ioapics[idx].mpc_apicid, 
 		mp_ioapics[idx].mpc_apicver, mp_ioapics[idx].mpc_apicaddr,
-		mp_ioapic_routing[idx].irq_start,
-		mp_ioapic_routing[idx].irq_end);
+		mp_ioapic_routing[idx].gsi_start,
+		mp_ioapic_routing[idx].gsi_end);
 
 	return;
 }
@@ -765,7 +765,7 @@
 	u8			bus_irq,
 	u8			polarity, 
 	u8			trigger, 
-	u32			global_irq)
+	u32			gsi)
 {
 	struct mpc_config_intsrc intsrc;
 	int			i = 0;
@@ -774,12 +774,12 @@
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
+	pin = gsi - mp_ioapic_routing[ioapic].gsi_start;
 
 	/*
 	 * TBD: This check is for faulty timer entries, where the override
@@ -804,7 +804,7 @@
 
 	/* 
 	 * If an existing [IOAPIC.PIN -> IRQ] routing entry exists we override it.
-	 * Otherwise create a new entry (e.g. global_irq == 2).
+	 * Otherwise create a new entry (e.g. gsi == 2).
 	 */
 	for (i = 0; i < mp_irq_entries; i++) {
 		if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus) 
@@ -878,7 +878,7 @@
 
 extern FADT_DESCRIPTOR acpi_fadt;
 
-void __init mp_config_ioapic_for_sci(int irq)
+void __init mp_config_ioapic_for_sci(u32 gsi)
 {
 #ifdef CONFIG_ACPI_INTERPRETER
 	int ioapic;
@@ -926,11 +926,11 @@
 	 */
 	flags = entry->flags;
 	acpi_fadt.sci_int = entry->global_irq;
-	irq = entry->global_irq;
+	gsi = entry->global_irq;
 
-	ioapic = mp_find_ioapic(irq);
+	ioapic = mp_find_ioapic(gsi);
 
-	ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
+	ioapic_pin = gsi - mp_ioapic_routing[ioapic].gsi_start;
 
 	/*
 	 * MPS INTI flags:
@@ -938,7 +938,7 @@
 	 *  polarity: 0=default, 1=high, 3=low
 	 * Per ACPI spec, default for SCI means level/low.
 	 */
-	io_apic_set_pci_routing(ioapic, ioapic_pin, irq, 
+	io_apic_set_pci_routing(ioapic, ioapic_pin, gsi, 
 		(flags.trigger == 1 ? 0 : 1), (flags.polarity == 1 ? 0 : 1));
 #endif
 }
@@ -951,7 +951,7 @@
 	struct acpi_prt_entry	*entry = NULL;
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
-	int			irq = 0;
+	int			gsi = 0;
 	int			idx, bit = 0;
 	int			edge_level = 0;
 	int			active_high_low = 0;
@@ -963,30 +963,30 @@
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
 		} else {
-			/* Hardwired IRQ. Assume PCI standard settings */
-			irq = entry->link.index;
+			/* Hardwired GSI. Assume PCI standard settings */
+			gsi = entry->link.index;
 			edge_level = 1;
 			active_high_low = 1;
 		}
 
 		/* Don't set up the ACPI SCI because it's already set up */
-		if (acpi_fadt.sci_int == irq)
+		if (acpi_fadt.sci_int == gsi)
 			continue;
 
-		ioapic = mp_find_ioapic(irq);
+		ioapic = mp_find_ioapic(gsi);
 		if (ioapic < 0)
 			continue;
-		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
+		ioapic_pin = gsi - mp_ioapic_routing[ioapic].gsi_start;
 
 		/* 
 		 * Avoid pin reprogramming.  PRTs typically include entries  
-		 * with redundant pin->irq mappings (but unique PCI devices);
+		 * with redundant pin->gsi mappings (but unique PCI devices);
 		 * we only only program the IOAPIC on the first.
 		 */
 		bit = ioapic_pin % 32;
@@ -1000,25 +1000,21 @@
 		if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 			Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 				mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
- 			if (use_pci_vector() && !platform_legacy_irq(irq))
- 				irq = IO_APIC_VECTOR(irq);
-			entry->irq = irq;
+			acpi_gsi_to_irq(gsi, &entry->irq);
 			continue;
 		}
 
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
-		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active_high_low)) {
- 			if (use_pci_vector() && !platform_legacy_irq(irq))
- 				irq = IO_APIC_VECTOR(irq);
-			entry->irq = irq;
- 		}
-		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d"
-			" -> IRQ %d\n", entry->id.segment, entry->id.bus, 
-			entry->id.device, ('A' + entry->pin), 
+		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, gsi, edge_level, active_high_low)) {
+			acpi_gsi_to_irq(gsi, &entry->irq);
+		}
+		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
+			entry->id.segment, entry->id.bus,
+			entry->id.device, ('A' + entry->pin),
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin,
 			entry->irq);
 	}
-	
+
 	print_IO_APIC();
 
 	return;
===== arch/x86_64/kernel/acpi/boot.c 1.16 vs edited =====
--- 1.16/arch/x86_64/kernel/acpi/boot.c	Tue Mar 16 11:59:19 2004
+++ edited/arch/x86_64/kernel/acpi/boot.c	Fri Mar 12 09:53:25 2004
@@ -366,6 +366,15 @@
 
 #endif /* CONFIG_ACPI_BUS */
 
+int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
+{
+	if (use_pci_vector() && !platform_legacy_irq(gsi))
+ 		*irq = IO_APIC_VECTOR(gsi);
+	else
+		*irq = gsi;
+	return 0;
+}
+
 static unsigned long __init
 acpi_scan_rsdp (
 	unsigned long		start,
===== include/asm-x86_64/acpi.h 1.6 vs edited =====
--- 1.6/include/asm-x86_64/acpi.h	Thu Feb 26 22:57:51 2004
+++ edited/include/asm-x86_64/acpi.h	Fri Mar 12 09:49:19 2004
@@ -109,6 +109,8 @@
 /* Fixmap pages to reserve for ACPI boot-time tables (see fixmap.h) */
 #define FIX_ACPI_PAGES 4
 
+extern int acpi_gsi_to_irq(u32 gsi, unsigned int *irq);
+
 #else	/* !CONFIG_ACPI_BOOT */
 #define acpi_lapic 0
 #define acpi_ioapic 0
===== include/asm-x86_64/mpspec.h 1.8 vs edited =====
--- 1.8/include/asm-x86_64/mpspec.h	Sat Aug 23 06:13:33 2003
+++ edited/include/asm-x86_64/mpspec.h	Fri Mar 12 11:46:21 2004
@@ -186,14 +186,14 @@
 extern void mp_register_lapic_address (u64 address);
 
 #ifdef CONFIG_X86_IO_APIC
-extern void mp_register_ioapic (u8 id, u32 address, u32 irq_base);
-extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 global_irq);
+extern void mp_register_ioapic (u8 id, u32 address, u32 gsi_base);
+extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 gsi);
 extern void mp_config_acpi_legacy_irqs (void);
 extern void mp_parse_prt (void);
 #endif /*CONFIG_X86_IO_APIC*/
 #endif
 
-extern void mp_config_ioapic_for_sci(int irq);
+extern void mp_config_ioapic_for_sci(u32 gsi);
 
 extern int using_apic_timer;
 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
