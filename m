From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] usb: Add support for runtime power management of the hcd
Date: Mon,  9 Nov 2009 17:43:30 -0500
Message-ID: <1257806610-6570-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49348 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbZKIWnm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2009 17:43:42 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-usb@vger.kernel.org, rjw@sisk.pl, stern@rowland.harvard.edu, Matthew Garrett <mjg@redhat.com>

The PCI runtime power management code means that we can implement support
for powering down PCI host controllers. This patchset adds core support code
along with a new hcd flag (HCD_RUNTIME_PM) that allows hosts to opt in if
they support this functionality. Successfully tested with Intel EHCI and
UHCI, though the UHCI code may need to pay more attention to vendor-specific
features.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/usb/core/hcd-pci.c  |   30 +++++++++++++++++++++++++++++-
 drivers/usb/core/hcd.c      |    9 +++++++++
 drivers/usb/core/hcd.h      |    1 +
 drivers/usb/host/ehci-pci.c |    2 +-
 drivers/usb/host/uhci-hcd.c |    2 +-
 5 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 91f2885..f32e954 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -232,7 +232,7 @@ static int hcd_pci_suspend(struct device *dev)
 	if (retval)
 		return retval;
 
-	/* We might already be suspended (runtime PM -- not yet written) */
+	/* We might already be suspended */
 	if (pci_dev->current_state != PCI_D0)
 		return retval;
 
@@ -363,6 +363,32 @@ static int hcd_pci_restore(struct device *dev)
 	return resume_common(dev, true);
 }
 
+static int hcd_pci_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct usb_hcd *hcd = pci_get_drvdata(pci_dev);
+	int retval;
+
+	if (!(hcd->driver->flags & HCD_RUNTIME_PM))
+		return -EINVAL;
+
+	retval = hcd_pci_suspend(dev);
+	if (retval)
+		return retval;
+
+	retval = hcd_pci_suspend_noirq(dev);
+	if (retval)
+		hcd_pci_resume(dev);
+
+	return retval;
+}
+
+static int hcd_pci_runtime_resume(struct device *dev)
+{
+	hcd_pci_resume_noirq(dev);
+	return resume_common(dev, false);
+}
+
 struct dev_pm_ops usb_hcd_pci_pm_ops = {
 	.suspend	= hcd_pci_suspend,
 	.suspend_noirq	= hcd_pci_suspend_noirq,
@@ -376,6 +402,8 @@ struct dev_pm_ops usb_hcd_pci_pm_ops = {
 	.poweroff_noirq	= hcd_pci_suspend_noirq,
 	.restore_noirq	= hcd_pci_resume_noirq,
 	.restore	= hcd_pci_restore,
+	.runtime_suspend = hcd_pci_runtime_suspend,
+	.runtime_resume	= hcd_pci_runtime_resume,
 };
 EXPORT_SYMBOL_GPL(usb_hcd_pci_pm_ops);
 
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 34de475..abd75c0 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -38,6 +38,7 @@
 #include <asm/unaligned.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/usb.h>
 
@@ -1764,6 +1765,7 @@ int hcd_bus_suspend(struct usb_device *rhdev, pm_message_t msg)
 	if (status == 0) {
 		usb_set_device_state(rhdev, USB_STATE_SUSPENDED);
 		hcd->state = HC_STATE_SUSPENDED;
+		pm_runtime_put(hcd->self.controller);
 	} else {
 		hcd->state = old_state;
 		dev_dbg(&rhdev->dev, "bus %s fail, err %d\n",
@@ -1785,6 +1787,7 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
 	if (hcd->state == HC_STATE_RUNNING)
 		return 0;
 
+	pm_runtime_get_sync(hcd->self.controller);
 	hcd->state = HC_STATE_RESUMING;
 	status = hcd->driver->bus_resume(hcd);
 	if (status == 0) {
@@ -1798,6 +1801,7 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
 		hcd->state = old_state;
 		dev_dbg(&rhdev->dev, "bus %s fail, err %d\n",
 				"resume", status);
+		pm_runtime_put(hcd->self.controller);
 		if (status != -ESHUTDOWN)
 			usb_hc_died(hcd);
 	}
@@ -1985,6 +1989,9 @@ struct usb_hcd *usb_create_hcd (const struct hc_driver *driver,
 	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
 #endif
 
+	pm_runtime_enable(dev);
+	pm_runtime_get(dev);
+
 	hcd->driver = driver;
 	hcd->product_desc = (driver->product_desc) ? driver->product_desc :
 			"USB Host Controller";
@@ -1996,6 +2003,8 @@ static void hcd_release (struct kref *kref)
 {
 	struct usb_hcd *hcd = container_of (kref, struct usb_hcd, kref);
 
+	pm_runtime_put_sync(hcd->self.controller);
+
 	kfree(hcd);
 }
 
diff --git a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
index 79782a1..182a8b7 100644
--- a/drivers/usb/core/hcd.h
+++ b/drivers/usb/core/hcd.h
@@ -171,6 +171,7 @@ struct hc_driver {
 	int	flags;
 #define	HCD_MEMORY	0x0001		/* HC regs use memory (else I/O) */
 #define	HCD_LOCAL_MEM	0x0002		/* HC needs local memory */
+#define	HCD_RUNTIME_PM	0x0004		/* HC supports handling runtime PM */
 #define	HCD_USB11	0x0010		/* USB 1.1 */
 #define	HCD_USB2	0x0020		/* USB 2.0 */
 #define	HCD_USB3	0x0040		/* USB 3.0 */
diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 378861b..5602101 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -370,7 +370,7 @@ static const struct hc_driver ehci_pci_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq =			ehci_irq,
-	.flags =		HCD_MEMORY | HCD_USB2,
+	.flags =		HCD_MEMORY | HCD_USB2 | HCD_RUNTIME_PM,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
index 5cd0e48..c6e50aa 100644
--- a/drivers/usb/host/uhci-hcd.c
+++ b/drivers/usb/host/uhci-hcd.c
@@ -900,7 +900,7 @@ static const struct hc_driver uhci_driver = {
 
 	/* Generic hardware linkage */
 	.irq =			uhci_irq,
-	.flags =		HCD_USB11,
+	.flags =		HCD_USB11 | HCD_RUNTIME_PM,
 
 	/* Basic lifecycle operations */
 	.reset =		uhci_init,
-- 
1.6.5.2

