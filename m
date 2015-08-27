From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/6] ACPI / property: Expose data-only subnodes via sysfs
Date: Thu, 27 Aug 2015 04:37:19 +0200
Message-ID: <16033996.GWWcV6IzrQ@vostro.rjw.lan>
References: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51765 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752707AbbH0CPS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Aug 2015 22:15:18 -0400
In-Reply-To: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Dustin Byford <dustin@cumulusnetworks.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add infrastructure needed to expose data-only subnodes of ACPI
device objects introduced previously via sysfs.

Each data-only subnode is represented as a sysfs directory under
the directory corresponding to its parent object (a device or a
data-only subnode).  Each of them has a "path" attribute (containing
the full ACPI namespace path to the object the subnode data come from)
at this time.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/device_sysfs.c |  120 +++++++++++++++++++++++++++++++++++++++-----
 drivers/acpi/property.c     |    8 +-
 include/acpi/acpi_bus.h     |    3 +
 3 files changed, 116 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/acpi/device_sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_sysfs.c
+++ linux-pm/drivers/acpi/device_sysfs.c
@@ -26,6 +26,106 @@
 
 #include "internal.h"
 
+static ssize_t acpi_object_path(acpi_handle handle, char *buf)
+{
+	struct acpi_buffer path = {ACPI_ALLOCATE_BUFFER, NULL};
+	int result;
+
+	result = acpi_get_name(handle, ACPI_FULL_PATHNAME, &path);
+	if (result)
+		return result;
+
+	result = sprintf(buf, "%s\n", (char*)path.pointer);
+	kfree(path.pointer);
+	return result;
+}
+
+struct acpi_data_node_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct acpi_data_node *, char *);
+	ssize_t (*store)(struct acpi_data_node *, const char *, size_t count);
+};
+
+#define DATA_NODE_ATTR(_name)			\
+	static struct acpi_data_node_attr data_node_##_name =	\
+		__ATTR(_name, 0444, data_node_show_##_name, NULL)
+
+static ssize_t data_node_show_path(struct acpi_data_node *dn, char *buf)
+{
+	return acpi_object_path(dn->handle, buf);
+}
+
+DATA_NODE_ATTR(path);
+
+static struct attribute *acpi_data_node_default_attrs[] = {
+	&data_node_path.attr,
+	NULL
+};
+
+#define to_data_node(k) container_of(k, struct acpi_data_node, kobj)
+#define to_attr(a) container_of(a, struct acpi_data_node_attr, attr)
+
+static ssize_t acpi_data_node_attr_show(struct kobject *kobj,
+					struct attribute *attr, char *buf)
+{
+	struct acpi_data_node *dn = to_data_node(kobj);
+	struct acpi_data_node_attr *dn_attr = to_attr(attr);
+
+	return dn_attr->show ? dn_attr->show(dn, buf) : -ENXIO;
+}
+
+static const struct sysfs_ops acpi_data_node_sysfs_ops = {
+	.show	= acpi_data_node_attr_show,
+};
+
+static void acpi_data_node_release(struct kobject *kobj)
+{
+	struct acpi_data_node *dn = to_data_node(kobj);
+	complete(&dn->kobj_done);
+}
+
+static struct kobj_type acpi_data_node_ktype = {
+	.sysfs_ops = &acpi_data_node_sysfs_ops,
+	.default_attrs = acpi_data_node_default_attrs,
+	.release = acpi_data_node_release,
+};
+
+static void acpi_expose_nondev_subnodes(struct kobject *kobj,
+					struct acpi_device_data *data)
+{
+	struct list_head *list = &data->subnodes;
+	struct acpi_data_node *dn;
+
+	if (list_empty(list))
+		return;
+
+	list_for_each_entry(dn, list, sibling) {
+		int ret;
+
+		init_completion(&dn->kobj_done);
+		ret = kobject_init_and_add(&dn->kobj, &acpi_data_node_ktype,
+					   kobj, dn->name);
+		if (ret)
+			acpi_handle_err(dn->handle, "Failed to expose (%d)\n", ret);
+		else
+			acpi_expose_nondev_subnodes(&dn->kobj, &dn->data);
+	}
+}
+
+static void acpi_hide_nondev_subnodes(struct acpi_device_data *data)
+{
+	struct list_head *list = &data->subnodes;
+	struct acpi_data_node *dn;
+
+	if (list_empty(list))
+		return;
+
+	list_for_each_entry_reverse(dn, list, sibling) {
+		acpi_hide_nondev_subnodes(&dn->data);
+		kobject_put(&dn->kobj);
+	}
+}
+
 /**
  * create_pnp_modalias - Create hid/cid(s) string for modalias and uevent
  * @acpi_dev: ACPI device object.
@@ -323,20 +423,12 @@ static ssize_t acpi_device_adr_show(stru
 }
 static DEVICE_ATTR(adr, 0444, acpi_device_adr_show, NULL);
 
-static ssize_t
-acpi_device_path_show(struct device *dev, struct device_attribute *attr, char *buf) {
+static ssize_t acpi_device_path_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_buffer path = {ACPI_ALLOCATE_BUFFER, NULL};
-	int result;
-
-	result = acpi_get_name(acpi_dev->handle, ACPI_FULL_PATHNAME, &path);
-	if (result)
-		goto end;
 
-	result = sprintf(buf, "%s\n", (char*)path.pointer);
-	kfree(path.pointer);
-end:
-	return result;
+	return acpi_object_path(acpi_dev->handle, buf);
 }
 static DEVICE_ATTR(path, 0444, acpi_device_path_show, NULL);
 
@@ -475,6 +567,8 @@ int acpi_device_setup_files(struct acpi_
 						    &dev_attr_real_power_state);
 	}
 
+	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
+
 end:
 	return result;
 }
@@ -485,6 +579,8 @@ end:
  */
 void acpi_device_remove_files(struct acpi_device *dev)
 {
+	acpi_hide_nondev_subnodes(&dev->data);
+
 	if (dev->flags.power_manageable) {
 		device_remove_file(&dev->dev, &dev_attr_power_state);
 		if (dev->power.flags.power_resources)
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -382,9 +382,12 @@ struct acpi_device {
 /* Non-device subnode */
 struct acpi_data_node {
 	const char *name;
+	acpi_handle handle;
 	struct fwnode_handle fwnode;
 	struct acpi_device_data data;
 	struct list_head sibling;
+	struct kobject kobj;
+	struct completion kobj_done;
 };
 
 static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -64,12 +64,13 @@ static bool acpi_nondev_subnode_ok(acpi_
 		goto fail;
 
 	if (acpi_extract_properties(buf.pointer, &dn->data))
-		dn->data.pointer = buf.pointer;
+		dn->handle = handle;
 
 	if (acpi_enumerate_nondev_subnodes(scope, buf.pointer, &dn->data))
-		dn->data.pointer = buf.pointer;
+		dn->handle = handle;
 
-	if (dn->data.pointer) {
+	if (dn->handle) {
+		dn->data.pointer = buf.pointer;
 		list_add_tail(&dn->sibling, list);
 		return true;
 	}
@@ -302,6 +303,7 @@ static void acpi_destroy_nondev_subnodes
 
 	list_for_each_entry_safe_reverse(dn, next, list, sibling) {
 		acpi_destroy_nondev_subnodes(&dn->data.subnodes);
+		wait_for_completion(&dn->kobj_done);
 		list_del(&dn->sibling);
 		ACPI_FREE((void *)dn->data.pointer);
 		kfree(dn);
