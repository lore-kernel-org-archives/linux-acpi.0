From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: [PATCH 2/6] thermal: add  new get_crit_temp callback
Date: Thu, 10 Apr 2008 16:13:10 +0800
Message-ID: <1207815190.27304.34.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63872 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198AbYDJIay (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Apr 2008 04:30:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi <linux-acpi@vger.kernel.org>


Add a new callback so that the generic thermal can get
the critical trip point info of a thermal zone,
which is needed for building the tempX_crit hwmon sysfs attribute.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c  |   13 +++++++++++++
 include/linux/thermal.h |    1 +
 2 files changed, 14 insertions(+)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -1012,6 +1012,18 @@ static int thermal_get_trip_temp(struct 
 	return -EINVAL;
 }
 
+static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
+				unsigned long *temperature) {
+	struct acpi_thermal *tz = thermal->devdata;
+
+	if (tz->trips.critical.flags.valid) {
+		*temperature = KELVIN_TO_MILLICELSIUS(
+				tz->trips.critical.temperature);
+		return 0;
+	} else
+		return -EINVAL;
+}
+
 typedef int (*cb)(struct thermal_zone_device *, int,
 		  struct thermal_cooling_device *);
 static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
@@ -1103,6 +1115,7 @@ static struct thermal_zone_device_ops ac
 	.set_mode = thermal_set_mode,
 	.get_trip_type = thermal_get_trip_type,
 	.get_trip_temp = thermal_get_trip_temp,
+	.get_crit_temp = thermal_get_crit_temp,
 };
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
Index: linux-2.6/include/linux/thermal.h
===================================================================
--- linux-2.6.orig/include/linux/thermal.h
+++ linux-2.6/include/linux/thermal.h
@@ -41,6 +41,7 @@ struct thermal_zone_device_ops {
 	int (*set_mode) (struct thermal_zone_device *, const char *);
 	int (*get_trip_type) (struct thermal_zone_device *, int, char *);
 	int (*get_trip_temp) (struct thermal_zone_device *, int, char *);
+	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
 };
 
 struct thermal_cooling_device_ops {


