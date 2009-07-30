From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: USB runtime D3
Date: Thu, 30 Jul 2009 03:06:23 +0100
Message-ID: <20090730020623.GB26389@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48053 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbZG3CGX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2009 22:06:23 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

I've been playing with putting host controllers into D3 when the root 
hub is suspended, with a certain amount of success. My current 
implementation simply calls the suspend and resume functions in the HCD 
device's pm struct on bus_suspend and bus_resume. It's also necessary to 
flag the ACPI GPEs for the HCDs as runtime and enabled in order to get 
wakeup events. This is good enough for already plugged devices to work, 
and running lsusb powers up any idle ports and notices that devices have 
been plugged in. I also get an event when devices are unplugged.

This is obviously not entirely ideal, for a couple of reasons.

The first is that UHCI works perfectly providing I provide a remote 
wakeup. An SCI is fired via ACPI, a notification is sent to the 
appropriate device and we resume it quite happily. Unplugs also trigger 
the ACPI event. However, plugging in doesn't generate any kind of wakeup 
event, even though port0en and port1n are set in USB_RES. Is there any 
way to get UHCI to do this? I'm guessing that the power is being cut to 
the port when it suspends with no device connected.

The second is that EHCI generates a PME# notification on device plugin. 
This triggers an SCI and the PME# notification shows up as a GPE event. 
This causes the kernel to evaluate _L0D. On this Dell, that looks 
something like this:

_L0D {
	SMI(foo, Local0)
	if (Local0 & 0x1)
		Notify(some hardware)
	if (Local0 & 0x2)
		Notify(EHCI)
	if (Local0 & 0x4)
		Notify(EHCI 2)
}

However, Local0 ends up being 0 and no notification is fired. I'm 
therefore not able to acknowledge the PME and it fires again. This is 
obviously not ideal. Does anyone have any idea why this might be? The 
fact that this ends up in SMI code obviously makes things more awkward.

I've thought of a way that this could be made to work, but it's kind of 
hacky. A generic GPE handler could be registered and then scan all PCIe 
devices for a raised PME bit. It could then flag it and send a 
notification to the attached driver. EHCI could then force a rescan of 
all currently powered off USB devices.

The downside to this (other than it being a hack) is that I can't see an 
obvious way to work out what the appropriate GPE is. On Intel, internal 
PCI devices generate an event on GPE 0xd - but the PCI object only 
claims 0xb in its _PRW object.

Anyone have any ideas? I've attached the current version of my code, 
which is hacked up in various ways as I try to understand what's going 
on but should give some idea what I'm trying.

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index ea15b05..6199f9e 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -120,12 +120,45 @@ static int acpi_pci_sleep_wake(struct pci_dev *dev, bool enable)
 	return error;
 }
 
+static int acpi_pci_runtime_wake(struct pci_dev *dev, bool enable)
+{
+	acpi_status status;
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+	struct acpi_device *acpi_dev;
+
+	if (!handle) {
+		printk("Fail2\n");
+		return -ENODEV;
+	}
+
+	status = acpi_bus_get_device(handle, &acpi_dev);
+	if (ACPI_FAILURE(status)) {
+		printk("Fail3\n");
+		return -ENODEV;
+	}
+
+	printk("Setting GPE type\n");
+	acpi_set_gpe_type(acpi_dev->wakeup.gpe_device,
+			  acpi_dev->wakeup.gpe_number, ACPI_GPE_TYPE_RUNTIME);
+	if (enable) {
+		printk("Enabling GPE\n");
+		acpi_enable_gpe(acpi_dev->wakeup.gpe_device,
+				acpi_dev->wakeup.gpe_number);
+	}
+
+	printk("Sleep/wake\n");
+	acpi_pm_device_sleep_wake(&dev->dev, enable);
+
+	return 0;
+}
+
 static struct pci_platform_pm_ops acpi_pci_platform_pm = {
 	.is_manageable = acpi_pci_power_manageable,
 	.set_state = acpi_pci_set_power_state,
 	.choose_state = acpi_pci_choose_state,
 	.can_wakeup = acpi_pci_can_wakeup,
 	.sleep_wake = acpi_pci_sleep_wake,
+	.runtime_wake = acpi_pci_runtime_wake,
 };
 
 /* ACPI bus type */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dbd0f94..7933f08 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -428,6 +428,12 @@ static inline int platform_pci_sleep_wake(struct pci_dev *dev, bool enable)
 			pci_platform_pm->sleep_wake(dev, enable) : -ENODEV;
 }
 
