From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [RFC PATCH 3/3] usb : Add sysfs files to control usb port's power
Date: Fri, 25 May 2012 13:48:02 +0800
Message-ID: <1337924882-17332-4-git-send-email-tianyu.lan@intel.com>
References: <1337924882-17332-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32424 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506Ab2EYFyX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 May 2012 01:54:23 -0400
In-Reply-To: <1337924882-17332-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, Lan Tianyu <tianyu.lan@intel.com>

This patch is to add two sys files for each usb hub ports to control port's power,
e.g port1_power_control and port1_power_state both for port one. Control port's
power through setting or clearing PORT_POWER feature.

port1_power_control has three options. "auto", "on" and "off"
"auto" - if port without device, power off the port.
"on" - port must be power on.
"off" - port must be power off.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/hub.c   |   38 +++++++++++
 drivers/usb/core/sysfs.c |  167 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/core/usb.c   |    2 +
 drivers/usb/core/usb.h   |    6 ++
 include/linux/usb.h      |   12 +++
 5 files changed, 222 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index cec5bd1..7f0adf6 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -48,6 +48,7 @@ struct usb_hub_port {
 	acpi_handle		port_acpi_handle;
 #endif
 	enum usb_port_connect_type connect_type;
+	enum port_power_policy port_power_policy;
 };
 
 struct usb_hub {
@@ -1493,6 +1494,12 @@ static int hub_configure(struct usb_hub *hub,
 	if (hub->has_indicators && blinkenlights)
 		hub->indicator [0] = INDICATOR_CYCLE;
 
+	/*
+	 * Create the ports' power related sys files.
+	 * The function requires the hub's port number.
+	 */
+	usb_create_sysfs_dev_files(hdev);
+
 	usb_acpi_bind_hub_ports(hdev);
 	hub_activate(hub, HUB_INIT);
 	return 0;
@@ -4985,6 +4992,37 @@ usb_get_hub_port_connect_type(struct usb_device *hdev,	int port1)
 	return hub->port_data[port1 - 1].connect_type;
 }
 
+enum port_power_policy
+usb_get_hub_port_power_policy(struct usb_device *hdev, int port1)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+	return hub->port_data[port1 - 1].port_power_policy;
+}
+
+void usb_set_hub_port_power_policy(struct usb_device *hdev, int port1,
+	enum port_power_policy value)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+	hub->port_data[port1 - 1].port_power_policy = value;
+}
+
+void usb_set_hub_port_power(struct usb_device *hdev, int port1, bool enabled)
+{
+	if (enabled)
+		set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+	else
+		clear_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+}
+
+int usb_get_hub_port_power_state(struct usb_device *hdev, int port1)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+	u16 portstatus, portchange;
+
+	hub_port_status(hub, port1, &portstatus, &portchange);
+	return port_is_power_on(hub, portstatus);
+}
+
 #ifdef CONFIG_ACPI
 /**
  * usb_set_hub_port_acpi_handle - Set the usb port's acpi handle
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 566d9f9..8703c7e 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -16,6 +16,14 @@
 #include <linux/usb/quirks.h>
 #include "usb.h"
 
+static const char on_string[] = "on";
+static const char off_string[] = "off";
+static const char auto_string[] = "auto";
+static char power_control_name[USB_MAXCHILDREN][25];
+static char power_state_name[USB_MAXCHILDREN][25];
+static struct device_attribute power_control_attr[USB_MAXCHILDREN];
+static struct device_attribute power_state_attr[USB_MAXCHILDREN];
+
 /* Active configuration fields */
 #define usb_actconfig_show(field, multiplier, format_string)		\
 static ssize_t  show_##field(struct device *dev,			\
