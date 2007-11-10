From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 2/3] ACPI: WMI: Add sysfs userspace interface
Date: Sat, 10 Nov 2007 15:34:44 +0000
Message-ID: <200711101534.45137.carlos@strangeworlds.co.uk>
References: <200711101532.07531.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:53576 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbXKJPfH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Nov 2007 10:35:07 -0500
In-Reply-To: <200711101532.07531.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Nashif, Anas" <anas.nashif@intel.com>

From: Carlos Corbacho <cathectic@gmail.com>

Userspace:

There is a userspace interface in /sys/firmware/acpi/wmi for WMI methods
and data.

/sys/firmware/acpi/wmi/
|
|-> <GUID>/
  |-> type (method, data, event)

Method & data blocks
  |-> <instance>/
    |-> data (binary data file - write input data to file, read file
              to execute method or retrieve data).

Method only
    |-> method_id (write value of method id to execute)

Events - passed to userspace via netlink. However, the extra WMI data
associated with an event is exposed through sysfs.

  |-> notification (ACPI event value)
  |-> data (binary data file - WMI data associated with the event)

Signed-off-by: Carlos Corbacho <cathectic@gmail.com>
---
 drivers/acpi/wmi.c |  332 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 332 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index 88b326b..59c3d76 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -42,6 +42,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/sysfs.h>
 #include <acpi/acpi_drivers.h>
 
 #define ACPI_WMI_CLASS "wmi"
@@ -202,6 +203,33 @@ static bool wmi_parse_guid(const u8 *src, u8 *dest)
 	return true;
 }
 
+/*
+ * Convert a raw GUID to the ACII string representation
+ */
+static int wmi_gtoa(const char *in, char *out)
+{
+	int i;
+
+	for (i = 3; i >= 0; i--)
+		out += sprintf(out, "%02X", in[i] & 0xFF);
+
+	out += sprintf(out, "-");
+	out += sprintf(out, "%02X", in[5] & 0xFF);
+	out += sprintf(out, "%02X", in[4] & 0xFF);
+	out += sprintf(out, "-");
+	out += sprintf(out, "%02X", in[7] & 0xFF);
+	out += sprintf(out, "%02X", in[6] & 0xFF);
+	out += sprintf(out, "-");
+	out += sprintf(out, "%02X", in[8] & 0xFF);
+	out += sprintf(out, "%02X", in[9] & 0xFF);
+	out += sprintf(out, "-");
+
+	for (i = 10; i <= 15; i++)
+		out += sprintf(out, "%02X", in[i] & 0xFF);
+
+	return 0;
+}
+
 static bool find_guid(const char *guid_string, struct guid_block **out)
 {
 	char tmp[16], guid_input[16];
@@ -479,6 +507,308 @@ bool wmi_has_guid(const char *guid_string)
 }
 EXPORT_SYMBOL_GPL(wmi_has_guid);
 
