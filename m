From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [RFC PATCH V4 2/3] USB/ACPI: Add usb port's acpi power control in the xhci PORT_POWER feature request process.
Date: Wed,  6 Jun 2012 15:39:34 +0800
Message-ID: <1338968375-25834-2-git-send-email-tianyu.lan@intel.com>
References: <1338968375-25834-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18532 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698Ab2FFHqU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Jun 2012 03:46:20 -0400
In-Reply-To: <1338968375-25834-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com

On our developping machine, bios can provide usb port's  power control via
acpi. This patch is to provide usb port's power control way through setting
or clearing PORT_POWER feature requests. Add two functions usb_acpi_power_manageable()
and usb_acpi_set_power_state(). The first one is used to find whether the
usb port has acpi power resource and the second is to set the power state.
They are invoked in the xhci_hub_control() where clearing or setting PORT_POWER
feature requests are processed.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/usb-acpi.c |   28 ++++++++++++++++++++++++++++
 drivers/usb/host/xhci-hub.c |   10 ++++++++++
 include/linux/usb.h         |   10 ++++++++++
 3 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 82c90d0..e95f26f 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -19,6 +19,34 @@
 
 #include "usb.h"
 
+bool usb_acpi_power_manageable(struct usb_device *hdev, int port1)
+{
+	acpi_handle port_handle;
+
+	port_handle = usb_get_hub_port_acpi_handle(hdev,
+		port1);
+	return port_handle ? acpi_bus_power_manageable(port_handle) : false;
+}
+EXPORT_SYMBOL_GPL(usb_acpi_power_manageable);
+
+int usb_acpi_set_power_state(struct usb_device *hdev, int port1, bool enable)
+{
+	acpi_handle port_handle;
+	unsigned char state;
+	int error = -EINVAL;
+
+	port_handle = (acpi_handle)usb_get_hub_port_acpi_handle(hdev,
+		port1);
+	state = enable ? ACPI_STATE_D0 : ACPI_STATE_D3_COLD;
+	error = acpi_bus_set_power(port_handle, state);
+	if (!error)
+		dev_dbg(&hdev->dev, "The power of hub port %d was set to %s\n",
+			port1, enable ? "enable" : "disabe");
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(usb_acpi_set_power_state);
+
 static int usb_acpi_check_port_connect_type(struct usb_device *hdev,
 	acpi_handle handle, int port1)
 {
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 2c55fcf..0ce48b3 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -728,6 +728,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 			temp = xhci_readl(xhci, port_array[wIndex]);
 			xhci_dbg(xhci, "set port power, actual port %d status  = 0x%x\n", wIndex, temp);
+
+			if (usb_acpi_power_manageable(hcd->self.root_hub,
+					wIndex + 1))
+				usb_acpi_set_power_state(hcd->self.root_hub,
+					wIndex + 1, true);
 			break;
 		case USB_PORT_FEAT_RESET:
 			temp = (temp | PORT_RESET);
@@ -830,6 +835,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_POWER:
 			xhci_writel(xhci, temp & ~PORT_POWER,
 				port_array[wIndex]);
+
+			if (usb_acpi_power_manageable(hcd->self.root_hub,
+					wIndex + 1))
+				usb_acpi_set_power_state(hcd->self.root_hub,
+					wIndex + 1, false);
 			break;
 		default:
 			goto error;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index feb0a04..92f8898 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -599,6 +599,16 @@ extern int usb_lock_device_for_reset(struct usb_device *udev,
 extern int usb_reset_device(struct usb_device *dev);
 extern void usb_queue_reset_device(struct usb_interface *dev);
 
+#ifdef CONFIG_ACPI
+extern int usb_acpi_set_power_state(struct usb_device *hdev, int port,
+	bool enable);
+extern bool usb_acpi_power_manageable(struct usb_device *hdev, int port);
+#else
+static inline int usb_acpi_set_power_state(struct usb_device *hdev, int port,
+	bool enable) { return 0; }
+static inline bool usb_acpi_power_manageable(struct usb_device *hdev, int port)
+	{ return 0; }
+#endif
 
 /* USB autosuspend and autoresume */
 #ifdef CONFIG_USB_SUSPEND
-- 
1.7.6.rc2.8.g28eb

