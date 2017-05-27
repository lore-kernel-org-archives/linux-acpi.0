From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH 07/16] platform/x86: wmi: Split devices into types and add basic sysfs attributes
Date: Fri, 26 May 2017 22:31:21 -0700
Message-ID: <6969d7841e7a2458a158ecbf64d499a0b2177bc9.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbdE0Fbt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 May 2017 01:31:49 -0400
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>

From: Andy Lutomirski <luto@kernel.org>

Divide the "data", "method" and "event" types. All devices get
"instance_count" and "expensive" attributes, data and method devices get
"object_id" attributes, and event devices get "notify_id" attributes.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 drivers/platform/x86/wmi.c | 78 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 31c317f..33a3609 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -575,13 +575,65 @@ static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
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
@@ -671,6 +723,24 @@ static struct bus_type wmi_bus_type = {
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
@@ -681,7 +751,13 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 
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
2.9.4

