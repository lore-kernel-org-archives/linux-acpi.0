From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] PCI domain support, part 1
Date: Wed, 11 Jun 2003 13:55:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030611125544.GU28581@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Note that this patch depends on a patch which Linus took into his tree
yesterday.  If you want to include it in 2.4 or for an earlier version
of 2.5, you'll want to sprinkle

#define pci_domain_nr(bus) pci_controller_num(bus->self)

somewhere.  Followup patches for PCI domain support coming later today,
hopefully.

 - Make acpi_pci_irq_lookup() static since nothing outside pci_irq.c uses it.
 - Change its arguments to take a struct pci_bus * rather than segment, busnr.
 - Use pci_domain_nr() to get the segment number instead of assuming 0.

Index: drivers/acpi/acpi_ksyms.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/acpi/acpi_ksyms.c,v
retrieving revision 1.12
diff -u -p -r1.12 acpi_ksyms.c
--- drivers/acpi/acpi_ksyms.c	27 May 2003 17:22:25 -0000	1.12
+++ drivers/acpi/acpi_ksyms.c	11 Jun 2003 12:26:40 -0000
@@ -144,8 +144,6 @@ EXPORT_SYMBOL(acpi_bus_unregister_driver
 #include <linux/pci.h>
 extern int acpi_pci_irq_enable(struct pci_dev *dev);
 EXPORT_SYMBOL(acpi_pci_irq_enable);
-extern int acpi_pci_irq_lookup (int segment, int bus, int device, int pin);
-EXPORT_SYMBOL(acpi_pci_irq_lookup);
 #endif /*CONFIG_ACPI_PCI */
 
 #ifdef CONFIG_ACPI_EC
Index: drivers/acpi/pci_irq.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/acpi/pci_irq.c,v
retrieving revision 1.10
diff -u -p -r1.10 pci_irq.c
--- drivers/acpi/pci_irq.c	25 Feb 2003 12:39:42 -0000	1.10
+++ drivers/acpi/pci_irq.c	11 Jun 2003 12:27:05 -0000
@@ -229,22 +229,20 @@ acpi_pci_irq_add_prt (
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
 
-int
-acpi_pci_irq_lookup (
-	int			segment,
-	int			bus,
-	int			device,
-	int			pin)
+static int
+acpi_pci_irq_lookup (struct pci_bus *bus, int device, int pin)
 {
 	struct acpi_prt_entry	*entry = NULL;
+	int segment = pci_domain_nr(bus);
+	int bus_nr = bus->number;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_lookup");
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 		"Searching for PRT entry for %02x:%02x:%02x[%c]\n", 
-		segment, bus, device, ('A' + pin)));
+		segment, bus_nr, device, ('A' + pin)));
 
-	entry = acpi_pci_irq_find_prt_entry(segment, bus, device, pin); 
+	entry = acpi_pci_irq_find_prt_entry(segment, bus_nr, device, pin); 
 	if (!entry) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PRT entry not found\n"));
 		return_VALUE(0);
@@ -288,7 +286,8 @@ acpi_pci_irq_derive (
 	while (!irq && bridge->bus->self) {
 		pin = (pin + PCI_SLOT(bridge->devfn)) % 4;
 		bridge = bridge->bus->self;
-		irq = acpi_pci_irq_lookup(0, bridge->bus->number, PCI_SLOT(bridge->devfn), pin);
+		irq = acpi_pci_irq_lookup(bridge->bus,
+				PCI_SLOT(bridge->devfn), pin);
 	}
 
 	if (!irq) {
@@ -331,7 +330,7 @@ acpi_pci_irq_enable (
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
 	 * values override any BIOS-assigned IRQs set during boot.
 	 */
- 	irq = acpi_pci_irq_lookup(0, dev->bus->number, PCI_SLOT(dev->devfn), pin);
+ 	irq = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin);
  
 	/*
 	 * If no PRT entry was found, we'll try to derive an IRQ from the

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
