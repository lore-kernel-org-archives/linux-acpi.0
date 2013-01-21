From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH v6 2/8] usb: Register usb port's acpi power resources
Date: Mon, 21 Jan 2013 22:18:01 +0800
Message-ID: <1358777887-2656-3-git-send-email-tianyu.lan@intel.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50635 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab3AUOUh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2013 09:20:37 -0500
In-Reply-To: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, rjw@sisk.pl, oneukum@suse.de
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>

This patch is to register usb port's acpi power resources. Create
link between usb port device and its acpi power resource.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/port.c     |    3 +++
 drivers/usb/core/usb-acpi.c |   20 ++++++++++++++++++++
 drivers/usb/core/usb.h      |    6 ++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index fe5959f..4dfa254 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -66,6 +66,7 @@ static void usb_port_device_release(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
 
+	usb_acpi_unregister_power_resources(dev);
 	kfree(port_dev);
 }
 
@@ -95,6 +96,8 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	if (retval)
 		goto error_register;
 
+	usb_acpi_register_power_resources(&port_dev->dev);
+
 	return 0;
 
 error_register:
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index cef4252..558ab01 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -216,6 +216,26 @@ static struct acpi_bus_type usb_acpi_bus = {
 	.find_device = usb_acpi_find_device,
 };
 
+int usb_acpi_register_power_resources(struct device *dev)
+{
+	acpi_handle port_handle = DEVICE_ACPI_HANDLE(dev);
+
+	if (!port_handle)
+		return -ENODEV;
+
+	if (acpi_power_resource_register_device(dev, port_handle) < 0)
+		return -ENODEV;
+	return 0;
+}
+
+void usb_acpi_unregister_power_resources(struct device *dev)
+{
+	acpi_handle port_handle = DEVICE_ACPI_HANDLE(dev);
+
+	if (port_handle)
+		acpi_power_resource_unregister_device(dev, port_handle);
+}
+
 int usb_acpi_register(void)
 {
 	return register_acpi_bus_type(&usb_acpi_bus);
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index a7f20bd..601b044 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -191,7 +191,13 @@ extern int usb_acpi_register(void);
 extern void usb_acpi_unregister(void);
 extern acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
 	int port1);
+extern int usb_acpi_register_power_resources(struct device *dev);
+extern void usb_acpi_unregister_power_resources(struct device *dev);
 #else
 static inline int usb_acpi_register(void) { return 0; };
 static inline void usb_acpi_unregister(void) { };
+static inline int usb_acpi_register_power_resources(struct device *dev)
+	{ return 0; };
+static inline void usb_acpi_unregister_power_resources(struct device *dev)
+	{ };
 #endif
-- 
1.7.9.5

