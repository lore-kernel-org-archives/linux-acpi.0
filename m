From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/8] [-mm] ACPI: add some helper macros and functions
Date: Tue, 20 Mar 2007 17:21:15 +0800
Message-ID: <1174382475.8833.80.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20126 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932515AbXCTJVz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 05:21:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Add some helper macros and functions for ACPI device sysfs duplication.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/scan.c         |   55 ++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_drivers.h |   44 +++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

Index: linux-2.6.21-rc3-mm2/include/acpi/acpi_drivers.h
===================================================================
--- linux-2.6.21-rc3-mm2.orig/include/acpi/acpi_drivers.h	2007-03-16 10:02:50.000000000 +0800
+++ linux-2.6.21-rc3-mm2/include/acpi/acpi_drivers.h	2007-03-19 10:27:15.000000000 +0800
@@ -45,6 +45,50 @@
 #define ACPI_VIDEO_HID			"video"
 #define ACPI_BAY_HID			"bay"
 /* --------------------------------------------------------------------------
+                                      Sysfs
+   -------------------------------------------------------------------------- */
+typedef ssize_t (*acpi_show)(struct acpi_device *dev, char *buf);
+typedef ssize_t (*acpi_store)(struct acpi_device *dev, const char *buf, size_t count);
+
+struct acpi_device_attr {
+	struct device_attribute attr;
+	acpi_show show;
+	acpi_store store;
+};
+
+ssize_t __acpi_show(struct device *dev, struct device_attribute *attr, char *buf);
+ssize_t __acpi_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t countf);
+
+#define ACPI_DEVICE_ATTR(_name, _mode, _show, _store)	\
+struct acpi_device_attr _name##_attr =	\
+{				\
+	.attr = __ATTR(_name, _mode, __acpi_show, __acpi_store),	\
+	.show = _show,		\
+	.store = _store,	\
+}
+
+#define GET_ATTR(_name)		&(_name##_attr.attr.attr)
+#define GET_DEV_ATTR(_name)	&(_name##_attr.attr)
+
+int acpi_device_add_sysfs(struct acpi_device *device, struct device_attribute **dev_attr);
+void acpi_device_remove_sysfs(struct acpi_device *device, struct device_attribute **dev_attr);
+
+#ifndef CONFIG_ACPI_PROCFS
+#define DECLARE_ACPI_DEVICE_PROCFS(_name) \
+static int acpi_##_name##_add_procfs(struct acpi_device *device) {	\
+	return 0;	\
+}			\
+static void acpi_##_name##_remove_procfs(struct acpi_device *device) {	\
+	return ;	\
+}			\
+static int acpi_##_name##_procfs_init(void) {	\
+	return 0;	\
+}			\
+static void acpi_##_name##_procfs_exit(void) {	\
+	return ;		\
+}
+#endif
+/* --------------------------------------------------------------------------
                                        PCI
    -------------------------------------------------------------------------- */
 
Index: linux-2.6.21-rc3-mm2/drivers/acpi/scan.c
===================================================================
--- linux-2.6.21-rc3-mm2.orig/drivers/acpi/scan.c	2007-03-16 10:02:50.000000000 +0800
+++ linux-2.6.21-rc3-mm2/drivers/acpi/scan.c	2007-03-16 10:11:51.000000000 +0800
@@ -510,6 +510,61 @@ void acpi_bus_unregister_driver(struct a
 
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
 
+ssize_t
+__acpi_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct acpi_device_attr *acpi_attr = container_of(attr, struct acpi_device_attr, attr);
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	if (!acpi_attr->show)
+		return -EINVAL;
+
+	return acpi_attr->show(acpi_dev, buf);
+}
+EXPORT_SYMBOL(__acpi_show);
+
+ssize_t
+__acpi_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t countf)
+{
+	struct acpi_device_attr *acpi_attr = container_of(attr, struct acpi_device_attr, attr);
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	if (!acpi_attr->store)
+		return -EINVAL;
+
+	return acpi_attr->store(acpi_dev, buf, countf);
+}
+EXPORT_SYMBOL(__acpi_store);
+
+int acpi_device_add_sysfs(struct acpi_device *device, struct device_attribute **dev_attr)
+{
+	int i;
+	int result;
+
+	for (i = 0; dev_attr[i] != NULL; i++) {
+		result = device_create_file(&device->dev, dev_attr[i]);
+		if (result)
+			goto Fail;
+	}
+	return 0;
+  Fail:
+  	while (--i >= 0)
+		device_remove_file(&device->dev, dev_attr[i]);
+	return result;
+}
+EXPORT_SYMBOL(acpi_device_add_sysfs);
+
+ void acpi_device_remove_sysfs(struct acpi_device *device, struct device_attribute **dev_attr)
+{
+	int i;
+
+	for (i = 0; dev_attr[i] != NULL; i++);
+  	while (--i >= 0)
+		device_remove_file(&device->dev, dev_attr[i]);
+	return ;
+}
+EXPORT_SYMBOL(acpi_device_remove_sysfs);
+
 /* --------------------------------------------------------------------------
                                  Device Enumeration
    -------------------------------------------------------------------------- */
