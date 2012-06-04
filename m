From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [RFC PATCH V3 3/3] usb : Add sysfs files to control usb port's power
Date: Mon,  4 Jun 2012 16:47:45 +0800
Message-ID: <1338799665-13997-3-git-send-email-tianyu.lan@intel.com>
References: <1338799665-13997-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31876 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756569Ab2FDIyl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Jun 2012 04:54:41 -0400
In-Reply-To: <1338799665-13997-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com

Change since v2: add ABI descripters for new sysfs files and with some small
modification.

Change since v1: move sysfs files from usb hub device sysfs directory to usb
hub interface sysfs directory.

This patch is to add two sys files for each usb hub ports to control port's power.
Control port's power through setting or clearing PORT_POWER feature.

The new sys files is under the usb hub interface sysfs portx directory.
ls /sys/bus/usb/devices/1-0:1.0
bAlternateSetting  bInterfaceClass  bInterfaceNumber  bInterfaceProtocol
bInterfaceSubClass  bNumEndpoints  driver  ep_81  modalias  power
subsystem  supports_autosuspend  uevent port1 port2 port3 port4

ls /sys/bus/usb/devices/1-0:1.0/port1
control state

control has three options. "auto", "on" and "off"
"auto" - For ports with device, there is a proposal that if the device was not
	in the suspend at that pointer, the power would remain on but it would
	power off when it was suspended. If the the device was in the suspend,
	"auto" means the device could be put into much lower state so the device
	need to resume and suspend again.
"on" - port must be power on.
"off" - port must be power off.

state reports usb ports' power state
"on" - power on
"off" - power off
"error" - can't get power state

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-usb |   37 +++++++
 drivers/usb/core/hub.c                  |  172 +++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 6df4e6f..62c396b 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -208,3 +208,40 @@ Description:
 		such as ACPI. This file will read either "removable" or
 		"fixed" if the information is available, and "unknown"
 		otherwise.
+
+What:		/sys/bus/usb/devices/.../(hub interface)/port1, port2,...portX
+Date:		June 2012
+Contact		Lan Tianyu <tianyu.lan@intel.com>
+Description:
+		The /sys/bus/usb/device/.../(hub interface)/portX directory
+		contains attributes allowing the user space to check and modify
+		some usb port related properties of associated port.
+
+What:		/sys/bus/usb/devices/.../(hub interface)/portX/control
+Date:		June 2012
+Contact		Lan Tianyu <tianyu.lan@intel.com>
+Description:
+		The /sys/bus/usb/devices/.../(hub interface)/portX/control attribue
+		allows the user space to control the power policy on the usb port
+
+		All ports have one of the following three values for portX/control
+		"auto" - For ports with device, if the device was not in the suspend
+			at that pointer, the power would remain on but it would power
+			off when it was suspended. If the the device was in the suspend,
+			"auto" means the device could be put into much lower state so
+			the device would be resumed and suspended again.
+		"on" - port must be power on.
+		"off" - port must be power off.
+
+What:		/sys/bus/usb/devices/.../(hub interface)/portX/state
+Date:		June 2012
+Contact		Lan Tianyu <tianyu.lan@intel.com>
+Description:
+		The /sys/bus/usb/devices/.../(hub interface)/portX/state attribue
+		allows the user space to check hub port's power state.
+
+		All ports have three following states
+		"on"	  -    port power on
+		"off"	  -    port power off
+		"error"	  -    can't get the hub port's power state
+
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 2ed5244..445cd6e 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -41,12 +41,22 @@
 #endif
 #endif
 
+enum port_power_policy {
+	USB_PORT_POWER_ON = 0,
+	USB_PORT_POWER_OFF,
+	USB_PORT_POWER_AUTO,
+};
+
 struct usb_hub_port {
 	void			*port_owner;
 	struct usb_device	*child;
 #ifdef CONFIG_ACPI
 	acpi_handle		port_acpi_handle;
 #endif
+	struct attribute_group	port_attr_group;
+	struct device_attribute	port_control_attr;
+	struct device_attribute	port_state_attr;
+	enum port_power_policy port_power_policy;
 	enum usb_port_connect_type connect_type;
 };
 
@@ -97,6 +107,13 @@ struct usb_hub {
 	struct usb_hub_port	*port_data;
 };
 
+static const char on_string[] = "on";
+static const char off_string[] = "off";
+static const char auto_string[] = "auto";
+static char port_name[USB_MAXCHILDREN][8];
+static void usb_hub_port_sysfs_add(struct usb_hub *hub);
+static void usb_hub_port_sysfs_remove(struct usb_hub *hub);
+
 static inline int hub_is_superspeed(struct usb_device *hdev)
 {
 	return (hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS);
@@ -1493,6 +1510,7 @@ static int hub_configure(struct usb_hub *hub,
 	if (hub->has_indicators && blinkenlights)
 		hub->indicator [0] = INDICATOR_CYCLE;
 
+	usb_hub_port_sysfs_add(hub);
 	usb_acpi_bind_hub_ports(hdev);
 	hub_activate(hub, HUB_INIT);
 	return 0;
@@ -1531,6 +1549,7 @@ static void hub_disconnect(struct usb_interface *intf)
 	hub->error = 0;
 	hub_quiesce(hub, HUB_DISCONNECT);
 
+	usb_hub_port_sysfs_remove(hub);
 	usb_set_intfdata (intf, NULL);
 	hub->hdev->maxchild = 0;
 
@@ -2558,6 +2577,25 @@ static int port_is_power_on(struct usb_hub *hub, unsigned portstatus)
 	return ret;
 }
 
+static int usb_get_hub_port_power_state(struct usb_device *hdev, int port1)
+{
+	struct usb_hub *hub = hdev_to_hub(hdev);
+	struct usb_port_status data;
+	u16 portstatus;
+	int ret;
+
+	ret = get_port_status(hub->hdev, port1, &data);
+	if (ret < 4) {
+		dev_err (hub->intfdev,
+			"%s failed (err = %d)\n", __func__, ret);
+		if (ret >= 0)
+			ret = -EIO;
+		return ret;
+	} else
+		portstatus = le16_to_cpu(data.wPortStatus);
+	return port_is_power_on(hub, portstatus);
+}
+
 #ifdef	CONFIG_PM
 
 /* Check if a port is suspended(USB2.0 port) or in U3 state(USB3.0 port) */
@@ -4499,6 +4537,139 @@ static int hub_thread(void *__unused)
 	return 0;
 }
 
