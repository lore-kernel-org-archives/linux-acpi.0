From: Betty Dall <betty.dall@hpe.com>
Subject: [PATCH v3 3/3] ACPI/device_sysfs: Clean up checkpatch errors
Date: Sat, 30 Apr 2016 10:03:39 -0600
Message-ID: <1462032219-12590-4-git-send-email-betty.dall@hpe.com>
References: <1462032219-12590-1-git-send-email-betty.dall@hpe.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462032219-12590-1-git-send-email-betty.dall@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Betty Dall <betty.dall@hpe.com>
List-Id: linux-acpi@vger.kernel.org

Cleaning up two existing checkpatch errors (and 2 warnings) in
device_sysfs.c since the file is being changed.

The change in acpi_device_setup_files() is changing spaces to a tab.

Signed-off-by: Betty Dall <betty.dall@hpe.com>
---
 drivers/acpi/device_sysfs.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index e556a3e..7b2c48f 100644
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
@@ -333,7 +333,8 @@ int acpi_device_modalias(struct device *dev, char *buf, int size)
 EXPORT_SYMBOL_GPL(acpi_device_modalias);
 
 static ssize_t
-acpi_device_modalias_show(struct device *dev, struct device_attribute *attr, char *buf) {
+acpi_device_modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
 	return __acpi_device_modalias(to_acpi_device(dev), buf, 1024);
 }
 static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, NULL);
@@ -397,7 +398,8 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
 static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
 
 static ssize_t
-acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf) {
+acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
 	return sprintf(buf, "%s\n", acpi_device_hid(acpi_dev));
@@ -568,10 +570,10 @@ int acpi_device_setup_files(struct acpi_device *dev)
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
