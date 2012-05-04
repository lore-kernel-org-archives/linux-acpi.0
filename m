From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Resend PATCH V2 6/7] usb/acpi: add the support of usb hub ports' acpi binding without attached devices.
Date: Fri,  4 May 2012 11:06:42 +0800
Message-ID: <1336100803-28353-7-git-send-email-tianyu.lan@intel.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336100803-28353-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, mfm-Oo0r1OC9pj9iLUuM0BA3LQ@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The usb port is a device in the acpi table but it's not in the linux
usb subsystem. USB hub port doesn't have struct device. So the acpi
glue framework only can cover the usb port connected with usb device
and store the acpi handle to struct device.archdata.acpi_handle. This
patch adds the member platform_data in the struct usb_hub_port and
gets the hub port's acpi_handle and store it in the port's platform_data
to resolve no attached device no binding problem. The acpi method "_UPC"
and "_PLD" can be accessed without attached device.

Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/core/hub.c      |   20 ++++++++++++++++++++
 drivers/usb/core/usb-acpi.c |   37 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/core/usb.h      |    6 ++++++
 3 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index bdf46fb..5ea9618 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -40,6 +40,7 @@
 struct usb_hub_port {
 	void			*port_owner;
 	struct usb_device	*child;
+	unsigned long		platform_data;
 };
 
 struct usb_hub {
@@ -1263,6 +1264,7 @@ static int hub_configure(struct usb_hub *hub,
 	if (hub->has_indicators && blinkenlights)
 		hub->indicator [0] = INDICATOR_CYCLE;
 
+	usb_acpi_bind_hub_ports(hdev);
 	hub_activate(hub, HUB_INIT);
 	return 0;
 
@@ -4246,3 +4248,21 @@ struct usb_device *usb_get_hub_child_device(struct usb_device *hdev,
 }
 EXPORT_SYMBOL_GPL(usb_get_hub_child_device);
 
+void usb_set_hub_port_platform_data(struct usb_device *hdev, int port1,
+	unsigned long data)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (!hub || port1 > hdev->maxchild || port1 < 1)
+		return;
+	hub->port_data[port1 - 1].platform_data = data;
+}
+
+unsigned long usb_get_hub_port_platform_data(struct usb_device *hdev, int port1)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	if (!hub || port1 > hdev->maxchild || port1 < 1)
+		return 0;
+	return hub->port_data[port1 - 1].platform_data;
+}
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index e49373a..984c559 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -82,7 +82,16 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
 	if (!parent_handle)
 		return -ENODEV;
 
-	*handle = acpi_get_child(parent_handle, udev->portnum);
+	/**
+	 * The root hub's acpi handle is got from acpi method.
+	 * Other device's acpi handle can be got from the usb hub
+	 * port's platform_data.
+	 */
+	if (!udev->parent)
+		*handle = acpi_get_child(parent_handle, udev->portnum);
+	else
+		*handle = (acpi_handle)usb_get_hub_port_platform_data(
+				udev->parent, udev->portnum);
 
 	if (!*handle)
 		return -ENODEV;
@@ -105,6 +114,32 @@ static struct acpi_bus_type usb_acpi_bus = {
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
+	/**
+	 * The usb hub port is not a device in the usb subsystem but it is a device
+	 * in the acpi table. Store its acpi handle in the platform data of usb
+	 * hub port.
+	 */
+	for (i = 1; i <= hdev->maxchild; i++) {
+		port_handle = acpi_get_child(hub_handle, i);
+		if (!port_handle)
+			continue;
+		usb_set_hub_port_platform_data(hdev, i,
+			(unsigned long)port_handle);
+	}
+	return 0;
+}
+
 int usb_acpi_register(void)
 {
 	return register_acpi_bus_type(&usb_acpi_bus);
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 5c5c538..d69d5f6 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -155,11 +155,17 @@ extern void usb_notify_add_device(struct usb_device *udev);
 extern void usb_notify_remove_device(struct usb_device *udev);
 extern void usb_notify_add_bus(struct usb_bus *ubus);
 extern void usb_notify_remove_bus(struct usb_bus *ubus);
+extern unsigned long usb_get_hub_port_platform_data(struct usb_device *hdev,
+	int port1);
+extern void usb_set_hub_port_platform_data(struct usb_device *hdev,
+	int port1, unsigned long data);
 
 #ifdef CONFIG_ACPI
 extern int usb_acpi_register(void);
 extern void usb_acpi_unregister(void);
+extern int usb_acpi_bind_hub_ports(struct usb_device *hdev);
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
