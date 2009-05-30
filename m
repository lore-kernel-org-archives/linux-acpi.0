From: Len Brown <lenb@kernel.org>
Subject: [PATCH 58/65] i7300_idle: allow testing on i5000-series hardware w/o
 re-compile
Date: Fri, 29 May 2009 21:42:36 -0400
Message-ID: <2f102607ac77354b02a76cf2748598ce9f270f08.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33022 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757376AbZE3BnF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:05 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00BXBORRY2C4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:04 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Testing the i7300_idle driver on i5000-series hardware required
an edit to i7300_idle.h to "#define SUPPORT_I5000 1" and a re-build
of both i7300_idle and ioat_dma.

Replace that build-time scheme with a load-time module parameter:
"7300_idle.forceload=1" to make it easier to test the driver
on hardware that while not officially validated, works fine
and is much more commonly available.

By default (no modparam) the driver will continue to load
only on the i7300.

Note that ioat_dma runs a copy of i7300_idle's probe routine
to know to reserve an IOAT channel for i7300_idle.
This change makes ioat_dma do that always on the i5000,
just like it does on the i7300.

Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Andrew Henroid <andrew.d.henroid@intel.com>
---
 drivers/dma/ioat_dma.c     |    2 +-
 drivers/idle/i7300_idle.c  |    6 +++++-
 include/linux/i7300_idle.h |   20 ++++++++++----------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/ioat_dma.c b/drivers/dma/ioat_dma.c
index 1955ee8..a600fc0 100644
--- a/drivers/dma/ioat_dma.c
+++ b/drivers/dma/ioat_dma.c
@@ -173,7 +173,7 @@ static int ioat_dma_enumerate_channels(struct ioatdma_device *device)
 	xfercap = (xfercap_scale == 0 ? -1 : (1UL << xfercap_scale));
 
 #ifdef  CONFIG_I7300_IDLE_IOAT_CHANNEL
-	if (i7300_idle_platform_probe(NULL, NULL) == 0) {
+	if (i7300_idle_platform_probe(NULL, NULL, 1) == 0) {
 		device->common.chancnt--;
 	}
 #endif
diff --git a/drivers/idle/i7300_idle.c b/drivers/idle/i7300_idle.c
index bf74039..949c97f 100644
--- a/drivers/idle/i7300_idle.c
+++ b/drivers/idle/i7300_idle.c
@@ -41,6 +41,10 @@ static int debug;
 module_param_named(debug, debug, uint, 0644);
 MODULE_PARM_DESC(debug, "Enable debug printks in this driver");
 
+static int forceload;
+module_param_named(forceload, forceload, uint, 0644);
+MODULE_PARM_DESC(debug, "Enable driver testing on unvalidated i5000");
+
 #define dprintk(fmt, arg...) \
 	do { if (debug) printk(KERN_INFO I7300_PRINT fmt, ##arg); } while (0)
 
@@ -552,7 +556,7 @@ static int __init i7300_idle_init(void)
 	cpus_clear(idle_cpumask);
 	total_us = 0;
 
-	if (i7300_idle_platform_probe(&fbd_dev, &ioat_dev))
+	if (i7300_idle_platform_probe(&fbd_dev, &ioat_dev, forceload))
 		return -ENODEV;
 
 	if (i7300_idle_thrt_save())
diff --git a/include/linux/i7300_idle.h b/include/linux/i7300_idle.h
index 05a80c4..1587b7d 100644
--- a/include/linux/i7300_idle.h
+++ b/include/linux/i7300_idle.h
@@ -16,35 +16,33 @@
 struct fbd_ioat {
 	unsigned int vendor;
 	unsigned int ioat_dev;
+	unsigned int enabled;
 };
 
 /*
  * The i5000 chip-set has the same hooks as the i7300
- * but support is disabled by default because this driver
- * has not been validated on that platform.
+ * but it is not enabled by default and must be manually
+ * manually enabled with "forceload=1" because it is
+ * only lightly validated.
  */
-#define SUPPORT_I5000 0
 
 static const struct fbd_ioat fbd_ioat_list[] = {
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT_CNB},
-#if SUPPORT_I5000
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT},
-#endif
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT_CNB, 1},
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT, 0},
 	{0, 0}
 };
 
 /* table of devices that work with this driver */
 static const struct pci_device_id pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_FBD_CNB) },
-#if SUPPORT_I5000
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
-#endif
 	{ } /* Terminating entry */
 };
 
 /* Check for known platforms with I/O-AT */
 static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
-						struct pci_dev **ioat_dev)
+						struct pci_dev **ioat_dev,
+						int enable_all)
 {
 	int i;
 	struct pci_dev *memdev, *dmadev;
@@ -69,6 +67,8 @@ static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
 	for (i = 0; fbd_ioat_list[i].vendor != 0; i++) {
 		if (dmadev->vendor == fbd_ioat_list[i].vendor &&
 		    dmadev->device == fbd_ioat_list[i].ioat_dev) {
+			if (!(fbd_ioat_list[i].enabled || enable_all))
+				continue;
 			if (fbd_dev)
 				*fbd_dev = memdev;
 			if (ioat_dev)
-- 
1.6.0.6

