From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ACPI: associate PCI devices with interrupt link devices
Date: Tue, 15 Feb 2005 11:07:07 -0700
Message-ID: <1108490827.15848.8.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Make PCI device -> interrupt link associations explicit, i.e.,

    ACPI: PCI Interrupt 0000:00:0f.2[A] -> Link [IUSB] -> GSI 10 (level, low) -> IRQ 10

Previously, you could sometimes infer an association based on the output
when an interrupt link is enabled, but when interrupt links are shared
among several PCI devices, you could only make the inference for the first
device to be enabled.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

===== drivers/acpi/pci_irq.c 1.36 vs edited =====
--- 1.36/drivers/acpi/pci_irq.c	2005-01-20 22:02:15 -07:00
+++ edited/drivers/acpi/pci_irq.c	2005-02-15 09:37:51 -07:00
@@ -281,7 +281,8 @@
 	int			device,
 	int			pin,
 	int			*edge_level,
-	int			*active_high_low)
+	int			*active_high_low,
+	char			**link)
 {
 	struct acpi_prt_entry	*entry = NULL;
 	int segment = pci_domain_nr(bus);
@@ -301,7 +302,8 @@
 	}
 	
 	if (entry->link.handle) {
-		irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, edge_level, active_high_low);
+		irq = acpi_pci_link_get_irq(entry->link.handle,
+			entry->link.index, edge_level, active_high_low, link);
 		if (irq < 0) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
 			return_VALUE(-1);
@@ -327,7 +329,8 @@
 	struct pci_dev		*dev,
 	int			pin,
 	int			*edge_level,
-	int			*active_high_low)
+	int			*active_high_low,
+	char			**link)
 {
 	struct pci_dev		*bridge = dev;
 	int			irq = -1;
@@ -360,7 +363,7 @@
 		}
 
 		irq = acpi_pci_irq_lookup(bridge->bus, PCI_SLOT(bridge->devfn),
-			pin, edge_level, active_high_low);
+			pin, edge_level, active_high_low, link);
 	}
 
 	if (irq < 0) {
@@ -389,6 +392,7 @@
 	int			edge_level = ACPI_LEVEL_SENSITIVE;
 	int			active_high_low = ACPI_ACTIVE_LOW;
 	extern int		via_interrupt_line_quirk;
+	char			*link = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_enable");
 
@@ -411,21 +415,23 @@
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
 	 * values override any BIOS-assigned IRQs set during boot.
 	 */
- 	irq = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin, &edge_level, &active_high_low);
+ 	irq = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
+		&edge_level, &active_high_low, &link);
 
 	/*
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
 	 * device's parent bridge.
 	 */
 	if (irq < 0)
- 		irq = acpi_pci_irq_derive(dev, pin, &edge_level, &active_high_low);
+ 		irq = acpi_pci_irq_derive(dev, pin, &edge_level,
+			&active_high_low, &link);
  
 	/*
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
 	 * driver reported one, then use it. Exit in any case.
 	 */
 	if (irq < 0) {
-		printk(KERN_WARNING PREFIX "PCI interrupt %s[%c]: no GSI",
+		printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: no GSI",
 			pci_name(dev), ('A' + pin));
 		/* Interrupt Line values above 0xF are forbidden */
 		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
@@ -443,9 +449,13 @@
 
 	dev->irq = acpi_register_gsi(irq, edge_level, active_high_low);
 
-	printk(KERN_INFO PREFIX "PCI interrupt %s[%c] -> GSI %u "
-		"(%s, %s) -> IRQ %d\n",
-		pci_name(dev), 'A' + pin, irq,
+	printk(KERN_INFO PREFIX "PCI Interrupt %s[%c] -> ",
+		pci_name(dev), 'A' + pin);
+
+	if (link)
+		printk("Link [%s] -> ", link);
+
+	printk("GSI %u (%s, %s) -> IRQ %d\n", irq,
 		(edge_level == ACPI_LEVEL_SENSITIVE) ? "level" : "edge",
 		(active_high_low == ACPI_ACTIVE_LOW) ? "low" : "high",
 		dev->irq);
===== drivers/acpi/pci_link.c 1.39 vs edited =====
--- 1.39/drivers/acpi/pci_link.c	2004-12-21 20:08:55 -07:00
+++ edited/drivers/acpi/pci_link.c	2005-02-15 09:16:53 -07:00
@@ -522,9 +522,11 @@
 
 static int acpi_irq_balance;	/* 0: static, 1: balance */
 
-static int acpi_pci_link_allocate(struct acpi_pci_link* link) {
-	int irq;
-	int i;
+static int acpi_pci_link_allocate(
+	struct acpi_pci_link	*link)
+{
+	int			irq;
+	int			i;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
 
@@ -597,8 +599,9 @@
 acpi_pci_link_get_irq (
 	acpi_handle		handle,
 	int			index,
-	int*			edge_level,
-	int*			active_high_low)
+	int			*edge_level,
+	int			*active_high_low,
+	char			**name)
 {
 	int                     result = 0;
 	struct acpi_device	*device = NULL;
@@ -634,6 +637,7 @@
 
 	if (edge_level) *edge_level = link->irq.edge_level;
 	if (active_high_low) *active_high_low = link->irq.active_high_low;
+	if (name) *name = acpi_device_bid(link->device);
 	return_VALUE(link->irq.active);
 }
 
===== include/acpi/acpi_drivers.h 1.21 vs edited =====
--- 1.21/include/acpi/acpi_drivers.h	2004-09-24 16:26:17 -06:00
+++ edited/include/acpi/acpi_drivers.h	2005-02-15 08:46:08 -07:00
@@ -56,7 +56,8 @@
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
 int acpi_irq_penalty_init (void);
-int acpi_pci_link_get_irq (acpi_handle handle, int index, int* edge_level, int* active_high_low);
+int acpi_pci_link_get_irq (acpi_handle handle, int index, int *edge_level,
+	int *active_high_low, char **name);
 
 /* ACPI PCI Interrupt Routing (pci_irq.c) */
 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
