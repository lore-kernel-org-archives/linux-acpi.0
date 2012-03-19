From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [RFC PATCH 3/4] usb/acpi: add the support of usb hub ports' acpi binding without attached devices.
Date: Mon, 19 Mar 2012 22:33:45 +0800
Message-ID: <1332167626-5806-3-git-send-email-tianyu.lan@intel.com>
References: <1332167626-5806-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27664 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030834Ab2CSOgV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Mar 2012 10:36:21 -0400
In-Reply-To: <1332167626-5806-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, mjg@redhat.com, linux-usb@vger.kernel.org, sarah.a.sharp@intel.com

The usb port is a device in the acpi table but it's not in the linux
usb subsystem. USB hub port doesn't have struct device. So the acpi
glue framework only can cover the usb port connected with usb device
and store the acpi handle to struct device.archdata.acpi_handle. This
patch gets the hub port's acpi_handle and store it in the port's platform_data
to resolve no attached device no binding problem. The acpi method "_UPC"
and "_PLD" can be accessed without attached device.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/hub.c      |    1 +
 drivers/usb/core/usb-acpi.c |   38 +++++++++++++++++++++++++++++++++++++-
 drivers/usb/core/usb.h      |    4 ++++
 3 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index af391cb..90877f0 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1238,6 +1238,7 @@ static int hub_configure(struct usb_hub *hub,
 		hub->indicator [0] = INDICATOR_CYCLE;
 
 	hub_activate(hub, HUB_INIT);
+	usb_acpi_bind_hub_ports(hdev, hub->descriptor->bNbrPorts);
 	return 0;
 
 fail:
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index e49373a..6ecff04 100644
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
+		usb_get_hub_port_platform_data(udev->parent, udev->portnum,
+			(unsigned long *)handle);
 
 	if (!*handle)
 		return -ENODEV;
@@ -105,6 +114,33 @@ static struct acpi_bus_type usb_acpi_bus = {
 	.find_device = usb_acpi_find_device,
 };
 
+int usb_acpi_bind_hub_ports(struct usb_device *hdev, int portnum)
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
+	 * in the acpi table. Store it's acpi handle in the platform data of usb
+	 * hub port.
+	 */
+	for (i = 1; i < portnum; i++) {
+		port_handle = acpi_get_child(hub_handle, i);
+		if (!port_handle)
+			continue;
+		if (usb_set_hub_port_platform_data(hdev, i,
+				(unsigned long)port_handle) < 0)
+			return -ENODEV;
+	}
+	return 0;
+}
+
 int usb_acpi_register(void)
 {
 	return register_acpi_bus_type(&usb_acpi_bus);
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 3e70565..b780246 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -162,7 +162,11 @@ extern int usb_set_hub_port_platform_data(struct usb_device *udev,
 #ifdef CONFIG_ACPI
 extern int usb_acpi_register(void);
 extern void usb_acpi_unregister(void);
+extern int usb_acpi_bind_hub_ports(struct usb_device *hdev,
+	int portnum);
 #else
 static inline int usb_acpi_register(void) { return 0; };
 static inline void usb_acpi_unregister(void) { };
+static inline int usb_acpi_bind_hub_ports(struct usb_device *hdev,
+	int portnum) { return 0; };
 #endif
-- 
1.7.6.rc2.8.g28eb

