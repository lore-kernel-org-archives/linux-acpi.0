From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH v6 4/8] usb: add runtime pm support for usb port device
Date: Mon, 21 Jan 2013 22:18:03 +0800
Message-ID: <1358777887-2656-5-git-send-email-tianyu.lan@intel.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38114 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab3AUOUl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2013 09:20:41 -0500
In-Reply-To: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, rjw@sisk.pl, oneukum@suse.de
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>

This patch is to add runtime pm callback for usb port device.
Set/clear PORT_POWER feature in the resume/suspend callbak.
Add portnum for struct usb_port to record port number. Do
pm_rumtime_get_sync/put(portdev) when a device is plugged/unplugged
to prevent it from being powered off when it is active.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/hub.c  |   18 ++++++++++++++++++
 drivers/usb/core/hub.h  |    4 ++++
 drivers/usb/core/port.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 29ca6ed..8c1f9a5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -714,6 +714,18 @@ static void hub_tt_work(struct work_struct *work)
 	spin_unlock_irqrestore (&hub->tt.lock, flags);
 }
 
+int usb_hub_set_port_power(struct usb_device *hdev, int port1,
+		bool set)
+{
+	int ret;
+
+	if (set)
+		ret = set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+	else
+		ret = clear_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+	return ret;
+}
+
 /**
  * usb_hub_clear_tt_buffer - clear control/bulk TT state in high speed hub
  * @urb: an URB associated with the failed or incomplete split transaction
@@ -1569,6 +1581,7 @@ static void hub_disconnect(struct usb_interface *intf)
 	kfree(hub->status);
 	kfree(hub->buffer);
 
+	pm_suspend_ignore_children(&intf->dev, false);
 	kref_put(&hub->kref, hub_release);
 }
 
@@ -1671,6 +1684,7 @@ descriptor_error:
 
 	usb_set_intfdata (intf, hub);
 	intf->needs_remote_wakeup = 1;
+	pm_suspend_ignore_children(&intf->dev, true);
 
 	if (hdev->speed == USB_SPEED_HIGH)
 		highspeed_hubs++;
@@ -1997,6 +2011,8 @@ void usb_disconnect(struct usb_device **pdev)
 
 		sysfs_remove_link(&udev->dev.kobj, "port");
 		sysfs_remove_link(&port_dev->dev.kobj, "device");
+
+		pm_runtime_put(&port_dev->dev);
 	}
 
 	usb_remove_ep_devs(&udev->ep0);
@@ -2307,6 +2323,8 @@ int usb_new_device(struct usb_device *udev)
 			sysfs_remove_link(&udev->dev.kobj, "port");
 			goto fail;
 		}
+
+		pm_runtime_get_sync(&port_dev->dev);
 	}
 
 	(void) usb_create_ep_devs(&udev->dev, &udev->ep0, udev);
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index d16a7c9..8ea6bc8 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -79,12 +79,14 @@ struct usb_hub {
  * @dev: generic device interface
  * @port_owner: port's owner
  * @connect_type: port's connect type
+ * @portnum: port index num based one
  */
 struct usb_port {
 	struct usb_device *child;
 	struct device dev;
 	struct dev_state *port_owner;
 	enum usb_port_connect_type connect_type;
+	u8 portnum;
 };
 
 #define to_usb_port(_dev) \
@@ -94,4 +96,6 @@ extern int usb_hub_create_port_device(struct usb_hub *hub,
 		int port1);
 extern void usb_hub_remove_port_device(struct usb_hub *hub,
 		int port1);
+extern int usb_hub_set_port_power(struct usb_device *hdev,
+		int port1, bool set);
 
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 4dfa254..bd08f7e 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/pm_qos.h>
 
 #include "hub.h"
 
@@ -70,9 +71,50 @@ static void usb_port_device_release(struct device *dev)
 	kfree(port_dev);
 }
 
+#ifdef CONFIG_USB_SUSPEND
+static int usb_port_runtime_resume(struct device *dev)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+	struct usb_device *hdev = to_usb_device(dev->parent->parent);
+	struct usb_interface *intf = to_usb_interface(dev->parent);
+	int retval;
+
+	usb_autopm_get_interface(intf);
+	retval = usb_hub_set_port_power(hdev, port_dev->portnum, true);
+	usb_autopm_put_interface(intf);
+	return retval;
+}
+
+static int usb_port_runtime_suspend(struct device *dev)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+	struct usb_device *hdev = to_usb_device(dev->parent->parent);
+	struct usb_interface *intf = to_usb_interface(dev->parent);
+	int retval;
+
+	if (dev_pm_qos_flags(&port_dev->dev, PM_QOS_FLAG_NO_POWER_OFF)
+			== PM_QOS_FLAGS_ALL)
+		return -EAGAIN;
+
+	usb_autopm_get_interface(intf);
+	retval = usb_hub_set_port_power(hdev, port_dev->portnum, false);
+	usb_autopm_put_interface(intf);
+	return retval;
+}
+#endif
+
+static const struct dev_pm_ops usb_port_pm_ops = {
+#ifdef CONFIG_USB_SUSPEND
+	.runtime_suspend =	usb_port_runtime_suspend,
+	.runtime_resume =	usb_port_runtime_resume,
+	.runtime_idle =		pm_generic_runtime_idle,
+#endif
+};
+
 struct device_type usb_port_device_type = {
 	.name =		"usb_port",
 	.release =	usb_port_device_release,
+	.pm = &usb_port_pm_ops,
 };
 
 int usb_hub_create_port_device(struct usb_hub *hub, int port1)
@@ -87,6 +129,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	}
 
 	hub->ports[port1 - 1] = port_dev;
+	port_dev->portnum = port1;
 	port_dev->dev.parent = hub->intfdev;
 	port_dev->dev.groups = port_dev_group;
 	port_dev->dev.type = &usb_port_device_type;
@@ -96,6 +139,8 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	if (retval)
 		goto error_register;
 
+	pm_runtime_set_active(&port_dev->dev);
+	pm_runtime_enable(&port_dev->dev);
 	usb_acpi_register_power_resources(&port_dev->dev);
 
 	return 0;
-- 
1.7.9.5

