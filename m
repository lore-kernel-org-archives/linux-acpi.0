From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0043/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:36:39 +0800
Message-ID: <20160802103639.16637-1-baolex.ni@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:7141 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754672AbcHBLPY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Aug 2016 07:15:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, travis@sgi.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/acpi/device_sysfs.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 7b2c48f..f0c7bb7 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -337,7 +337,7 @@ acpi_device_modalias_show(struct device *dev, struct device_attribute *attr, cha
 {
 	return __acpi_device_modalias(to_acpi_device(dev), buf, 1024);
 }
-static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, NULL);
+static DEVICE_ATTR(modalias, S_IRUSR | S_IRGRP | S_IROTH, acpi_device_modalias_show, NULL);
 
 static ssize_t real_power_state_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
@@ -353,7 +353,7 @@ static ssize_t real_power_state_show(struct device *dev,
 	return sprintf(buf, "%s\n", acpi_power_state_string(state));
 }
 
-static DEVICE_ATTR(real_power_state, 0444, real_power_state_show, NULL);
+static DEVICE_ATTR(real_power_state, S_IRUSR | S_IRGRP | S_IROTH, real_power_state_show, NULL);
 
 static ssize_t power_state_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -363,7 +363,7 @@ static ssize_t power_state_show(struct device *dev,
 	return sprintf(buf, "%s\n", acpi_power_state_string(adev->power.state));
 }
 
-static DEVICE_ATTR(power_state, 0444, power_state_show, NULL);
+static DEVICE_ATTR(power_state, S_IRUSR | S_IRGRP | S_IROTH, power_state_show, NULL);
 
 static ssize_t
 acpi_eject_store(struct device *d, struct device_attribute *attr,
@@ -395,7 +395,7 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
 	return status == AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
 }
 
-static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
+static DEVICE_ATTR(eject, S_IWUSR, NULL, acpi_eject_store);
 
 static ssize_t
 acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -404,7 +404,7 @@ acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *bu
 
 	return sprintf(buf, "%s\n", acpi_device_hid(acpi_dev));
 }
-static DEVICE_ATTR(hid, 0444, acpi_device_hid_show, NULL);
+static DEVICE_ATTR(hid, S_IRUSR | S_IRGRP | S_IROTH, acpi_device_hid_show, NULL);
 
 static ssize_t acpi_device_uid_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
@@ -413,7 +413,7 @@ static ssize_t acpi_device_uid_show(struct device *dev,
 
 	return sprintf(buf, "%s\n", acpi_dev->pnp.unique_id);
 }
-static DEVICE_ATTR(uid, 0444, acpi_device_uid_show, NULL);
+static DEVICE_ATTR(uid, S_IRUSR | S_IRGRP | S_IROTH, acpi_device_uid_show, NULL);
 
 static ssize_t acpi_device_adr_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
@@ -423,7 +423,7 @@ static ssize_t acpi_device_adr_show(struct device *dev,
 	return sprintf(buf, "0x%08x\n",
 		       (unsigned int)(acpi_dev->pnp.bus_address));
 }
-static DEVICE_ATTR(adr, 0444, acpi_device_adr_show, NULL);
+static DEVICE_ATTR(adr, S_IRUSR | S_IRGRP | S_IROTH, acpi_device_adr_show, NULL);
 
 static ssize_t acpi_device_path_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
@@ -432,7 +432,7 @@ static ssize_t acpi_device_path_show(struct device *dev,
 
 	return acpi_object_path(acpi_dev->handle, buf);
 }
-static DEVICE_ATTR(path, 0444, acpi_device_path_show, NULL);
+static DEVICE_ATTR(path, S_IRUSR | S_IRGRP | S_IROTH, acpi_device_path_show, NULL);
 
 /* sysfs file that shows description text from the ACPI _STR method */
 static ssize_t description_show(struct device *dev,
@@ -458,7 +458,7 @@ static ssize_t description_show(struct device *dev,
 
 	return result;
 }
-static DEVICE_ATTR(description, 0444, description_show, NULL);
+static DEVICE_ATTR(description, S_IRUSR | S_IRGRP | S_IROTH, description_show, NULL);
 
 static ssize_t
 acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
@@ -473,7 +473,7 @@ acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
 
 	return sprintf(buf, "%llu\n", sun);
 }
-static DEVICE_ATTR(sun, 0444, acpi_device_sun_show, NULL);
+static DEVICE_ATTR(sun, S_IRUSR | S_IRGRP | S_IROTH, acpi_device_sun_show, NULL);
 
 static ssize_t
 acpi_device_hrv_show(struct device *dev, struct device_attribute *attr,
@@ -488,7 +488,7 @@ acpi_device_hrv_show(struct device *dev, struct device_attribute *attr,
 
 	return sprintf(buf, "%llu\n", hrv);
 }
-static DEVICE_ATTR(hrv, 0444, acpi_device_hrv_show, NULL);
+static DEVICE_ATTR(hrv, S_IRUSR | S_IRGRP | S_IROTH, acpi_device_hrv_show, NULL);
 
 static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 				char *buf) {
-- 
2.9.2

