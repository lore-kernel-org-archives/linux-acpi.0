From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 053/112] the generic thermal sysfs driver
Date: Thu, 7 Feb 2008 17:05:02 -0500
Message-ID: <200802071705.02695.lenb@kernel.org>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org> <203d3d4aa482339b4816f131f713e1b8ee37f6dd.1202376824.git.len.brown@intel.com> <20080207084645.c6e67aad.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57720 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757155AbYBGWFa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 17:05:30 -0500
In-Reply-To: <20080207084645.c6e67aad.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>

Thanks for the review, Randy.

I've corrected the issues you pointed out, as well as
run the doc through ispell and run thermal.c through Lindent.

I've left the goto labels where Lindent put them.
If there is a Linux style consensus on that issue,
perhaps the Linux community can enhance Lindent?
(I'm not going to move a bunch of labels around,
 just to have the next Lindent sweep move them back)

Also, regarding the kernel-doc syntax, that too
would be a good thing for Lindent, or some other tool
to do for us -- or at least to complain about for us:-)

thanks,
-Len

>From 54c82f9ae5b2106cc79633a611367883c374ad3f Mon Sep 17 00:00:00 2001
From: Len Brown <len.brown@intel.com>
Date: Thu, 7 Feb 2008 16:55:08 -0500
Subject: [PATCH] ACPI: thermal: syntax, spelling, kernel-doc
Organization: Intel Open Source Technology Center

Reviewed-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thermal/sysfs-api.txt |   23 ++++++++--------
 drivers/thermal/Kconfig             |    4 +-
 drivers/thermal/thermal.c           |   49 ++++++++++++++++++++---------------
 3 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 5776e09..ba9c2da 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -14,7 +14,7 @@ The generic thermal sysfs provides a set of interfaces for thermal zone devices
 and thermal cooling devices (fan, processor...) to register with the thermal management
 solution and to be a part of it.
 
-This how-to focusses on enabling new thermal zone and cooling devices to participate
+This how-to focuses on enabling new thermal zone and cooling devices to participate
 in thermal management.
 This solution is platform independent and any type of thermal zone devices and
 cooling devices should be able to make use of the infrastructure.
@@ -41,9 +41,9 @@ and throttle appropriate devices.
 	name: the thermal zone name.
 	trips: the total number of trip points this thermal zone supports.
 	devdata: device private data
-	ops: thermal zone device callbacks.
+	ops: thermal zone device call-backs.
 		.bind: bind the thermal zone device with a thermal cooling device.
-		.unbind: unbing the thermal zone device with a thermal cooling device.
+		.unbind: unbind the thermal zone device with a thermal cooling device.
 		.get_temp: get the current temperature of the thermal zone.
 		.get_mode: get the current mode (user/kernel) of the thermal zone.
 			   "kernel" means thermal management is done in kernel.
@@ -69,7 +69,7 @@ and throttle appropriate devices.
 	It tries to bind itself to all the thermal zone devices register at the same time.
 	name: the cooling device name.
 	devdata: device private data.
-	ops: thermal cooling devices callbacks.
+	ops: thermal cooling devices call-backs.
 		.get_max_state: get the Maximum throttle state of the cooling device.
 		.get_cur_state: get the Current throttle state of the cooling device.
 		.set_cur_state: set the Current throttle state of the cooling device.
@@ -109,7 +109,6 @@ RO	read only value
 RW	read/write value
 
 All thermal sysfs attributes will be represented under /sys/class/thermal
-/sys/class/thermal/
 
 Thermal zone device sys I/F, created once it's registered:
 |thermal_zone[0-*]:
@@ -129,7 +128,7 @@ Thermal cooling device sys I/F, created once it's registered:
 These two dynamic attributes are created/removed in pairs.
 They represent the relationship between a thermal zone and its associated cooling device.
 They are created/removed for each
-thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_device successful exection.
+thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_device successful execution.
 
 |thermal_zone[0-*]
 	|-----cdev[0-*]:		The [0-*]th cooling device in the current thermal zone
@@ -147,11 +146,11 @@ type				Strings which represent the thermal zone type.
 				Optional
 
 temp				Current temperature as reported by thermal zone (sensor)
-				Unit: degree celsius
+				Unit: degree Celsius
 				RO
 				Required
 
-mode				One of the predifned values in [kernel, user]
+mode				One of the predefined values in [kernel, user]
 				This file gives information about the algorithm
 				that is currently managing the thermal zone.
 				It can be either default kernel based algorithm