+static inline int platform_pci_runtime_wake(struct pci_dev *dev, bool enable)
+{
+	return pci_platform_pm ?
+			pci_platform_pm->runtime_wake(dev, enable) : -ENODEV;
+}
+
 /**
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
  *                           given PCI device
@@ -1215,6 +1221,8 @@ int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
 	int error = 0;
 	bool pme_done = false;
 
+	return 0;
+
 	if (enable && !device_may_wakeup(&dev->dev))
 		return -EINVAL;
 
@@ -1239,6 +1247,33 @@ int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
 }
 
 /**
+ * pci_enable_runtime_wake - enable PCI device as runtime wakeup event source
+ * @dev: PCI device affected
+ * @enable: True to enable event generation; false to disable
+ *
+ * This enables the device as a runtime wakeup event source, or disables it.
+ * This typically requires platform support.
+ *
+ * RETURN VALUE:
+ * 0 is returned on success
+ * -EINVAL is returned if device is not supposed to wake up the system
+ * -ENODEV is returned if platform cannot support runtime PM on the device
+ */
+int pci_enable_runtime_wake(struct pci_dev *dev, bool enable)
+{
+	int error = 0;
+
+	if (!platform_pci_can_wakeup(dev)) {
+		printk("Fail1\n");
+		return -EINVAL;
+	}
+
+	error = platform_pci_runtime_wake(dev, enable);
+
+	return error;
+}
+
+/**
  * pci_wake_from_d3 - enable/disable device to wake up from D3_hot or D3_cold
  * @dev: PCI device to prepare
  * @enable: True to enable wake-up event generation; false to disable
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f73bcbe..6516931 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -34,6 +34,8 @@ extern int pci_mmap_fits(struct pci_dev *pdev, int resno,
  *
  * @sleep_wake: enables/disables the system wake up capability of given device
  *
+ * @runtime_wake: enables/disables runtime wake up capability of given device
+ *
  * If given platform is generally capable of power managing PCI devices, all of
  * these callbacks are mandatory.
  */
@@ -43,6 +45,7 @@ struct pci_platform_pm_ops {
 	pci_power_t (*choose_state)(struct pci_dev *dev);
 	bool (*can_wakeup)(struct pci_dev *dev);
 	int (*sleep_wake)(struct pci_dev *dev, bool enable);
+	int (*runtime_wake)(struct pci_dev *dev, bool enable);
 };
 
 extern int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 91f2885..9b11f6a 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -250,6 +250,11 @@ static int hcd_pci_suspend(struct device *dev)
 	 * link (except maybe for PME# resume signaling).  We'll enter a
 	 * low power state during suspend_noirq, if the hardware allows.
 	 */
+
+	device_set_wakeup_capable(dev, 1);
+	device_set_wakeup_enable(dev, 1);
+//	pci_enable_wake(pci_dev, PCI_D3hot, 1);
+	pci_enable_runtime_wake(pci_dev, 1);
 	pci_disable_device(pci_dev);
 	return retval;
 }
@@ -319,6 +324,7 @@ static int hcd_pci_resume_noirq(struct device *dev)
 
 	/* Go back to D0 and disable remote wakeup */
 	pci_back_from_sleep(pci_dev);
+	pci_pme_active(pci_dev, 0);
 	return 0;
 }
 
@@ -333,6 +339,7 @@ static int resume_common(struct device *dev, bool hibernated)
 		return 0;
 	}
 
