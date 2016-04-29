From: Betty Dall <betty.dall@hpe.com>
Subject: [PATCH v2 3/3] ACPI/device_sysfs: Clean up checkpatch errors
Date: Fri, 29 Apr 2016 13:21:21 -0600
Message-ID: <1461957681-6163-4-git-send-email-betty.dall@hpe.com>
References: <1461957681-6163-1-git-send-email-betty.dall@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:60022 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbcD2TXR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Apr 2016 15:23:17 -0400
In-Reply-To: <1461957681-6163-1-git-send-email-betty.dall@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Betty Dall <betty.dall@hpe.com>

Cleaning up five existing checkpatch errors in device_sysfs.c since the
file is being changed.

Signed-off-by: Betty Dall <betty.dall@hpe.com>
---
 drivers/acpi/device_sysfs.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index e556a3e..5aaebec 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -35,7 +35,7 @@ static ssize_t acpi_object_path(acpi_handle handle, char *buf)
 	if (result)
 		return result;
 
-	result = sprintf(buf, "%s\n", (char*)path.pointer);
+	result = sprintf(buf, "%s\n", (char *)path.pointer);
 	kfree(path.pointer);
 	return result;
 }
@@ -81,6 +81,7 @@ static const struct sysfs_ops acpi_data_node_sysfs_ops = {
 static void acpi_data_node_release(struct kobject *kobj)
 {
 	struct acpi_data_node *dn = to_data_node(kobj);
+
 	complete(&dn->kobj_done);
 }
 
@@ -106,7 +107,8 @@ static void acpi_expose_nondev_subnodes(struct kobject *kobj,
 		ret = kobject_init_and_add(&dn->kobj, &acpi_data_node_ktype,
 					   kobj, "%s", dn->name);
 		if (ret)
-			acpi_handle_err(dn->handle, "Failed to expose (%d)\n", ret);
+			acpi_handle_err(dn->handle,
+				"Failed to expose (%d)\n", ret);
 		else
 			acpi_expose_nondev_subnodes(&dn->kobj, &dn->data);
 	}
@@ -333,7 +335,9 @@ int acpi_device_modalias(struct device *dev, char *buf, int size)
 EXPORT_SYMBOL_GPL(acpi_device_modalias);
 
 static ssize_t
-acpi_device_modalias_show(struct device *dev, struct device_attribute *attr, char *buf) {
+acpi_device_modalias_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
 	return __acpi_device_modalias(to_acpi_device(dev), buf, 1024);
 }
 static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, NULL);
@@ -397,7 +401,9 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
 static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
 
 static ssize_t
-acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf) {
+acpi_device_hid_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
 	return sprintf(buf, "%s\n", acpi_device_hid(acpi_dev));
@@ -568,10 +574,10 @@ int acpi_device_setup_files(struct acpi_device *dev)
 			goto end;
 	}
 
-        /*
-         * If device has _EJ0, 'eject' file is created that is used to trigger
-         * hot-removal function from userland.
-         */
+	/*
+	 * If device has _EJ0, 'eject' file is created that is used to trigger
+	 * hot-removal function from userland.
+	 */
 	if (acpi_has_method(dev->handle, "_EJ0")) {
 		result = device_create_file(&dev->dev, &dev_attr_eject);
 		if (result)
-- 
1.9.1

