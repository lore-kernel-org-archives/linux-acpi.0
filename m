From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 08/14] wmi: Probe data objects for read and write capabilities
Date: Mon, 30 Nov 2015 17:05:58 -0800
Message-ID: <6027f0563e82e3ca5265c6b29777636a9b8dc244.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46796 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755075AbbLABGU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Nov 2015 20:06:20 -0500
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>

My laptop has one RW data object, one RO data object, and one
totally inaccessible data object.  Check for the existence of the
accessor methods and report in sysfs.

The docs also permit WQxx getters for single-instance objects to
take no parameters.  Probe for that as well to avoid ACPICA warnings
about mismatched signatures.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/wmi.c | 94 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/wmi.h        |  6 +++
 2 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 5571ae7354a1..49be61207c4a 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -66,6 +66,8 @@ struct wmi_block {
 	struct acpi_device *acpi_device;
 	wmi_notify_handler handler;
 	void *handler_data;
+
+	bool read_takes_no_args;	/* only defined if readable */
 };
 
 
@@ -216,6 +218,25 @@ static bool find_guid(const char *guid_string, struct wmi_block **out)
 	return false;
 }
 
+static int get_subobj_info(acpi_handle handle, const char *pathname,
+			   struct acpi_device_info *info)
+{
+	acpi_handle subobj_handle;
+	acpi_status status;
+
+	status = acpi_get_handle(handle, (char *)pathname, &subobj_handle);
+	if (status == AE_NOT_FOUND)
+		return -ENOENT;
+	else if (ACPI_FAILURE(status))
+		return -EIO;
+
+	status = acpi_get_object_info(subobj_handle, &info);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return 0;
+}
+
 static acpi_status wmi_method_enable(struct wmi_block *wblock, int enable)
 {
 	struct guid_block *block = NULL;
@@ -339,6 +360,9 @@ struct acpi_buffer *out)
 	wq_params[0].type = ACPI_TYPE_INTEGER;
 	wq_params[0].integer.value = instance;
 
+	if (instance == 0 && wblock->read_takes_no_args)
+		input.count = 0;
+
 	/*
 	 * If ACPI_WMI_EXPENSIVE, call the relevant WCxx method first to
 	 * enable collection.
@@ -706,11 +730,37 @@ static ssize_t object_id_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(object_id);
 
-static struct attribute *wmi_data_or_method_attrs[] = {
+static ssize_t readable_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct wmi_device *wdev = dev_to_wdev(dev);
+
+	return sprintf(buf, "%d\n", (int)wdev->readable);
+}
+static DEVICE_ATTR_RO(readable);
+
+static ssize_t writeable_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct wmi_device *wdev = dev_to_wdev(dev);
+
+	return sprintf(buf, "%d\n", (int)wdev->writeable);
+}
+static DEVICE_ATTR_RO(writeable);
+
+static struct attribute *wmi_data_attrs[] = {
 	&dev_attr_object_id.attr,
+	&dev_attr_readable.attr,
+	&dev_attr_writeable.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(wmi_data_or_method);
+ATTRIBUTE_GROUPS(wmi_data);
+
+static struct attribute *wmi_method_attrs[] = {
+	&dev_attr_object_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(wmi_method);
 
 static int wmi_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
@@ -809,13 +859,13 @@ static struct device_type wmi_type_event = {
 
 static struct device_type wmi_type_method = {
 	.name = "method",
-	.groups = wmi_data_or_method_groups,
+	.groups = wmi_method_groups,
 	.release = wmi_dev_release,
 };
 
 static struct device_type wmi_type_data = {
 	.name = "data",
-	.groups = wmi_data_or_method_groups,
+	.groups = wmi_data_groups,
 	.release = wmi_dev_release,
 };
 
@@ -834,7 +884,43 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 	} else if (gblock->flags & ACPI_WMI_METHOD) {
 		wblock->dev.dev.type = &wmi_type_method;
 	} else {
+		struct acpi_device_info info;
+		char method[5];
+		int result;
+
 		wblock->dev.dev.type = &wmi_type_data;
+
+		strcpy(method, "WQ");
+		strncat(method, wblock->gblock.object_id, 2);
+		result = get_subobj_info(device->handle, method, &info);
+
+		if (result == 0) {
+			wblock->dev.readable = true;
+
+			/*
+			 * The Microsoft documentation specifically states:
+			 *
+			 *   Data blocks registered with only a single instance
+			 *   can ignore the parameter.
+			 *
+			 * ACPICA will get mad at us if we call the method
+			 * with the wrong number of arguments, so check what
+			 * our method expects.  (On some Dell laptops, WQxx
+			 * may not be a method at all.)
+			 */
+			if (info.type != ACPI_TYPE_METHOD ||
+			    info.param_count == 0)
+				wblock->read_takes_no_args = true;
+		}
+
+		strcpy(method, "WS");
+		strncat(method, wblock->gblock.object_id, 2);
+		result = get_subobj_info(device->handle, method, &info);
+
+		if (result == 0) {
+			wblock->dev.writeable = true;
+		}
+
 	}
 
 	return device_register(&wblock->dev.dev);
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 29ed34b4dae1..53095006821e 100644
--- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -21,6 +21,12 @@
 
 struct wmi_device {
 	struct device dev;
+
+	/*
+	 * These are true for data objects that support reads and writes,
+	 * respectively.
+	 */
+	bool readable, writeable;
 };
 
 struct wmi_device_id {
-- 
2.5.0

