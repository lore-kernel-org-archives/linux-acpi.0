From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 1/4]  pci: return max reserved busnr
Date: Tue, 17 Jan 2006 16:56:56 -0800
Message-ID: <1137545816.19858.46.camel@whizzy>
References: <20060116200218.275371000@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:28568 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964978AbWARAyQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2006 19:54:16 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org, pavel@ucw.cz

Change the semantics of this call to return the max reserved
bus number instead of just the max assigned bus number.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com> 


 drivers/pci/pci.c   |    5 +++--
 include/linux/pci.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.15-mm.orig/drivers/pci/pci.c
+++ linux-2.6.15-mm/drivers/pci/pci.c
@@ -19,7 +19,6 @@
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
-#if 0
 
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
@@ -34,7 +33,7 @@ pci_bus_max_busnr(struct pci_bus* bus)
 	struct list_head *tmp;
 	unsigned char max, n;
 
-	max = bus->number;
+	max = bus->subordinate;
 	list_for_each(tmp, &bus->children) {
 		n = pci_bus_max_busnr(pci_bus_b(tmp));
 		if(n > max)
@@ -42,7 +41,9 @@ pci_bus_max_busnr(struct pci_bus* bus)
 	}
 	return max;
 }
+EXPORT_SYMBOL_GPL(pci_bus_max_busnr);
 
+#if 0
 /**
  * pci_max_busnr - returns maximum PCI bus number
  *
--- linux-2.6.15-mm.orig/include/linux/pci.h
+++ linux-2.6.15-mm/include/linux/pci.h
@@ -514,6 +514,7 @@ int pci_scan_bridge(struct pci_bus *bus,
 void pci_walk_bus(struct pci_bus *top, void (*cb)(struct pci_dev *, void *),
 		  void *userdata);
 int pci_cfg_space_size(struct pci_dev *dev);
+unsigned char pci_bus_max_busnr(struct pci_bus* bus);
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 

