From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH 2.6] ia64 support for PCI link devices
Date: Tue, 6 Apr 2004 10:11:58 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404061011.58634.bjorn.helgaas@hp.com>
References: <20040406014553.GV7695@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040406014553.GV7695-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Chris McDermott <lcm-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 05 April 2004 7:45 pm, Chris McDermott wrote:
> This patch enables correct enablement of interrupts described by
> PCI link device entries in the DSDT.
> 
> The current ia64 implementation ignores link entries and therefore
> prevents such interrupts from being configured correctly.

I'm working on cleaning this up in a generic way, which will eventually
remove iosapic_parse_prt() completely.  Unfortunately, I don't think
I have any boxes that use link entries, so I can't test that bit of it.

Here's the patch I'm currently testing (ia64 and generic changes only).
Can you give it a whirl and see what it does with your link entries?

===== arch/ia64/kernel/acpi.c 1.65 vs edited =====
--- 1.65/arch/ia64/kernel/acpi.c	Sat Mar 20 22:28:40 2004
+++ edited/arch/ia64/kernel/acpi.c	Mon Apr  5 11:23:32 2004
@@ -527,7 +527,7 @@
 	if (fadt->iapc_boot_arch & BAF_LEGACY_DEVICES)
 		acpi_legacy_devices = 1;
 
-	acpi_register_irq(fadt->sci_int, ACPI_ACTIVE_LOW, ACPI_LEVEL_SENSITIVE);
+	acpi_register_gsi(fadt->sci_int, ACPI_ACTIVE_LOW, ACPI_LEVEL_SENSITIVE);
 	return 0;
 }
 
@@ -662,5 +662,12 @@
 			(trigger == ACPI_EDGE_SENSITIVE) ? IOSAPIC_EDGE : IOSAPIC_LEVEL);
 }
 EXPORT_SYMBOL(acpi_register_irq);
+
+unsigned int
+acpi_register_gsi (u32 gsi, int polarity, int trigger)
+{
+	return acpi_register_irq(gsi, polarity, trigger);
+}
+EXPORT_SYMBOL(acpi_register_gsi);
 
 #endif /* CONFIG_ACPI_BOOT */
===== arch/ia64/pci/pci.c 1.45 vs edited =====
--- 1.45/arch/ia64/pci/pci.c	Tue Mar 23 18:55:32 2004
+++ edited/arch/ia64/pci/pci.c	Mon Apr  5 15:21:56 2004
@@ -441,7 +441,6 @@
 	if (ret < 0)
 		return ret;
 
-	printk(KERN_INFO "PCI: Found IRQ %d for device %s\n", dev->irq, pci_name(dev));
 	return acpi_pci_irq_enable(dev);
 }
 
===== drivers/acpi/pci_irq.c 1.26 vs edited =====
--- 1.26/drivers/acpi/pci_irq.c	Thu Apr  1 02:03:21 2004
+++ edited/drivers/acpi/pci_irq.c	Mon Apr  5 15:25:35 2004
@@ -38,9 +38,6 @@
 #ifdef CONFIG_X86_IO_APIC
 #include <asm/mpspec.h>
 #endif
-#ifdef CONFIG_IOSAPIC
-# include <asm/iosapic.h>
-#endif
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -50,10 +47,6 @@
 
 struct acpi_prt_list		acpi_prt;
 
-#ifdef CONFIG_X86
-extern void eisa_set_level_irq(unsigned int irq);
-#endif
-
 
 /* --------------------------------------------------------------------------
                          PCI IRQ Routing Table (PRT) Support
@@ -238,11 +231,17 @@
    -------------------------------------------------------------------------- */
 
 int
-acpi_pci_irq_lookup (struct pci_bus *bus, int device, int pin)
+acpi_pci_irq_lookup (
+	struct pci_bus		*bus,
+	int			device,
+	int			pin,
+	int			*polarity,
+	int			*trigger)
 {
 	struct acpi_prt_entry	*entry = NULL;
 	int segment = pci_domain_nr(bus);
 	int bus_nr = bus->number;
+	int irq;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_lookup");
 
@@ -255,28 +254,30 @@
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PRT entry not found\n"));
 		return_VALUE(0);
 	}
-
-	if (!entry->irq && entry->link.handle) {
-		entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, NULL, NULL);
-		if (!entry->irq) {
+	
+	if (entry->link.handle) {
+		irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, polarity, trigger);
+		if (!irq) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
 			return_VALUE(0);
 		}
-	}
-	else if (!entry->irq) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Invalid static routing entry (IRQ 0)\n"));
-		return_VALUE(0);
+	} else {
+		irq = entry->link.index;
+		*polarity = ACPI_ACTIVE_LOW;
+		*trigger = ACPI_LEVEL_SENSITIVE;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found IRQ %d\n", entry->irq));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found IRQ %d\n", irq));
 
