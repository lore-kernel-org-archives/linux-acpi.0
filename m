From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V4 8/8] usb : Add usb port's power control attributes
Date: Thu, 28 Jun 2012 15:31:42 +0800
Message-ID: <1340868702-1894-9-git-send-email-tianyu.lan@intel.com>
References: <1340868702-1894-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62841 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932558Ab2F1Hj5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jun 2012 03:39:57 -0400
In-Reply-To: <1340868702-1894-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, Lan Tianyu <tianyu.lan@intel.com>

This patch is to add two attributes for each usb hub ports to control port's power.
Control port's power through setting or clearing PORT_POWER feature.

control has two options. "auto", "on" and "off"
"on" - port power must be on.
"off" - port power must be off.

state reports usb port's power state
"on" - power on
"off" - power off
"error" - can't get power state

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-usb |   25 +++++++
 drivers/usb/core/hub.c                  |  116 ++++++++++++++++++++++++++++++-
 2 files changed, 140 insertions(+), 1 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 6df4e6f..abe4ea4 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -208,3 +208,28 @@ Description:
 		such as ACPI. This file will read either "removable" or
 		"fixed" if the information is available, and "unknown"
 		otherwise.
+
+What:		/sys/bus/usb/devices/.../(hub interface)/portX/control
+Date:		June 2012
+Contact		Lan Tianyu <tianyu.lan@intel.com>
+Description:
+		The /sys/bus/usb/devices/.../(hub interface)/portX/control
+		attribute allows user space to control the power policy on
+		the usb port.
+
+		All ports have one of the following two values for control
+		"on" - port power must be on.
+		"off" - port power must be off.
+
+What:		/sys/bus/usb/devices/.../(hub interface)/portX/state
+Date:		June 2012
+Contact		Lan Tianyu <tianyu.lan@intel.com>
+Description:
+		The /sys/bus/usb/devices/.../(hub interface)/portX/state
+		attribute allows user space to check hub port's power state.
+
+		All ports have three following states
+		"on"	  -    port power on
+		"off"	  -    port power off
+		"error"	  -    can't get the hub port's power state
+
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 05cdc7b..f7cf93c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -37,12 +37,18 @@
 #endif
 #endif
 
+enum port_power_policy {
+	USB_PORT_POWER_ON = 0,
+	USB_PORT_POWER_OFF,
+};
+
 struct usb_port {
 	struct usb_device *udev;
 	struct usb_device *child;
 	struct device dev;
 	struct dev_state *port_owner;
 	enum usb_port_connect_type connect_type;
+	enum port_power_policy port_power_policy;
 };
 
 struct usb_hub {
@@ -96,6 +102,10 @@ struct device_type usb_port_device_type = {
 	.name =		"usb_port",
 };
 
+static const char on_string[] = "on";
+static const char off_string[] = "off";
+static const struct attribute_group *port_dev_group[];
+
 static inline int hub_is_superspeed(struct usb_device *hdev)
 {
 	return (hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS);
@@ -848,7 +858,9 @@ static unsigned hub_power_on(struct usb_hub *hub, bool do_delay)
 		dev_dbg(hub->intfdev, "trying to enable port power on "
 				"non-switchable hub\n");
 	for (port1 = 1; port1 <= hub->descriptor->bNbrPorts; port1++)
-		set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
+		if (hub->ports[port1 - 1]->port_power_policy
+				== USB_PORT_POWER_ON)
+			set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
 
 	/* Wait at least 100 msec for power to become stable */
 	delay = max(pgood_delay, (unsigned) 100);
@@ -1262,6 +1274,7 @@ static int usb_hub_create_port_device(struct usb_hub *hub,
 	hub->ports[port1 - 1] = port_dev;
 	port_dev->udev = hub->hdev;
 	port_dev->dev.parent = hub->intfdev;
+	port_dev->dev.groups = port_dev_group;
 	port_dev->dev.type = &usb_port_device_type;
 	port_dev->dev.release = usb_port_device_release;
 	dev_set_name(&port_dev->dev, "port%d", port1);
@@ -2611,6 +2624,25 @@ static int port_is_power_on(struct usb_hub *hub, unsigned portstatus)
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
+		dev_err(hub->intfdev,
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
@@ -4552,6 +4584,88 @@ static int hub_thread(void *__unused)
 	return 0;
 }
 
+static ssize_t show_port_power_state(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct usb_device *udev = to_usb_device(dev->parent->parent);
+	int port1, power_state;
+	const char *result;
+
+	sscanf(dev_name(dev), "port%d", &port1);
+	power_state = usb_get_hub_port_power_state(udev, port1);
+	if (power_state == 1)
+		result = on_string;
+	else if (!power_state)
+		result = off_string;
+	else
+		result = "error";
+	return sprintf(buf, "%s\n", result);
+}
+static DEVICE_ATTR(state, S_IRUGO, show_port_power_state, NULL);
+
+static ssize_t show_port_power_control(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct usb_port *hub_port = to_usb_port(dev);
+	const char *result;
+
+	switch (hub_port->port_power_policy) {
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
+	struct usb_device *hdev = to_usb_device(dev->parent->parent);
+	struct usb_port *hub_port = to_usb_port(dev);
+	int port1, len = count;
+	char *cp;
+
+	sscanf(dev_name(dev), "port%d", &port1);
+	cp = memchr(buf, '\n', count);
+	if (cp)
+		len = cp - buf;
+	if (len == sizeof on_string - 1
+		&& strncmp(buf, on_string, len) == 0) {
+		hub_port->port_power_policy = USB_PORT_POWER_ON;
+		set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+	} else if (len == sizeof off_string - 1
+		&& strncmp(buf, off_string, len) == 0) {
+		hub_port->port_power_policy = USB_PORT_POWER_OFF;
+		clear_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+	} else
+		return -EINVAL;
+
+	return count;
+}
+static DEVICE_ATTR(control, S_IWUSR | S_IRUGO, show_port_power_control,
+		store_port_power_control);
+
+static struct attribute *port_dev_attrs[] = {
+	&dev_attr_control.attr,
+	&dev_attr_state.attr,
+	NULL,
+};
+
+static struct attribute_group port_dev_attr_grp = {
+	.attrs = port_dev_attrs,
+};
+
+static const struct attribute_group *port_dev_group[] = {
+	&port_dev_attr_grp,
+	NULL,
+};
+
 static const struct usb_device_id hub_id_table[] = {
     { .match_flags = USB_DEVICE_ID_MATCH_DEV_CLASS,
       .bDeviceClass = USB_CLASS_HUB},
-- 
1.7.6.rc2.8.g28eb

