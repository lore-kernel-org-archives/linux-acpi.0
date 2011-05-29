From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/18] ACPI:Fix goto flows in thermal-sys
Date: Sun, 29 May 2011 05:43:56 -0400
Message-ID: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:57404 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab1E2JoS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:44:18 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY00BP1B1S8QB0@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:44:17 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Len Brown <len.brown@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch fixes two minor bugs in thermal_sys:
(a) The flow of goto's in thermal_hwmon_add_sysfs.
(b) Remove the temp*_crit only if there is a get_crit_temp defined, in
    thermal_remove_hwmon_sysfs.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 713b7ea..0b1c82a 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -499,7 +499,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	dev_set_drvdata(hwmon->device, hwmon);
 	result = device_create_file(hwmon->device, &dev_attr_name);
 	if (result)
-		goto unregister_hwmon_device;
+		goto free_mem;
 
  register_sys_interface:
 	tz->hwmon = hwmon;
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
 
@@ -539,9 +539,9 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	return 0;
 
- unregister_hwmon_device:
-	device_remove_file(hwmon->device, &tz->temp_crit.attr);
+ unregister_input:
 	device_remove_file(hwmon->device, &tz->temp_input.attr);
+ unregister_name:
 	if (new_hwmon_device) {
 		device_remove_file(hwmon->device, &dev_attr_name);
 		hwmon_device_unregister(hwmon->device);
@@ -560,7 +560,8 @@ thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	tz->hwmon = NULL;
 	device_remove_file(hwmon->device, &tz->temp_input.attr);
-	device_remove_file(hwmon->device, &tz->temp_crit.attr);
+	if (tz->ops->get_crit_temp)
+		device_remove_file(hwmon->device, &tz->temp_crit.attr);
 
 	mutex_lock(&thermal_list_lock);
 	list_del(&tz->hwmon_node);
-- 
1.7.5.3.367.ga9930.dirty

