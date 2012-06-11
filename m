From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 3/4] RFC Thermal: Introduce a step-wise thermal governor
Date: Mon, 11 Jun 2012 23:09:33 +0530
Message-ID: <1339436374-26881-4-git-send-email-durgadoss.r@intel.com>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26560 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192Ab2FLFWt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jun 2012 01:22:49 -0400
In-Reply-To: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, Durgadoss R <durgadoss.r@intel.com>

This patch adds a simple step-wise governor to the
generic thermal layer. This algorithm throttles the
cooling devices in a linear fashion. If the 'trend'
is heating, it throttles by one step. And if the
thermal trend is cooling it de-throttles by one step.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/Kconfig     |    7 +++
 drivers/thermal/Makefile    |    1 +
 drivers/thermal/step_wise.c |   86 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 0 deletions(-)
 create mode 100644 drivers/thermal/step_wise.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index f5132f3..74992cd 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -32,3 +32,10 @@ config FAIR_SHARE
 	depends on THERMAL
 	help
 	  Enable this to manage platform thermals using fair-share governor.
+
+config STEP_WISE
+	bool "step_wise thermal governor"
+	depends on THERMAL
+	help
+	  Enable this to manage platform thermals using a simple linear
+          throttling algorithm
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
index 0000000..7ce923a
--- /dev/null
+++ b/drivers/thermal/step_wise.c
@@ -0,0 +1,86 @@
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
+unsigned long get_new_state(unsigned long cur_state, enum thermal_trend trend)
+{
+	switch (trend) {
+	case THERMAL_TREND_HEATING:
+		return cur_state + 1;
+	case THERMAL_TREND_COOLING:
+		return cur_state - 1;
+	default:
+		return cur_state + 1;
+	}
+}
+
+/**
+ * step_wise_throttle - throttles devices asscciated with the given zone
+ * @tz - thermal_zone_device
+ *
+ * Throttling Logic: This uses the trend of the thermal zone to throttle.
+ * If the thermal zone is 'heating up' this throttles all the cooling
+ * devices associated with the zone by one step. If the zone is
+ * 'cooling down' it brings back the performance of the devices by one step.
+ */
+int step_wise_throttle(struct thermal_zone_device *tz,
+			int trip, enum thermal_trip_type trip_type)
+{
+	struct thermal_zone_params *tzp = tz->tzp;
+	struct thermal_cooling_device *cdev;
+	unsigned long max_state, cur_state, new_state;
+	enum thermal_trend trend;
+	int i;
+
+	if (!tz->ops->get_trend || tz->ops->get_trend(tz, trip, &trend))
+		trend = THERMAL_TREND_DEFAULT;
+
+	for (i = 0; i < tzp->num_cdevs; i++) {
+		if (!tzp->cdevs[i])
+			continue;
+
+		cdev = tzp->cdevs[i];
+		cdev->ops->get_cur_state(cdev, &cur_state);
+		cdev->ops->get_max_state(cdev, &max_state);
+
+		new_state = get_new_state(cur_state, trend);
+		if (new_state >= max_state)
+			cdev->ops->set_cur_state(cdev, max_state);
+		else if (new_state <= 0)
+			cdev->ops->set_cur_state(cdev, 0);
+		else
+			cdev->ops->set_cur_state(cdev, new_state);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(step_wise_throttle);
+
+MODULE_AUTHOR("Durgadoss R");
+MODULE_DESCRIPTION("A step-by-step thermal throttling governor");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4

