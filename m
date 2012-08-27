From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv2 09/14] Thermal: Introduce fair_share thermal governor
Date: Mon, 27 Aug 2012 09:58:21 +0530
Message-ID: <1346041706-29642-10-git-send-email-durgadoss.r@intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4000 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab2H0E3W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2012 00:29:22 -0400
In-Reply-To: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch introduces a simple 'weight' based
governor named fair_share governor. Whenever the
thermal framework gets notified of the trip point
violation, this governor (if configured), throttles
the cooling devices associated with a thermal zone.

This mapping between a thermal zone and a cooling device
and the effectiveness of cooling are provided in the
platform layer.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/Kconfig      |    6 +++
 drivers/thermal/Makefile     |    3 +-
 drivers/thermal/fair_share.c |  113 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h      |    9 ++++
 4 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/fair_share.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 3ab2bd5..f5110c0 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -27,3 +27,9 @@ config SPEAR_THERMAL
 	help
 	  Enable this to plug the SPEAr thermal sensor driver into the Linux
 	  thermal framework
+
+config FAIR_SHARE
+	bool "Fair-share thermal governor"
+	depends on THERMAL
+	help
+	  Enable this to manage platform thermals using fair-share governor.
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index a9fff0b..4ffe1a8 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -3,4 +3,5 @@
 #
 
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
-obj-$(CONFIG_SPEAR_THERMAL)		+= spear_thermal.o
\ No newline at end of file
+obj-$(CONFIG_SPEAR_THERMAL)		+= spear_thermal.o
+obj-$(CONFIG_FAIR_SHARE)		+= fair_share.o
diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
new file mode 100644
index 0000000..a57e40d
--- /dev/null
+++ b/drivers/thermal/fair_share.c
@@ -0,0 +1,113 @@
+/*
+ *  fair_share.c - A simple weight based Thermal governor
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
+/**
+ * get_trip_level: - obtains the current trip level for a zone
+ * @tz:		thermal zone device
+ */
+static int get_trip_level(struct thermal_zone_device *tz)
+{
+	int count = 0;
+	unsigned long trip_temp;
+
+	if (tz->trips == 0 || !tz->ops->get_trip_temp)
+		return 0;
+
+	for (count = 0; count < tz->trips; count++) {
+		tz->ops->get_trip_temp(tz, count, &trip_temp);
+		if (tz->temperature < trip_temp)
+			break;
+	}
+	return count;
+}
+
+static long get_target_state(struct thermal_zone_device *tz,
+		struct thermal_cooling_device *cdev, int weight, int level)
+{
+	unsigned long max_state;
+
+	cdev->ops->get_max_state(cdev, &max_state);
+
+	return (long)(weight * level * max_state) / (100 * tz->trips);
+}
+
+/**
+ * fair_share_throttle - throttles devices asscciated with the given zone
+ * @tz - thermal_zone_device
+ *
+ * Throttling Logic: This uses three parameters to calculate the new
+ * throttle state of the cooling devices associated with the given zone.
+ *
+ * Parameters used for Throttling:
+ * P1. max_state: Maximum throttle state exposed by the cooling device.
+ * P2. weight[i]/100:
+ *	How 'effective' the 'i'th device is, in cooling the given zone.
+ * P3. cur_trip_level/max_no_of_trips:
+ *	This describes the extent to which the devices should be throttled.
+ *	We do not want to throttle too much when we trip a lower temperature,
+ *	whereas the throttling is at full swing if we trip critical levels.
+ *	(Heavily assumes the trip points are in ascending order)
+ * new_state of cooling device = P3 * P2 * P1
+ */
+void fair_share_throttle(struct thermal_zone_device *tz, int trip)
+{
+	struct thermal_zone_params *tzp;
+	struct thermal_cooling_device *cdev;
+	struct thermal_instance *instance;
+	int i;
+	int cur_trip_level = get_trip_level(tz);
+
+	if (!tz->tzp || !tz->tzp->tbp)
+		return;
+
+	tzp = tz->tzp;
+
+	for (i = 0; i < tzp->num_tbps; i++) {
+		if (!tzp->tbp[i].cdev)
+			continue;
+
+		cdev = tzp->tbp[i].cdev;
+		instance = get_thermal_instance(tz, cdev, trip);
+		if (!instance)
+			continue;
+
+		instance->target = get_target_state(tz, cdev,
+					tzp->tbp[i].weight, cur_trip_level);
+
+		instance->cdev->updated = false;
+		thermal_cdev_update(cdev);
+	}
+}
+EXPORT_SYMBOL(fair_share_throttle);
+
+MODULE_AUTHOR("Durgadoss R");
+MODULE_DESCRIPTION("A simple weight based thermal throttling governor");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 591f350..472beed 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -237,6 +237,15 @@ void thermal_cdev_update(struct thermal_cooling_device *);
  */
 extern int (*get_platform_thermal_params)(struct thermal_zone_device *);
 
+#ifdef CONFIG_FAIR_SHARE
+extern void fair_share_throttle(struct thermal_zone_device *tz, int trip);
+#else
+static inline void fair_share_throttle(struct thermal_zone_device *tz, int trip)
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

