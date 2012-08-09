From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 07/13] Thermal: Update binding logic based on platform data
Date: Thu,  9 Aug 2012 18:15:59 +0530
Message-ID: <1344516365-7230-8-git-send-email-durgadoss.r@intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14321 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932467Ab2HIMqc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2012 08:46:32 -0400
In-Reply-To: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com, Durgadoss R <durgadoss.r@intel.com>

This patch updates the binding logic in thermal_sys.c
It uses the platform layer data to bind a thermal zone
to a cdev for a particular trip point.

 * If we do not have platform data and do not have
   .bind defined, do not bind.
 * If we do not have platform data but .bind is
   defined, then use tz->ops->bind.
 * If we have platform data, use it to create binding.

The same logic sequence is followed for unbind also.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |  170 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 144 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 195e529..748b12f 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -158,6 +158,107 @@ static void retrieve_zone_params(struct thermal_zone_device *tz)
 	}
 }
 
+static void print_bind_err_msg(struct thermal_zone_device *tz,
+			struct thermal_cooling_device *cdev, int ret)
+{
+	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
+				tz->type, cdev->type, ret);
+}
+
+static void __bind(struct thermal_zone_device *tz, int mask,
+			struct thermal_cooling_device *cdev)
+{
+	int i, ret;
+
+	for (i = 0; i < tz->trips; i++) {
+		if (mask & (1 << i)) {
+			ret = thermal_zone_bind_cooling_device(tz, i, cdev,
+					THERMAL_NO_LIMIT, THERMAL_NO_LIMIT);
+			if (ret)
+				print_bind_err_msg(tz, cdev, ret);
+		}
+	}
+}
+
+static void __unbind(struct thermal_zone_device *tz, int mask,
+			struct thermal_cooling_device *cdev)
+{
+	int i;
+
+	for (i = 0; i < tz->trips; i++)
+		if (mask & (1 << i))
+			thermal_zone_unbind_cooling_device(tz, i, cdev);
+}
+
+static void update_bind_info(struct thermal_cooling_device *cdev)
+{
+	int i, ret;
+	struct thermal_zone_params *tzp;
+	struct thermal_zone_device *pos = NULL;
+
+	mutex_lock(&thermal_list_lock);
+
+	list_for_each_entry(pos, &thermal_tz_list, node) {
+		if (!pos->tzp && !pos->ops->bind)
+			continue;
+
+		if (!pos->tzp && pos->ops->bind) {
+			ret = pos->ops->bind(pos, cdev);
+			if (ret)
+				print_bind_err_msg(pos, cdev, ret);
+		}
+
+		tzp = pos->tzp;
+		for (i = 0; i < tzp->num_cdevs; i++) {
+			if (!strcmp(tzp->cdevs_name[i], cdev->type)) {
+				__bind(pos, tzp->trip_mask[i], cdev);
+				break;
+			}
+		}
+	}
+	mutex_unlock(&thermal_list_lock);
+}
+
+static void do_binding(struct thermal_zone_device *tz)
+{
+	int i, ret;
+	char *name;
+	struct thermal_cooling_device *pos = NULL;
+	struct thermal_zone_params *tzp = tz->tzp;
+
+	if (!tzp && !tz->ops->bind)
+		return;
+
+	/* If there is no platform data, try to use ops->bind */
+	if (!tzp && tz->ops->bind) {
+		mutex_lock(&thermal_list_lock);
+
+		list_for_each_entry(pos, &thermal_cdev_list, node) {
+			ret = tz->ops->bind(tz, pos);
+			if (ret)
+				print_bind_err_msg(tz, pos, ret);
+		}
+
+		mutex_unlock(&thermal_list_lock);
+		return;
+	}
+
+	/* If platform data is available, use it to create binding */
+	for (i = 0; i < tzp->num_cdevs; i++) {
+		name = tzp->cdevs_name[i];
+		pos = get_cdev_by_name(name);
+
+		if (!pos) {
+			dev_err(&tz->device, "cannot find cdev %s\n", name);
+			continue;
+		}
+
+		mutex_lock(&thermal_list_lock);
+		__bind(tz, tzp->trip_mask[i], pos);
+		mutex_unlock(&thermal_list_lock);
+	}
+}
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
@@ -975,7 +1076,6 @@ thermal_cooling_device_register(char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
-	struct thermal_zone_device *pos;
 	int result;
 
 	if (strlen(type) >= THERMAL_NAME_LENGTH)
@@ -1025,20 +1125,15 @@ thermal_cooling_device_register(char *type, void *devdata,
 	if (result)
 		goto unregister;
 
+	/* Add 'this' new cdev to the global cdev list */
 	mutex_lock(&thermal_list_lock);
 	list_add(&cdev->node, &thermal_cdev_list);
-	list_for_each_entry(pos, &thermal_tz_list, node) {
-		if (!pos->ops->bind)
-			continue;
-		result = pos->ops->bind(pos, cdev);
-		if (result)
-			break;
-
-	}
 	mutex_unlock(&thermal_list_lock);
 
-	if (!result)
-		return cdev;
+	/* Update binding information for 'this' new cdev */
+	update_bind_info(cdev);
+
+	return cdev;
 
 unregister:
 	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
@@ -1054,10 +1149,10 @@ EXPORT_SYMBOL(thermal_cooling_device_register);
  * thermal_cooling_device_unregister() must be called when the device is no
  * longer needed.
  */
-void thermal_cooling_device_unregister(struct
-				       thermal_cooling_device
-				       *cdev)
+void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 {
+	int i;
+	struct thermal_zone_params *tzp;
 	struct thermal_zone_device *tz;
 	struct thermal_cooling_device *pos = NULL;
 
@@ -1074,12 +1169,23 @@ void thermal_cooling_device_unregister(struct
 		return;
 	}
 	list_del(&cdev->node);
+
+	/* Unbind all thermal zones associated with 'this' cdev */
 	list_for_each_entry(tz, &thermal_tz_list, node) {
-		if (!tz->ops->unbind)
+		tzp = tz->tzp;
+		if (!tzp && !tz->ops->unbind)
 			continue;
-		tz->ops->unbind(tz, cdev);
+
+		if (!tzp && tz->ops->unbind)
+			tz->ops->unbind(tz, cdev);
+
+		for (i = 0; i < tzp->num_cdevs; i++)
+			if (!strcmp(cdev->type, tzp->cdevs_name[i]))
+				__unbind(tz, tzp->trip_mask[i], cdev);
 	}
+
 	mutex_unlock(&thermal_list_lock);
+
 	if (cdev->type[0])
 		device_remove_file(&cdev->device, &dev_attr_cdev_type);
 	device_remove_file(&cdev->device, &dev_attr_max_state);
@@ -1424,7 +1530,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	int passive_delay, int polling_delay)
 {
 	struct thermal_zone_device *tz;
-	struct thermal_cooling_device *pos;
 	enum thermal_trip_type trip_type;
 	int result;
 	int count;
@@ -1519,14 +1624,12 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	mutex_lock(&thermal_list_lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
-	if (ops->bind)
-		list_for_each_entry(pos, &thermal_cdev_list, node) {
-		result = ops->bind(tz, pos);
-		if (result)
-			break;
-		}
 	mutex_unlock(&thermal_list_lock);
 
+	/* Bind cooling devices for this zone */
+	do_binding(tz);
+
+
 	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
 
 	thermal_zone_device_update(tz);
@@ -1547,12 +1650,16 @@ EXPORT_SYMBOL(thermal_zone_device_register);
  */
 void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 {
+	int i;
+	struct thermal_zone_params *tzp;
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
 
 	if (!tz)
 		return;
 
+	tzp = tz->tzp;
+
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_tz_list, node)
 	    if (pos == tz)
@@ -1563,9 +1670,20 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 		return;
 	}
 	list_del(&tz->node);
-	if (tz->ops->unbind)
-		list_for_each_entry(cdev, &thermal_cdev_list, node)
-		    tz->ops->unbind(tz, cdev);
+
+	/* Unbind all cdevs associated with 'this' thermal zone */
+	list_for_each_entry(cdev, &thermal_cdev_list, node) {
+		if (!tzp && !tz->ops->unbind)
+			break;
+
+		if (!tzp && tz->ops->unbind)
+			tz->ops->unbind(tz, cdev);
+
+		for (i = 0; i < tzp->num_cdevs; i++)
+			if (!strcmp(cdev->type, tzp->cdevs_name[i]))
+				__unbind(tz, tzp->trip_mask[i], cdev);
+	}
+
 	mutex_unlock(&thermal_list_lock);
 
 	thermal_zone_device_set_polling(tz, 0);
-- 
1.7.9.5

