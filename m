From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/2] ACPI: Add identification objects' user interface.
Date: Fri, 28 Sep 2012 08:40:38 +0800
Message-ID: <e25fb2e7fd4cda9094eb52e766404cc0b2040654.1348791925.git.lv.zheng@intel.com>
References: <3f02ff942122d086c4d6e44a9ffa9269300675b3.1348736272.git.lv.zheng@intel.com> <cover.1348791925.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62839 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829Ab2I1AlH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Sep 2012 20:41:07 -0400
In-Reply-To: <cover.1348791925.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

ACPI devices are glued with physical devices through _ADR object, ACPI
enumerated devices are identified with _UID object.  Currently we can
observe _HID/_CID through sysfs interfaces (hid/modalias), but there's
no mean for us to check _ADR/_UID from user space.  This patch fix this
gap for ACPI developers and users.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/scan.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7e8a130..3f522a9 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -215,6 +215,25 @@ acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *bu
 }
 static DEVICE_ATTR(hid, 0444, acpi_device_hid_show, NULL);
 
+static ssize_t acpi_device_uid_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	return sprintf(buf, "%s\n", acpi_dev->pnp.unique_id);
+}
+static DEVICE_ATTR(uid, 0444, acpi_device_uid_show, NULL);
+
+static ssize_t acpi_device_adr_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	return sprintf(buf, "0x%08x\n",
+		       (unsigned int)(acpi_dev->pnp.bus_address));
+}
+static DEVICE_ATTR(adr, 0444, acpi_device_adr_show, NULL);
+
 static ssize_t
 acpi_device_path_show(struct device *dev, struct device_attribute *attr, char *buf) {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
@@ -257,6 +276,11 @@ static int acpi_device_setup_files(struct acpi_device *dev)
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
@@ -281,6 +305,10 @@ static void acpi_device_remove_files(struct acpi_device *dev)
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

