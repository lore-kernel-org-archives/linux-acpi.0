From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] Export a func to find the corresponding PCI
	bus:seg.func of an ACPI device
Date: Mon, 15 Oct 2007 18:33:05 +0200
Message-ID: <1192465985.9847.585.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:51739 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763187AbXJOQdP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Oct 2007 12:33:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Christian Birchinger <joker@netswarm.net>, "Li, Shaohua" <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, ibm-acpi-devel <ibm-acpi-devel@lists.sourceforge.net>

Hi,

Li: Could you double check and comment on that one please. It works fine
here on a Lenovo ThinkPad...

These two should avoid the registration of a dummy ACPI device for
graphics card on recent Lenovo ThinkPads.

Christian: This is why you saw two devices in /proc/acpi/video
It would be great if you could check if it's working for you.


    Thomas

------------------

Export a func to find the corresponding PCI bus:seg.func of an ACPI device

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/pci_root.c |  155 ++++++++++++++++++++++++++++++++++++++----------
 include/linux/acpi.h    |    2 
 2 files changed, 127 insertions(+), 30 deletions(-)

Index: lenb/drivers/acpi/pci_root.c
===================================================================
--- lenb.orig/drivers/acpi/pci_root.c
+++ lenb/drivers/acpi/pci_root.c
@@ -32,6 +32,7 @@
 #include <linux/pm.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -184,31 +185,11 @@ static void acpi_pci_bridge_scan(struct 
 		}
 }
 
-static int acpi_pci_root_add(struct acpi_device *device)
+static int acpi_pci_root_get_seg_bus(struct acpi_device *device, u16 *seg, u16 *bus)
 {
-	int result = 0;
-	struct acpi_pci_root *root = NULL;
-	struct acpi_pci_root *tmp;
+
 	acpi_status status = AE_OK;
 	unsigned long value = 0;
-	acpi_handle handle = NULL;
-	struct acpi_device *child;
-
-
-	if (!device)
-		return -EINVAL;
-
-	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
-	if (!root)
-		return -ENOMEM;
-	INIT_LIST_HEAD(&root->node);
-
-	root->device = device;
-	strcpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
-	acpi_driver_data(device) = root;
-
-	device->ops.bind = acpi_pci_bind;
 
 	/* 
 	 * Segment
@@ -219,17 +200,16 @@ static int acpi_pci_root_add(struct acpi
 				       &value);
 	switch (status) {
 	case AE_OK:
-		root->id.segment = (u16) value;
+		*seg = (u16) value;
 		break;
 	case AE_NOT_FOUND:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Assuming segment 0 (no _SEG)\n"));
-		root->id.segment = 0;
+		*seg = 0;
 		break;
 	default:
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _SEG"));
-		result = -ENODEV;
-		goto end;
+		return -ENODEV;
 	}
 
 	/* 
@@ -241,17 +221,48 @@ static int acpi_pci_root_add(struct acpi
 				       &value);
 	switch (status) {
 	case AE_OK:
-		root->id.bus = (u16) value;
+		*bus = (u16) value;
 		break;
 	case AE_NOT_FOUND:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Assuming bus 0 (no _BBN)\n"));
-		root->id.bus = 0;
+		*bus = 0;
 		break;
 	default:
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BBN"));
-		result = -ENODEV;
-		goto end;
+		return -ENODEV;
 	}
+	return 0;
+}
+
+static int acpi_pci_root_add(struct acpi_device *device)
+{
+	int result = 0;
+	struct acpi_pci_root *root = NULL;
+	struct acpi_pci_root *tmp;
+	acpi_status status = AE_OK;
+	acpi_handle handle = NULL;
+	struct acpi_device *child;
+
+
+	if (!device)
+		return -EINVAL;
+
+	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
+	if (!root)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&root->node);
+
+	root->device = device;
+	strcpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
+	acpi_driver_data(device) = root;
+
+	device->ops.bind = acpi_pci_bind;
+
+	result = acpi_pci_root_get_seg_bus(device, &root->id.bus,
+					   &root->id.segment);
+	if (result < 0)
+		goto end;
 
 	/* Some systems have wrong _BBN */
 	list_for_each_entry(tmp, &acpi_pci_roots, node) {
@@ -392,3 +403,87 @@ static int __init acpi_pci_root_init(voi
 }
 
 subsys_initcall(acpi_pci_root_init);
+
+/*
+ * Find the struct pci_dev* structure associated to the given ACPI device
+ *
+ * The device might be deeper in the device tree, the function goes until the
+ * PCI root bridge and returns the registered PCI device in the PCI sublayer,
+ * e.g.:
+ *
+ * \_SB
+ *     PCI0
+ *         SATA          S-ATA controller
+ *             _ADR      PCI Address of the SATA controller
+ *             PRT0      Port 0 device
+ *                 _ADR  Physical port and multiplier topology
+ *             PRTn      Port n device
+ *
+ * Whether PRT0 or SATA is passed it will always return the pci_dev
+ * structure of the SATA device.
+ * Be aware that the PCI device could be a PCI root bridge (e.g. in AGP
+ * case). If you want to have the real PCI struct of it, you need PCI sublayer
+ * functions to map the PCI root bridge device to the PCI bus the device has
+ * been set up to.
+ *
+ * Returns:
+ *   - zero on success
+ *   - -EINVAL on a real error -> buggy BIOS...
+ *   - -ENODEV is there is no physicaly PCI device associated/registered
+ */
+
+int acpi_find_pci_device(struct acpi_device *device, struct pci_dev *pci)
+{
+	struct acpi_device *parent, *child;
+	unsigned int devfn;
+	u16 bus, seg;
+	int result;
+	const struct acpi_device_id root_bridge_ids[] = {
+		{PCI_ROOT_HID_STRING, 0},
+		{PCI_EXPRESS_ROOT_HID_STRING, 0},
+		{"", 0},
+	};
+	pci = NULL;
+
+	if (!device || !device->parent) {
+		return -EINVAL;
+	}
+	child = device;
+	parent = device->parent;
+
+	while (acpi_match_device_ids(parent, root_bridge_ids)) {
+		/* Passed device was not under a PCI root bus */
+		if (!parent)
+			return -EINVAL;
+
+		child = parent;
+		parent = parent->parent;
+
+	}
+
+	if (!child->flags.bus_address) {
+		printk (KERN_DEBUG PREFIX "Child device of PCI root bus has no"
+			" _ADR func\n");
+		return -EINVAL;
+	}
+
+	/* _ADR  is lowest 16 bit -> func, highest 16 bit -> slot
+	 * devfn is lowest  3 bit -> func, rest is        -> slot
+	 */
+	devfn = (acpi_device_adr(child) >> 13) |
+		(acpi_device_adr(child) & 0xFFFF);
+
+	result = acpi_pci_root_get_seg_bus(parent, &bus, &seg);
+	if (result < 0)
+		return -EINVAL;
+
+	pci = pci_get_bus_and_slot(bus, devfn);
+
+	/* There is no physical PCI device registered for the ACPI device */
+	if (!pci)
+		return -ENODEV;
+	pci_dev_put(pci);
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_find_pci_device);
Index: lenb/include/linux/acpi.h
===================================================================
--- lenb.orig/include/linux/acpi.h
+++ lenb/include/linux/acpi.h
@@ -170,6 +170,8 @@ struct acpi_prt_list {
 
 struct pci_dev;
 
+int acpi_find_pci_device(struct acpi_device *device, struct pci_dev *pci);
+
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 


