From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 06/16] Thermal: set upper and lower limits
Date: Thu, 19 Jul 2012 14:31:10 +0800
Message-ID: <1342679480-5336-7-git-send-email-rui.zhang@intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61928 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410Ab2GSGbs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 02:31:48 -0400
In-Reply-To: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>

set upper and lower limits when binding
a thermal cooling device to a thermal zone device.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/thermal/sysfs-api.txt |    6 ++++-
 drivers/acpi/thermal.c              |   49 ++++++++++++++++++++++-------------
 drivers/platform/x86/acerhdf.c      |    2 +-
 drivers/thermal/thermal_sys.c       |   20 +++++++++-----
 include/linux/thermal.h             |    3 ++-
 5 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index b7b3609..f169821 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -84,7 +84,7 @@ temperature) and throttle appropriate devices.
 
 1.3 interface for binding a thermal zone device with a thermal cooling device
 1.3.1 int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
-		int trip, struct thermal_cooling_device *cdev);
+	int trip, struct thermal_cooling_device *cdev, long upper, long lower);
 
     This interface function bind a thermal cooling device to the certain trip
     point of a thermal zone device.
@@ -93,6 +93,10 @@ temperature) and throttle appropriate devices.
     cdev: thermal cooling device
     trip: indicates which trip point the cooling devices is associated with
 	  in this thermal zone.
+    upper:the Maximum cooling state for this trip point.
+          -1 means no upper limit, and the cooling device can be in max_state.
+    lower:the Minimum cooling state can be used for this trip point.
+          -1 means no lower limit, and the cooling device can be in cooling state 0.
 
 1.3.2 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 		int trip, struct thermal_cooling_device *cdev);
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 8275e7b..a7c97f5 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -727,11 +727,9 @@ static int thermal_notify(struct thermal_zone_device *thermal, int trip,
 	return 0;
 }
 
-typedef int (*cb)(struct thermal_zone_device *, int,
-		  struct thermal_cooling_device *);
 static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 					struct thermal_cooling_device *cdev,
-					cb action)
+					int bind)
 {
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_thermal *tz = thermal->devdata;
@@ -755,11 +753,18 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 		    i++) {
 			handle = tz->trips.passive.devices.handles[i];
 			status = acpi_bus_get_device(handle, &dev);
-			if (ACPI_SUCCESS(status) && (dev == device)) {
-				result = action(thermal, trip, cdev);
-				if (result)
-					goto failed;
-			}
+			if (ACPI_FAILURE(status) || dev != device)
+				continue;
+			if (bind)
+				result =
+					thermal_zone_bind_cooling_device
+					(thermal, trip, cdev, -1, -1);
+			else
+				result =
+					thermal_zone_unbind_cooling_device
+					(thermal, trip, cdev);
+			if (result)
+				goto failed;
 		}
 	}
 
@@ -772,11 +777,16 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 		    j++) {
 			handle = tz->trips.active[i].devices.handles[j];
 			status = acpi_bus_get_device(handle, &dev);
-			if (ACPI_SUCCESS(status) && (dev == device)) {
-				result = action(thermal, trip, cdev);
-				if (result)
-					goto failed;
-			}
+			if (ACPI_FAILURE(status) || dev != device)
+				continue;
+			if (bind)
+				result = thermal_zone_bind_cooling_device
+					(thermal, trip, cdev, -1, -1);
+			else
+				result = thermal_zone_unbind_cooling_device
+					(thermal, trip, cdev);
+			if (result)
+				goto failed;
 		}
 	}
 
@@ -784,7 +794,12 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 		handle = tz->devices.handles[i];
 		status = acpi_bus_get_device(handle, &dev);
 		if (ACPI_SUCCESS(status) && (dev == device)) {
-			result = action(thermal, -1, cdev);
+			if (bind)
+				result = thermal_zone_bind_cooling_device
+						(thermal, -1, cdev, -1, -1);
+			else
+				result = thermal_zone_unbind_cooling_device
+						(thermal, -1, cdev);
 			if (result)
 				goto failed;
 		}
@@ -798,16 +813,14 @@ static int
 acpi_thermal_bind_cooling_device(struct thermal_zone_device *thermal,
 					struct thermal_cooling_device *cdev)
 {
-	return acpi_thermal_cooling_device_cb(thermal, cdev,
-				thermal_zone_bind_cooling_device);
+	return acpi_thermal_cooling_device_cb(thermal, cdev, 1);
 }
 
 static int
 acpi_thermal_unbind_cooling_device(struct thermal_zone_device *thermal,
 					struct thermal_cooling_device *cdev)
 {
-	return acpi_thermal_cooling_device_cb(thermal, cdev,
-				thermal_zone_unbind_cooling_device);
+	return acpi_thermal_cooling_device_cb(thermal, cdev, 0);
 }
 
 static const struct thermal_zone_device_ops acpi_thermal_zone_ops = {
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 39abb15..278aa0e 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -329,7 +329,7 @@ static int acerhdf_bind(struct thermal_zone_device *thermal,
 	if (cdev != cl_dev)
 		return 0;
 
-	if (thermal_zone_bind_cooling_device(thermal, 0, cdev)) {
+	if (thermal_zone_bind_cooling_device(thermal, 0, cdev, -1, -1)) {
 		pr_err("error binding cooling dev\n");
 		return -EINVAL;
 	}
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 4267a49..db35300 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -316,7 +316,7 @@ passive_store(struct device *dev, struct device_attribute *attr,
 				     sizeof("Processor")))
 				thermal_zone_bind_cooling_device(tz,
 								 THERMAL_TRIPS_NONE,
-								 cdev);
+								 cdev, -1, -1);
 		}
 		mutex_unlock(&thermal_list_lock);
 		if (!tz->passive_delay)
@@ -801,7 +801,8 @@ static void thermal_zone_device_check(struct work_struct *work)
  */
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 				     int trip,
-				     struct thermal_cooling_device *cdev)
+				     struct thermal_cooling_device *cdev,
+				     long upper, long lower)
 {
 	struct thermal_cooling_device_instance *dev;
 	struct thermal_cooling_device_instance *pos;
@@ -825,6 +826,15 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (tz != pos1 || cdev != pos2)
 		return -EINVAL;
 
+	cdev->ops->get_max_state(cdev, &max_state);
+
+	/* lower default 0, upper default max_state */
+	lower = lower < 0 ? 0 : lower;
+	upper = upper < 0 ? max_state : upper;
+
+	if (lower > upper || upper > max_state)
+		return -EINVAL;
+
 	dev =
 	    kzalloc(sizeof(struct thermal_cooling_device_instance), GFP_KERNEL);
 	if (!dev)
@@ -832,10 +842,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	dev->tz = tz;
 	dev->cdev = cdev;
 	dev->trip = trip;
-
-	cdev->ops->get_max_state(dev, &max_state);
-	dev->upper = max_state;
-	dev->lower = 0;
+	dev->upper = upper;
+	dev->lower = lower;
 
 	result = get_idr(&tz->idr, &tz->lock, &dev->id);
 	if (result)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index cfc8d90..b355c62 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -157,7 +157,8 @@ struct thermal_zone_device *thermal_zone_device_register(char *, int, int,
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
-				     struct thermal_cooling_device *);
+				     struct thermal_cooling_device *,
+				     long, long);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *);
-- 
1.7.9.5

