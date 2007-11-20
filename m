From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 2/2] ACPI: WMI: Add sysfs userspace interface
Date: Tue, 20 Nov 2007 17:41:45 +0000
Message-ID: <200711201741.46314.carlos@strangeworlds.co.uk>
References: <200711201739.16839.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:51726 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087AbXKTRmx (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 20 Nov 2007 12:42:53 -0500
In-Reply-To: <200711201739.16839.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Nashif, Anas" <anas.nashif@intel.com>

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

===
ChangeLog
==

v1 (2007-11-03)

* Initial release

v2 (2007-11-07)

* Split out into a separate patch

v3 (2007-11-20)

* Convert kobject storage to using kernel list structures.
* Change instance handling - store input data on a per instance basis,
  rather than a per GUID.
* Add locking to methods - method_id (write) and data (read & write)
  should all be mutually exclusive - we do not want the input data to
  change when we are trying to execute a method.
* Change method calling semantics: when input is written to 'data',
  store it, but don't execute the method until 'data' is read. This is
  due to the fact that it is perfectly acceptable to have a WMI method
  that does not take any input (and it is easier to trigger an execute
  on reading the file, and not return anything if there is nothing to
  return, rather than trying to write values that aren't required, or
  may cause ACPI evaluation to fail on the method).
* Do not try and convert String's from ASCII to Unicode - instead, only
  handle ASCII (as per ACPI), and leave it up to userspace to convert
  to/ from whatever encoding they wish to use.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---
 drivers/acpi/wmi.c |  380 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 379 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index 93b9799..0bdb8ec 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -60,15 +60,31 @@ struct guid_block
 	u8 flags;
 };
 
+struct wmi_instance
+{
+	struct kobject kobj;
+	u32 method_id;
+	void *pointer;
+	acpi_size length;
+};
+
 struct wmi_block
 {
 	struct list_head list;
 	struct guid_block gblock;
 	acpi_handle handle;
+	struct kobject kobj;
+	struct wmi_instance *instances;
 };
 
 static struct wmi_block wmi_blocks;
 
+/*
+ * Temporary list - hold contents of each WMI device for sysfs initialisation,
+ * before adding to wmi_blocks
+ */
+static struct wmi_block wmi_block_sysfs;
+
 static wmi_notify_handler wmi_external_handler;
 static void *wmi_external_data;
 
