From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V7 7/9] USB/ACPI: Add usb port's acpi power control in the xhci PORT_POWER feature request process.
Date: Fri,  6 Jul 2012 14:13:58 +0800
Message-ID: <1341555240-17248-7-git-send-email-tianyu.lan@intel.com>
References: <1341555240-17248-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35723 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139Ab2GFGW3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Jul 2012 02:22:29 -0400
In-Reply-To: <1341555240-17248-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com

Change since v1: use variable temp to record the return value of
usb_acpi_power_manageable().

On our developping machine, bios can provide usb port's  power control via
acpi. This patch is to provide usb port's power control way through setting
or clearing PORT_POWER feature requests. Add two functions usb_acpi_power_manageable()
and usb_acpi_set_power_state(). The first one is used to find whether the
usb port has acpi power resource and the second is to set the power state.
They are invoked in the xhci_hub_control() where clearing or setting PORT_POWER
feature requests are processed.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/usb-acpi.c |   62 +++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-hub.c |   12 ++++++++
 include/linux/usb.h         |   10 +++++++
 3 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 404d86a..0ef7d42 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -19,6 +19,68 @@
 
 #include "usb.h"
 
+/**
+ * usb_acpi_power_manageable - check whether usb port has
+ * acpi power resource.
+ * @hdev: USB device belonging to the usb hub
+ * @index: port index based zero
+ *
+ * Return true if the port has acpi power resource and false if no.
+ */
+bool usb_acpi_power_manageable(struct usb_device *hdev, int index)
+{
+	acpi_handle port_handle;
+	int port1 = index + 1;
+
+	port_handle = usb_get_hub_port_acpi_handle(hdev,
+		port1);
+	if (port_handle)
+		return acpi_bus_power_manageable(port_handle);
+	else
+		return false;
+}
+EXPORT_SYMBOL_GPL(usb_acpi_power_manageable);
+
+/**
+ * usb_acpi_set_power_state - control usb port's power via acpi power
+ * resource
+ * @hdev: USB device belonging to the usb hub
+ * @index: port index based zero
+ * @enable: power state expected to be set
+ *
+ * Notice to use usb_acpi_power_manageable() to check whether the usb port
+ * has acpi power resource before invoking this function.
+ *
+ * Returns 0 on success, else negative errno.
+ */
+int usb_acpi_set_power_state(struct usb_device *hdev, int index, bool enable)
+{
+	acpi_handle port_handle;
+	unsigned char state;
+	int port1 = index + 1;
+	int error = -EINVAL;
+
+	port_handle = (acpi_handle)usb_get_hub_port_acpi_handle(hdev,
+		port1);
+	if (!port_handle)
+		return error;
+
+	if (enable)
+		state = ACPI_STATE_D0;
+	else
+		state = ACPI_STATE_D3_COLD;
+
+	error = acpi_bus_set_power(port_handle, state);
+	if (!error)
+		dev_dbg(&hdev->dev, "The power of hub port %d was set to %d\n",
+			port1, enable);
+	else
+		dev_dbg(&hdev->dev, "The power of hub port failed to be set\n");
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(usb_acpi_set_power_state);
+
 static int usb_acpi_check_port_connect_type(struct usb_device *hdev,
 	acpi_handle handle, int port1)
 {
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 2c55fcf..b990541 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -728,6 +728,12 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 			temp = xhci_readl(xhci, port_array[wIndex]);
 			xhci_dbg(xhci, "set port power, actual port %d status  = 0x%x\n", wIndex, temp);
+
+			temp = usb_acpi_power_manageable(hcd->self.root_hub,
+					wIndex);
+			if (temp)
+				usb_acpi_set_power_state(hcd->self.root_hub,
+						wIndex, true);
 			break;
 		case USB_PORT_FEAT_RESET:
 			temp = (temp | PORT_RESET);
@@ -830,6 +836,12 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_POWER:
 			xhci_writel(xhci, temp & ~PORT_POWER,
 				port_array[wIndex]);
+
+			temp = usb_acpi_power_manageable(hcd->self.root_hub,
+					wIndex);
+			if (temp)
+				usb_acpi_set_power_state(hcd->self.root_hub,
+						wIndex, false);
 			break;
 		default:
 			goto error;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 0fc5e03..4de6d7a 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -597,6 +597,16 @@ extern int usb_lock_device_for_reset(struct usb_device *udev,
 extern int usb_reset_device(struct usb_device *dev);
 extern void usb_queue_reset_device(struct usb_interface *dev);
 
+#ifdef CONFIG_ACPI
+extern int usb_acpi_set_power_state(struct usb_device *hdev, int index,
+	bool enable);
+extern bool usb_acpi_power_manageable(struct usb_device *hdev, int index);
+#else
+static inline int usb_acpi_set_power_state(struct usb_device *hdev, int index,
+	bool enable) { return 0; }
+static inline bool usb_acpi_power_manageable(struct usb_device *hdev, int index)
+	{ return true; }
+#endif
 
 /* USB autosuspend and autoresume */
 #ifdef CONFIG_USB_SUSPEND
-- 
1.7.6.rc2.8.g28eb

