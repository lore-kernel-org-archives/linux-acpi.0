From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/2] x86/PCI: for debuggability,
	show host bridge windows even when ignoring _CRS
Date: Wed, 04 Nov 2009 10:39:13 -0700
Message-ID: <20091104173913.17517.30881.stgit@bob.kio>
References: <20091104173601.17517.71697.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20091104173601.17517.71697.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We have occasional problems with PCI resource allocation, and sometimes
they could be avoided by paying attention to what ACPI tells us about
the host bridges.  This patch doesn't change the behavior, but it prints
window information that should make debugging easier.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/x86/pci/acpi.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 68b89dc..54db5a0 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -92,11 +92,12 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	start = addr.minimum + addr.translation_offset;
 	end = start + addr.address_length - 1;
 	if (info->res_num >= max_root_bus_resources) {
-		printk(KERN_WARNING "PCI: Failed to allocate 0x%lx-0x%lx "
-			"from %s for %s due to _CRS returning more than "
-			"%d resource descriptors\n", (unsigned long) start,
-			(unsigned long) end, root->name, info->name,
-			max_root_bus_resources);
+		if (pci_probe & PCI_USE__CRS)
+			printk(KERN_WARNING "PCI: Failed to allocate "
+			       "0x%lx-0x%lx from %s for %s due to _CRS "
+			       "returning more than %d resource descriptors\n",
+			       (unsigned long) start, (unsigned long) end,
+			       root->name, info->name, max_root_bus_resources);
 		return AE_OK;
 	}
 
@@ -107,6 +108,12 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	res->end = end;
 	res->child = NULL;
 
+	if (!(pci_probe & PCI_USE__CRS)) {
+		dev_printk(KERN_DEBUG, &info->bridge->dev,
+			   "host bridge window %pR (ignored)\n", res);
+		return AE_OK;
+	}
+
 	if (insert_resource(root, res)) {
 		dev_err(&info->bridge->dev,
 			"can't allocate host bridge window %pR\n", res);
@@ -132,6 +139,11 @@ get_current_resources(struct acpi_device *device, int busnum,
 	struct pci_root_info info;
 	size_t size;
 
+	if (!(pci_probe & PCI_USE__CRS))
+		dev_info(&device->dev,
+			 "ignoring host bridge windows from ACPI; "
+			 "boot with \"pci=use_crs\" to use them\n");
+
 	info.bridge = device;
 	info.bus = bus;
 	info.res_num = 0;
@@ -220,9 +232,7 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_device *device, int do
 	} else {
 		bus = pci_create_bus(NULL, busnum, &pci_root_ops, sd);
 		if (bus) {
-			if (pci_probe & PCI_USE__CRS)
-				get_current_resources(device, busnum, domain,
-							bus);
+			get_current_resources(device, busnum, domain, bus);
 			bus->subordinate = pci_scan_child_bus(bus);
 		}
 	}
