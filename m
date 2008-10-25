From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/9] i7300_idle: Disable ioat channel only on platforms where
 ile driver can load
Date: Sat, 25 Oct 2008 04:13:31 -0400
Message-ID: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
References: <1224922419-7823-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60431 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbYJYIOm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 04:14:42 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9A00CMIC8H1DH2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 25 Oct 2008 03:14:42 -0500 (CDT)
In-reply-to: <1224922419-7823-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venki Pallipadi <venkatesh.pallipadi@intel.com>

Based on input from Andi Kleen:
share the platform detection code with ioat_dma and disable the channel in
dma engine only for specific platforms.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/dma/ioat_dma.c     |    5 ++-
 drivers/idle/i7300_idle.c  |   72 +-------------------------------------
 include/linux/i7300_idle.h |   83 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 71 deletions(-)
 create mode 100644 include/linux/i7300_idle.h

diff --git a/drivers/dma/ioat_dma.c b/drivers/dma/ioat_dma.c
index f8396ca..fd1631d 100644
--- a/drivers/dma/ioat_dma.c
+++ b/drivers/dma/ioat_dma.c
@@ -33,6 +33,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/workqueue.h>
+#include <linux/i7300_idle.h>
 #include "ioatdma.h"
 #include "ioatdma_registers.h"
 #include "ioatdma_hw.h"
@@ -172,7 +173,9 @@ static int ioat_dma_enumerate_channels(struct ioatdma_device *device)
 	xfercap = (xfercap_scale == 0 ? -1 : (1UL << xfercap_scale));
 
 #if CONFIG_I7300_IDLE_IOAT_CHANNEL
-	device->common.chancnt--;
+	if (i7300_idle_platform_probe(NULL, NULL) == 0) {
+		device->common.chancnt--;
+	}
 #endif
 	for (i = 0; i < device->common.chancnt; i++) {
 		ioat_chan = kzalloc(sizeof(*ioat_chan), GFP_KERNEL);
diff --git a/drivers/idle/i7300_idle.c b/drivers/idle/i7300_idle.c
index 59d1bbc..79d47f2 100644
--- a/drivers/idle/i7300_idle.c
+++ b/drivers/idle/i7300_idle.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/debugfs.h>
 #include <linux/stop_machine.h>
+#include <linux/i7300_idle.h>
 
 #include <asm/idle.h>
 
@@ -505,77 +506,8 @@ static struct notifier_block i7300_idle_nb = {
 	.notifier_call = i7300_idle_notifier,
 };
 
-/*
- * I/O AT controls (PCI bus 0 device 8 function 0)
- * DIMM controls (PCI bus 0 device 16 function 1)
- */
-#define IOAT_BUS 0
-#define IOAT_DEVFN PCI_DEVFN(8, 0)
-#define MEMCTL_BUS 0
-#define MEMCTL_DEVFN PCI_DEVFN(16, 1)
-
-struct fbd_ioat {
-	unsigned int vendor;
-	unsigned int ioat_dev;
-};
-
-/*
- * The i5000 chip-set has the same hooks as the i7300
- * but support is disabled by default because this driver
- * has not been validated on that platform.
- */
-#define SUPPORT_I5000 0
-
-static const struct fbd_ioat fbd_ioat_list[] = {
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT_CNB},
-#if SUPPORT_I5000
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT},
-#endif
-	{0, 0}
-};
-
-/* table of devices that work with this driver */
-static const struct pci_device_id pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_FBD_CNB) },
-#if SUPPORT_I5000
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
-#endif
-	{ } /* Terminating entry */
-};
-
 MODULE_DEVICE_TABLE(pci, pci_tbl);
 
