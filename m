From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [patch 06/12] Link newly created pci child bus to its parent on creation
Date: Fri, 18 Mar 2005 14:09:22 -0800
Message-ID: <20050318140922.F1145@unix-os.sc.intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318133856.A878-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>; from rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Fri, Mar 18, 2005 at 01:38:57PM -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: gregkh-l3A5Bk7waGM@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

When a pci child bus is created, add it to the parent's children
list immediately rather than waiting till pci_bus_add_devices().
For hot-plug bridges/devices, pci_bus_add_devices() may be called
much later, after they have been properly configured. In the 
meantime, this allows us to use the normal pci bus search functions
for the hot-plug bridges/buses.

Signed-off-by: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

 linux-2.6.11-mm4-iohp-rshah1/drivers/pci/bus.c   |   11 +++++++----
 linux-2.6.11-mm4-iohp-rshah1/drivers/pci/probe.c |    4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff -puN drivers/pci/probe.c~pci_link_child_bus drivers/pci/probe.c
--- linux-2.6.11-mm4-iohp/drivers/pci/probe.c~pci_link_child_bus	2005-03-16 13:07:18.745444812 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/pci/probe.c	2005-03-16 13:07:18.857749498 -0800
@@ -457,7 +457,7 @@ int __devinit pci_scan_bridge(struct pci
 			return max;
 		}
 
-		child = pci_alloc_child_bus(bus, dev, busnr);
+		child = pci_add_new_bus(bus, dev, busnr);
 		if (!child)
 			return max;
 		child->primary = buses & 0xFF;
@@ -484,7 +484,7 @@ int __devinit pci_scan_bridge(struct pci
 		 * This can happen when a bridge is hot-plugged */
 		if (pci_find_bus(pci_domain_nr(bus), max+1))
 			return max;
-		child = pci_alloc_child_bus(bus, dev, ++max);
+		child = pci_add_new_bus(bus, dev, ++max);
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
 		      | ((unsigned int)(child->secondary)   <<  8)
diff -puN drivers/pci/bus.c~pci_link_child_bus drivers/pci/bus.c
--- linux-2.6.11-mm4-iohp/drivers/pci/bus.c~pci_link_child_bus	2005-03-16 13:07:18.749351062 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/pci/bus.c	2005-03-16 13:07:18.858726061 -0800
@@ -121,10 +121,13 @@ void __devinit pci_bus_add_devices(struc
 		 * If there is an unattached subordinate bus, attach
 		 * it and then scan for unattached PCI devices.
 		 */
-		if (dev->subordinate && list_empty(&dev->subordinate->node)) {
-			spin_lock(&pci_bus_lock);
-			list_add_tail(&dev->subordinate->node, &dev->bus->children);
-			spin_unlock(&pci_bus_lock);
+		if (dev->subordinate) {
+		       if (list_empty(&dev->subordinate->node)) {
+			       spin_lock(&pci_bus_lock);
+			       list_add_tail(&dev->subordinate->node,
+					       &dev->bus->children);
+			       spin_unlock(&pci_bus_lock);
+		       }
 			pci_bus_add_devices(dev->subordinate);
 
 			sysfs_create_link(&dev->subordinate->class_dev.kobj, &dev->dev.kobj, "bridge");
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
