From: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 04/04] PCI: let AMD boxes use MMCONFIG
Date: Tue, 14 Jun 2005 22:33:16 -0700
Message-ID: <20050615053316.GE23394@kroah.com>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615053214.GD23394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050615053214.GD23394-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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


Now that we parse and handle the MCFG table properly, we can hopefully
remove the AMD check and let those boxes use MMCONFIG.

Note, this needs _lots_ of testing on lots of boxes before going to
mainline...

Signed-off-by: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>


---
 arch/i386/pci/mmconfig.c   |    7 -------
 arch/x86_64/pci/mmconfig.c |    7 -------
 2 files changed, 14 deletions(-)

--- gregkh-2.6.orig/arch/i386/pci/mmconfig.c	2005-06-14 22:07:52.000000000 -0700
+++ gregkh-2.6/arch/i386/pci/mmconfig.c	2005-06-14 22:09:16.000000000 -0700
@@ -127,13 +127,6 @@
 	    (pci_mmcfg_config[0].base_address == 0))
 		goto out;
 
-	/* Kludge for now. Don't use mmconfig on AMD systems because
-	   those have some busses where mmconfig doesn't work,
-	   and we don't parse ACPI MCFG well enough to handle that. 
-	   Remove when proper handling is added. */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-		goto out; 
-
 	printk(KERN_INFO "PCI: Using MMCONFIG\n");
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
--- gregkh-2.6.orig/arch/x86_64/pci/mmconfig.c	2005-06-14 22:08:44.000000000 -0700
+++ gregkh-2.6/arch/x86_64/pci/mmconfig.c	2005-06-14 22:09:11.000000000 -0700
@@ -111,13 +111,6 @@
 	    (pci_mmcfg_config[0].base_address == 0))
 		return 0;
 
-	/* Kludge for now. Don't use mmconfig on AMD systems because
-	   those have some busses where mmconfig doesn't work,
-	   and we don't parse ACPI MCFG well enough to handle that. 
-	   Remove when proper handling is added. */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-		return 0; 
-
 	/* RED-PEN i386 doesn't do _nocache right now */
 	pci_mmcfg_virt = kmalloc(sizeof(*pci_mmcfg_virt) * pci_mmcfg_config_num, GFP_KERNEL);
 	if (pci_mmcfg_virt == NULL) {


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
