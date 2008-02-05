From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 4/5] ACPI: WMI: Add sysfs userspace interface
Date: Tue, 05 Feb 2008 02:17:21 +0000
Message-ID: <20080205021721.4422.58508.stgit@pacifica>
References: <20080205021658.4422.83165.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:60862 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756034AbYBECU7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2008 21:20:59 -0500
In-Reply-To: <20080205021658.4422.83165.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Create a 'wmi' class, and populate it with a virtual device for each GUID.
This also allows us to autoload WMI drivers based on GUID
via MODULE_ALIAS.

Under each GUID are a set of files that can be read and written to from
userspace (these will be fully documented in a later patch).

For now, the length of the GUID name/ directory is limited to 19
characters, due to the current hardcoded limit on bus_id. When this is
fixed, this can be changed in the code.

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

v8 (2008-01-18)

* Add new in kernel function, wmi_get_device(), to take advantage of the
  class and virtual devices, and return the virtual device for a GUID.

v9 (2008-02-04)

* Fold in bus_id length workaround

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Len Brown <lenb@kernel.org>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
---

 drivers/acpi/Kconfig |   10 +
 drivers/acpi/wmi.c   |  547 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |    1 
 3 files changed, 556 insertions(+), 2 deletions(-)


diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 0065f37..646b6f7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -210,6 +210,16 @@ config ACPI_WMI
 	  NOTE: You will need another driver or userspace application on top of
 	  this to actually use anything defined in the ACPI-WMI mapper.
 
+config ACPI_WMI_SYSFS_DEVEL
+	bool "WMI future sysfs interface"
+	default n
+	depends on ACPI_WMI
+	depends on SYSFS
+	help
+	  This creates a sysfs interface for the GUIDs associated with WMI.
+	  This is currently in development, so should only be enabled by testers
+	  or developers.
+
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
 	depends on X86
diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index 36b84ab..499add8 100644
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
@@ -66,6 +68,11 @@ struct wmi_block {
 	acpi_handle handle;
 	wmi_notify_handler handler;
 	void *handler_data;
+	struct device *dev;
+	u8 instance;
+	u32 method_id;
+	void *pointer;
+	acpi_size length;
 };
 
 static struct wmi_block wmi_blocks;
@@ -194,6 +201,35 @@ static bool wmi_parse_guid(const u8 *src, u8 *dest)
 	return true;
 }
 