-/* Check for known platforms with I/O-AT */
-static int __init i7300_idle_platform_probe(void)
-{
-	int i;
-
-	fbd_dev = pci_get_bus_and_slot(MEMCTL_BUS, MEMCTL_DEVFN);
-	if (!fbd_dev)
-		return -ENODEV;
-
-	for (i = 0; pci_tbl[i].vendor != 0; i++) {
-		if (fbd_dev->vendor == pci_tbl[i].vendor &&
-		    fbd_dev->device == pci_tbl[i].device) {
-			break;
-		}
-	}
-	if (pci_tbl[i].vendor == 0)
-		return -ENODEV;
-
-	ioat_dev = pci_get_bus_and_slot(IOAT_BUS, IOAT_DEVFN);
-	if (!ioat_dev)
-		return -ENODEV;
-
-	for (i = 0; fbd_ioat_list[i].vendor != 0; i++) {
-		if (ioat_dev->vendor == fbd_ioat_list[i].vendor &&
-		    ioat_dev->device == fbd_ioat_list[i].ioat_dev) {
-			return 0;
-		}
-	}
-	return -ENODEV;
-}
-
 int stats_open_generic(struct inode *inode, struct file *fp)
 {
 	fp->private_data = inode->i_private;
@@ -617,7 +549,7 @@ static int __init i7300_idle_init(void)
 	cpus_clear(idle_cpumask);
 	total_us = 0;
 
-	if (i7300_idle_platform_probe())
+	if (i7300_idle_platform_probe(&fbd_dev, &ioat_dev))
 		return -ENODEV;
 
 	if (i7300_idle_thrt_save())
diff --git a/include/linux/i7300_idle.h b/include/linux/i7300_idle.h
new file mode 100644
index 0000000..05a80c4
--- /dev/null
+++ b/include/linux/i7300_idle.h
@@ -0,0 +1,83 @@
+
+#ifndef I7300_IDLE_H
+#define I7300_IDLE_H
+
+#include <linux/pci.h>
+
+/*
+ * I/O AT controls (PCI bus 0 device 8 function 0)
+ * DIMM controls (PCI bus 0 device 16 function 1)
+ */
+#define IOAT_BUS 0
+#define IOAT_DEVFN PCI_DEVFN(8, 0)
+#define MEMCTL_BUS 0
+#define MEMCTL_DEVFN PCI_DEVFN(16, 1)
+
+struct fbd_ioat {
+	unsigned int vendor;
+	unsigned int ioat_dev;
+};
+
+/*
+ * The i5000 chip-set has the same hooks as the i7300
+ * but support is disabled by default because this driver
+ * has not been validated on that platform.
+ */
+#define SUPPORT_I5000 0
+
+static const struct fbd_ioat fbd_ioat_list[] = {
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT_CNB},
+#if SUPPORT_I5000
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT},
+#endif
+	{0, 0}
+};
+
+/* table of devices that work with this driver */
+static const struct pci_device_id pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_FBD_CNB) },
+#if SUPPORT_I5000
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
+#endif
+	{ } /* Terminating entry */
+};
+
+/* Check for known platforms with I/O-AT */
+static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
+						struct pci_dev **ioat_dev)
+{
+	int i;
+	struct pci_dev *memdev, *dmadev;
+
+	memdev = pci_get_bus_and_slot(MEMCTL_BUS, MEMCTL_DEVFN);
+	if (!memdev)
+		return -ENODEV;
+
+	for (i = 0; pci_tbl[i].vendor != 0; i++) {
+		if (memdev->vendor == pci_tbl[i].vendor &&
+		    memdev->device == pci_tbl[i].device) {
+			break;
+		}
+	}
+	if (pci_tbl[i].vendor == 0)
+		return -ENODEV;
+
+	dmadev = pci_get_bus_and_slot(IOAT_BUS, IOAT_DEVFN);
+	if (!dmadev)
+		return -ENODEV;
+
+	for (i = 0; fbd_ioat_list[i].vendor != 0; i++) {
+		if (dmadev->vendor == fbd_ioat_list[i].vendor &&
+		    dmadev->device == fbd_ioat_list[i].ioat_dev) {
+			if (fbd_dev)
+				*fbd_dev = memdev;
+			if (ioat_dev)
+				*ioat_dev = dmadev;
+
+			return 0;
+		}
+	}
+	return -ENODEV;
+}
+
+#endif
-- 
1.5.6.5

