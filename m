From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv2 10/14] Thermal: Introduce a step_wise thermal governor
Date: Mon, 27 Aug 2012 09:58:22 +0530
Message-ID: <1346041706-29642-11-git-send-email-durgadoss.r@intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4000 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab2H0E3Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2012 00:29:24 -0400
In-Reply-To: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch adds a simple step_wise governor to the
generic thermal layer. This algorithm throttles the
cooling devices in a linear fashion. If the 'trend'
is heating, it throttles by one step. And if the
thermal trend is cooling it de-throttles by one step.

This actually moves the throttling logic from thermal_sys.c
and puts inside step_wise.c, without any change.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/Kconfig     |    6 ++
 drivers/thermal/Makefile    |    1 +
 drivers/thermal/step_wise.c |  173 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h     |    9 +++
 4 files changed, 189 insertions(+)
 create mode 100644 drivers/thermal/step_wise.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index f5110c0..0401cdf 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -33,3 +33,9 @@ config FAIR_SHARE
 	depends on THERMAL
 	help
 	  Enable this to manage platform thermals using fair-share governor.
+
+config STEP_WISE
+	bool "Step_wise thermal governor"
+	depends on THERMAL
+	help
+	  Enable this to manage platform thermals using a simple linear
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 4ffe1a8..c2c0ce0 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 obj-$(CONFIG_SPEAR_THERMAL)		+= spear_thermal.o
 obj-$(CONFIG_FAIR_SHARE)		+= fair_share.o
+obj-$(CONFIG_STEP_WISE)			+= step_wise.o
diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
new file mode 100644
index 0000000..1161974
--- /dev/null
+++ b/drivers/thermal/step_wise.c
@@ -0,0 +1,173 @@
+/*
+ *  step_wise.c - A step-by-step Thermal throttling governor
+ *
+ *  Copyright (C) 2012 Intel Corp
+ *  Copyright (C) 2012 Durgadoss R <durgadoss.r@intel.com>
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+/*
+ * If the temperature is higher than a trip point,
+ *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
+ *       state for this trip point
+ *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
+ *       state for this trip point
+ */
+static unsigned long get_target_state(struct thermal_instance *instance,
+					enum thermal_trend trend)
+{
+	struct thermal_cooling_device *cdev = instance->cdev;
+	unsigned long cur_state;
+
+	cdev->ops->get_cur_state(cdev, &cur_state);
+
+	if (trend == THERMAL_TREND_RAISING) {
+		cur_state = cur_state < instance->upper ?
+			    (cur_state + 1) : instance->upper;
+	} else if (trend == THERMAL_TREND_DROPPING) {
+		cur_state = cur_state > instance->lower ?
+			    (cur_state - 1) : instance->lower;
+	}
+
+	return cur_state;
+}
+
+static void update_passive_instance(struct thermal_zone_device *tz,
+				enum thermal_trip_type type, int value)
+{
+	/*
+	 * If value is +1, activate a passive instance.
+	 * If value is -1, deactivate a passive instance.
+	 */
+	if (type == THERMAL_TRIP_PASSIVE || type == THERMAL_TRIPS_NONE)
+		tz->passive += value;
+}
+
+static void update_instance_for_throttle(struct thermal_zone_device *tz,
+				int trip, enum thermal_trip_type trip_type,
+				enum thermal_trend trend)
+{
+	struct thermal_instance *instance;
+
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		if (instance->trip != trip)
+			continue;
+
+		instance->target = get_target_state(instance, trend);
+
+		/* Activate a passive thermal instance */
+		if (instance->target == THERMAL_NO_TARGET)
+			update_passive_instance(tz, trip_type, 1);
+
+		instance->cdev->updated = false; /* cdev needs update */
+	}
+}
+
+static void update_instance_for_dethrottle(struct thermal_zone_device *tz,
+				int trip, enum thermal_trip_type trip_type)
+{
+	struct thermal_instance *instance;
+	struct thermal_cooling_device *cdev;
+	unsigned long cur_state;
+
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		if (instance->trip != trip ||
+			instance->target == THERMAL_NO_TARGET)
+			continue;
+
+		cdev = instance->cdev;
+		cdev->ops->get_cur_state(cdev, &cur_state);
+
+		instance->target = cur_state > instance->lower ?
+			    (cur_state - 1) : THERMAL_NO_TARGET;
+
+		/* Deactivate a passive thermal instance */
+		if (instance->target == THERMAL_NO_TARGET)
+			update_passive_instance(tz, trip_type, -1);
+
+		cdev->updated = false; /* cdev needs update */
+	}
+}
+
+static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
+{
+	long trip_temp;
+	enum thermal_trip_type trip_type;
+	enum thermal_trend trend;
+
+	if (trip == THERMAL_TRIPS_NONE) {
+		trip_temp = tz->forced_passive;
+		trip_type = THERMAL_TRIPS_NONE;
+	} else {
+		tz->ops->get_trip_temp(tz, trip, &trip_temp);
+		tz->ops->get_trip_type(tz, trip, &trip_type);
+	}
+
+	trend = get_tz_trend(tz, trip);
+
+	mutex_lock(&tz->lock);
+
+	if (tz->temperature >= trip_temp)
+		update_instance_for_throttle(tz, trip, trip_type, trend);
+	else
+		update_instance_for_dethrottle(tz, trip, trip_type);
+
+	mutex_unlock(&tz->lock);
+}
+
+/**
+ * step_wise_throttle - throttles devices asscciated with the given zone
+ * @tz - thermal_zone_device
+ * @trip - the trip point
+ * @trip_type - type of the trip point
+ *
+ * Throttling Logic: This uses the trend of the thermal zone to throttle.
+ * If the thermal zone is 'heating up' this throttles all the cooling
+ * devices associated with the zone and its particular trip point, by one
+ * step. If the zone is 'cooling down' it brings back the performance of
+ * the devices by one step.
+ */
+void step_wise_throttle(struct thermal_zone_device *tz, int trip)
+{
+	struct thermal_instance *instance;
+
+	thermal_zone_trip_update(tz, trip);
+
+	if (tz->forced_passive)
+		thermal_zone_trip_update(tz, THERMAL_TRIPS_NONE);
+
+	mutex_lock(&tz->lock);
+
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
+		thermal_cdev_update(instance->cdev);
+
+	mutex_unlock(&tz->lock);
+}
+EXPORT_SYMBOL(step_wise_throttle);
+
+MODULE_AUTHOR("Durgadoss R");
+MODULE_DESCRIPTION("A step-by-step thermal throttling governor");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 472beed..c7e0a4d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -246,6 +246,15 @@ static inline void fair_share_throttle(struct thermal_zone_device *tz, int trip)
 }
 #endif
 
+#ifdef CONFIG_STEP_WISE
+extern void step_wise_throttle(struct thermal_zone_device *tz, int trip);
+#else
+static inline void step_wise_throttle(struct thermal_zone_device *tz, int trip)
+{
+	return;
+}
+#endif
+
 #ifdef CONFIG_NET
 extern int thermal_generate_netlink_event(u32 orig, enum events event);
 #else
-- 
1.7.9.5