+/*
+ * sysfs interface
+ */
+struct wmi_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct kobject *kobj, char *buf);
+	ssize_t (*store)(struct kobject *kobj, const char *buf, ssize_t count);
+};
+
+#define WMI_ATTR(_name, _mode, _show, _store) \
+struct wmi_attribute wmi_attr_##_name = __ATTR(_name, _mode, _show, _store);
+
+#define to_attr(a) container_of(a, struct wmi_attribute, attr)
+
+static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct wmi_attribute *wmi_attr = to_attr(attr);
+	ssize_t ret = 0;
+
+	if (wmi_attr->show)
+		ret = wmi_attr->show(kobj, buf);
+	return ret;
+}
+
+static ssize_t store(struct kobject *kobj, struct attribute *attr, const
+	char *buf, size_t count)
+{
+	struct wmi_attribute *wmi_attr = to_attr(attr);
+	ssize_t ret = 0;
+
+	if (wmi_attr->store)
+		ret = wmi_attr->store(kobj, buf, count);
+	return ret;
+}
+
+static struct sysfs_ops wmi_sysfs_ops = {
+	.show   = show,
+	.store  = store,
+};
+
+static struct kobj_type ktype_wmi = {
+	.sysfs_ops      = &wmi_sysfs_ops,
+};
+
+struct guid_kobjects {
+	struct kobject guid_kobj;
+	struct kobject *instance_kobjs;
+	struct kobject *params;
+	void *data;
+	size_t data_size;
+	u8 instances;
+	u8 method_id;
+};
+
+static struct kobject wmi_kobj;
+static struct guid_kobjects *wmi_guid_kobj;
+
+static ssize_t wmi_data_read(struct kobject *kobj, struct bin_attribute
+			*bin_attr, char *buf, loff_t offset, size_t count) {
+	u8 method_id;
+	int i;
+	u8 instance;
+	const char *guid;
+	struct guid_kobjects *gkobj;
+	struct acpi_buffer in;
+	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obj;
+
+	guid = kobject_name(kobj->parent);
+
+	for (i = 0; i < guids.total; i++) {
+		gkobj = &wmi_guid_kobj[i];
+		if (memcmp(kobject_name(&gkobj->guid_kobj), guid, 36) == 0) {
+			instance = simple_strtoul(kobject_name(kobj), NULL, 10);
+
+			method_id = gkobj->method_id;
+
+			if (guids.pointer[i].flags & ACPI_WMI_METHOD) {
+				if (gkobj->data) {
+					in.pointer = gkobj->data;
+					in.length = gkobj->data_size;
+					wmi_evaluate_method(guid, instance,
+						method_id, &in, &out);
+				} else {
+					wmi_evaluate_method(guid, instance,
+						method_id, NULL, &out);
+				}
+				break;
+			} else {
+				wmi_query_block(guid, instance, &out);
+				break;
+			}
+		}
+	}
+
+	obj = (union acpi_object *) out.pointer;
+	buf = obj->buffer.pointer;
+
+	return 0;
+}
+
+static ssize_t wmi_data_write(struct kobject *kobj, struct bin_attribute
+			*bin_attr, char *buf, loff_t offset, size_t count){
+	int i;
+
+	for (i = 0; i < guids.total; i++) {
+		if (memcmp(kobject_name(&wmi_guid_kobj[i].guid_kobj),
+				kobject_name(kobj->parent), 36) == 0) {
+			kfree(wmi_guid_kobj[i].data);
+			wmi_guid_kobj[i].data = kzalloc(count, GFP_KERNEL);
+			memcpy(wmi_guid_kobj[i].data, buf, count);
+			wmi_guid_kobj[i].data_size = count;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+
+static struct bin_attribute wmi_attr_data = {
+	.attr = {.name = "data", .mode = 0600},
+	.size = 0,
+	.read = wmi_data_read,
+	.write = wmi_data_write,
+};
+
+static ssize_t wmi_event_data_read(struct kobject *kobj, struct bin_attribute
+			*bin_attr, char *buf, loff_t offset, size_t count) {
+	int i;
+	const char *guid;
+	struct guid_kobjects *gkobj;
+	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obj;
+
+	guid = kobject_name(kobj->parent);
+
+	for (i = 0; i < guids.total; i++) {
+		gkobj = &wmi_guid_kobj[i];
+		if (memcmp(kobject_name(&gkobj->guid_kobj), guid, 36) == 0)
+			wmi_get_event_data(guids.pointer[i].notify_id, &out);
+	}
+
+	obj = (union acpi_object *) out.pointer;
+	buf = obj->buffer.pointer;
+
+	return 0;
+}
+
+static struct bin_attribute wmi_attr_event_data = {
+	.attr = {.name = "data", .mode = 0400},
+	.size = 0,
+	.read = wmi_event_data_read,
+};
+
+/* sysfs calls */
+static ssize_t
+show_guid_type(struct kobject *kobj, char *buf)
+{
+	struct guid_block *block;
+
+	find_guid(kobject_name(kobj), &block);
+
+	if (block->flags & ACPI_WMI_METHOD) {
+		return sprintf(buf, "method\n");
+	} else if (block->flags & ACPI_WMI_EVENT) {
+		return sprintf(buf, "event\n");
+	} else {
+		return sprintf(buf, "data\n");
+	}
+}
+static WMI_ATTR(type, S_IRUGO, show_guid_type, NULL);
+
+static ssize_t show_guid_method_id(struct kobject *kobj, char *buf)
+{
+	int i;
+
+	for (i = 0; i < guids.total; i++) {
+		if (memcmp(kobject_name(&wmi_guid_kobj[i].guid_kobj),
+			kobject_name(kobj->parent), 36) == 0)
+			return sprintf(buf, "%d\n", wmi_guid_kobj[i].method_id);
+	}
+	return sprintf(buf, "Error\n");
+}
+
+static ssize_t set_guid_method_id(struct kobject *kobj, const char *buf,
+	ssize_t count)
+{
+	int i;
+	u8 method_id;
+
+	method_id = simple_strtoul(buf, NULL, 10);
+
+	for (i = 0; i < guids.total; i++) {
+		if (memcmp(kobject_name(&wmi_guid_kobj[i].guid_kobj),
+			kobject_name(kobj->parent), 36) == 0) {
+			wmi_guid_kobj[i].method_id = method_id;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+static WMI_ATTR(method_id, S_IWUGO | S_IRUGO, show_guid_method_id,
+	set_guid_method_id);
+
+static ssize_t show_event_notification(struct kobject *kobj, char *buf)
+{
+	int i;
+
+	for (i = 0; i < guids.total; i++) {
+		if (memcmp(kobject_name(&wmi_guid_kobj[i].guid_kobj),
+			kobject_name(kobj), 36) == 0)
+			return sprintf(buf, "%d\n",
+				guids.pointer[i].notify_id & 0xFF);
+	}
+	return sprintf(buf, "Error\n");
+}
+static WMI_ATTR(notification, S_IRUGO, show_event_notification, NULL);
+
+static int wmi_sysfs_init(void)
+{
+	int i, j, result;
+	u8 instances;
+	char guid_string[37];
+	char temp[4];
+	struct kobject *guid_kobj;
+	struct kobject *instance_kobjs;
+	struct guid_block *block;
+
+	wmi_guid_kobj = kzalloc(sizeof(struct guid_kobjects) * guids.total,
+		GFP_KERNEL);
+
+	wmi_kobj.parent = &acpi_subsys.kobj;
+	wmi_kobj.ktype = &ktype_wmi;
+	kobject_set_name(&wmi_kobj, "wmi");
+
+	result = kobject_register(&wmi_kobj);
+	if (result)
+		return result;
+
+	/* Create directories for all the GUIDs */
+	for (i = 0; i < guids.total; i++) {
+		guid_kobj = &wmi_guid_kobj[i].guid_kobj;
+		guid_kobj->parent = &wmi_kobj;
+		guid_kobj->ktype = &ktype_wmi;
+
+		block = guids.pointer + i;
+		wmi_gtoa(block->guid, guid_string);
+		kobject_set_name(guid_kobj, guid_string);
+
+		result = kobject_register(guid_kobj);
+		if (result)
+			return result;
+
+		result = sysfs_create_file(guid_kobj, &wmi_attr_type.attr);
+		if (result)
+			return result;
+
+		if (guids.pointer[i].flags & ACPI_WMI_EVENT) {
+			result = sysfs_create_file(guid_kobj,
+				&wmi_attr_notification.attr);
+			if (result)
+				return result;
+
+			result = sysfs_create_bin_file(guid_kobj,
+				&wmi_attr_event_data);
+			if (result)
+				return result;
+			break;
+		}
+
+		/* Create directories for all the instances */
+		instances = guids.pointer[i].instance_count;
+		wmi_guid_kobj[i].instances = instances;
+		wmi_guid_kobj[i].instance_kobjs = kzalloc(sizeof(struct kobject)
+			* instances, GFP_KERNEL);
+		instance_kobjs = wmi_guid_kobj[i].instance_kobjs;
+		for (j = 0; j < instances; j++) {
+			instance_kobjs[j].parent = guid_kobj;
+			instance_kobjs[j].ktype = &ktype_wmi;
+			sprintf(temp, "%d", j+1);
+			kobject_set_name(&instance_kobjs[j], temp);
+
+			result = kobject_register(&instance_kobjs[j]);
+			if (result)
+				return result;
+
+			/* Create the relevant files under each instance */
+			result = sysfs_create_bin_file(&instance_kobjs[j],
+				&wmi_attr_data);
+			if (result)
+				return result;
+
+			if (guids.pointer[i].flags & ACPI_WMI_METHOD) {
+				result = sysfs_create_file(&instance_kobjs[j],
+					&wmi_attr_method_id.attr);
+				if (result)
+					return result;
+			}
+		}
+	}
+	return 0;
+}
+
 /**
  * parse_wdg - Parse the _WDG method for the GUID data blocks
  */
@@ -551,6 +881,8 @@ static int __init acpi_wmi_add(struct acpi_device *device)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
+	result = wmi_sysfs_init();
+
 	return result;
 }
 
-- 
1.5.3.4

