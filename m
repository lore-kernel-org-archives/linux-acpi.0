From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [patch 04/12] Prevent duplicate bus numbers when scanning PCI bridge
Date: Fri, 18 Mar 2005 14:04:37 -0800
Message-ID: <20050318140437.D1145@unix-os.sc.intel.com>
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

When hot-plugging a root bridge, as we try to assign bus numbers
we may find that the hotplugged hieratchy has more PCI to PCI
bridges (i.e. bus requirements) than available.  Make sure we
don't step over an existing bus when that happens. 

Signed-off-by: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

 linux-2.6.11-mm4-iohp-rshah1/drivers/pci/probe.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff -puN drivers/pci/probe.c~prevent_duplicate_busnr drivers/pci/probe.c
--- linux-2.6.11-mm4-iohp/drivers/pci/probe.c~prevent_duplicate_busnr	2005-03-16 13:07:10.376304290 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/pci/probe.c	2005-03-16 13:07:10.496421476 -0800
@@ -417,7 +417,7 @@ int __devinit pci_scan_bridge(struct pci
 {
 	struct pci_bus *child;
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
-	u32 buses;
+	u32 buses, i;
 	u16 bctl;
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
@@ -476,6 +476,10 @@ int __devinit pci_scan_bridge(struct pci
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
+		/* Prevent assigning a bus number that already exists.
+		 * This can happen when a bridge is hot-plugged */
+		if (pci_find_bus(pci_domain_nr(bus), max+1))
+			return max;
 		child = pci_alloc_child_bus(bus, dev, ++max);
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
@@ -507,7 +511,11 @@ int __devinit pci_scan_bridge(struct pci
 			 * as cards with a PCI-to-PCI bridge can be
 			 * inserted later.
 			 */
-			max += CARDBUS_RESERVE_BUSNR;
+			for (i=0; i<CARDBUS_RESERVE_BUSNR; i++)
+				if (pci_find_bus(pci_domain_nr(bus),
+							max+i+1))
+					break;
+			max += i;
 		}
 		/*
 		 * Set the subordinate bus number to its real value.
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
