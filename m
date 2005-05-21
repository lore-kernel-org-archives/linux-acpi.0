From: rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Subject: [patch 1/2] i386: collect host bridge resources
Date: Fri, 20 May 2005 17:42:40 -0700
Message-ID: <20050521004506.414236000@csdlinux-1>
References: <20050521004239.581618000@csdlinux-1>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=i386-host-bridge-resources.patch
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ak-l3A5Bk7waGM@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This patch reads and stores host bridge resources reported by
ACPI BIOS for i386 systems.  This is needed since ACPI hotplug
code now uses the PCI core for resource management. This patch
also adds a new boot parameter (acpi=root_resources) to trigger
the code, and host bridge resources are not stored unless
this boot parameter is specified.

Signed-off-by: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Index: linux-2.6.12-rc4-mm2/arch/i386/pci/acpi.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/i386/pci/acpi.c
+++ linux-2.6.12-rc4-mm2/arch/i386/pci/acpi.c
@@ -5,14 +5,168 @@
 #include <asm/hw_irq.h>
 #include "pci.h"
 
+int acpi_read_root_resources;
+
+static void inline
+_set_resource(int idx, struct pci_bus *bus,
+		struct acpi_resource_address64 *addr, unsigned long flags)
+{
+	bus->resource[idx]->name = bus->name;
+	bus->resource[idx]->start = addr->min_address_range;
+	bus->resource[idx]->end = addr->max_address_range;
+	bus->resource[idx]->flags = flags;
+}
+
+static acpi_status
+add_resources(struct acpi_resource *acpi_res, void *context)
+{
+	struct acpi_resource_address64 address;
+	unsigned long smallest, old_size, new_size, flags = 0;
+	struct pci_bus *bus = context;
+	int i, idx = 1;
+
+	if (acpi_res->id != ACPI_RSTYPE_ADDRESS16 &&
+	    acpi_res->id != ACPI_RSTYPE_ADDRESS32 &&
+	    acpi_res->id != ACPI_RSTYPE_ADDRESS64)
+		return AE_OK;
+
+	if (ACPI_FAILURE(acpi_resource_to_address64(acpi_res, &address)))
+		return AE_OK;
+
+	/*
+	 * Per the ACPI spec, we should pick up only ACPI_PRODUCER type
+	 * resources. However, many BIOSs get this wrong and report
+	 * resources they pass down as ACPI_CONSUMER type resources. For now,
+	 * pick up all resources here.
+	 */
+	if (address.address_length <= 0)
+		return AE_OK;
+
+	switch (address.resource_type) {
+		/*
+		 * We (arbitrarily) reserve 1 resource descriptor for the
+		 * largest block of IO resources, and the remaining descriptors
+		 * for the largest blocks of memory resources.
+		 */
+		case ACPI_IO_RANGE:
+			flags = IORESOURCE_IO;
+			new_size = address.max_address_range -
+				address.min_address_range;
+			old_size = bus->resource[0]->end -
+				bus->resource[0]->start;
+			if (new_size > old_size) {
+				if (old_size)
+					printk(KERN_WARNING
+						"PCI: Ignoring IO range %lx-%lx\n",
+						bus->resource[0]->start,
+						bus->resource[0]->end);
+				_set_resource(0, bus, &address, flags);
+			}
+			break;
+
+		case ACPI_MEMORY_RANGE:
+			flags = IORESOURCE_MEM;
+			if (address.attribute.memory.cache_attribute ==
+					ACPI_PREFETCHABLE_MEMORY)
+				flags |= IORESOURCE_PREFETCH;
+			smallest = ~0;
+			new_size = address.max_address_range -
+				address.min_address_range;
+			for (i = 1; i < PCI_BUS_NUM_RESOURCES; i++) {
+				if (!bus->resource[i]->flags) {
+					_set_resource(i, bus, &address, flags);
+					return AE_OK;
+				}
+				old_size = bus->resource[i]->end -
+					bus->resource[i]->start;
+				if (old_size < smallest) {
+					smallest = old_size;
+					idx = i;
+				}
+			}
+			if (new_size > smallest) {
+				printk(KERN_WARNING
+					"PCI: Ignoring range %lx-%lx, flags %lx\n",
+					bus->resource[idx]->start,
+					bus->resource[idx]->end, flags);
+				_set_resource(idx, bus, &address, flags);
+			}
+			break;
+		default:
+			break;
+	}
+	return AE_OK;
+}
+
+static int __devinit
+verify_root_windows(struct pci_bus *bus)
+{
+	int i, num_io = 0, num_mem = 0;
+	int type_mask = IORESOURCE_IO | IORESOURCE_MEM;
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+		switch (bus->resource[i]->flags & type_mask) {
+			case IORESOURCE_IO:
+				num_io++;
+				break;
+			case IORESOURCE_MEM:
+				num_mem++;
+				break;
+			default:
+				break;
+		}
+	}
+
+	if (num_io || num_mem)
+		return 1;
+	else
+		printk(KERN_WARNING
+			"PCI: BIOS reported bogus host bridge resources\n");
+	return 0;
+}
+
+static void __devinit
+pcibios_setup_root_windows(struct pci_bus *bus, acpi_handle handle)
+{
+	struct resource *res;
+	int i;
+	acpi_status status;
+
+	res = kmalloc((PCI_BUS_NUM_RESOURCES * sizeof(*res)),
+			GFP_KERNEL);
+	if (!res)
+		return;
+	memset(res, 0, (PCI_BUS_NUM_RESOURCES * sizeof(*res)));
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
+		bus->resource[i] = res+i;
+
+	sprintf(bus->name, "PCI Bus #%02x", bus->number);
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+			add_resources, bus);
+	if (ACPI_FAILURE(status) || !verify_root_windows(bus)) {
+		printk(KERN_WARNING
+			"PCI: Falling back to default host bridge resources\n");
+		for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
+			bus->resource[i] = NULL;
+		kfree(res);
+		bus->resource[0] = &ioport_resource;
+		bus->resource[1] = &iomem_resource;
+	}
+}
+
 struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_device *device, int domain, int busnum)
 {
+	struct pci_bus *bus;
 	if (domain != 0) {
 		printk(KERN_WARNING "PCI: Multiple domains not supported\n");
 		return NULL;
 	}
 
-	return pcibios_scan_root(busnum);
+	bus =  pcibios_scan_root(busnum);
+	if ((bus) && (acpi_read_root_resources))
+		pcibios_setup_root_windows(bus, device->handle);
+	return bus;
 }
 
 extern int pci_routeirq;
