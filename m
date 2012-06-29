From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V5 5/8] usb/acpi: add check for the connect type of usb port
Date: Fri, 29 Jun 2012 14:19:56 +0800
Message-ID: <1340950799-3321-5-git-send-email-tianyu.lan@intel.com>
References: <1340950799-3321-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64347 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162Ab2F2G23 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Jun 2012 02:28:29 -0400
In-Reply-To: <1340950799-3321-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com

Change since v4: Remove some redundant kerneldocs and fix typo.

Change since v3: Rebase on the patch "make usb port a real device"

Check the connect type of usb port when getting the usb port's
acpi_handle and store result into connect_type in the struct
usb_port.

Accoding to ACPI Spec 9.13. PLD indicates whether usb port is
user visible and _UPC indicates whether it is connectable. If
the port was visible and connectable, it could be freely connected
and disconnected with USB devices. If no visible and connectable,
a usb device is directly hard-wired to the port. If no visible and
no connectable, the port would be not used.

When a device was found on the port, if the connect_type was hot-plug,
then the device would be removable. If the connect_type was hard-wired,
the device would be non-removable.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/hub.c      |   32 +++++++++++++++++
 drivers/usb/core/usb-acpi.c |   80 ++++++++++++++++++++++++-------------------
 drivers/usb/core/usb.h      |    4 ++
 include/linux/usb.h         |    7 ++++
 4 files changed, 88 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 16a1282..9012c73 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -41,6 +41,7 @@ struct usb_port {
 	struct usb_device *child;
 	struct device dev;
 	struct dev_state *port_owner;
+	enum usb_port_connect_type connect_type;
 };
 
 struct usb_hub {
@@ -4989,6 +4990,37 @@ struct usb_device *usb_hub_get_child(struct usb_device *hdev,
 }
 EXPORT_SYMBOL_GPL(usb_hub_get_child);
 
+/**
+ * usb_set_hub_port_connect_type - set hub port connect type.
+ * @hdev: USB device belonging to the usb hub
+ * @port1: port num of the port
+ * @type: connect type of the port
+ */
+void usb_set_hub_port_connect_type(struct usb_device *hdev, int port1,
+	enum usb_port_connect_type type)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	hub->ports[port1 - 1]->connect_type = type;
+}
+
+/**
+ * usb_get_hub_port_connect_type - Get the port's connect
+ * type
+ * @hdev: USB device belonging to the usb hub
+ * @port1: port num of the port
+ *
+ * Return connect type of the port and if input params are
+ *	invalid, return USB_PORT_CONNECT_TYPE_UNKNOWN.
+ */
+enum usb_port_connect_type
+usb_get_hub_port_connect_type(struct usb_device *hdev,	int port1)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	return hub->ports[port1 - 1]->connect_type;
+}
+
 #ifdef CONFIG_ACPI
 /**
  * usb_get_hub_port_acpi_handle - Get the usb port's acpi handle
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 47197bf..404d86a 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -19,20 +19,29 @@
 
 #include "usb.h"
 
-static int usb_acpi_check_upc(struct usb_device *udev, acpi_handle handle)
+static int usb_acpi_check_port_connect_type(struct usb_device *hdev,
+	acpi_handle handle, int port1)
 {
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *upc;
+	struct acpi_pld pld;
 	int ret = 0;
 
-	status = acpi_evaluate_object(handle, "_UPC", NULL, &buffer);
-
+	/*
+	 * Accoding to ACPI Spec 9.13. PLD indicates whether usb port is
+	 * user visible and _UPC indicates whether it is connectable. If
+	 * the port was visible and connectable, it could be freely connected
+	 * and disconnected with USB devices. If no visible and connectable,
+	 * a usb device is directly hard-wired to the port. If no visible and
+	 * no connectable, the port would be not used.
+	 */
+	status = acpi_get_physical_device_location(handle, &pld);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
+	status = acpi_evaluate_object(handle, "_UPC", NULL, &buffer);
 	upc = buffer.pointer;
-
 	if (!upc || (upc->type != ACPI_TYPE_PACKAGE)
 		|| upc->package.count != 4) {
 		ret = -EINVAL;
@@ -40,33 +49,20 @@ static int usb_acpi_check_upc(struct usb_device *udev, acpi_handle handle)
 	}
 
 	if (upc->package.elements[0].integer.value)
