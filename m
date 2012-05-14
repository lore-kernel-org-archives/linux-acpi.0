From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] usb/acpi: add usb check for the connect type of usb port
Date: Mon, 14 May 2012 21:14:28 +0800
Message-ID: <1337001268-3100-3-git-send-email-tianyu.lan@intel.com>
References: <1337001268-3100-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337001268-3100-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
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
 drivers/usb/core/hub.c      |   45 +++++++++++++++++++++++++++++
 drivers/usb/core/usb-acpi.c |   67 ++++++++++++++++++++++--------------------
 drivers/usb/core/usb.h      |    4 ++
 include/linux/usb.h         |    7 ++++
 4 files changed, 91 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 93581c1..69c3b74 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -47,6 +47,7 @@ struct usb_hub_port {
 #ifdef CONFIG_ACPI
 	acpi_handle		port_acpi_handle;
 #endif
+	enum usb_port_connect_type connect_type;
 };
 
 struct usb_hub {
@@ -4266,6 +4267,50 @@ struct usb_device *usb_get_hub_child_device(struct usb_device *hdev,
 }
 EXPORT_SYMBOL_GPL(usb_get_hub_child_device);
 
+/**
+ * usb_set_hub_port_connect_type - set hub port connect type.
+ *
+ * @param hdev: USB device belonging to the usb hub
+ * @param port1: port num of the port
+ * @param type: connect type of the port
+ *		USB_PORT_CONNECT_TYPE_UNKNOWN
+ *		USB_PORT_CONNECT_TYPE_HOT_PLUG
+ *		USB_PORT_CONNECT_TYPE_HARD_WIRED
+ *		USB_PORT_NOT_USED
+ */
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
+/**
+ * usb_get_hub_port_connect_type - Get the port's connect
+ * type
+ *
+ * @param hdev: USB device belonging to the usb hub
+ * @param port1: port num of the port
+ *
+ * @return: connect type of the port
+ *		USB_PORT_CONNECT_TYPE_UNKNOWN
+ *		USB_PORT_CONNECT_TYPE_HOT_PLUG
+ *		USB_PORT_CONNECT_TYPE_HARD_WIRED
+ *		USB_PORT_NOT_USED
+ */
+enum usb_port_connect_type
+usb_get_hub_port_connect_type(struct usb_device *hdev,	int port1)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (!hub || port1 > hdev->maxchild || port1 < 1)
+		return USB_PORT_CONNECT_TYPE_UNKNOWN;
+	return hub->port_data[port1 - 1].connect_type;
+}
+
 #ifdef CONFIG_ACPI
 /**
  * usb_set_hub_port_acpi_handle - Set the usb port's acpi handle
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 1ed73a1..21a4b56 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -19,20 +19,32 @@
 
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
 	if (!upc || (upc->type != ACPI_TYPE_PACKAGE)
 		|| upc->package.count != 4) {
 		ret = -EINVAL;
@@ -40,38 +52,24 @@ static int usb_acpi_check_upc(struct usb_device *udev, acpi_handle handle)
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
@@ -97,14 +95,18 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
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
@@ -137,6 +139,7 @@ int usb_acpi_bind_hub_ports(struct usb_device *hdev)
 			continue;
 		usb_set_hub_port_acpi_handle(hdev, i,
 			port_handle);
+		usb_acpi_check_port_connect_type(hdev, port_handle, i);
 	}
 	return 0;
 }
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index b2b0cb3..da78c15 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -158,6 +158,10 @@ extern void usb_notify_add_device(struct usb_device *udev);
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
index 69163a0..2256b78 100644
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
 /**
  * struct usb_device - kernel's representation of a USB device
  * @devnum: device number; address on a USB bus
-- 
1.7.9

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
