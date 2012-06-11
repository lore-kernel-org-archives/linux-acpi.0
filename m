From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 2/4] RFC Thermal: Introduce fair-share thermal governor
Date: Mon, 11 Jun 2012 23:09:32 +0530
Message-ID: <1339436374-26881-3-git-send-email-durgadoss.r@intel.com>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3499 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049Ab2FLFWm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jun 2012 01:22:42 -0400
In-Reply-To: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, Durgadoss R <durgadoss.r@intel.com>

This patch introduces a simple 'weight' based
governor named fair-share governor. Whenever the
thermal framework gets notified of the trip point
violation, this governor (if configured), throttles
the cooling devices associated with a thermal zone.

This mapping between a thermal zone and a cooling device
and the effectiveness of cooling are provided in the
platform layer.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/Kconfig      |    6 ++
 drivers/thermal/Makefile     |    3 +-
 drivers/thermal/fair_share.c |  111 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletions(-)
 create mode 100644 drivers/thermal/fair_share.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 514a691..f5132f3 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -26,3 +26,9 @@ config SPEAR_THERMAL
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
index 0000000..59af81d
--- /dev/null
+++ b/drivers/thermal/fair_share.c
@@ -0,0 +1,111 @@
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
+/**
+ * get_trip_level: - obtains the current trip level for a zone
+ * @tz:		thermal zone device
+ */
+int get_trip_level(struct thermal_zone_device *tz)
+{
+	int count = 0;
+	unsigned long cur_temp, trip_temp;
+
+	if (tz->trips == 0 || !tz->ops->get_trip_temp)
+		return 0;
+
+	tz->ops->get_temp(tz, &cur_temp);
+
+	for (count = 0; count < tz->trips; count++) {
+		tz->ops->get_trip_temp(tz, count, &trip_temp);
+		if (cur_temp < trip_temp)
+			break;
+	}
+	return count;
+}
+
+/**
+ * fair_share_throttle - throttles devices asscciated with the given zone
+ * @tz - thermal_zone_device
+ *
+ * Throttling Logic: This uses three parameters to calculate the new
+ * throttle state of the cooling devices associated with the given zone.
+ *
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
+int fair_share_throttle(struct thermal_zone_device *tz)
+{
+	struct thermal_zone_params *tzp;
+	struct thermal_cooling_device *cdev;
+	unsigned long max_state, new_state;
+	int i;
+
+	int cur_trip_level = get_trip_level(tz);
+
+	/* Do not throttle:
+	 * if there are no parameters defined for this zone
+	 * if current trip level is 0 (for performance reasons)
+	 */
+	if (!tz->tzp || cur_trip_level == 0)
+		return 0;
+
+	tzp = tz->tzp;
+
+	for (i = 0; i < tzp->num_cdevs; i++) {
+		/*
+		 * Do not throttle:
+		 * if this device cannot cool the zone, or
+		 * if the cooling device does not exist anymore
+		 */
+		if (tzp->weights[i] == 0 || !tzp->cdevs[i])
+			continue;
+
+		cdev = tzp->cdevs[i];
+		cdev->ops->get_max_state(cdev, &max_state);
+
+		new_state =
+		(long)(tzp->weights[i] * cur_trip_level * max_state) /
+		(100 * tz->trips);
+
+		cdev->ops->set_cur_state(cdev, new_state);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(fair_share_throttle);
+
+MODULE_AUTHOR("Durgadoss R");
+MODULE_DESCRIPTION("A simple weight based thermal throttling governor");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4

