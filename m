From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 4/4] [RFC] ACPI: WMI: Add sysfs userspace interface
Date: Tue, 18 Dec 2007 23:52:00 +0000
Message-ID: <20071218235200.12838.13702.stgit@localhost>
References: <20071218235137.12838.75397.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:42950 "EHLO
	pacifica." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1752603AbXLRXzg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Dec 2007 18:55:36 -0500
In-Reply-To: <20071218235137.12838.75397.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Create a 'wmi' class, and populate it with a virtual device for each GUID.
This also allows us to autoload WMI drivers based on GUID
via MODULE_ALIAS.

Under each GUID are a set of files that can be read and written to from
userspace (these will be fully documented in a later patch).

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

v4 (2007-11-28)

* Add code to remove sysfs files on module removal

v5 (2007-12-08)

* Convert to a class device, instead of trying to manually create and
  manipulate kobject's - this allows us to add module autoloading for WMI
  based drivers, and will (hopefully) be less likely to break with the
  latest round of kobject changes.
* Convert GUIDs to use a 'flat' structure - add two new files:
  instance and instance_count, and use these to provide the instance
  to call for a given GUID (while still communicating the maximum number
  of instances available - for now, we will always respect instance_count
  when setting instance - so any instance > instance_count will be
  discarded).

v6 (2007-12-12)

* Add string file - this reports back if the GUID has the string flag set.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Len Brown <lenb@kernel.org>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
---

 drivers/acpi/wmi.c |  463 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 461 insertions(+), 2 deletions(-)


diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index 1392aa9..f9f289e 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -30,6 +30,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
@@ -64,6 +66,11 @@ struct wmi_block {
 	struct list_head list;
 	struct guid_block gblock;
 	acpi_handle handle;
+	struct device dev;
+	u8 instance;
+	u32 method_id;
+	void *pointer;
+	acpi_size length;
 };
 
 static struct wmi_block wmi_blocks;
