From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 6/7] usb/acpi: add the support of usb hub ports' acpi binding without attached devices.
Date: Tue, 17 Apr 2012 14:02:01 +0800
Message-ID: <1334642522-22021-7-git-send-email-tianyu.lan@intel.com>
References: <1334642522-22021-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:19892 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753957Ab2DQGHO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2012 02:07:14 -0400
In-Reply-To: <1334642522-22021-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, Lan Tianyu <tianyu.lan@intel.com>

The usb port is a device in the acpi table but it's not in the linux
usb subsystem. USB hub port doesn't have struct device. So the acpi
glue framework only can cover the usb port connected with usb device
and store the acpi handle to struct device.archdata.acpi_handle. This
patch adds the member platform_data in the struct usb_hub_port and
gets the hub port's acpi_handle and store it in the port's platform_data
to resolve no attached device no binding problem. The acpi method "_UPC"
and "_PLD" can be accessed without attached device.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/hub.c      |   20 ++++++++++++++++++++
 drivers/usb/core/usb-acpi.c |   37 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/core/usb.h      |    6 ++++++
 3 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 50a85e8..53fcbec 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -40,6 +40,7 @@
 struct usb_hub_port {
 	void			*port_owner;
 	struct usb_device	*child;
+	unsigned long		platform_data;
 };
 
 struct usb_hub {
@@ -1265,6 +1266,7 @@ static int hub_configure(struct usb_hub *hub,
 	if (hub->has_indicators && blinkenlights)
 		hub->indicator [0] = INDICATOR_CYCLE;
 
+	usb_acpi_bind_hub_ports(hdev);
 	hub_activate(hub, HUB_INIT);
 	return 0;
 
@@ -4252,3 +4254,21 @@ struct usb_device *usb_get_hub_child_device(struct usb_device *hdev,
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

