From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] simplify pci_irq internal interfaces
Date: Fri, 18 Mar 2005 13:21:33 -0700
Message-ID: <1111177293.13286.51.camel@eeyore>
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
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pass around the struct pci_dev when looking up PRT entries rather
than prematurely extracting segment/bus/device.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

===== drivers/acpi/pci_irq.c 1.37 vs edited =====
--- 1.37/drivers/acpi/pci_irq.c	2005-03-01 09:57:29 -07:00
+++ edited/drivers/acpi/pci_irq.c	2005-03-18 12:52:08 -07:00
@@ -51,9 +51,7 @@
 
 static struct acpi_prt_entry *
 acpi_pci_irq_find_prt_entry (
-	int			segment,
-	int			bus,
-	int			device,
+	struct pci_dev		*dev,
 	int			pin)
 {
 	struct list_head	*node = NULL;
@@ -67,15 +65,14 @@
 	/*
 	 * Parse through all PRT entries looking for a match on the specified
 	 * PCI device's segment, bus, device, and pin (don't care about func).
-	 *
 	 */
 	spin_lock(&acpi_prt_lock);
 	list_for_each(node, &acpi_prt.entries) {
 		entry = list_entry(node, struct acpi_prt_entry, node);
-		if ((segment == entry->id.segment) 
-			&& (bus == entry->id.bus) 
-			&& (device == entry->id.device)
-			&& (pin == entry->pin)) {
+		if ((entry->id.segment == pci_domain_nr(dev->bus)) 
+			&& (entry->id.bus == dev->bus->number) 
+			&& (entry->id.device == PCI_SLOT(dev->devfn))
+			&& (entry->pin == pin)) {
 			spin_unlock(&acpi_prt_lock);
 			return_PTR(entry);
 		}
@@ -277,24 +274,20 @@
  */
 static int
 acpi_pci_irq_lookup (
-	struct pci_bus		*bus,
-	int			device,
+	struct pci_dev		*dev,
 	int			pin,
 	int			*edge_level,
 	int			*active_high_low)
 {
 	struct acpi_prt_entry	*entry = NULL;
-	int segment = pci_domain_nr(bus);
-	int bus_nr = bus->number;
 	int irq;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_lookup");
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
-		"Searching for PRT entry for %02x:%02x:%02x[%c]\n", 
-		segment, bus_nr, device, ('A' + pin)));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Searching for PRT entry for %s[%c]\n", 
+		pci_name(dev), 'A' + pin));
 
-	entry = acpi_pci_irq_find_prt_entry(segment, bus_nr, device, pin); 
+	entry = acpi_pci_irq_find_prt_entry(dev, pin); 
 	if (!entry) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PRT entry not found\n"));
 		return_VALUE(-1);
@@ -359,8 +352,8 @@
 			pin = bridge_pin;
 		}
 
-		irq = acpi_pci_irq_lookup(bridge->bus, PCI_SLOT(bridge->devfn),
-			pin, edge_level, active_high_low);
+		irq = acpi_pci_irq_lookup(bridge, pin, edge_level,
+			active_high_low);
 	}
 
 	if (irq < 0) {
@@ -411,7 +404,7 @@
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
 	 * values override any BIOS-assigned IRQs set during boot.
 	 */
- 	irq = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin, &edge_level, &active_high_low);
+ 	irq = acpi_pci_irq_lookup(dev, pin, &edge_level, &active_high_low);
 
 	/*
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
@@ -481,8 +474,7 @@
 	/*
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.
 	 */
- 	gsi = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
-				  &edge_level, &active_high_low);
+ 	gsi = acpi_pci_irq_lookup(dev, pin, &edge_level, &active_high_low);
 	/*
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
 	 * device's parent bridge.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
