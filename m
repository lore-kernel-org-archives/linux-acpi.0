From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND 14/16] Thermal: Introduce simple arbitrator for setting device cooling state
Date: Wed, 25 Jul 2012 10:11:11 +0800
Message-ID: <1343182273-32096-15-git-send-email-rui.zhang@intel.com>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36673 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755834Ab2GYCLy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jul 2012 22:11:54 -0400
In-Reply-To: <1343182273-32096-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

This fixes the problem that a cooling device may be referenced by
by multiple trip points in multiple thermal zones.

With this patch, we have two stages for updating a thermal zone,
1. check if a thermal_instance needs to be updated or not
2. update the cooling device, based on the target cooling state
   of all its instances.

Note that, currently, the cooling device is set to the deepest
cooling state required.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |   44 ++++++++++++++++++++++++++++++++++++++---
 include/linux/thermal.h       |    1 +
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 0a06ea4..ee10df5 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -41,6 +41,7 @@ MODULE_AUTHOR("Zhang Rui");
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
 MODULE_LICENSE("GPL");
 
+#define THERMAL_NO_TARGET -1UL
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
@@ -54,6 +55,7 @@ struct thermal_instance {
 	int trip;
 	unsigned long upper;	/* Highest cooling state for this trip point */
 	unsigned long lower;	/* Lowest cooling state for this trip point */
+	unsigned long target;	/* expected cooling state */
 	char attr_name[THERMAL_NAME_LENGTH];
 	struct device_attribute attr;
 	struct list_head tz_node; /* node in tz->thermal_instances */
@@ -857,6 +859,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	dev->trip = trip;
 	dev->upper = upper;
 	dev->lower = lower;
+	dev->target = THERMAL_NO_TARGET;
 
 	result = get_idr(&tz->idr, &tz->lock, &dev->id);
 	if (result)
@@ -994,6 +997,7 @@ thermal_cooling_device_register(char *type, void *devdata,
 	strcpy(cdev->type, type);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
 	cdev->ops = ops;
+	cdev->updated = true;
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
@@ -1085,6 +1089,34 @@ void thermal_cooling_device_unregister(struct
 }
 EXPORT_SYMBOL(thermal_cooling_device_unregister);
 
+static void thermal_cdev_do_update(struct thermal_cooling_device *cdev)
+{
+	struct thermal_instance *instance;
+	unsigned long target = 0;
+
+	/* cooling device is updated*/
+	if (cdev->updated)
+		return;
+
+	/* Make sure cdev enters the deepest cooling state */
+	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
+		if (instance->target == THERMAL_NO_TARGET)
+			continue;
+		if (instance->target > target)
+			target = instance->target;
+	}
+	cdev->ops->set_cur_state(cdev, target);
+	cdev->updated = true;
+}
+
+static void thermal_zone_do_update(struct thermal_zone_device *tz)
+{
+	struct thermal_instance *instance;
+
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
+		thermal_cdev_do_update(instance->cdev);
+}
+
 /*
  * Cooling algorithm for active trip points
  *
@@ -1131,19 +1163,24 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
 				cur_state = cur_state > instance->lower ?
 				    (cur_state - 1) : instance->lower;
 			}
-			cdev->ops->set_cur_state(cdev, cur_state);
+			instance->target = cur_state;
+			cdev->updated = false; /* cooling device needs update */
 		}
 	} else {	/* below trip */
 		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 			if (instance->trip != trip)
 				continue;
 
+			/* Do not use the deacitve thermal instance */
+			if (instance->target == THERMAL_NO_TARGET)
+				continue;
 			cdev = instance->cdev;
 			cdev->ops->get_cur_state(cdev, &cur_state);
 
 			cur_state = cur_state > instance->lower ?
-				    (cur_state - 1) : instance->lower;
-			cdev->ops->set_cur_state(cdev, cur_state);
+				    (cur_state - 1) : THERMAL_NO_TARGET;
+			instance->target = cur_state;
+			cdev->updated = false; /* cooling device needs update */
 		}
 	}
 
@@ -1204,6 +1241,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 		}
 	}
 
+	thermal_zone_do_update(tz);
 	if (tz->forced_passive)
 		thermal_zone_device_passive(tz, temp, tz->forced_passive,
 					    THERMAL_TRIPS_NONE);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index bcf3384..3e66214 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -94,6 +94,7 @@ struct thermal_cooling_device {
 	struct device device;
 	void *devdata;
 	const struct thermal_cooling_device_ops *ops;
+	bool updated; /* true if the cooling device does not need update */
 	struct list_head thermal_instances;
 	struct list_head node;
 };
-- 
1.7.9.5

