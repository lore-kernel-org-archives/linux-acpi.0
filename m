From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] x86_64 part of ACPI IRQ cleanup
Date: Tue, 6 Apr 2004 15:08:10 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404061508.10717.bjorn.helgaas@hp.com>
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

Here's the x86_64 part of the ACPI IRQ cleanup I proposed here:

    http://www.gelato.unsw.edu.au/linux-ia64/0403/8979.html

No functional change in this patch; after x86_64, i386, and ia64
interfaces are in, I'll post the ACPI pci_irq.c changes to use them.

i386 and x86_64 share arch/i386/kernel/acpi/boot.c, so the x86_64
bit has to go in before the i386 one.

Booted on Altus 1000E.

===== arch/x86_64/kernel/mpparse.c 1.24 vs edited =====
--- 1.24/arch/x86_64/kernel/mpparse.c	Mon Mar 22 23:53:14 2004
+++ edited/arch/x86_64/kernel/mpparse.c	Tue Apr  6 14:19:30 2004
@@ -969,6 +969,49 @@
 
 #endif /*CONFIG_ACPI_PCI*/
 
+void mp_register_gsi (u32 gsi, int polarity, int trigger)
+{
+	int			ioapic = -1;
+	int			ioapic_pin = 0;
+	int			idx, bit = 0;
+
+	/* Don't set up the ACPI SCI because it's already set up */
+	if (acpi_fadt.sci_int == gsi)
+		return;
+
+	ioapic = mp_find_ioapic(gsi);
+	if (ioapic < 0) {
+		printk(KERN_WARNING "No IOAPIC for GSI 0x%x\n", gsi);
+		return;
+	}
+
+	ioapic_pin = gsi - mp_ioapic_routing[ioapic].gsi_start;
+
+	/* 
+	 * Avoid pin reprogramming.  PRTs typically include entries  
+	 * with redundant pin->gsi mappings (but unique PCI devices);
+	 * we only only program the IOAPIC on the first.
+	 */
+	bit = ioapic_pin % 32;
+	idx = (ioapic_pin < 32) ? 0 : (ioapic_pin / 32);
+	if (idx > 3) {
+		printk(KERN_ERR "Invalid reference to IOAPIC pin "
+			"%d-%d\n", mp_ioapic_routing[ioapic].apic_id, 
+			ioapic_pin);
+		return;
+	}
+	if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
+		Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
+			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
+		return;
+	}
+
+	mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
+	io_apic_set_pci_routing(ioapic, ioapic_pin, gsi,
+		trigger == ACPI_EDGE_SENSITIVE ? 0 : 1,
+		polarity == ACPI_ACTIVE_HIGH ? 0 : 1);
+}
+
 #endif /*CONFIG_X86_IO_APIC*/
 
 #endif /*CONFIG_ACPI_BOOT*/
===== include/asm-x86_64/mpspec.h 1.10 vs edited =====
--- 1.10/include/asm-x86_64/mpspec.h	Mon Mar 22 23:53:14 2004
+++ edited/include/asm-x86_64/mpspec.h	Tue Apr  6 14:21:14 2004
@@ -190,6 +190,7 @@
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 gsi);
 extern void mp_config_acpi_legacy_irqs (void);
 extern void mp_parse_prt (void);
+extern void mp_register_gsi (u32 gsi, int polarity, int trigger);
 #endif /*CONFIG_X86_IO_APIC*/
 #endif
 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