Index: linux-2.6.12-rc4-mm2/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/i386/kernel/setup.c
+++ linux-2.6.12-rc4-mm2/arch/i386/kernel/setup.c
@@ -791,6 +791,10 @@ static void __init parse_cmdline_early (
 		else if (!memcmp(from, "acpi=noirq", 10)) {
 			acpi_noirq_set();
 		}
+		/* Use ACPI to read host bridge resources */
+		else if (!memcmp(from, "acpi=root_resources", 19)) {
+			acpi_set_read_root_resources();
+		}
 
 		else if (!memcmp(from, "acpi_sci=edge", 13))
 			acpi_sci_flags.trigger =  1;
Index: linux-2.6.12-rc4-mm2/include/asm-i386/acpi.h
===================================================================
--- linux-2.6.12-rc4-mm2.orig/include/asm-i386/acpi.h
+++ linux-2.6.12-rc4-mm2/include/asm-i386/acpi.h
@@ -164,10 +164,16 @@ static inline void acpi_disable_pci(void
 	acpi_noirq_set();
 }
 extern int acpi_irq_balance_set(char *str);
+extern int acpi_read_root_resources;
+static inline void acpi_set_read_root_resources(void)
+{
+	acpi_read_root_resources = 1;
+}
 #else
 static inline void acpi_noirq_set(void) { }
 static inline void acpi_disable_pci(void) { }
 static inline int acpi_irq_balance_set(char *str) { return 0; }
+static inline void acpi_set_read_root_resources(void) { }
 #endif
 
 #ifdef CONFIG_ACPI_SLEEP

--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
