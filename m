From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [RFC PATCH 4/4] usb/acpi: add usb check for the connect type of usb port
Date: Mon, 19 Mar 2012 22:33:46 +0800
Message-ID: <1332167626-5806-4-git-send-email-tianyu.lan@intel.com>
References: <1332167626-5806-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63807 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030834Ab2CSOgX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Mar 2012 10:36:23 -0400
In-Reply-To: <1332167626-5806-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, mjg@redhat.com, linux-usb@vger.kernel.org, sarah.a.sharp@intel.com

Check the connect type of usb port when getting the usb port's
acpi_handle and store result into connect_type in the struct
usb_hub_port.

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
 drivers/usb/core/hub.c      |   27 +++++++++++++++++-
 drivers/usb/core/usb-acpi.c |   64 +++++++++++++++++++++----------------------
 drivers/usb/core/usb.h      |    4 +++
 include/linux/usb.h         |    7 +++++
 4 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 90877f0..5e8976d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -40,6 +40,7 @@
 struct usb_hub_port {
 	void			*port_owner;
 	unsigned long		platform_data;
+	enum usb_port_connect_type connect_type;
 };
 
 struct usb_hub {
@@ -132,7 +133,7 @@ MODULE_PARM_DESC(initial_descriptor_timeout,
  *
  * For maximum flexibility there are two boolean parameters to control the
  * hub driver's behavior.  On the first initialization attempt, if the
- * "old_scheme_first" parameter is set then the old scheme will be used,
+.iiies * "old_scheme_first" parameter is set then the old scheme will be used,
  * otherwise the new scheme is used.  If that fails and "use_both_schemes"
  * is set, then the driver will make another attempt, using the other scheme.
  */
@@ -4174,3 +4175,27 @@ int usb_get_hub_port_platform_data(struct usb_device *udev, int port,
 	*data = hub->port_data[port - 1].platform_data;
 	return 0;
 }
+
+int usb_set_hub_port_connect_type(struct usb_device *hdev, int port,
+	enum usb_port_connect_type type)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (port > hub->descriptor->bNbrPorts || port < 1)
+		return -EINVAL;
+
+	hub->port_data[port - 1].connect_type = type;
+	return 0;
+}
+
+int usb_get_hub_port_connect_type(struct usb_device *hdev, int port,
+	enum usb_port_connect_type *type)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (port > hub->descriptor->bNbrPorts || port < 1)
+		return -EINVAL;
+
+	*type = hub->port_data[port - 1].connect_type;
+	return 0;
+}
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 6ecff04..3a3b07b 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -19,58 +19,57 @@
 
 #include "usb.h"
 
-static int usb_acpi_check_upc(struct usb_device *udev, acpi_handle handle)
+static int usb_acpi_check_port_connect_type(struct usb_device *hdev,
+	acpi_handle handle, int port)
 {
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *upc;
+	struct acpi_pld pld;
 	int ret = 0;
 
-	status = acpi_evaluate_object(handle, "_UPC", NULL, &buffer);
+	/**
+	 * Accoding to ACPI Spec 9.13. PLD indicates whether usb port is
+	 * user visible and _UPC indicates whether it is connectable. If
+	 * the port was visible and connectable, it could be freely connected
+	 * and disconnected with USB devices. If no visible and connectable,
+	 * a usb device is directly hard-wired to the port. If no visible and
+	 * no connectable, the port would be not used.
+	 */
+	status = acpi_get_physical_device_location(handle, &pld);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
 
+	status = acpi_evaluate_object(handle, "_UPC", NULL, &buffer);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
 	upc = buffer.pointer;
-
 	if (!upc || (upc->type != ACPI_TYPE_PACKAGE) || upc->package.count != 4) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (upc->package.elements[0].integer.value)
-		udev->removable = USB_DEVICE_REMOVABLE;
-	else
-		udev->removable = USB_DEVICE_FIXED;
+	if (upc->package.elements[0].integer.value && pld.user_visible)
+		usb_set_hub_port_connect_type(hdev, port,
+			USB_PORT_CONNECT_TYPE_HOT_PLUG);
+	else if (upc->package.elements[0].integer.value && !pld.user_visible)
+		usb_set_hub_port_connect_type(hdev, port,
+			USB_PORT_CONNECT_TYPE_HARD_WIRED);
+	else if (!upc->package.elements[0].integer.value && !pld.user_visible)
+		usb_set_hub_port_connect_type(hdev, port, USB_PORT_NOT_USED);
 
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
 	struct device *parent;
 	acpi_handle *parent_handle;
+	enum usb_port_connect_type type;
 
 	if (!is_usb_device(dev))
 		return -ENODEV;
@@ -96,14 +95,12 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
 	if (!*handle)
 		return -ENODEV;
 
-	/*
-	 * PLD will tell us whether a port is removable to the user or
-	 * not. If we don't get an answer from PLD (it's not present
-	 * or it's malformed) then try to infer it from UPC. If a
-	 * device isn't connectable then it's probably not removable.
-	 */
-	if (usb_acpi_check_pld(udev, *handle) != 0)
-		usb_acpi_check_upc(udev, *handle);
+	usb_get_hub_port_connect_type(udev->parent, udev->portnum, &type);
+
+	if (type == USB_PORT_CONNECT_TYPE_HOT_PLUG)
+		udev->removable = USB_DEVICE_REMOVABLE;
+	else if (type == USB_PORT_CONNECT_TYPE_HARD_WIRED)
+		udev->removable = USB_DEVICE_FIXED;
 
 	return 0;
 }
@@ -137,6 +134,7 @@ int usb_acpi_bind_hub_ports(struct usb_device *hdev, int portnum)
 		if (usb_set_hub_port_platform_data(hdev, i,
 				(unsigned long)port_handle) < 0)
 			return -ENODEV;
+		usb_acpi_check_port_connect_type(hdev, port_handle, i);
 	}
 	return 0;
 }
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index b780246..23e6693 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -158,6 +158,10 @@ extern int usb_get_hub_port_platform_data(struct usb_device *udev,
 		int port, unsigned long *data);
 extern int usb_set_hub_port_platform_data(struct usb_device *udev,
 		int port, unsigned long data);
+extern int usb_get_hub_port_connect_type(struct usb_device *hdev, int port,
+	enum usb_port_connect_type *type);
+extern int usb_set_hub_port_connect_type(struct usb_device *hdev, int port,
+	enum usb_port_connect_type type);
 
 #ifdef CONFIG_ACPI
 extern int usb_acpi_register(void);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 0c51663..0741ea3 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -382,6 +382,13 @@ enum usb_device_removable {
 	USB_DEVICE_FIXED,
 };
 
+enum usb_port_connect_type {
+	USB_PORT_CONNECT_TYPE_UNKNOWN = 0,
+	USB_PORT_CONNECT_TYPE_HOT_PLUG,
+	USB_PORT_CONNECT_TYPE_HARD_WIRED,
+	USB_PORT_NOT_USED,
+};
+
 /**
  * struct usb_device - kernel's representation of a USB device
  * @devnum: device number; address on a USB bus
-- 
1.7.6.rc2.8.g28eb