-		udev->removable = USB_DEVICE_REMOVABLE;
-	else
-		udev->removable = USB_DEVICE_FIXED;
+		if (pld.user_visible)
+			usb_set_hub_port_connect_type(hdev, port1,
+				USB_PORT_CONNECT_TYPE_HOT_PLUG);
+		else
+			usb_set_hub_port_connect_type(hdev, port1,
+				USB_PORT_CONNECT_TYPE_HARD_WIRED);
+	else if (!pld.user_visible)
+		usb_set_hub_port_connect_type(hdev, port1, USB_PORT_NOT_USED);
 
 out:
 	kfree(upc);
 	return ret;
 }
 
-static int usb_acpi_check_pld(struct usb_device *udev, acpi_handle handle)
-{
-	acpi_status status;
-	struct acpi_pld pld;
-
-	status = acpi_get_physical_device_location(handle, &pld);
-
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	if (pld.user_visible)
-		udev->removable = USB_DEVICE_REMOVABLE;
-	else
-		udev->removable = USB_DEVICE_FIXED;
-
-	return 0;
-}
-
 static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
 {
 	struct usb_device *udev;
@@ -88,8 +84,30 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
 	 */
 	if (is_usb_device(dev)) {
 		udev = to_usb_device(dev);
-		if (udev->parent)
+		if (udev->parent) {
+			enum usb_port_connect_type type;
+
+			/*
+			 * According usb port's connect type to set usb device's
+			 * removability.
+			 */
+			type = usb_get_hub_port_connect_type(udev->parent,
+				udev->portnum);
+			switch (type) {
+			case USB_PORT_CONNECT_TYPE_HOT_PLUG:
+				udev->removable = USB_DEVICE_REMOVABLE;
+				break;
+			case USB_PORT_CONNECT_TYPE_HARD_WIRED:
+				udev->removable = USB_DEVICE_FIXED;
+				break;
+			default:
+				udev->removable = USB_DEVICE_REMOVABLE_UNKNOWN;
+				break;
+			}
+
 			return -ENODEV;
+		}
+
 		/* root hub's parent is the usb hcd. */
 		parent_handle = DEVICE_ACPI_HANDLE(dev->parent);
 		*handle = acpi_get_child(parent_handle, udev->portnum);
@@ -122,18 +140,10 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
 			if (!*handle)
 				return -ENODEV;
 		}
+		usb_acpi_check_port_connect_type(udev, *handle, port_num);
 	} else
 		return -ENODEV;
 
-	/*
-	 * PLD will tell us whether a port is removable to the user or
-	 * not. If we don't get an answer from PLD (it's not present
-	 * or it's malformed) then try to infer it from UPC. If a
-	 * device isn't connectable then it's probably not removable.
-	 */
-	if (usb_acpi_check_pld(udev, *handle) != 0)
-		usb_acpi_check_upc(udev, *handle);
-
 	return 0;
 }
 
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 4aa20f4..bbd7df4 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -168,6 +168,10 @@ extern void usb_notify_add_device(struct usb_device *udev);
 extern void usb_notify_remove_device(struct usb_device *udev);
 extern void usb_notify_add_bus(struct usb_bus *ubus);
 extern void usb_notify_remove_bus(struct usb_bus *ubus);
+extern enum usb_port_connect_type
+	usb_get_hub_port_connect_type(struct usb_device *hdev, int port1);
+extern void usb_set_hub_port_connect_type(struct usb_device *hdev, int port1,
+	enum usb_port_connect_type type);
 
 #ifdef CONFIG_ACPI
 extern int usb_acpi_register(void);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 84ac047..016fa98 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -378,6 +378,13 @@ enum usb_device_removable {
 	USB_DEVICE_FIXED,
 };
 
+enum usb_port_connect_type {
+	USB_PORT_CONNECT_TYPE_UNKNOWN = 0,
+	USB_PORT_CONNECT_TYPE_HOT_PLUG,
+	USB_PORT_CONNECT_TYPE_HARD_WIRED,
+	USB_PORT_NOT_USED,
+};
+
 /*
  * USB 3.0 Link Power Management (LPM) parameters.
  *
-- 
1.7.6.rc2.8.g28eb