+	pci_enable_runtime_wake(pci_dev, 0);
 	retval = pci_enable_device(pci_dev);
 	if (retval < 0) {
 		dev_err(dev, "can't re-enable after resume, %d!\n", retval);
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 95ccfa0..f53b0b8 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/utsname.h>
 #include <linux/mm.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
@@ -45,6 +46,13 @@
 #include "hcd.h"
 #include "hub.h"
 
+#ifdef CONFIG_ACPI
+static void hcd_setup_runtime_wakeup(struct usb_hcd *hcd);
+static void hcd_remove_runtime_wakeup(struct usb_hcd *hcd);
+#else
+static inline void hcd_setup_runtime_wakeup(struct usb_hcd *hcd) { }
+static inline void hcd_remove_runtime_wakeup(struct usb_hcd *hcd) { }
+#endif
 
 /*-------------------------------------------------------------------------*/
 
@@ -1730,6 +1738,47 @@ int usb_hcd_get_frame_number (struct usb_device *udev)
 
 #ifdef	CONFIG_PM
 
+
+static int hcd_suspend(struct usb_hcd *hcd)
+{
+	int rc = 0;
+	struct device *dev = hcd->self.controller;
+	struct device_driver *drv = dev->driver;
+
+	if (hcd->driver->runtime_wake)
+		rc = hcd->driver->runtime_wake(hcd);
+	else
+		rc = -EINVAL;
+
+	if (rc)
+		return rc;
+
+	if (drv->pm->suspend)
+		rc = drv->pm->suspend(dev);
+	if (rc)
+		return rc;
+
+	if (drv->pm->suspend_noirq)
+		rc = drv->pm->suspend_noirq(dev);
+	return rc;
+}
+
+static int hcd_resume(struct usb_hcd *hcd)
+{
+	int rc = 0;
+	struct device *dev = hcd->self.controller;
+	struct device_driver *drv = dev->driver;
+
+	if (drv->pm->resume_noirq)
+		rc = drv->pm->resume_noirq(dev);
+	if (rc)
+		return rc;
+
+	if (drv->pm->resume)
+		rc = drv->pm->resume(dev);
+	return rc;
+}
+
 int hcd_bus_suspend(struct usb_device *rhdev, pm_message_t msg)
 {
 	struct usb_hcd	*hcd = container_of(rhdev->bus, struct usb_hcd, self);
@@ -1741,12 +1790,15 @@ int hcd_bus_suspend(struct usb_device *rhdev, pm_message_t msg)
 	if (!hcd->driver->bus_suspend) {
 		status = -ENOENT;
 	} else {
+		rhdev->do_remote_wakeup = 1;
 		hcd->state = HC_STATE_QUIESCING;
 		status = hcd->driver->bus_suspend(hcd);
 	}
 	if (status == 0) {
 		usb_set_device_state(rhdev, USB_STATE_SUSPENDED);
 		hcd->state = HC_STATE_SUSPENDED;
+		if (device_can_wakeup(hcd->self.controller))
+			status = hcd_suspend(hcd);
 	} else {
 		hcd->state = old_state;
 		dev_dbg(&rhdev->dev, "bus %s fail, err %d\n",
@@ -1758,7 +1810,7 @@ int hcd_bus_suspend(struct usb_device *rhdev, pm_message_t msg)
 int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
 {
 	struct usb_hcd	*hcd = container_of(rhdev->bus, struct usb_hcd, self);
-	int		status;
+	int		status = 0;
 	int		old_state = hcd->state;
 
 	dev_dbg(&rhdev->dev, "usb %s%s\n",
@@ -1768,8 +1820,14 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
 	if (hcd->state == HC_STATE_RUNNING)
 		return 0;
 
-	hcd->state = HC_STATE_RESUMING;
-	status = hcd->driver->bus_resume(hcd);
+	if (device_can_wakeup(hcd->self.controller))
+		status = hcd_resume(hcd);
+
+	if (!status) {
+		hcd->state = HC_STATE_RESUMING;
+		status = hcd->driver->bus_resume(hcd);
+	}
+
 	if (status == 0) {
 		/* TRSMRCY = 10 msec */
 		msleep(10);
@@ -1966,6 +2024,7 @@ struct usb_hcd *usb_create_hcd (const struct hc_driver *driver,
 	hcd->rh_timer.data = (unsigned long) hcd;
 #ifdef CONFIG_PM
 	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
+	hcd_setup_runtime_wakeup(hcd);
 #endif
 
 	hcd->driver = driver;
@@ -1979,6 +2038,9 @@ static void hcd_release (struct kref *kref)
 {
 	struct usb_hcd *hcd = container_of (kref, struct usb_hcd, kref);
 
+#ifdef CONFIG_PM
+	hcd_remove_runtime_wakeup(hcd);
+#endif
 	kfree(hcd);
 }
 
@@ -2195,6 +2257,40 @@ usb_hcd_platform_shutdown(struct platform_device* dev)
 }
 EXPORT_SYMBOL_GPL(usb_hcd_platform_shutdown);
 
+#ifdef CONFIG_ACPI
+static void hcd_acpi_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct usb_hcd *hcd = data;
+	pm_message_t msg;
+
+	msg.event = PM_EVENT_AUTO | PM_EVENT_RESUME;
+
+	if (event == 0x2)
+		hcd_bus_resume(hcd->self.root_hub, msg);
+}
+
+static void hcd_setup_runtime_wakeup(struct usb_hcd *hcd)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(hcd->self.controller);
+
+	if (!handle)
+		return;
+
+	acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+				    hcd_acpi_notify, hcd);
+}
+
+static void hcd_remove_runtime_wakeup(struct usb_hcd *hcd)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(hcd->self.controller);
+
+	if (!handle)
+		return;
+
+	acpi_remove_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+				   hcd_acpi_notify);
+}
+#endif
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
diff --git a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
index ec5c67e..2bffe71 100644
--- a/drivers/usb/core/hcd.h
+++ b/drivers/usb/core/hcd.h
@@ -195,6 +195,9 @@ struct hc_driver {
 	/* shutdown HCD */
 	void	(*shutdown) (struct usb_hcd *hcd);
 
+	/* does the HCD support waking at runtime ? */
+	int	(*runtime_wake) (struct usb_hcd *hcd);
+
 	/* return current frame number */
 	int	(*get_frame_number) (struct usb_hcd *hcd);
 
diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index c2f1b7d..51f824b 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -357,6 +357,12 @@ static int ehci_pci_resume(struct usb_hcd *hcd, bool hibernated)
 	hcd->state = HC_STATE_SUSPENDED;
 	return 0;
 }
+
+static int ehci_pci_runtime_wake(struct usb_hcd *hcd)
+{
+	struct pci_dev		*pdev = to_pci_dev(hcd->self.controller);
+	return pci_enable_runtime_wake(pdev, 1);
+}
 #endif
 
 static const struct hc_driver ehci_pci_hc_driver = {
@@ -378,6 +384,7 @@ static const struct hc_driver ehci_pci_hc_driver = {
 #ifdef	CONFIG_PM
 	.pci_suspend =		ehci_pci_suspend,
 	.pci_resume =		ehci_pci_resume,
+	.runtime_wake =		ehci_pci_runtime_wake,
 #endif
 	.stop =			ehci_stop,
 	.shutdown =		ehci_shutdown,
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index d2ba04d..bad6015 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -414,6 +414,11 @@ static int ohci_pci_resume(struct usb_hcd *hcd, bool hibernated)
 	return 0;
 }
 
+static int ohci_pci_runtime_wake(struct usb_hcd *hcd)
+{
+	struct pci_dev		*pdev = to_pci_dev(hcd->self.controller);
+	return pci_enable_runtime_wake(pdev, 1);
+}
 #endif	/* CONFIG_PM */
 
 
@@ -441,6 +446,7 @@ static const struct hc_driver ohci_pci_hc_driver = {
 #ifdef	CONFIG_PM
 	.pci_suspend =		ohci_pci_suspend,
 	.pci_resume =		ohci_pci_resume,
+	.runtime_wake =		ohci_pci_runtime_wake,
 #endif
 
 	/*
diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
index 274751b..c194c76 100644
--- a/drivers/usb/host/uhci-hcd.c
+++ b/drivers/usb/host/uhci-hcd.c
@@ -849,6 +849,12 @@ static int uhci_pci_resume(struct usb_hcd *hcd, bool hibernated)
 	}
 	return 0;
 }
+
+static int uhci_pci_runtime_wake(struct usb_hcd *hcd)
+{
+	struct pci_dev		*pdev = to_pci_dev(hcd->self.controller);
+	return pci_enable_runtime_wake(pdev, 1);
+}
 #endif
 
 /* Wait until a particular device/endpoint's QH is idle, and free it */
@@ -910,6 +916,7 @@ static const struct hc_driver uhci_driver = {
 	.pci_resume =		uhci_pci_resume,
 	.bus_suspend =		uhci_rh_suspend,
 	.bus_resume =		uhci_rh_resume,
+	.runtime_wake =		uhci_pci_runtime_wake,
 #endif
 	.stop =			uhci_stop,
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 115fb7b..ac9290a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -734,6 +734,7 @@ pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 void pci_pme_active(struct pci_dev *dev, bool enable);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable);
+int pci_enable_runtime_wake(struct pci_dev *dev, bool enable);
 int pci_wake_from_d3(struct pci_dev *dev, bool enable);
 pci_power_t pci_target_state(struct pci_dev *dev);
 int pci_prepare_to_sleep(struct pci_dev *dev);

-- 
Matthew Garrett | mjg59@srcf.ucam.org
