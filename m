From: Betty Dall <betty.dall@hpe.com>
Subject: [PATCH v3 1/3] ACPI/device_sysfs: Add sysfs support for _HRV hardware revision
Date: Sat, 30 Apr 2016 10:03:37 -0600
Message-ID: <1462032219-12590-2-git-send-email-betty.dall@hpe.com>
References: <1462032219-12590-1-git-send-email-betty.dall@hpe.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462032219-12590-1-git-send-email-betty.dall@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Betty Dall <betty.dall@hpe.com>
List-Id: linux-acpi@vger.kernel.org

The ACPI _HRV object on the device is used to supply Linux with the
device's hardware revision. This is an optional object. Add sysfs support
for the _HRV object if it exists on the device.

This change allows users to easily find the hardware version of non-PCI
hardware by looking at the sysfs 'hrv' file. It is most useful for
non-PCI devices because lspci can list the hardware version for PCI
devices.

Signed-off-by: Betty Dall <betty.dall@hpe.com>
---
 drivers/acpi/device_sysfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index b9afb47..49cc0cb 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -473,6 +473,21 @@ acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR(sun, 0444, acpi_device_sun_show, NULL);
 
+static ssize_t
+acpi_device_hrv_show(struct device *dev, struct device_attribute *attr,
+		     char *buf) {
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	acpi_status status;
+	unsigned long long hrv;
+
+	status = acpi_evaluate_integer(acpi_dev->handle, "_HRV", NULL, &hrv);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return sprintf(buf, "%llu\n", hrv);
+}
+static DEVICE_ATTR(hrv, 0444, acpi_device_hrv_show, NULL);
+
 static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 				char *buf) {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
@@ -541,6 +556,12 @@ int acpi_device_setup_files(struct acpi_device *dev)
 			goto end;
 	}
 
+	if (acpi_has_method(dev->handle, "_HRV")) {
+		result = device_create_file(&dev->dev, &dev_attr_hrv);
+		if (result)
+			goto end;
+	}
+
 	if (acpi_has_method(dev->handle, "_STA")) {
 		result = device_create_file(&dev->dev, &dev_attr_status);
 		if (result)
@@ -604,6 +625,9 @@ void acpi_device_remove_files(struct acpi_device *dev)
 	if (acpi_has_method(dev->handle, "_SUN"))
 		device_remove_file(&dev->dev, &dev_attr_sun);
 
+	if (acpi_has_method(dev->handle, "_HRV"))
+		device_remove_file(&dev->dev, &dev_attr_hrv);
+
 	if (dev->pnp.unique_id)
 		device_remove_file(&dev->dev, &dev_attr_uid);
 	if (dev->pnp.type.bus_address)
-- 
1.9.1