@@ -195,6 +202,33 @@ static bool wmi_parse_guid(const u8 *src, u8 *dest)
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
@@ -501,6 +535,421 @@ bool wmi_has_guid(const char *guid_string)
 EXPORT_SYMBOL_GPL(wmi_has_guid);
 
 /*
+ * sysfs interface
+ */
+static ssize_t wmi_data_read(struct kobject *kobj, struct bin_attribute
+			*bin_attr, char *buf, loff_t offset, size_t count) {
+	u8 instance;
+	const char *guid;
+	struct acpi_buffer in;
+	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_status status;
+	union acpi_object *obj;
+	struct wmi_block *block;
+	struct device *dev;
+
+	dev = container_of(kobj, struct device, kobj);
+	if (!dev)
+		return -ENODEV;
+
+	block = container_of(dev, struct wmi_block, dev);
+	if (!block)
+		return -EINVAL;
+
+	guid = block->gblock.guid;
+	if (!guid)
+		return -EINVAL;
+
+	instance = block->instance;
+
+	if (block->gblock.flags & ACPI_WMI_METHOD) {
+		mutex_lock(&wmi_data_lock);
+		if (block->pointer) {
+			in.pointer = block->pointer;
+			in.length = block->length;
+			status = wmi_evaluate_method(guid, instance,
+				block->method_id, &in, &out);
+		} else {
+			status = wmi_evaluate_method(guid, instance,
+				block->method_id, NULL, &out);
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
+	struct wmi_block *block;
+	struct acpi_buffer in;
+	acpi_status status;
+	struct device *dev;
+	char guid_string[37];
+
+	dev = container_of(kobj, struct device, kobj);
+	if (!dev)
+		return -ENODEV;
+
+	block = container_of(dev, struct wmi_block, dev);
+	if (!block)
+		return -EINVAL;
+
+	if (count == 0)
+		return count;
+
+	if (block->gblock.flags & ACPI_WMI_METHOD) {
+		block->pointer = kzalloc(count, GFP_KERNEL);
+		if (!block->pointer)
+			return count;
+
+		memcpy(block->pointer, buf, count);
+		block->length = count;
+	} else {
+		in.pointer = buf;
+		in.length = count;
+		wmi_gtoa(block->gblock.guid, guid_string);
+		status = wmi_set_block(guid_string, block->instance, &in);
+	}
+
+	return count;
+}
+
+static struct bin_attribute wmi_attr_data = {
+	.attr = {
+		.name = "data",
+		.mode = 0600
+	},
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
+	struct device *dev;
+
+	dev = container_of(kobj, struct device, kobj);
+	if (!dev)
+		return -ENODEV;
+
+	block = container_of(dev, struct wmi_block, dev);
+	if (!block)
+		return -EINVAL;
+
+	wmi_get_event_data(block->gblock.notify_id, &out);
+
+	obj = (union acpi_object *) out.pointer;
+	buf = obj->buffer.pointer;
+
+	return 0;
+}
+
+static struct bin_attribute wmi_attr_event_data = {
+	.attr = {
+		.name = "data",
+		.mode = 0400
+	},
+	.size = 0,
+	.read = wmi_event_data_read,
+};
+
+static ssize_t show_type(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct guid_block *block;
+	struct wmi_block *wblock;
+
+	wblock = container_of(dev, struct wmi_block, dev);
+	if (!wblock)
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
+static DEVICE_ATTR(type, S_IRUGO, show_type, NULL);
+
+static ssize_t show_instance_count(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct wmi_block *block;
+
+	block = container_of(dev, struct wmi_block, dev);
+	if (!block)
+		return sprintf(buf, "Error\n");
+
+	return sprintf(buf, "%d\n", block->gblock.instance_count);
+}
+static DEVICE_ATTR(instance_count, S_IRUGO, show_instance_count, NULL);
+
+static ssize_t show_instance(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct wmi_block *block;
+
+	block = container_of(dev, struct wmi_block, dev);
+	if (!block)
+		return sprintf(buf, "Error\n");
+
+	return sprintf(buf, "%d\n", block->instance);
+}
+
+static ssize_t set_instance(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct wmi_block *block;
+	u8 instance;
+
+	instance = simple_strtoul(buf, NULL, 10);
+
+	block = container_of(dev, struct wmi_block, dev);
+	if (!block)
+		return -EINVAL;
+
+	if (instance <= block->gblock.instance_count) {
+		block->instance = instance;
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+static DEVICE_ATTR(instance, S_IWUGO | S_IRUGO, show_instance, set_instance);
+
+static ssize_t show_method_id(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct wmi_block *block;
+
+	block = container_of(dev, struct wmi_block, dev);
+	if (!block)
+		return sprintf(buf, "Error\n");
+
+	return sprintf(buf, "%d\n", block->method_id);
+}
+
+static ssize_t set_method_id(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct wmi_block *block;
+	u8 method_id;
+
+	method_id = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&wmi_data_lock);
+
+	block = container_of(dev, struct wmi_block, dev);
+	if (!block) {
+		mutex_unlock(&wmi_data_lock);
+		return -EINVAL;
+	}
+
+	block->method_id = method_id;
+	mutex_unlock(&wmi_data_lock);
+
+	return count;
+}
+static DEVICE_ATTR(method_id, S_IWUGO | S_IRUGO, show_method_id,
+	set_method_id);
+
+static ssize_t show_event_notification(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct wmi_block *block;
+	struct guid_block *gblock;
+
+	block = container_of(dev, struct wmi_block, dev);
+	gblock = &block->gblock;
+
+	return sprintf(buf, "%d\n", gblock->notify_id & 0xFF);
+}
+static DEVICE_ATTR(notification, S_IRUGO, show_event_notification, NULL);
+
+static ssize_t show_string(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct wmi_block *block;
+	struct guid_block *gblock;
+
+	block = container_of(dev, struct wmi_block, dev);
+	gblock = &block->gblock;
+
+	return sprintf(buf, "%d\n", (gblock->flags & ACPI_WMI_STRING) >> 2);
+}
+static DEVICE_ATTR(string, S_IRUGO, show_string, NULL);
+
+static int wmi_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	char guid_string[37];
+
+	struct wmi_block *wblock;
+
+	if (add_uevent_var(env, "MODALIAS="))
+		return -ENOMEM;
+
+	wblock = container_of(dev, struct wmi_block, dev);
+	if (!wblock)
+		return -ENOMEM;
+
+	wmi_gtoa(wblock->gblock.guid, guid_string);
+
+	strcpy(&env->buf[env->buflen - 1], "wmi:");
+	memcpy(&env->buf[env->buflen - 1 + 4], guid_string, 36);
+	env->buflen += 40;
+
+	return 0;
+}
+
+static struct class wmi_class = {
+	.name = "wmi",
+	.dev_release = (void(*)(struct device *)) kfree,
+	.dev_uevent = wmi_dev_uevent,
+};
+
+static int wmi_create_devs(void)
+{
+	int result;
+	char guid_string[37];
+	struct guid_block *gblock;
+	struct wmi_block *wblock;
+	struct list_head *p;
+	struct device *guid_dev;
+
+	/* Create devices for all the GUIDs */
+	list_for_each(p, &wmi_blocks.list) {
+		wblock = list_entry(p, struct wmi_block, list);
+
+		guid_dev = &wblock->dev;
+		guid_dev->class = &wmi_class;
+
+		gblock = &wblock->gblock;
+
+		wmi_gtoa(gblock->guid, guid_string);
+		memcpy(guid_dev->bus_id, guid_string, 36);
+
+		result = device_register(guid_dev);
+		if (result)
+			return result;
+
+		result = device_create_file(guid_dev, &dev_attr_type);
+		if (result)
+			return result;
+
+		result = device_create_file(guid_dev, &dev_attr_string);
+		if (result)
+			return result;
+
+		if (gblock->flags & ACPI_WMI_EVENT) {
+			result = device_create_file(guid_dev,
+				&dev_attr_notification);
+			if (result)
+				return result;
+
+			result = device_create_bin_file(guid_dev,
+				&wmi_attr_event_data);
+			if (result)
+				return result;
+			break;
+		}
+
+		result = device_create_file(guid_dev, &dev_attr_instance_count);
+		if (result)
+			return result;
+
+		result = device_create_file(guid_dev, &dev_attr_instance);
+		if (result)
+			return result;
+
+		result = device_create_bin_file(guid_dev, &wmi_attr_data);
+		if (result)
+			return result;
+
+		if (gblock->flags & ACPI_WMI_METHOD) {
+			result = device_create_file(guid_dev,
+				&dev_attr_method_id);
+			if (result)
+				return result;
+		}
+	}
+
+	return 0;
+}
+
+static void wmi_remove_devs(void)
+{
+	struct guid_block *gblock;
+	struct wmi_block *wblock;
+	struct list_head *p;
+	struct device *guid_dev;
+
+	/* Delete devices for all the GUIDs */
+	list_for_each(p, &wmi_blocks.list) {
+		wblock = list_entry(p, struct wmi_block, list);
+
+		guid_dev = &wblock->dev;
+		gblock = &wblock->gblock;
+
+		device_remove_file(guid_dev, &dev_attr_type);
+		device_remove_file(guid_dev, &dev_attr_string);
+
+		if (gblock->flags & ACPI_WMI_EVENT) {
+			device_remove_file(guid_dev, &dev_attr_notification);
+			device_remove_bin_file(guid_dev, &wmi_attr_event_data);
+		} else {
+			device_remove_file(guid_dev, &dev_attr_instance_count);
+			device_remove_file(guid_dev, &dev_attr_instance);
+			device_remove_bin_file(guid_dev, &wmi_attr_data);
+
+			if (gblock->flags & ACPI_WMI_METHOD) {
+				device_remove_file(guid_dev,
+					&dev_attr_method_id);
+			}
+		}
+		device_unregister(guid_dev);
+	}
+}
+
+static int wmi_class_init(void)
+{
+	int ret;
+
+	ret = class_register(&wmi_class);
+	if (ret)
+		return ret;
+
+	return wmi_create_devs();
+}
+
+static void wmi_class_exit(void)
+{
+	wmi_remove_devs();
+	class_unregister(&wmi_class);
+}
+
+/*
  * Parse the _WDG method for the GUID data blocks
  */
 static __init acpi_status parse_wdg(acpi_handle handle)
@@ -657,6 +1106,7 @@ static int __init acpi_wmi_add(struct acpi_device *device)
 
 static int __init acpi_wmi_init(void)
 {
+	int ret;
 	acpi_status result;
 
 	if (acpi_disabled)
@@ -668,10 +1118,17 @@ static int __init acpi_wmi_init(void)
 
 	if (ACPI_FAILURE(result)) {
 		printk(KERN_INFO PREFIX "Error loading mapper\n");
-	} else {
-		printk(KERN_INFO PREFIX "Mapper loaded\n");
+		return -ENODEV;
+	}
+
+	ret = wmi_class_init();
+	if (ret) {
+		acpi_bus_unregister_driver(&acpi_wmi_driver);
+		return ret;
 	}
 
+	printk(KERN_INFO PREFIX "Mapper loaded\n");
+
 	return result;
 }
 
@@ -680,6 +1137,8 @@ static void __exit acpi_wmi_exit(void)
 	struct list_head *p, *tmp;
 	struct wmi_block *wblock;
 
+	wmi_class_exit();
+
 	acpi_bus_unregister_driver(&acpi_wmi_driver);
 
 	list_for_each_safe(p, tmp, &wmi_blocks.list) {

