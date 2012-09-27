From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI: Add identification objects' user interface.
Date: Thu, 27 Sep 2012 09:40:31 +0800
Message-ID: <ce5e3ff518a8a0a74b2acb2920df409fa618276f.1348709690.git.lv.zheng@intel.com>
References: <3f02ff942122d086c4d6e44a9ffa9269300675b3.1348736272.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:47321 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287Ab2I0BlU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Sep 2012 21:41:20 -0400
In-Reply-To: <3f02ff942122d086c4d6e44a9ffa9269300675b3.1348736272.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Ying Huang <ying.huang@intel.com>, Rui Zhang <rui.zhang@intel.com>, Lv Zheng <lv.zheng@intel.com>

ACPI devices are glued with physical devices through _ADR object, ACPI
enumerated devices are identified with _UID object.  Currently we can
observe _HID/_CID through sysfs interfaces (hid/modalias), but there's
no mean for us to check _ADR/_UID from user space.  This patch fix this
gap for ACPI developers and users.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/scan.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index bb7fe47..df53190 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -216,6 +216,22 @@ acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *bu
 static DEVICE_ATTR(hid, 0444, acpi_device_hid_show, NULL);
 
 static ssize_t
+acpi_device_uid_show(struct device *dev, struct device_attribute *attr, char *buf) {
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	return sprintf(buf, "%s\n", acpi_dev->pnp.unique_id);
+}
+static DEVICE_ATTR(uid, 0444, acpi_device_uid_show, NULL);
+
+static ssize_t
+acpi_device_adr_show(struct device *dev, struct device_attribute *attr, char *buf) {
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	return sprintf(buf, "0x%08x\n", (unsigned int)(acpi_dev->pnp.bus_address));
+}
+static DEVICE_ATTR(adr, 0444, acpi_device_adr_show, NULL);
+
+static ssize_t
 acpi_device_path_show(struct device *dev, struct device_attribute *attr, char *buf) {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_buffer path = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -257,6 +273,11 @@ static int acpi_device_setup_files(struct acpi_device *dev)
 			goto end;
 	}
 
+	if (dev->flags.bus_address)
+		result = device_create_file(&dev->dev, &dev_attr_adr);
+	if (dev->pnp.unique_id)
+		result = device_create_file(&dev->dev, &dev_attr_uid);
+
         /*
          * If device has _EJ0, 'eject' file is created that is used to trigger
          * hot-removal function from userland.
@@ -281,6 +302,10 @@ static void acpi_device_remove_files(struct acpi_device *dev)
 	if (ACPI_SUCCESS(status))
 		device_remove_file(&dev->dev, &dev_attr_eject);
 
+	if (dev->pnp.unique_id)
+		device_remove_file(&dev->dev, &dev_attr_uid);
+	if (dev->flags.bus_address)
+		device_remove_file(&dev->dev, &dev_attr_adr);
 	device_remove_file(&dev->dev, &dev_attr_modalias);
 	device_remove_file(&dev->dev, &dev_attr_hid);
 	if (dev->handle)
-- 
1.7.10

