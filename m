From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH v6 7/8] usb: add usb_device_allow_power_off() and usb_device_prevent_power_off() function.
Date: Mon, 21 Jan 2013 22:18:06 +0800
Message-ID: <1358777887-2656-8-git-send-email-tianyu.lan@intel.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34715 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934Ab3AUOVM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2013 09:21:12 -0500
In-Reply-To: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, rjw@sisk.pl, oneukum@suse.de
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>

Some usb devices can't be resumed correctly after power off. This
patch is to add usb_device_allow_power_off() and usb_device_prevent_power_off()
for device's driver. Call pm_runtime_get_sync(portdev) to increase port's usage
count and then port will not be suspended. The device will not be powered off.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/port.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 0c51d24..0334d91 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -18,11 +18,39 @@
 
 #include <linux/slab.h>
 #include <linux/pm_qos.h>
+#include <linux/module.h>
 
 #include "hub.h"
 
 static const struct attribute_group *port_dev_group[];
 
+/**
+ * usb_device_control_power_off - Allow or prohibit power off device.
+ * @udev: target usb device
+ * @allow: choice of allow or prohibit
+ *
+ * Call pm_runtime_get/put_sync(portdev) to allow or prohibit target
+ * usb device to be powered off in the kernel. The operations of setting
+ * true and false should be couple. The default status is allowed.
+ */
+int usb_device_control_power_off(struct usb_device *udev, bool allow)
+{
+	struct usb_port *port_dev;
+
+	if (!udev->parent)
+		return -EINVAL;
+
+	port_dev = hdev_to_hub(udev->parent)->ports[udev->portnum - 1];
+
+	if (allow)
+		pm_runtime_put_sync(&port_dev->dev);
+	else
+		pm_runtime_get_sync(&port_dev->dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_device_control_power_off);
+
 static ssize_t show_port_connect_type(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-- 
1.7.9.5

