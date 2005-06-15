From: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 03/04] PCI: use the MCFG table to properly access pci devices (x86-64)
Date: Tue, 14 Jun 2005 22:32:14 -0700
Message-ID: <20050615053214.GD23394@kroah.com>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050615053120.GC23394-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ak-l3A5Bk7waGM@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Now that we have access to the whole MCFG table, let's properly use it
for all pci device accesses (as that's what it is there for, some boxes
don't put all the busses into one entry.)

If, for some reason, the table is incorrect, we fallback to the "old
style" of mmconfig accesses, namely, we just assume the first entry in
the table is the one for us, and blindly use it.

Signed-off-by: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>

---
 arch/x86_64/pci/mmconfig.c |   58 +++++++++++++++++++++++++++++++++++++--------
 1 files changed, 48 insertions(+), 10 deletions(-)

--- gregkh-2.6.orig/arch/x86_64/pci/mmconfig.c	2005-06-14 22:06:17.000000000 -0700
+++ gregkh-2.6/arch/x86_64/pci/mmconfig.c	2005-06-14 22:08:44.000000000 -0700
@@ -13,17 +13,44 @@
 #define MMCONFIG_APER_SIZE (256*1024*1024)
 
 /* Static virtual mapping of the MMCONFIG aperture */
-static char *pci_mmcfg_virt;
+struct mmcfg_virt {
+	struct acpi_table_mcfg_config *cfg;
+	char *virt;
+};
+static struct mmcfg_virt *pci_mmcfg_virt;
+
+static char *get_virt(unsigned int seg, int bus)
+{
+	int cfg_num = -1;
+	struct acpi_table_mcfg_config *cfg;
+
+	while (1) {
+		++cfg_num;
+		if (cfg_num >= pci_mmcfg_config_num) {
+			/* something bad is going on, no cfg table is found. */
+			/* so we fall back to the old way we used to do this */
+			/* and just rely on the first entry to be correct. */
+			return pci_mmcfg_virt[0].virt;
+		}
+		cfg = pci_mmcfg_virt[cfg_num].cfg;
+		if (cfg->pci_segment_group_number != seg)
+			continue;
+		if ((cfg->start_bus_number <= bus) &&
+		    (cfg->end_bus_number >= bus))
+			return pci_mmcfg_virt[cfg_num].virt;
+	}
+}
 
-static inline char *pci_dev_base(unsigned int bus, unsigned int devfn)
+static inline char *pci_dev_base(unsigned int seg, unsigned int bus, unsigned int devfn)
 {
-	return pci_mmcfg_virt + ((bus << 20) | (devfn << 12));
+
+	return get_virt(seg, bus) + ((bus << 20) | (devfn << 12));
 }
 
 static int pci_mmcfg_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
-	char *addr = pci_dev_base(bus, devfn); 
+	char *addr = pci_dev_base(seg, bus, devfn);
 
 	if (unlikely(!value || (bus > 255) || (devfn > 255) || (reg > 4095)))
 		return -EINVAL;
@@ -46,7 +73,7 @@
 static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
-	char *addr = pci_dev_base(bus,devfn);
+	char *addr = pci_dev_base(seg, bus, devfn);
 
 	if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095)))
 		return -EINVAL;
@@ -73,6 +100,8 @@
 
 static int __init pci_mmcfg_init(void)
 {
+	int i;
+
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return 0;
 
@@ -90,13 +119,22 @@
 		return 0; 
 
 	/* RED-PEN i386 doesn't do _nocache right now */
-	pci_mmcfg_virt = ioremap_nocache(pci_mmcfg_config[0].base_address, MMCONFIG_APER_SIZE);
-	if (!pci_mmcfg_virt) { 
-		printk("PCI: Cannot map mmconfig aperture\n");
+	pci_mmcfg_virt = kmalloc(sizeof(*pci_mmcfg_virt) * pci_mmcfg_config_num, GFP_KERNEL);
+	if (pci_mmcfg_virt == NULL) {
+		printk("PCI: Can not allocate memory for mmconfig structures\n");
 		return 0;
-	}	
+	}
+	for (i = 0; i < pci_mmcfg_config_num; ++i) {
+		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
+		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);
+		if (!pci_mmcfg_virt[i].virt) {
+			printk("PCI: Cannot map mmconfig aperture for segment %d\n",
+			       pci_mmcfg_config[i].pci_segment_group_number);
+			return 0;
+		}
+		printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[i].base_address);
+	}
 
-	printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[0].base_address);
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
