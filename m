From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv2 08/14] Thermal: Make thermal_cdev_update as a global function
Date: Mon, 27 Aug 2012 09:58:20 +0530
Message-ID: <1346041706-29642-9-git-send-email-durgadoss.r@intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4000 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab2H0E3U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2012 00:29:20 -0400
In-Reply-To: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch makes the thermal_cdev_update function as a
global one, so that other files can use it. This function
serves as a single arbitrator to set the state of a cooling
device.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |    5 +++--
 include/linux/thermal.h       |    2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 5d38501..768458b 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1174,7 +1174,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 }
 EXPORT_SYMBOL(thermal_cooling_device_unregister);
 
-static void thermal_cdev_do_update(struct thermal_cooling_device *cdev)
+void thermal_cdev_update(struct thermal_cooling_device *cdev)
 {
 	struct thermal_instance *instance;
 	unsigned long target = 0;
@@ -1195,13 +1195,14 @@ static void thermal_cdev_do_update(struct thermal_cooling_device *cdev)
 	cdev->ops->set_cur_state(cdev, target);
 	cdev->updated = true;
 }
+EXPORT_SYMBOL(thermal_cdev_update);
 
 static void thermal_zone_do_update(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *instance;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		thermal_cdev_do_update(instance->cdev);
+		thermal_cdev_update(instance->cdev);
 }
 
 /*
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index b644b8e..591f350 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -225,6 +225,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
 		struct thermal_cooling_device *, int);
+void thermal_cdev_update(struct thermal_cooling_device *);
+
 /*
  * The platform layer shall define a 'function' that provides the
  * parameters for all thermal zones in the platform. This pointer
-- 
1.7.9.5