@@ -376,9 +384,6 @@ set_autosuspend(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR(autosuspend, S_IRUGO | S_IWUSR,
 		show_autosuspend, set_autosuspend);
 
-static const char on_string[] = "on";
-static const char auto_string[] = "auto";
-
 static void warn_level(void) {
 	static int level_warned;
 
@@ -524,6 +529,85 @@ static void remove_power_attributes(struct device *dev)
 
 #endif	/* CONFIG_USB_SUSPEND */
 
+static ssize_t show_port_power_state(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct usb_device *udev = to_usb_device(dev);
+	const char *result;
+	int port1;
+
+	if (sscanf(attr->attr.name, "port%d_power_control", &port1) != 1)
+		return -EINVAL;
+
+	if (usb_get_hub_port_power_state(udev, port1))
+		result = on_string;
+	else
+		result = off_string;
+	return sprintf(buf, "%s\n", result);
+}
+
+static ssize_t show_port_power_control(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct usb_device *udev = to_usb_device(dev);
+	enum port_power_policy policy;
+	int port1;
+	const char *result;
+
+	if (sscanf(attr->attr.name, "port%d_power_control", &port1) != 1)
+		return -EINVAL;
+
+	policy = usb_get_hub_port_power_policy(udev, port1);
+	switch (policy) {
+	case USB_PORT_POWER_AUTO:
+		result = auto_string;
+		break;
+	case USB_PORT_POWER_ON:
+		result = on_string;
+		break;
+	case USB_PORT_POWER_OFF:
+		result = off_string;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return sprintf(buf, "%s\n", result);
+}
+
+static ssize_t
+store_port_power_control(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct usb_device *udev = to_usb_device(dev);
+	char *cp;
+	int port1;
+	int len = count;
+
+	if (sscanf(attr->attr.name, "port%d_power_control", &port1) != 1)
+		return -EINVAL;
+
+	cp = memchr(buf, '\n', count);
+	if (cp)
+		len = cp - buf;
+
+	if (len == sizeof auto_string - 1 &&
+		strncmp(buf, auto_string, len) == 0) {
+		if (!usb_get_hub_child(udev, port1))
+			usb_set_hub_port_power(udev, port1, false);
+		usb_set_hub_port_power_policy(udev, port1, USB_PORT_POWER_AUTO);
+	} else if (len == sizeof on_string - 1
+		&& strncmp(buf, on_string, len) == 0) {
+		usb_set_hub_port_power_policy(udev, port1, USB_PORT_POWER_ON);
+		usb_set_hub_port_power(udev, port1, true);
+	} else if (len == sizeof off_string - 1
+		&& strncmp(buf, off_string, len) == 0) {
+		usb_set_hub_port_power_policy(udev, port1, USB_PORT_POWER_OFF);
+		usb_set_hub_port_power(udev, port1, false);
+	} else
+		return -EINVAL;
+
+	return count;
+}
 
 /* Descriptor fields */
 #define usb_descriptor_attr_le16(field, format_string)			\
@@ -771,6 +855,9 @@ void usb_remove_sysfs_dev_files(struct usb_device *udev)
 	remove_power_attributes(dev);
 	remove_persist_attributes(dev);
 	device_remove_bin_file(dev, &dev_bin_attr_descriptors);
+
+	if (udev->descriptor.bDeviceClass == USB_CLASS_HUB)
+		usb_remove_sysfs_hub_port_power(udev);
 }
 
 /* Interface Accociation Descriptor fields */
@@ -945,3 +1032,77 @@ void usb_remove_sysfs_intf_files(struct usb_interface *intf)
 	device_remove_file(&intf->dev, &dev_attr_interface);
 	intf->sysfs_files_created = 0;
 }
+
+void usb_create_sysfs_hub_port_power(struct usb_device *udev)
+{
+	int i, rc;
+
+	if (udev->descriptor.bDeviceClass == USB_CLASS_HUB) {
+		for (i = 0; i < udev->maxchild && !rc; i++) {
+			rc = sysfs_add_file_to_group(&udev->dev.kobj,
+				&power_control_attr[i].attr,
+				power_group_name);
+			if (rc) {
+				while (--i > 0)
+					sysfs_remove_file_from_group(&udev->dev.kobj,
+						&power_control_attr[i].attr,
+						power_group_name);
+				break;
+			}
+		}
+
+		for (i = 0; i < udev->maxchild && !rc; i++) {
+			rc = sysfs_add_file_to_group(&udev->dev.kobj,
+				&power_state_attr[i].attr,
+				power_group_name);
+			if (rc) {
+				while (--i > 0)
+					sysfs_remove_file_from_group(&udev->dev.kobj,
+						&power_state_attr[i].attr,
+						power_group_name);
+				break;
+			}
+		}
+
+	}
+}
+
+void usb_remove_sysfs_hub_port_power(struct usb_device *udev)
+{
+	int i;
+
+	for (i = 0; i < udev->maxchild; i++) {
+		sysfs_remove_file_from_group(&udev->dev.kobj,
+			&power_control_attr[i].attr,
+			power_group_name);
+		sysfs_remove_file_from_group(&udev->dev.kobj,
+			&power_state_attr[i].attr,
+			power_group_name);
+	}
+}
+
+int __init usb_sysfs_init(void)
+{
+	int i;
+	char name[25];
+
+	for (i = 0; i < USB_MAXCHILDREN; i++) {
+		sprintf(name, "port%d_power_control", i + 1);
+		strcpy(power_control_name[i], name);
+		power_control_attr[i] = (struct device_attribute) {
+			.attr = { .name = power_control_name[i], .mode = 0644 }, \
+			.show	= show_port_power_control, \
+			.store	= store_port_power_control \
+		};
+
+		sprintf(name, "port%d_power_state", i + 1);
+		strcpy(power_state_name[i], name);
+		power_state_attr[i] = (struct device_attribute) {
+			.attr = { .name = power_state_name[i], .mode = 0644 }, \
+			.show	= show_port_power_state, \
+		};
+
+	}
+
+	return 0;
+}
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 25d0c61..b8908d5 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -1011,6 +1011,8 @@ static int __init usb_init(void)
 		return 0;
 	}
 