+static ssize_t show_port_power_state(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct usb_device *udev = to_usb_device(dev->parent);
+	struct usb_hub_port *hub_port = container_of(attr,
+		struct usb_hub_port, port_state_attr);
+	int power_state;
+	const char *result;
+	int port1;
+
+	if (sscanf(hub_port->port_attr_group.name, "port%d", &port1) != 1)
+		return -EINVAL;
+
+	power_state = usb_get_hub_port_power_state(udev, port1);
+	if (power_state == 1)
+		result = on_string;
+	else if (!power_state)
+		result = off_string;
+	else
+		result = "error";
+	return sprintf(buf, "%s\n", result);
+}
+
+static ssize_t show_port_power_control(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct usb_hub_port *hub_port = container_of(attr,
+		struct usb_hub_port, port_control_attr);
+	const char *result;
+
+	switch (hub_port->port_power_policy) {
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
+	struct usb_device *udev = to_usb_device(dev->parent);
+	struct usb_hub_port *hub_port = container_of(attr,
+		struct usb_hub_port, port_control_attr);
+	char *cp;
+	int port1;
+	int len = count;
+
+	if (sscanf(hub_port->port_attr_group.name, "port%d", &port1) != 1)
+		return -EINVAL;
+
+	cp = memchr(buf, '\n', count);
+	if (cp)
+		len = cp - buf;
+
+	if (len == sizeof auto_string - 1 &&
+		strncmp(buf, auto_string, len) == 0) {
+		hub_port->port_power_policy = USB_PORT_POWER_AUTO;
+	} else if (len == sizeof on_string - 1
+		&& strncmp(buf, on_string, len) == 0) {
+		hub_port->port_power_policy = USB_PORT_POWER_ON;
+		set_port_feature(udev, port1, USB_PORT_FEAT_POWER);
+	} else if (len == sizeof off_string - 1
+		&& strncmp(buf, off_string, len) == 0) {
+		hub_port->port_power_policy = USB_PORT_POWER_OFF;
+		clear_port_feature(udev, port1, USB_PORT_FEAT_POWER);
+	} else
+		return -EINVAL;
+
+	return count;
+}
+
+static void usb_hub_port_sysfs_add(struct usb_hub *hub)
+{
+	int i, rc;
+	struct attribute* port_attrs[3];
+
+	for (i = 0; i < hub->hdev->maxchild; i++) {
+		hub->port_data[i].port_control_attr = (struct device_attribute)
+			__ATTR(control, S_IRUGO | S_IWUSR,
+			show_port_power_control,
+			store_port_power_control);
+		hub->port_data[i].port_state_attr = (struct device_attribute)
+			__ATTR(state, S_IRUGO, show_port_power_state, NULL);
+
+		port_attrs[0] = &hub->port_data[i].port_control_attr.attr;
+		port_attrs[1] = &hub->port_data[i].port_state_attr.attr;
+		port_attrs[2] = NULL;
+		hub->port_data[i].port_attr_group = (struct attribute_group) {
+			.name = port_name[i],
+			.attrs = port_attrs
+		};
+
+		rc = sysfs_create_group(&hub->intfdev->kobj,
+			&hub->port_data[i].port_attr_group);
+		if (rc < 0)
+			dev_err(hub->intfdev, "can't create sys " \
+				"files for port%d\n", i + 1);
+	}
+}
+
+static void usb_hub_port_sysfs_remove(struct usb_hub *hub)
+{
+	int i;
+	struct attribute* port_attrs[3];
+
+	for (i = 0; i < hub->hdev->maxchild; i++) {
+		port_attrs[0] = &hub->port_data[i].port_control_attr.attr;
+		port_attrs[1] = &hub->port_data[i].port_state_attr.attr;
+		port_attrs[2] = NULL;
+		hub->port_data[i].port_attr_group.attrs = port_attrs;
+		sysfs_remove_group(&hub->intfdev->kobj,
+			&hub->port_data[i].port_attr_group);
+	}
+}
+
+static void usb_hub_port_sysfs_init(void)
+{
+	int i;
+
+	for (i = 0; i < USB_MAXCHILDREN; i++)
+		sprintf(port_name[i], "port%d", i + 1);
+}
+
 static const struct usb_device_id hub_id_table[] = {
     { .match_flags = USB_DEVICE_ID_MATCH_DEV_CLASS,
       .bDeviceClass = USB_CLASS_HUB},
@@ -4531,6 +4702,7 @@ int usb_hub_init(void)
 		return -1;
 	}
 
+	usb_hub_port_sysfs_init();
 	khubd_task = kthread_run(hub_thread, NULL, "khubd");
 	if (!IS_ERR(khubd_task))
 		return 0;
-- 
1.7.6.rc2.8.g28eb

