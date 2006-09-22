From: Zhang Rui <rui.zhang@intel.com>
Subject: [02/12] acpi: rename some functions
Date: Fri, 22 Sep 2006 17:20:00 +0800
Message-ID: <1158916800.11985.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36762 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751103AbWIVJS0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 05:18:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

We want the name 'to_acpi_device'.
And the current macro 'to_acpi_device' will be removed 
after device model is setup.
So just simply rename them.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>

---
 drivers/acpi/scan.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.18-rc7/drivers/acpi/scan.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/acpi/scan.c	2006-09-14 17:21:37.000000000 +0800
+++ linux-2.6.18-rc7/drivers/acpi/scan.c	2006-09-14 17:24:45.000000000 +0800
@@ -49,13 +49,13 @@ static void setup_sys_fs_device_files(st
 #define remove_sysfs_device_files(dev)	\
 	setup_sys_fs_device_files(dev, (acpi_device_sysfs_files *)&sysfs_remove_file)
 
-#define to_acpi_device(n) container_of(n, struct acpi_device, kobj)
+#define to_acpi_dev(n) container_of(n, struct acpi_device, kobj)
 #define to_handle_attr(n) container_of(n, struct acpi_device_attribute, attr);
 
 static ssize_t acpi_device_attr_show(struct kobject *kobj,
 				     struct attribute *attr, char *buf)
 {
-	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_device *device = to_acpi_dev(kobj);
 	struct acpi_device_attribute *attribute = to_handle_attr(attr);
 	return attribute->show ? attribute->show(device, buf) : -EIO;
 }
@@ -63,7 +63,7 @@ static ssize_t acpi_device_attr_store(st
 				      struct attribute *attr, const char *buf,
 				      size_t len)
 {
-	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_device *device = to_acpi_dev(kobj);
 	struct acpi_device_attribute *attribute = to_handle_attr(attr);
 	return attribute->store ? attribute->store(device, buf, len) : -EIO;
 }
@@ -82,7 +82,7 @@ static int namespace_uevent(struct kset 
 			     char **envp, int num_envp, char *buffer,
 			     int buffer_size)
 {
-	struct acpi_device *dev = to_acpi_device(kobj);
+	struct acpi_device *dev = to_acpi_dev(kobj);
 	int i = 0;
 	int len = 0;
 
@@ -222,7 +222,7 @@ acpi_eject_store(struct acpi_device *dev
 /* --------------------------------------------------------------------------
 			ACPI Bus operations
    -------------------------------------------------------------------------- */
-static inline struct acpi_device * to_acpi_dev(struct device * dev)
+static inline struct acpi_device * to_acpi_device(struct device * dev)
 {
 	return container_of(dev, struct acpi_device, dev);
 }
@@ -251,7 +251,7 @@ static int root_suspend(struct acpi_devi
 
 static int acpi_device_suspend(struct device * dev, pm_message_t state)
 {
-	struct acpi_device * acpi_dev = to_acpi_dev(dev);
+	struct acpi_device * acpi_dev = to_acpi_device(dev);
 
 	/*
 	 * For now, we should only register 1 generic device -
@@ -288,7 +288,7 @@ static int root_resume(struct acpi_devic
 
 static int acpi_device_resume(struct device * dev)
 {
-	struct acpi_device * acpi_dev = to_acpi_dev(dev);
+	struct acpi_device * acpi_dev = to_acpi_device(dev);
 
 	/*
 	 * For now, we should only register 1 generic device -