@@ -164,12 +163,12 @@ mode				One of the predifned values in [kernel, user]
 					  charge of the thermal management.
 
 trip_point_[0-*]_temp		The temperature above which trip point will be fired
-				Unit: degree celsius
+				Unit: degree Celsius
 				RO
 				Optional
 
 trip_point_[0-*]_type 		Strings which indicate the type of the trip point
-				Eg. it can be one of critical, hot, passive,
+				E.g. it can be one of critical, hot, passive,
 				    active[0-*] for ACPI thermal zone.
 				RO
 				Optional
@@ -179,7 +178,7 @@ cdev[0-*]			Sysfs link to the thermal cooling device node where the sys I/F
 				RO
 				Optional
 
-cdev[0-*]_trip_point		The trip point with which cdev[0-*] is assocated in this thermal zone
+cdev[0-*]_trip_point		The trip point with which cdev[0-*] is associated in this thermal zone
 				-1 means the cooling device is not associated with any trip point.
 				RO
 				Optional
@@ -211,7 +210,7 @@ cur_state			The current cooling state of this cooling device.
 
 ACPI thermal zone may support multiple trip points like critical/hot/passive/active.
 If an ACPI thermal zone supports critical, passive, active[0] and active[1] at the same time,
-it may register itself as a thermale_zone_device (thermal_zone1) with 4 trip points in all.
+it may register itself as a thermal_zone_device (thermal_zone1) with 4 trip points in all.
 It has one processor and one fan, which are both registered as thermal_cooling_device.
 If the processor is listed in _PSL method, and the fan is listed in _AL0 method,
 the sys I/F structure will be built like this:
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 9b3f612..69f19f2 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -9,7 +9,7 @@ menuconfig THERMAL
 	  Generic Thermal Sysfs driver offers a generic mechanism for
 	  thermal management. Usually it's made up of one or more thermal
 	  zone and cooling device.
-	  each thermal zone contains its own temperature, trip points,
+	  Each thermal zone contains its own temperature, trip points,
 	  cooling devices.
 	  All platforms with ACPI thermal support can use this driver.
-	  If you want this support, you should say Y here
+	  If you want this support, you should say Y here.
diff --git a/drivers/thermal/thermal.c b/drivers/thermal/thermal.c
index 3273e34..e782b3e 100644
--- a/drivers/thermal/thermal.c
+++ b/drivers/thermal/thermal.c
@@ -267,7 +267,7 @@ thermal_cooling_device_cur_state_store(struct device *dev,
 }
 
 static struct device_attribute dev_attr_cdev_type =