+	usb_sysfs_init();
+
 	retval = usb_debugfs_init();
 	if (retval)
 		goto out;
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index da78c15..5737f46 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -158,10 +158,16 @@ extern void usb_notify_add_device(struct usb_device *udev);
 extern void usb_notify_remove_device(struct usb_device *udev);
 extern void usb_notify_add_bus(struct usb_bus *ubus);
 extern void usb_notify_remove_bus(struct usb_bus *ubus);
+extern int usb_sysfs_init(void);
 extern enum usb_port_connect_type
 	usb_get_hub_port_connect_type(struct usb_device *hdev, int port1);
 extern void usb_set_hub_port_connect_type(struct usb_device *hdev, int port1,
 	enum usb_port_connect_type type);
+extern void usb_create_sysfs_hub_port_power(struct usb_device *udev);
+extern void usb_remove_sysfs_hub_port_power(struct usb_device *udev);
+extern enum port_power_policy
+	usb_get_hub_port_power_policy(struct usb_device *hdev, int port1);
+extern int usb_get_hub_port_power_state(struct usb_device *hdev, int port1);
 
 #ifdef CONFIG_ACPI
 extern int usb_acpi_register(void);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 92f8898..58fa7b8 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -424,6 +424,12 @@ enum usb_port_connect_type {
 	USB_PORT_NOT_USED,
 };
 
+enum port_power_policy {
+	USB_PORT_POWER_AUTO = 0,
+	USB_PORT_POWER_ON,
+	USB_PORT_POWER_OFF,
+};
+
 /**
  * struct usb_device - kernel's representation of a USB device
  * @devnum: device number; address on a USB bus
@@ -570,6 +576,12 @@ static inline struct usb_device *interface_to_usbdev(struct usb_interface *intf)
 	return to_usb_device(intf->dev.parent);
 }
 
+extern enum port_power_policy
+usb_get_hub_port_power_policy(struct usb_device *hdev, int port1);
+extern void usb_set_hub_port_power_policy(struct usb_device *hdev,
+	int port1, enum port_power_policy value);
+extern void usb_set_hub_port_power(struct usb_device *hdev,
+	int port1, bool enabled);
 extern struct usb_device *usb_get_dev(struct usb_device *dev);
 extern void usb_put_dev(struct usb_device *dev);
 extern struct usb_device *usb_get_hub_child(struct usb_device *hdev,
-- 
1.7.6.rc2.8.g28eb

