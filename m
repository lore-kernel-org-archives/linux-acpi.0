From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V3 3/4] usb/acpi: add the support of usb hub ports' acpi binding without attached devices.
Date: Fri, 25 May 2012 22:06:26 +0800
Message-ID: <1337954787-28388-3-git-send-email-tianyu.lan@intel.com>
References: <1337954787-28388-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337954787-28388-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The usb port is a device in the acpi table but it's not in the linux
usb subsystem. USB hub port doesn't have struct device. So the acpi
glue framework only can cover the usb port connected with usb device
and store the acpi handle to struct device.archdata.acpi_handle. This
patch is to add member port_acpi_handle in the struct usb_hub_port to
store acpi handle. The acpi method "_UPC" and "_PLD" can be accessed
without attached device.

v2
 replace struct usb_hub_port member platform_data with member port_acpi_handle
to store acpi_handle

Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/core/hub.c      |   42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb-acpi.c |   37 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/core/usb.h      |    9 +++++++++
 3 files changed, 87 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 3f547f5..82658de 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -30,6 +30,10 @@
 
 #include "usb.h"
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
+
 /* if we are in debug mode, always announce new devices */
 #ifdef DEBUG
 #ifndef CONFIG_USB_ANNOUNCE_NEW_DEVICES
@@ -40,6 +44,9 @@
 struct usb_hub_port {
 	void			*port_owner;
 	struct usb_device	*child;
+#ifdef CONFIG_ACPI
+	acpi_handle		port_acpi_handle;
+#endif
 };
 
 struct usb_hub {
@@ -1485,6 +1492,7 @@ static int hub_configure(struct usb_hub *hub,
 	if (hub->has_indicators && blinkenlights)
 		hub->indicator [0] = INDICATOR_CYCLE;
 
+	usb_acpi_bind_hub_ports(hdev);
 	hub_activate(hub, HUB_INIT);
 	return 0;
 
@@ -4933,3 +4941,37 @@ struct usb_device *usb_get_hub_child(struct usb_device *hdev,
 }
 EXPORT_SYMBOL_GPL(usb_get_hub_child);
 
+#ifdef CONFIG_ACPI
+/**
+ * usb_set_hub_port_acpi_handle - Set the usb port's acpi handle
+ * @hdev: USB device belonging to the usb hub
+ * @port1: port num of the port
+ * @handle: port's acpi handle
+ */
+void usb_set_hub_port_acpi_handle(struct usb_device *hdev, int port1,
+	void *handle)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (port1 < 1 || port1 > hdev->maxchild)
+		return;
+	hub->port_data[port1 - 1].port_acpi_handle = handle;
+}
+
+/**
+ * usb_get_hub_port_acpi_handle - Get the usb port's acpi handle
+ * @hdev: USB device belonging to the usb hub
+ * @port1: port num of the port
+ *
+ * Return port's acpi handle if successful, NULL if params are
+ * invaild.
+ */
+acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev, int port1)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (port1 < 1 || port1 > hdev->maxchild)
+		return NULL;
+	return hub->port_data[port1 - 1].port_acpi_handle;
+}
+#endif
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 8947b20..e609664 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -83,7 +83,16 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
 	if (!parent_handle)
 		return -ENODEV;
 
-	*handle = acpi_get_child(parent_handle, udev->portnum);
+	/*
+	 * The root hub's acpi handle is got from acpi method.
+	 * Other device's acpi handle can be got from the usb hub
+	 * port's platform_data.
+	 */
+	if (!udev->parent)
+		*handle = acpi_get_child(parent_handle, udev->portnum);
+	else
+		*handle = usb_get_hub_port_acpi_handle(
+				udev->parent, udev->portnum);
 
 	if (!*handle)
 		return -ENODEV;
@@ -106,6 +115,32 @@ static struct acpi_bus_type usb_acpi_bus = {
 	.find_device = usb_acpi_find_device,
 };
 
+int usb_acpi_bind_hub_ports(struct usb_device *hdev)
+{
+	acpi_handle hub_handle = NULL;
+	acpi_handle port_handle = NULL;
+	struct device *dev = &hdev->dev;
+	int i;
+
+	hub_handle = DEVICE_ACPI_HANDLE(dev);
+	if (!hub_handle)
+		return -ENODEV;
+
+	/*
+	 * usb hub port is not a device in the usb subsystem but it is a device
+	 * in the acpi table. Store its acpi handle in the platform data of usb
+	 * hub port.
+	 */
+	for (i = 1; i <= hdev->maxchild; i++) {
+		port_handle = acpi_get_child(hub_handle, i);
+		if (!port_handle)
+			continue;
+		usb_set_hub_port_acpi_handle(hdev, i,
+			port_handle);
+	}
+	return 0;
+}
+
 int usb_acpi_register(void)
 {
 	return register_acpi_bus_type(&usb_acpi_bus);
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 5c5c538..b2b0cb3 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -1,5 +1,8 @@
 #include <linux/pm.h>
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
 /* Functions local to drivers/usb/core/ */
 
 extern int usb_create_sysfs_dev_files(struct usb_device *dev);
@@ -159,7 +162,13 @@ extern void usb_notify_remove_bus(struct usb_bus *ubus);
 #ifdef CONFIG_ACPI
 extern int usb_acpi_register(void);
 extern void usb_acpi_unregister(void);
+extern int usb_acpi_bind_hub_ports(struct usb_device *hdev);
+extern void usb_set_hub_port_acpi_handle(struct usb_device *hdev,
+	int port1, acpi_handle handle);
+extern acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
+	int port1);
 #else
 static inline int usb_acpi_register(void) { return 0; };
 static inline void usb_acpi_unregister(void) { };
+static inline int usb_acpi_bind_hub_ports(struct usb_device *dev) { return 0; };
 #endif
-- 
1.7.6.rc2.8.g28eb

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
