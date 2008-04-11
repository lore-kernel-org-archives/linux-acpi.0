From: akpm@linux-foundation.org
Subject: [patch for 2.6.25? 1/3] acpi: unneccessary to scan the PCI bus already scanned
Date: Thu, 10 Apr 2008 21:30:12 -0700
Message-ID: <200804110430.m3B4UC0a000412@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33755 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750787AbYDKEbH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Apr 2008 00:31:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, yakui.zhao@intel.com, greg@kroah.com, mingo@elte.hu, muli@il.ibm.com, stian@jordet.net, yhlu.kernel@gmail.com

From: <yakui.zhao@intel.com>


http://bugzilla.kernel.org/show_bug.cgi?id=10124

this change:

      commit 08f1c192c3c32797068bfe97738babb3295bbf42
      Author: Muli Ben-Yehuda <muli@il.ibm.com>
      Date:   Sun Jul 22 00:23:39 2007 +0300

         x86-64: introduce struct pci_sysdata to facilitate sharing of ->sysdata

         This patch introduces struct pci_sysdata to x86 and x86-64, and
         converts the existing two users (NUMA, Calgary) to use it.

         This lays the groundwork for having other users of sysdata, such as
         the PCI domains work.

         The Calgary bits are tested, the NUMA bits just look ok.

replaces pcibios_scan_root by pci_scan_bus_parented...

but in pcibios_scan_root we have a check about scanned busses.

Cc: <yakui.zhao@intel.com>
Cc: Stian Jordet <stian@jordet.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Greg KH <greg@kroah.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: "Yinghai Lu" <yhlu.kernel@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/ia64/pci/pci.c |    7 ++++++-
 arch/x86/pci/acpi.c |   17 +++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff -puN arch/ia64/pci/pci.c~acpi-unneccessary-to-scan-the-pci-bus-already-scanned arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c~acpi-unneccessary-to-scan-the-pci-bus-already-scanned
+++ a/arch/ia64/pci/pci.c
@@ -362,7 +362,12 @@ pci_acpi_scan_root(struct acpi_device *d
 	info.name = name;
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS, add_window,
 			&info);
-
+	/*
+	 * See arch/x86/pci/acpi.c.
+	 * The desired pci bus might already be scanned in a quirk. We
+	 * should handle the case here, but it appears that IA64 hasn't
+	 * such quirk. So we just ignore the case now.
+	 */
 	pbus = pci_scan_bus_parented(NULL, bus, &pci_root_ops, controller);
 	if (pbus)
 		pcibios_setup_root_windows(pbus, controller);
diff -puN arch/x86/pci/acpi.c~acpi-unneccessary-to-scan-the-pci-bus-already-scanned arch/x86/pci/acpi.c
--- a/arch/x86/pci/acpi.c~acpi-unneccessary-to-scan-the-pci-bus-already-scanned
+++ a/arch/x86/pci/acpi.c
@@ -219,8 +219,21 @@ struct pci_bus * __devinit pci_acpi_scan
 	if (pxm >= 0)
 		sd->node = pxm_to_node(pxm);
 #endif
+	/*
+	 * Maybe the desired pci bus has been already scanned. In such case
+	 * it is unnecessary to scan the pci bus with the given domain,busnum.
+	 */
+	bus = pci_find_bus(domain, busnum);
+	if (bus) {
+		/*
+		 * If the desired bus exits, the content of bus->sysdata will
+		 * be replaced by sd.
+		 */
+		memcpy(bus->sysdata, sd, sizeof(*sd));
+		kfree(sd);
+	} else
+		bus = pci_scan_bus_parented(NULL, busnum, &pci_root_ops, sd);
 
-	bus = pci_scan_bus_parented(NULL, busnum, &pci_root_ops, sd);
 	if (!bus)
 		kfree(sd);
 
@@ -228,7 +241,7 @@ struct pci_bus * __devinit pci_acpi_scan
 	if (bus != NULL) {
 		if (pxm >= 0) {
 			printk("bus %d -> pxm %d -> node %d\n",
-				busnum, pxm, sd->node);
+				busnum, pxm, pxm_to_node(pxm));
 		}
 	}
 #endif
_