@@ -198,6 +214,33 @@ static bool wmi_parse_guid(const u8 *src, u8 *dest)
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
 static bool find_guid(const char *guid_string, struct wmi_block **out)
 {
 	char tmp[16], guid_input[16];
@@ -500,6 +543,323 @@ bool wmi_has_guid(const char *guid_string)
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
+static struct kobject wmi_kobj;
+
+static ssize_t wmi_data_read(struct kobject *kobj, struct bin_attribute
+			*bin_attr, char *buf, loff_t offset, size_t count) {
+	u8 instance;
+	const char *guid;
+	struct acpi_buffer in;
+	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_status status;
+	union acpi_object *obj;
+	struct wmi_block *block;
+	struct wmi_instance *iblock;
+
+	guid = kobject_name(kobj->parent);
+
+	block = container_of(kobj->parent, struct wmi_block, kobj);
+	if (!block)
+		return -EINVAL;
+
+	iblock = container_of(kobj, struct wmi_instance, kobj);
+	if (!iblock)
+		return -EINVAL;
+
+	instance = simple_strtoul(kobject_name(kobj), NULL, 10);
+
+	if (block->gblock.flags & ACPI_WMI_METHOD) {
+		mutex_lock(&wmi_data_lock);
+		if (iblock->pointer) {
+			in.pointer = iblock->pointer;
+			in.length = iblock->length;
+			status = wmi_evaluate_method(guid, instance,
+				iblock->method_id, &in, &out);
+		} else {
+			status = wmi_evaluate_method(guid, instance,
+				iblock->method_id, NULL, &out);
+		}
+		mutex_unlock(&wmi_data_lock);
+	} else {
+		status = wmi_query_block(guid, instance, &out);
+	}
+
+	obj = (union acpi_object *) out.pointer;
+
+	switch (obj->type) {
+	case (ACPI_TYPE_STRING):
+	case (ACPI_TYPE_BUFFER):
+		buf = obj->buffer.pointer;
+		break;
+	default:
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static ssize_t wmi_data_write(struct kobject *kobj, struct bin_attribute
+			*bin_attr, char *buf, loff_t offset, size_t count){
+	struct wmi_block *wblock = NULL;
+	struct wmi_instance *iblock = NULL;
+	struct acpi_buffer in;
+	acpi_status status;
+	const char *guid;
+	u8 inst;
+
+	guid = kobject_name(kobj->parent);
+	inst = simple_strtoul(kobject_name(kobj), NULL, 10);
+
+	wblock = container_of(kobj->parent, struct wmi_block, kobj);
+	if (!wblock)
+		return -EINVAL;
+
+	iblock = container_of(kobj, struct wmi_instance, kobj);
+	if (!iblock)
+		return -EINVAL;
+
+	if (count == 0)
+		return count;
+
+	if (wblock->gblock.flags & ACPI_WMI_METHOD) {
+		iblock->pointer = kzalloc(count, GFP_KERNEL);
+		if (!iblock->pointer)
+			return count;
+
+		memcpy(iblock->pointer, buf, count);
+
+		iblock->length = count;
+	} else {
+		in.pointer = buf;
+		in.length = count;
+		status = wmi_set_block(guid, inst, &in);
+	}
+
+	return count;
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
+	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obj;
+	struct wmi_block *block;
+
+	block = container_of(kobj, struct wmi_block, kobj);
+	wmi_get_event_data(block->gblock.notify_id, &out);
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
+static ssize_t show_guid_type(struct kobject *kobj, char *buf)
+{
+	struct guid_block *block;
+	struct wmi_block *wblock;
+	bool result;
+
+	result = find_guid(kobject_name(kobj), &wblock);
+	if (result == false)
+		return sprintf(buf, "Error\n");
+
+	block = &wblock->gblock;
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
+	struct wmi_instance *block;
+
+	block = container_of(kobj, struct wmi_instance, kobj);
+	if (!block)
+		return sprintf(buf, "Error\n");
+
+	return sprintf(buf, "%d\n", block->method_id);
+}
+
+static ssize_t set_guid_method_id(struct kobject *kobj, const char *buf,
+	ssize_t count)
+{
+	struct wmi_instance *block;
+	u8 method_id;
+
+	method_id = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&wmi_data_lock);
+
+	block = container_of(kobj, struct wmi_instance, kobj);
+	if (!block) {
+		mutex_unlock(&wmi_data_lock);
+		return -EINVAL;
+	}
+
+	block->method_id = method_id;
+	mutex_unlock(&wmi_data_lock);
+	return count;
+}
+static WMI_ATTR(method_id, S_IWUGO | S_IRUGO, show_guid_method_id,
+	set_guid_method_id);
+
+static ssize_t show_event_notification(struct kobject *kobj, char *buf)
+{
+	struct wmi_block *block;
+	struct guid_block *gblock;
+
+	block = container_of(kobj, struct wmi_block, kobj);
+	gblock = &block->gblock;
+
+	return sprintf(buf, "%d\n", gblock->notify_id & 0xFF);
+}
+static WMI_ATTR(notification, S_IRUGO, show_event_notification, NULL);
+
+static int wmi_sysfs_init(void)
+{
+	int i, result;
+	u8 instances;
+	char guid_string[37];
+	char inst_string[4];
+	struct kobject *guid_kobj, *inst_kobj;
+	struct guid_block *gblock;
+	struct wmi_block *wblock;
+	struct list_head *p;
+
+	/* Create directories for all the GUIDs */
+	list_for_each(p, &wmi_block_sysfs.list) {
+		wblock = list_entry(p, struct wmi_block, list);
+		guid_kobj = &wblock->kobj;
+		guid_kobj->parent = &wmi_kobj;
+		guid_kobj->ktype = &ktype_wmi;
+
+		gblock = &wblock->gblock;
+		wmi_gtoa(gblock->guid, guid_string);
+
+		result = kobject_set_name(guid_kobj, guid_string);
+		if (result)
+			return result;
+
+		result = kobject_register(guid_kobj);
+		if (result)
+			return result;
+
+		result = sysfs_create_file(guid_kobj, &wmi_attr_type.attr);
+		if (result)
+			return result;
+
+		if (gblock->flags & ACPI_WMI_EVENT) {
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
+		instances = gblock->instance_count;
+		for (i = 0; i < instances; i++) {
+			inst_kobj = &wblock->instances[i].kobj;
+			inst_kobj->parent = guid_kobj;
+			inst_kobj->ktype = &ktype_wmi;
+			sprintf(inst_string, "%d", i+1);
+			result = kobject_set_name(inst_kobj, inst_string);
+			if (result)
+				return result;
+
+			result = kobject_register(inst_kobj);
+			if (result)
+				return result;
+
+			/* Create the relevant files under each instance */
+			result = sysfs_create_bin_file(inst_kobj,
+				&wmi_attr_data);
+			if (result)
+				return result;
+
+			if (gblock->flags & ACPI_WMI_METHOD) {
+				result = sysfs_create_file(inst_kobj,
+					&wmi_attr_method_id.attr);
+				if (result)
+					return result;
+			}
+		}
+	}
+
+	list_splice_init(&wmi_block_sysfs.list, &wmi_blocks.list);
+
+	return 0;
+}
+
 /**
  * parse_wdg - Parse the _WDG method for the GUID data blocks
  */
@@ -535,9 +895,14 @@ static __init acpi_status parse_wdg(acpi_handle handle)
 		if (!wblock)
 			return AE_NO_MEMORY;
 
+		wblock->instances = kzalloc(gblock[i].instance_count *
+			sizeof(struct wmi_instance), GFP_KERNEL);
+		if (!wblock->instances)
+			return AE_NO_MEMORY;
+
 		wblock->gblock = gblock[i];
 		wblock->handle = handle;
-		list_add_tail(&wblock->list, &wmi_blocks.list);
+		list_add_tail(&wblock->list, &wmi_block_sysfs.list);
 	}
 
 	kfree(out.pointer);
@@ -588,6 +953,8 @@ static int __init acpi_wmi_add(struct acpi_device *device)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
+	result = wmi_sysfs_init();
+
 	return result;
 }
 
@@ -598,7 +965,18 @@ static int __init acpi_wmi_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
+	wmi_kobj.parent = &acpi_subsys.kobj;
+	wmi_kobj.ktype = &ktype_wmi;
+	result = kobject_set_name(&wmi_kobj, "wmi");
+	if (result)
+		return result;
+
+	result = kobject_register(&wmi_kobj);
+	if (result)
+		return result;
+
 	INIT_LIST_HEAD(&wmi_blocks.list);
+	INIT_LIST_HEAD(&wmi_block_sysfs.list);
 
 	result = acpi_bus_register_driver(&acpi_wmi_driver);
 
-- 
1.5.3.4

