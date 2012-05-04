From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Resend PATCH V2 7/7] usb/acpi: add usb check for the connect type of usb port
Date: Fri,  4 May 2012 11:06:43 +0800
Message-ID: <1336100803-28353-8-git-send-email-tianyu.lan@intel.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336100803-28353-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, mfm-Oo0r1OC9pj9iLUuM0BA3LQ@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

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

Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/core/hub.c      |   21 +++++++++++++
 drivers/usb/core/usb-acpi.c |   67 ++++++++++++++++++++++--------------------
 drivers/usb/core/usb.h      |    4 ++
 include/linux/usb.h         |    7 ++++
 4 files changed, 67 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 5ea9618..4aa9dc7 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -41,6 +41,7 @@ struct usb_hub_port {
 	void			*port_owner;
 	struct usb_device	*child;
 	unsigned long		platform_data;
+	enum usb_port_connect_type connect_type;
 };
 
 struct usb_hub {
@@ -4266,3 +4267,23 @@ unsigned long usb_get_hub_port_platform_data(struct usb_device *hdev, int port1)
 		return 0;
 	return hub->port_data[port1 - 1].platform_data;
 }
+
+void usb_set_hub_port_connect_type(struct usb_device *hdev, int port1,
+	enum usb_port_connect_type type)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (!hub || port1 > hdev->maxchild || port1 < 1)
+		return;
+	hub->port_data[port1 - 1].connect_type = type;
+}
+
+enum usb_port_connect_type
+usb_get_hub_port_connect_type(struct usb_device *hdev,	int port1)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (!hub || port1 > hdev->maxchild || port1 < 1)
+		return USB_PORT_CONNECT_TYPE_UNKNOWN;
+	return hub->port_data[port1 - 1].connect_type;
+}
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 984c559..ef7810b 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -19,58 +19,56 @@
 
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
 
 	if (upc->package.elements[0].integer.value)
-		udev->removable = USB_DEVICE_REMOVABLE;
-	else
-		udev->removable = USB_DEVICE_FIXED;
+		usb_set_hub_port_connect_type(hdev, port1,
+				pld.user_visible ?
+					USB_PORT_CONNECT_TYPE_HOT_PLUG :
+					USB_PORT_CONNECT_TYPE_HARD_WIRED);
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
 	struct device *parent;
 	acpi_handle *parent_handle;
+	enum usb_port_connect_type type;
 
 	if (!is_usb_device(dev))
 		return -ENODEV;
@@ -96,14 +94,18 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
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
+	type = usb_get_hub_port_connect_type(udev->parent, udev->portnum);
+	switch (type) {
+	case USB_PORT_CONNECT_TYPE_HOT_PLUG:
+		udev->removable = USB_DEVICE_REMOVABLE;
+		break;
+	case USB_PORT_CONNECT_TYPE_HARD_WIRED:
+		udev->removable = USB_DEVICE_FIXED;
+		break;
+	default:
+		udev->removable = USB_DEVICE_REMOVABLE_UNKNOWN;
+		break;
+	}
 
 	return 0;
 }
@@ -136,6 +138,7 @@ int usb_acpi_bind_hub_ports(struct usb_device *hdev)
 			continue;
 		usb_set_hub_port_platform_data(hdev, i,
 			(unsigned long)port_handle);
+		usb_acpi_check_port_connect_type(hdev, port_handle, i);
 	}
 	return 0;
 }
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index d69d5f6..26fcabc1 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -159,6 +159,10 @@ extern unsigned long usb_get_hub_port_platform_data(struct usb_device *hdev,
 	int port1);
 extern void usb_set_hub_port_platform_data(struct usb_device *hdev,
 	int port1, unsigned long data);
+extern enum usb_port_connect_type
+	usb_get_hub_port_connect_type(struct usb_device *hdev, int port1);
+extern void usb_set_hub_port_connect_type(struct usb_device *hdev, int port1,
+	enum usb_port_connect_type type);
 
 #ifdef CONFIG_ACPI
 extern int usb_acpi_register(void);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 5e7058d..848809a 100644
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