-	return_VALUE(entry->irq);
+	return_VALUE(irq);
 }
 
 static int
 acpi_pci_irq_derive (
 	struct pci_dev		*dev,
-	int			pin)
+	int			pin,
+	int			*polarity,
+	int			*trigger)
 {
 	struct pci_dev		*bridge = dev;
 	int			irq = 0;
@@ -309,7 +310,7 @@
 		}
 
 		irq = acpi_pci_irq_lookup(bridge->bus,
-				PCI_SLOT(bridge->devfn), pin);
+				PCI_SLOT(bridge->devfn), pin, polarity, trigger);
 	}
 
 	if (!irq) {
@@ -330,6 +331,8 @@
 {
 	int			irq = 0;
 	u8			pin = 0;
+	int			polarity = ACPI_ACTIVE_LOW;
+	int			trigger = ACPI_LEVEL_SENSITIVE;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_enable");
 
@@ -352,14 +355,14 @@
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
 	 * values override any BIOS-assigned IRQs set during boot.
 	 */
- 	irq = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin);
+ 	irq = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin, &polarity, &trigger);
 
 	/*
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
 	 * device's parent bridge.
 	 */
 	if (!irq)
- 		irq = acpi_pci_irq_derive(dev, pin);
+ 		irq = acpi_pci_irq_derive(dev, pin, &polarity, &trigger);
  
 	/*
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
@@ -378,27 +381,10 @@
 		}
  	}
 
-	dev->irq = irq;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device %s using IRQ %d\n", pci_name(dev), dev->irq));
+	dev->irq = acpi_register_gsi(irq, polarity, trigger);
 
-	/* 
-	 * Make sure all (legacy) PCI IRQs are set as level-triggered.
-	 */
-#ifdef CONFIG_X86
-	{
-		static u16 irq_mask;
-		if ((dev->irq < 16) &&  !((1 << dev->irq) & irq_mask)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Setting IRQ %d as level-triggered\n", dev->irq));
-			irq_mask |= (1 << dev->irq);
-			eisa_set_level_irq(dev->irq);
-		}
-	}
-#endif
-#ifdef CONFIG_IOSAPIC
-	if (acpi_irq_model == ACPI_IRQ_MODEL_IOSAPIC)
-		iosapic_enable_intr(dev->irq);
-#endif
+	printk(KERN_DEBUG PREFIX "PCI interrupt %s[%c] -> GSI 0x%x -> IRQ %d\n",
+		pci_name(dev), 'A' + pin, irq, dev->irq);
 
 	return_VALUE(dev->irq);
 }
@@ -426,10 +412,6 @@
 	/* Program IOAPICs using data from PRT entries. */
 	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC)
 		mp_parse_prt();
-#endif
-#ifdef CONFIG_IOSAPIC
-	if (acpi_irq_model == ACPI_IRQ_MODEL_IOSAPIC)
-		iosapic_parse_prt();
 #endif
 
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
===== drivers/serial/8250_acpi.c 1.8 vs edited =====
--- 1.8/drivers/serial/8250_acpi.c	Mon Mar 15 15:53:32 2004
+++ edited/drivers/serial/8250_acpi.c	Mon Apr  5 11:01:19 2004
@@ -58,28 +58,18 @@
 static acpi_status acpi_serial_ext_irq(struct serial_struct *req,
 				       struct acpi_resource_ext_irq *ext_irq)
 {
-	if (ext_irq->number_of_interrupts > 0) {
-#ifdef CONFIG_IA64
-		req->irq = acpi_register_irq(ext_irq->interrupts[0],
+	if (ext_irq->number_of_interrupts > 0)
+		req->irq = acpi_register_gsi(ext_irq->interrupts[0],
 	                  ext_irq->active_high_low, ext_irq->edge_level);
-#else
-		req->irq = ext_irq->interrupts[0];
-#endif
-	}
 	return AE_OK;
 }
 
 static acpi_status acpi_serial_irq(struct serial_struct *req,
 				   struct acpi_resource_irq *irq)
 {
-	if (irq->number_of_interrupts > 0) {
-#ifdef CONFIG_IA64
-		req->irq = acpi_register_irq(irq->interrupts[0],
+	if (irq->number_of_interrupts > 0)
+		req->irq = acpi_register_gsi(irq->interrupts[0],
 	                  irq->active_high_low, irq->edge_level);
-#else
-		req->irq = irq->interrupts[0];
-#endif
-	}
 	return AE_OK;
 }
 
===== drivers/serial/8250_hcdp.c 1.3 vs edited =====
--- 1.3/drivers/serial/8250_hcdp.c	Mon Mar 15 15:53:32 2004
+++ edited/drivers/serial/8250_hcdp.c	Mon Apr  5 11:04:34 2004
@@ -179,12 +179,8 @@
 			printk(KERN_WARNING"warning: No support for PCI serial console\n");
 			return;
 		}
-#ifdef CONFIG_IA64
-		port.irq = acpi_register_irq(gsi, ACPI_ACTIVE_HIGH,
+		port.irq = acpi_register_gsi(gsi, ACPI_ACTIVE_HIGH,
 				ACPI_EDGE_SENSITIVE);
-#else
-		port.irq = gsi;
-#endif
 		port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_RESOURCES;
 
 		/*
===== include/linux/acpi.h 1.32 vs edited =====
--- 1.32/include/linux/acpi.h	Mon Mar  1 01:26:35 2004
+++ edited/include/linux/acpi.h	Mon Apr  5 11:19:03 2004
@@ -438,6 +438,7 @@
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
 int acpi_pci_irq_init (void);
+unsigned int acpi_register_gsi (u32 gsi, int polarity, int trigger);
 
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
