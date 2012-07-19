From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 14/16] Thermal: Introduce simple arbitrator for setting device cooling state
Date: Thu, 19 Jul 2012 14:31:18 +0800
Message-ID: <1342679480-5336-15-git-send-email-rui.zhang@intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:23168 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab2GSGcG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 02:32:06 -0400
In-Reply-To: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>

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
 drivers/thermal/thermal_sys.c |   41 ++++++++++++++++++++++++++++++++++++++---
 include/linux/thermal.h       |    1 +
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 48b2668..803ce94 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -54,6 +54,7 @@ struct thermal_instance {
 	int trip;
 	unsigned long upper;	/* Highest cooling state for this trip point */
 	unsigned long lower;	/* Lowest cooling state for this trip point */
+	unsigned long target;	/* expected cooling state */
 	char attr_name[THERMAL_NAME_LENGTH];
 	struct device_attribute attr;
 	struct list_head tz_node; /* node in tz->instances */
@@ -853,6 +854,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	dev->trip = trip;
 	dev->upper = upper;
 	dev->lower = lower;
+	dev->target = -1;
 
 	result = get_idr(&tz->idr, &tz->lock, &dev->id);
 	if (result)
@@ -990,6 +992,7 @@ thermal_cooling_device_register(char *type, void *devdata,
 	strcpy(cdev->type, type);
 	INIT_LIST_HEAD(&cdev->instances);
 	cdev->ops = ops;
+	cdev->updated = 1;
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
@@ -1081,6 +1084,32 @@ void thermal_cooling_device_unregister(struct
 }
 EXPORT_SYMBOL(thermal_cooling_device_unregister);
 
+static void thermal_zone_do_update(struct thermal_zone_device *tz)
+{
+	struct thermal_instance *instance1, *instance2;
+	struct thermal_cooling_device *cdev;
+	int target;
+
+	list_for_each_entry(instance1, &tz->instances, tz_node) {
+		cdev = instance1->cdev;
+
+		/* cooling device has already been updated*/
+		if (cdev->updated)
+			continue;
+
+		target = 0;
+		/* Make sure cdev enters the deepest cooling state */
+		list_for_each_entry(instance2, &cdev->instances, cdev_node) {
+			if (instance2->target == -1)
+				continue;
+			if (instance2->target > target)
+				target = instance2->target;
+		}
+		cdev->ops->set_cur_state(cdev, target);
+		cdev->updated = 1;
+	}
+}
+
 /*
  * Cooling algorithm for active trip points
  *
@@ -1127,19 +1156,24 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
 				cur_state = cur_state > instance->lower ?
 				    (cur_state - 1) : instance->lower;
 			}
-			cdev->ops->set_cur_state(cdev, cur_state);
+			instance->target = cur_state;
+			cdev->updated = 0; /* cooling device needs update */
 		}
 	} else {	/* below trip */
 		list_for_each_entry(instance, &tz->instances, tz_node) {
 			if (instance->trip != trip)
 				continue;
 
+			/* Do not use the deacitve thermal instance */
+			if (instance->target == -1)
+				continue;
 			cdev = instance->cdev;
 			cdev->ops->get_cur_state(cdev, &cur_state);
 
 			cur_state = cur_state > instance->lower ?
-				    (cur_state - 1) : instance->lower;
-			cdev->ops->set_cur_state(cdev, cur_state);
+				    (cur_state - 1) : -1;
+			instance->target = cur_state;
+			cdev->updated = 0; /* cooling device needs update */
 		}
 	}
 
@@ -1200,6 +1234,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 		}
 	}
 
+	thermal_zone_do_update(tz);
 	if (tz->forced_passive)
 		thermal_zone_device_passive(tz, temp, tz->forced_passive,
 					    THERMAL_TRIPS_NONE);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d8e069e..604c0f0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -92,6 +92,7 @@ struct thermal_cooling_device {
 	struct device device;
 	void *devdata;
 	const struct thermal_cooling_device_ops *ops;
+	int updated; /* 1 if the cooling device does not need update */
 	struct list_head instances;
 	struct list_head node;
 };
-- 
1.7.9.5

