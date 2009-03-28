From: Len Brown <lenb@kernel.org>
Subject: [PATCH 81/98] thermal: support forcing support for passive cooling
Date: Sat, 28 Mar 2009 00:31:56 -0400
Message-ID: <03a971a2899886006f19f3495973bbd646d8bdae.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:35065 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577AbZC1Edo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:44 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700KLV8O4YMU6@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:42 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Due to poor thermal design or Linux driving hardware outside its thermal
envelope, some systems will reach critical temperature and shut down
under high load. This patch adds support for forcing a polling-based
passive trip point if the firmware doesn't provide one. The assumption
is made that the processor is the most practical means to reduce the
dynamic heat generation, so hitting the passive thermal limit will cause
the CPU to be throttled until the temperature stabalises around the
defined value.

UI is provided via a "passive" sysfs entry in the thermal zone
directory. It accepts a decimal value in millidegrees celsius, or "0" to
disable the functionality. Default behaviour is for this functionality
to be disabled.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |   77 +++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h       |    1 +
 2 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 6378741..d0b093b 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -214,9 +214,69 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%ld\n", temperature);
 }
 
+static ssize_t
+passive_store(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_cooling_device *cdev = NULL;
+	int state;
+
+	if (!sscanf(buf, "%d\n", &state))
+		return -EINVAL;
+
+	if (state && !tz->forced_passive) {
+		mutex_lock(&thermal_list_lock);
+		list_for_each_entry(cdev, &thermal_cdev_list, node) {
+			if (!strncmp("Processor", cdev->type,
+				     sizeof("Processor")))
+				thermal_zone_bind_cooling_device(tz,
+								 THERMAL_TRIPS_NONE,
+								 cdev);
+		}
+		mutex_unlock(&thermal_list_lock);
+	} else if (!state && tz->forced_passive) {
+		mutex_lock(&thermal_list_lock);
+		list_for_each_entry(cdev, &thermal_cdev_list, node) {
+			if (!strncmp("Processor", cdev->type,
+				     sizeof("Processor")))
+				thermal_zone_unbind_cooling_device(tz,
+								   THERMAL_TRIPS_NONE,
+								   cdev);
+		}
+		mutex_unlock(&thermal_list_lock);
+	}
+
+	tz->tc1 = 1;
+	tz->tc2 = 1;
+
+	if (!tz->passive_delay)
+		tz->passive_delay = 1000;
+
+	if (!tz->polling_delay)
+		tz->polling_delay = 10000;
+
+	tz->forced_passive = state;
+
+	thermal_zone_device_update(tz);
+
+	return count;
+}
+
+static ssize_t
+passive_show(struct device *dev, struct device_attribute *attr,
+		   char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+
+	return sprintf(buf, "%d\n", tz->forced_passive);
+}
+
 static DEVICE_ATTR(type, 0444, type_show, NULL);
 static DEVICE_ATTR(temp, 0444, temp_show, NULL);
 static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
+static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, \
+		   passive_store);
 
 static struct device_attribute trip_point_attrs[] = {
 	__ATTR(trip_point_0_type, 0444, trip_point_type_show, NULL),
@@ -939,6 +999,11 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 			break;
 		}
 	}
+
+	if (tz->forced_passive)
+		thermal_zone_device_passive(tz, temp, tz->forced_passive,
+					    THERMAL_TRIPS_NONE);
+
 	tz->last_temperature = temp;
 	if (tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay);
@@ -977,8 +1042,10 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 {
 	struct thermal_zone_device *tz;
 	struct thermal_cooling_device *pos;
+	enum thermal_trip_type trip_type;
 	int result;
 	int count;
+	int passive = 0;
 
 	if (strlen(type) >= THERMAL_NAME_LENGTH)
 		return ERR_PTR(-EINVAL);
@@ -1041,8 +1108,18 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 		TRIP_POINT_ATTR_ADD(&tz->device, count, result);
 		if (result)
 			goto unregister;
+		tz->ops->get_trip_type(tz, count, &trip_type);
+		if (trip_type == THERMAL_TRIP_PASSIVE)
+			passive = 1;
 	}
 
+	if (!passive)
+		result = device_create_file(&tz->device,
+					    &dev_attr_passive);
+
+	if (result)
+		goto unregister;
+
 	result = thermal_add_hwmon_sysfs(tz);
 	if (result)
 		goto unregister;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a81c615..1de8b9e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -113,6 +113,7 @@ struct thermal_zone_device {
 	int polling_delay;
 	int last_temperature;
 	bool passive;
+	unsigned int forced_passive;
 	struct thermal_zone_device_ops *ops;
 	struct list_head cooling_devices;
 	struct idr idr;
-- 
1.6.0.6

