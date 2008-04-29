From: Len Brown <lenb@kernel.org>
Subject: [PATCH 095/171] thermal: add new get_crit_temp callback
Date: Tue, 29 Apr 2008 04:44:15 -0400
Message-ID: <9ec732ff80b7e8a9096666f78ae584d3b393bc84.1209457070.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:45231 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760733AbYD2IpL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:11 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang, Rui <rui.zhang@intel.com>

Add a new callback so that the generic thermal can get
the critical trip point info of a thermal zone,
which is needed for building the tempX_crit hwmon sysfs attribute.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c  |   13 +++++++++++++
 include/linux/thermal.h |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 766bd25..ec707ed 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1012,6 +1012,18 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
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
@@ -1103,6 +1115,7 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 	.set_mode = thermal_set_mode,
 	.get_trip_type = thermal_get_trip_type,
 	.get_trip_temp = thermal_get_trip_temp,
+	.get_crit_temp = thermal_get_crit_temp,
 };
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 3ff680b..16e6a8b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -41,6 +41,7 @@ struct thermal_zone_device_ops {
 	int (*set_mode) (struct thermal_zone_device *, const char *);
 	int (*get_trip_type) (struct thermal_zone_device *, int, char *);
 	int (*get_trip_temp) (struct thermal_zone_device *, int, char *);
+	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
 };
 
 struct thermal_cooling_device_ops {
-- 
1.5.5.1.99.gf0ec4

