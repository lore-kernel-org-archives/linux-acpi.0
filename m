From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 07/14] wmi: Split devices into types and add basic sysfs attributes
Date: Mon, 30 Nov 2015 17:05:57 -0800
Message-ID: <4d173f283e09f5e1e04c8ff970052438b54ffb96.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46769 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755075AbbLABGT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Nov 2015 20:06:19 -0500
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>

This devices the "data", "method" and "event" types.  All devices
get "instance_count" and "expensive" attributes, data and method
devices get "object_id" attributes, and event devices get
"notify_id" attributes.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/wmi.c | 78 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index c181cf5ecdc6..5571ae7354a1 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -653,13 +653,65 @@ static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(guid);
 
+static ssize_t instance_count_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct wmi_block *wblock = dev_to_wblock(dev);
+
+	return sprintf(buf, "%d\n", (int)wblock->gblock.instance_count);
+}
+static DEVICE_ATTR_RO(instance_count);
+
+static ssize_t expensive_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct wmi_block *wblock = dev_to_wblock(dev);
+
+	return sprintf(buf, "%d\n",
+		       (wblock->gblock.flags & ACPI_WMI_EXPENSIVE) != 0);
+}
+static DEVICE_ATTR_RO(expensive);
+
 static struct attribute *wmi_attrs[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_guid.attr,
+	&dev_attr_instance_count.attr,
+	&dev_attr_expensive.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(wmi);
 
+static ssize_t notify_id_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct wmi_block *wblock = dev_to_wblock(dev);
+
+	return sprintf(buf, "%02X\n", (unsigned int)wblock->gblock.notify_id);
+}
+static DEVICE_ATTR_RO(notify_id);
+
+static struct attribute *wmi_event_attrs[] = {
+	&dev_attr_notify_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(wmi_event);
+
+static ssize_t object_id_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct wmi_block *wblock = dev_to_wblock(dev);
+
+	return sprintf(buf, "%c%c\n", wblock->gblock.object_id[0],
+		       wblock->gblock.object_id[1]);
+}
+static DEVICE_ATTR_RO(object_id);
+
+static struct attribute *wmi_data_or_method_attrs[] = {
+	&dev_attr_object_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(wmi_data_or_method);
+
 static int wmi_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
@@ -749,6 +801,24 @@ static struct bus_type wmi_bus_type = {
 	.remove = wmi_dev_remove,
 };
 
+static struct device_type wmi_type_event = {
+	.name = "event",
+	.groups = wmi_event_groups,
+	.release = wmi_dev_release,
+};
+
+static struct device_type wmi_type_method = {
+	.name = "method",
+	.groups = wmi_data_or_method_groups,
+	.release = wmi_dev_release,
+};
+
+static struct device_type wmi_type_data = {
+	.name = "data",
+	.groups = wmi_data_or_method_groups,
+	.release = wmi_dev_release,
+};
+
 static int wmi_create_device(struct device *wmi_bus_dev,
 			     const struct guid_block *gblock,
 			     struct wmi_block *wblock,
@@ -759,7 +829,13 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 
 	dev_set_name(&wblock->dev.dev, "%pUL", gblock->guid);
 
-	wblock->dev.dev.release = wmi_dev_release;
+	if (gblock->flags & ACPI_WMI_EVENT) {
+		wblock->dev.dev.type = &wmi_type_event;
+	} else if (gblock->flags & ACPI_WMI_METHOD) {
+		wblock->dev.dev.type = &wmi_type_method;
+	} else {
+		wblock->dev.dev.type = &wmi_type_data;
+	}
 
 	return device_register(&wblock->dev.dev);
 }
-- 
2.5.0

