From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V6 4/9] usb/acpi : rebinding usb with acpi since usb port being made a real device
Date: Wed,  4 Jul 2012 11:12:07 +0800
Message-ID: <1341371532-5118-4-git-send-email-tianyu.lan@intel.com>
References: <1341371532-5118-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341371532-5118-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In the ACPI DSDT table, only usb root hub and usb ports are acpi device nodes.
Original, binding the usb ports' acpi node with the usb device attached to the
port. The usb port is made a real device by previous patch. This patch is to
rebind the port's acpi node with port's struct device.

Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/core/hub.c      |   18 +++++++++++
 drivers/usb/core/usb-acpi.c |   67 +++++++++++++++++++++++++++++++++---------
 drivers/usb/core/usb.h      |   12 ++++++++
 3 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index adbb889..58b3aaf 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4988,3 +4988,21 @@ struct usb_device *usb_hub_find_child(struct usb_device *hdev,
 	return hub->ports[port1 - 1]->child;
 }
 EXPORT_SYMBOL_GPL(usb_hub_find_child);
+
+#ifdef CONFIG_ACPI
+/**
+ * usb_get_hub_port_acpi_handle - Get the usb port's acpi handle
+ * @hdev: USB device belonging to the usb hub
+ * @port1: port num of the port
+ *
+ * Return port's acpi handle if successful, NULL if params are
+ * invaild.
+ */
+acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
+	int port1)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+
+	return DEVICE_ACPI_HANDLE(&hub->ports[port1 - 1]->dev);
+}
+#endif
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 8947b20..47197bf 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -70,22 +70,59 @@ static int usb_acpi_check_pld(struct usb_device *udev, acpi_handle handle)
 static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
 {
 	struct usb_device *udev;
-	struct device *parent;
 	acpi_handle *parent_handle;
+	int port_num;
 
-	if (!is_usb_device(dev))
-		return -ENODEV;
-
-	udev = to_usb_device(dev);
-	parent = dev->parent;
-	parent_handle = DEVICE_ACPI_HANDLE(parent);
-
-	if (!parent_handle)
-		return -ENODEV;
-
-	*handle = acpi_get_child(parent_handle, udev->portnum);
-
-	if (!*handle)
+	/*
+	 * In the ACPI DSDT table, only usb root hub and usb ports are
+	 * acpi device nodes. The hierarchy like following.
+	 * Device (EHC1)
+	 *	Device (HUBN)
+	 *		Device (PR01)
+	 *			Device (PR11)
+	 *			Device (PR12)
+	 *			Device (PR13)
+	 *			...
+	 * So all binding process is divided into two parts. binding
+	 * root hub and usb ports.
+	 */
+	if (is_usb_device(dev)) {
+		udev = to_usb_device(dev);
+		if (udev->parent)
+			return -ENODEV;
+		/* root hub's parent is the usb hcd. */
+		parent_handle = DEVICE_ACPI_HANDLE(dev->parent);
+		*handle = acpi_get_child(parent_handle, udev->portnum);
+		if (!*handle)
+			return -ENODEV;
+		return 0;
+	} else if (is_usb_port(dev)) {
+		sscanf(dev_name(dev), "port%d", &port_num);
+		/* Get the struct usb_device point of port's hub */
+		udev = to_usb_device(dev->parent->parent);
+
+		/*
+		 * The root hub ports' parent is the root hub. The non-root-hub
+		 * ports' parent is the parent hub port which the hub is
+		 * connected to.
+		 */
+		if (!udev->parent) {
+			*handle = acpi_get_child(DEVICE_ACPI_HANDLE(&udev->dev),
+				port_num);
+			if (!*handle)
+				return -ENODEV;
+		} else {
+			parent_handle =
+				usb_get_hub_port_acpi_handle(udev->parent,
+				udev->portnum);
+			if (!parent_handle)
+				return -ENODEV;
+
+			*handle = acpi_get_child(parent_handle,	port_num);
+			if (!*handle)
+				return -ENODEV;
+		}
+	} else
 		return -ENODEV;
 
 	/*
@@ -102,7 +139,7 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
 
 static struct acpi_bus_type usb_acpi_bus = {
 	.bus = &usb_bus_type,
-	.find_bridge = NULL,
+	.find_bridge = usb_acpi_find_device,
 	.find_device = usb_acpi_find_device,
 };
 
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 67875a8..4aa20f4 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -1,5 +1,9 @@
 #include <linux/pm.h>
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
+
 struct dev_state;
 
 /* Functions local to drivers/usb/core/ */
@@ -111,6 +115,7 @@ extern struct bus_type usb_bus_type;
 extern struct device_type usb_device_type;
 extern struct device_type usb_if_device_type;
 extern struct device_type usb_ep_device_type;
+extern struct device_type usb_port_device_type;
 extern struct usb_device_driver usb_generic_driver;
 
 static inline int is_usb_device(const struct device *dev)
@@ -128,6 +133,11 @@ static inline int is_usb_endpoint(const struct device *dev)
 	return dev->type == &usb_ep_device_type;
 }
 
+static inline int is_usb_port(const struct device *dev)
+{
+	return dev->type == &usb_port_device_type;
+}
+
 /* Do the same for device drivers and interface drivers. */
 
 static inline int is_usb_device_driver(struct device_driver *drv)
@@ -162,6 +172,8 @@ extern void usb_notify_remove_bus(struct usb_bus *ubus);
 #ifdef CONFIG_ACPI
 extern int usb_acpi_register(void);
 extern void usb_acpi_unregister(void);
+extern acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
+	int port1);
 #else
 static inline int usb_acpi_register(void) { return 0; };
 static inline void usb_acpi_unregister(void) { };
-- 
1.7.6.rc2.8.g28eb

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