-		__ATTR(type, 0444, thermal_cooling_device_type_show, NULL);
+__ATTR(type, 0444, thermal_cooling_device_type_show, NULL);
 static DEVICE_ATTR(max_state, 0444,
 		   thermal_cooling_device_max_state_show, NULL);
 static DEVICE_ATTR(cur_state, 0644,
@@ -276,7 +276,7 @@ static DEVICE_ATTR(cur_state, 0644,
 
 static ssize_t
 thermal_cooling_device_trip_point_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+				       struct device_attribute *attr, char *buf)
 {
 	struct thermal_cooling_device_instance *instance;
 
@@ -293,11 +293,12 @@ thermal_cooling_device_trip_point_show(struct device *dev,
 
 /**
  * thermal_zone_bind_cooling_device - bind a cooling device to a thermal zone
- * this function is usually called in the thermal zone device .bind callback.
  * @tz:		thermal zone device
  * @trip:	indicates which trip point the cooling devices is
  *		associated with in this thermal zone.
  * @cdev:	thermal cooling device
+ *
+ * This function is usually called in the thermal zone device .bind callback.
  */
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 				     int trip,
@@ -307,8 +308,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	struct thermal_cooling_device_instance *pos;
 	int result;
 
-	if (trip >= tz->trips ||
-	    (trip < 0 && trip != THERMAL_TRIPS_NONE))
+	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
 		return -EINVAL;
 
 	if (!tz || !cdev)
@@ -361,15 +361,17 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	kfree(dev);
 	return result;
 }
+
 EXPORT_SYMBOL(thermal_zone_bind_cooling_device);
 
 /**
  * thermal_zone_unbind_cooling_device - unbind a cooling device from a thermal zone
- * this function is usually called in the thermal zone device .unbind callback.
  * @tz:		thermal zone device
  * @trip:	indicates which trip point the cooling devices is
  *		associated with in this thermal zone.
  * @cdev:	thermal cooling device
+ *
+ * This function is usually called in the thermal zone device .unbind callback.
  */
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 				       int trip,
@@ -379,8 +381,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 
 	mutex_lock(&tz->lock);
 	list_for_each_entry_safe(pos, next, &tz->cooling_devices, node) {
-		if (pos->tz == tz && pos->trip == trip
-		    && pos->cdev == cdev) {
+		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->node);
 			mutex_unlock(&tz->lock);
 			goto unbind;
@@ -397,6 +398,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 	kfree(pos);
 	return 0;
 }
+
 EXPORT_SYMBOL(thermal_zone_unbind_cooling_device);
 
 static void thermal_release(struct device *dev)
@@ -425,7 +427,10 @@ static struct class thermal_class = {
  * @ops:		standard thermal cooling devices callbacks.
  */
 struct thermal_cooling_device *thermal_cooling_device_register(char *type,
-		       void *devdata, struct thermal_cooling_device_ops *ops)
+							       void *devdata,
+							       struct
+							       thermal_cooling_device_ops
+							       *ops)
 {
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos;
@@ -435,7 +440,7 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *type,
 		return NULL;
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
-		!ops->set_cur_state)
+	    !ops->set_cur_state)
 		return NULL;
 
 	cdev = kzalloc(sizeof(struct thermal_cooling_device), GFP_KERNEL);
@@ -462,8 +467,7 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *type,
 
 	/* sys I/F */
 	if (type) {
-		result = device_create_file(&cdev->device,
-					    &dev_attr_cdev_type);
+		result = device_create_file(&cdev->device, &dev_attr_cdev_type);
 		if (result)
 			goto unregister;
 	}
@@ -496,11 +500,11 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *type,
 	device_unregister(&cdev->device);
 	return NULL;
 }
+
 EXPORT_SYMBOL(thermal_cooling_device_register);
 
 /**
  * thermal_cooling_device_unregister - removes the registered thermal cooling device
- *
  * @cdev:	the thermal cooling device to remove.
  *
  * thermal_cooling_device_unregister() must be called when the device is no
@@ -533,8 +537,7 @@ void thermal_cooling_device_unregister(struct
 	}
 	mutex_unlock(&thermal_list_lock);
 	if (cdev->type[0])
-		device_remove_file(&cdev->device,
-				   &dev_attr_cdev_type);
+		device_remove_file(&cdev->device, &dev_attr_cdev_type);
 	device_remove_file(&cdev->device, &dev_attr_max_state);
 	device_remove_file(&cdev->device, &dev_attr_cur_state);
 
@@ -542,6 +545,7 @@ void thermal_cooling_device_unregister(struct
 	device_unregister(&cdev->device);
 	return;
 }
+
 EXPORT_SYMBOL(thermal_cooling_device_unregister);
 
 /**
@@ -555,8 +559,10 @@ EXPORT_SYMBOL(thermal_cooling_device_unregister);
  * longer needed.
  */
 struct thermal_zone_device *thermal_zone_device_register(char *type,
-					int trips, void *devdata,
-					struct thermal_zone_device_ops *ops)
+							 int trips,
+							 void *devdata, struct
+							 thermal_zone_device_ops
+							 *ops)
 {
 	struct thermal_zone_device *tz;
 	struct thermal_cooling_device *pos;
@@ -625,9 +631,9 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 	list_add_tail(&tz->node, &thermal_tz_list);
 	if (ops->bind)
 		list_for_each_entry(pos, &thermal_cdev_list, node) {
-			result = ops->bind(tz, pos);
-			if (result)
-				break;
+		result = ops->bind(tz, pos);
+		if (result)
+			break;
 		}
 	mutex_unlock(&thermal_list_lock);
 
@@ -639,11 +645,11 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 	device_unregister(&tz->device);
 	return NULL;
 }
+
 EXPORT_SYMBOL(thermal_zone_device_register);
 
 /**
  * thermal_device_unregister - removes the registered thermal zone device
- *
  * @tz: the thermal zone device to remove
  */
 void thermal_zone_device_unregister(struct thermal_zone_device *tz)
@@ -685,6 +691,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	device_unregister(&tz->device);
 	return;
 }
+
 EXPORT_SYMBOL(thermal_zone_device_unregister);
 
 static int __init thermal_init(void)
-- 
1.5.4.34.g053d9

