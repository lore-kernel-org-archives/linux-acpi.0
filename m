From: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 02/04] PCI: use the MCFG table to properly access pci devices (i386)
Date: Tue, 14 Jun 2005 22:31:20 -0700
Message-ID: <20050615053120.GC23394@kroah.com>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050615053031.GB23394-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
 arch/i386/pci/mmconfig.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

--- gregkh-2.6.orig/arch/i386/pci/mmconfig.c	2005-06-14 21:53:11.000000000 -0700
+++ gregkh-2.6/arch/i386/pci/mmconfig.c	2005-06-14 22:07:52.000000000 -0700
@@ -22,10 +22,31 @@
 /*
  * Functions for accessing PCI configuration space with MMCONFIG accesses
  */
+static u32 get_base_addr(unsigned int seg, int bus)
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
+			return pci_mmcfg_config[0].base_address;
+		}
+		cfg = &pci_mmcfg_config[cfg_num];
+		if (cfg->pci_segment_group_number != seg)
+			continue;
+		if ((cfg->start_bus_number <= bus) &&
+		    (cfg->end_bus_number >= bus))
+			return cfg->base_address;
+	}
+}
 
-static inline void pci_exp_set_dev_base(int bus, int devfn)
+static inline void pci_exp_set_dev_base(unsigned int seg, int bus, int devfn)
 {
-	u32 dev_base = pci_mmcfg_config[0].base_address | (bus << 20) | (devfn << 12);
+	u32 dev_base = get_base_addr(seg, bus) | (bus << 20) | (devfn << 12);
 	if (dev_base != mmcfg_last_accessed_device) {
 		mmcfg_last_accessed_device = dev_base;
 		set_fixmap_nocache(FIX_PCIE_MCFG, dev_base);
@@ -42,7 +63,7 @@
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	pci_exp_set_dev_base(bus, devfn);
+	pci_exp_set_dev_base(seg, bus, devfn);
 
 	switch (len) {
 	case 1:
@@ -71,7 +92,7 @@
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	pci_exp_set_dev_base(bus, devfn);
+	pci_exp_set_dev_base(seg, bus, devfn);
 
 	switch (len) {
 	case 1:


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
