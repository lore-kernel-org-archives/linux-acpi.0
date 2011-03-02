From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH] ACPI:Fix goto flows in thermal-sys
Date: Thu,  3 Mar 2011 04:30:13 +0530
Message-ID: <1299106813-13726-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4116 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832Ab1CCLBS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Mar 2011 06:01:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, Durgadoss R <durgadoss.r@intel.com>

This patch fixes two minor bugs in thermal_sys:
(a) The flow of goto's in thermal_hwmon_add_sysfs.
(b) Remove the temp*_crit only if there is a get_crit_temp defined, in
    thermal_remove_hwmon_sysfs.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 13c72c6..b826dfb 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -495,7 +495,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	dev_set_drvdata(hwmon->device, hwmon);
 	result = device_create_file(hwmon->device, &dev_attr_name);
 	if (result)
-		goto unregister_hwmon_device;
+		goto free_mem;
 
  register_sys_interface:
 	tz->hwmon = hwmon;
@@ -509,7 +509,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	sysfs_attr_init(&tz->temp_input.attr.attr);
 	result = device_create_file(hwmon->device, &tz->temp_input.attr);
 	if (result)
-		goto unregister_hwmon_device;
+		goto unregister_name;
 
 	if (tz->ops->get_crit_temp) {
 		unsigned long temperature;
@@ -523,7 +523,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 			result = device_create_file(hwmon->device,
 						    &tz->temp_crit.attr);
 			if (result)
-				goto unregister_hwmon_device;
+				goto unregister_input;
 		}
 	}
 
@@ -535,9 +535,9 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	return 0;
 
- unregister_hwmon_device:
-	device_remove_file(hwmon->device, &tz->temp_crit.attr);
+ unregister_input:
 	device_remove_file(hwmon->device, &tz->temp_input.attr);
+ unregister_name:
 	if (new_hwmon_device) {
 		device_remove_file(hwmon->device, &dev_attr_name);
 		hwmon_device_unregister(hwmon->device);
@@ -556,7 +556,8 @@ thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	tz->hwmon = NULL;
 	device_remove_file(hwmon->device, &tz->temp_input.attr);
-	device_remove_file(hwmon->device, &tz->temp_crit.attr);
+	if (tz->ops->get_crit_temp)
+		device_remove_file(hwmon->device, &tz->temp_crit.attr);
 
 	mutex_lock(&thermal_list_lock);
 	list_del(&tz->hwmon_node);
-- 
1.7.4