+#ifdef CONFIG_ACPI_WMI_SYSFS_DEVEL
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
+#endif
+
 static bool find_guid(const char *guid_string, struct wmi_block **out)
 {
 	char tmp[16], guid_input[16];
@@ -517,6 +553,503 @@ bool wmi_has_guid(const char *guid_string)
 EXPORT_SYMBOL_GPL(wmi_has_guid);
 
 /*
+ * Until sysfs support is stabilised, allow it to be disabled
+ */
+#ifdef CONFIG_ACPI_WMI_SYSFS_DEVEL
+/**
+ * wmi_get_device - Get the virtual device associated with a GUID
+ * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
+ * @dev: Pointer to pointer to the device
+ *
+ * Return a pointer to a pointer to virtual device associated with a GUID
+ */
+int wmi_get_device(const char *guid_string, struct device **dev)
+{
+	struct wmi_block *block;
+	bool ret;
+
+	ret = find_guid(guid_string, &block);
+	if (!ret)
+		return -ENODEV;
+
+	*dev = block->dev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wmi_get_device);
+
+/*
+ * sysfs interface
+ */
+static ssize_t wmi_data_read(struct kobject *kobj, struct bin_attribute
+			*bin_attr, char *buf, loff_t offset, size_t count) {
+	u8 instance;
+	u32 method_id;
+	const char *guid;
+	struct acpi_buffer in;
+	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_status status;
+	union acpi_object *obj;
+	struct wmi_block *block;
+	struct device *dev;
+	char guid_string[37];
+
+	dev = container_of(kobj, struct device, kobj);
+	if (!dev)
+		return -ENODEV;
+
+	block = dev->driver_data;
+	if (!block)
+		return -EINVAL;
+
+	guid = block->gblock.guid;
+	if (!guid)
+		return -EINVAL;
+
+	instance = block->instance;
+	if (instance == 0)
+		return -EINVAL;
+
+	wmi_gtoa(block->gblock.guid, guid_string);
+
+	if (block->gblock.flags & ACPI_WMI_METHOD) {
+		method_id = block->method_id;
+		if (method_id == 0)
+			return -EINVAL;
+
+		mutex_lock(&wmi_data_lock);
+		if (block->pointer) {
+			in.pointer = block->pointer;
+			in.length = block->length;
+			status = wmi_evaluate_method(guid_string, instance,
+				method_id, &in, &out);
+		} else {
+			status = wmi_evaluate_method(guid_string, instance,
+				method_id, NULL, &out);
+		}
+		kfree(block->pointer);
+		block->length = 0;
+		mutex_unlock(&wmi_data_lock);
+	} else {
+		status = wmi_query_block(guid_string, instance, &out);
+	}
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj = (union acpi_object *) out.pointer;
+
+	if (!obj || obj->buffer.length == 0)
+		return -EIO;
+
+	switch (obj->type) {
+	case (ACPI_TYPE_STRING):
+	case (ACPI_TYPE_BUFFER):
+		block->pointer = kzalloc(obj->buffer.length, GFP_KERNEL);
+		if (!block->pointer)
+			return -ENOMEM;
+
+		memcpy(block->pointer, obj->buffer.pointer, obj->buffer.length);
+		kfree(out.pointer);
+		buf = block->pointer;
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
+	block = dev->driver_data;
+	if (!block)
+		return -EINVAL;
+
+	if (block->instance == 0)
+		return -EINVAL;
+
+	if (count == 0)
+		return count;
+
+	if (block->gblock.flags & ACPI_WMI_METHOD) {
+		kfree(block->pointer);
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
+	block = dev->driver_data;
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
+	wblock = dev->driver_data;
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
+	block = dev->driver_data;
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
+	block = dev->driver_data;
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
+	block = dev->driver_data;
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
+	block = dev->driver_data;
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
+	block = dev->driver_data;
+	if (!block)
+		return -EINVAL;
+
+	mutex_lock(&wmi_data_lock);
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
+	block = dev->driver_data;
+	if (!block)
+		return -EINVAL;
+
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
+	block = dev->driver_data;
+	if (!block)
+		return -EINVAL;
+
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
+	wblock = dev->driver_data;
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
+static void wmi_dev_free(struct device *dev)
+{
+	kfree(dev);
+}
+
+static struct class wmi_class = {
+	.name = "wmi",
+	.dev_release = wmi_dev_free,
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
+		guid_dev = kzalloc(sizeof(struct device), GFP_KERNEL);
+		if (!guid_dev)
+			return -ENOMEM;
+
+		wblock->dev = guid_dev;
+
+		guid_dev->class = &wmi_class;
+		guid_dev->driver_data = wblock;
+
+		gblock = &wblock->gblock;
+
+		wmi_gtoa(gblock->guid, guid_string);
+		memcpy(guid_dev->bus_id, guid_string, 19);
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
+		guid_dev = wblock->dev;
+		gblock = &wblock->gblock;
+
+		device_remove_file(guid_dev, &dev_attr_type);
+		device_remove_file(guid_dev, &dev_attr_string);
+		device_remove_file(guid_dev, &dev_attr_notification);
+		device_remove_bin_file(guid_dev, &wmi_attr_event_data);
+		device_remove_file(guid_dev, &dev_attr_instance_count);
+		device_remove_file(guid_dev, &dev_attr_instance);
+		device_remove_bin_file(guid_dev, &wmi_attr_data);
+		device_remove_file(guid_dev, &dev_attr_method_id);
+
+		kfree(wblock->pointer);
+		device_unregister(guid_dev);
+	}
+}
+
+static void wmi_class_exit(void)
+{
+	wmi_remove_devs();
+	class_unregister(&wmi_class);
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
+	ret = wmi_create_devs();
+	if (ret)
+		wmi_class_exit();
+
+	return ret;
+}
+#else
+int wmi_get_device(const char *guid_string, struct device **dev)
+{
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(wmi_get_device);
+
+static int wmi_class_init(void)
+{
+	return 0;
+}
+
+static void wmi_class_exit(void)
+{
+	return;
+}
+#endif
+
+/*
  * Parse the _WDG method for the GUID data blocks
  */
 static __init acpi_status parse_wdg(acpi_handle handle)
@@ -671,6 +1204,7 @@ static int __init acpi_wmi_add(struct acpi_device *device)
 
 static int __init acpi_wmi_init(void)
 {
+	int ret;
 	acpi_status result;
 
 	if (acpi_disabled)
@@ -682,10 +1216,17 @@ static int __init acpi_wmi_init(void)
 
 	if (result < 0) {
 		printk(KERN_INFO PREFIX "Error loading mapper\n");
-	} else {
-		printk(KERN_INFO PREFIX "Mapper loaded\n");
+		return -ENODEV;
 	}
 
+	ret = wmi_class_init();
+	if (ret) {
+		acpi_bus_unregister_driver(&acpi_wmi_driver);
+		return ret;
+	}
+
+	printk(KERN_INFO PREFIX "Mapper loaded\n");
+
 	return result;
 }
 
@@ -694,6 +1235,8 @@ static void __exit acpi_wmi_exit(void)
 	struct list_head *p, *tmp;
 	struct wmi_block *wblock;
 
+	wmi_class_exit();
+
 	acpi_bus_unregister_driver(&acpi_wmi_driver);
 
 	list_for_each_safe(p, tmp, &wmi_blocks.list) {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9f2ee42..8cbbeb2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -208,6 +208,7 @@ extern acpi_status wmi_install_notify_handler(const char *guid,
 extern acpi_status wmi_remove_notify_handler(const char *guid);
 extern acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out);
 extern bool wmi_has_guid(const char *guid);
+extern int wmi_get_device(const char *guid, struct device **dev);
 
 #endif	/* CONFIG_ACPI_WMI */
 

