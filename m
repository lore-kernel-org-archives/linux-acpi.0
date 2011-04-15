From: Durgadoss R <durgadoss.r@intel.com>
Subject: PATCH[1/1]:Fix goto flows in thermal_hwmon_add_sysfs
Date: Fri, 15 Apr 2011 23:08:17 +0530
Message-ID: <1302889097-26548-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11625 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754285Ab1DOME7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Apr 2011 08:04:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, Durgadoss R <durgadoss.r@intel.com>

This patch fixes the flow of goto in thermal_hwmon_add_sysfs
method in thermal_sys.c

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index fc6f2a5..bc74c42 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -513,7 +513,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	sysfs_attr_init(&tz->temp_input.attr.attr);
 	result = device_create_file(hwmon->device, &tz->temp_input.attr);
 	if (result)
-		goto unregister_hwmon_device;
+		goto unregister_name;
 
 	if (tz->ops->get_crit_temp) {
 		unsigned long temperature;
@@ -527,7 +527,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 			result = device_create_file(hwmon->device,
 						    &tz->temp_crit.attr);
 			if (result)
-				goto unregister_hwmon_device;
+				goto unregister_input;
 		}
 	}
 
@@ -539,13 +539,14 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	return 0;
 
- unregister_hwmon_device:
-	device_remove_file(hwmon->device, &tz->temp_crit.attr);
+ unregister_input:
 	device_remove_file(hwmon->device, &tz->temp_input.attr);
-	if (new_hwmon_device) {
+ unregister_name:
+	if (new_hwmon_device)
 		device_remove_file(hwmon->device, &dev_attr_name);
+ unregister_hwmon_device:
+	if (new_hwmon_device)
 		hwmon_device_unregister(hwmon->device);
-	}
  free_mem:
 	if (new_hwmon_device)
 		kfree(hwmon);
-- 
1.6.1

