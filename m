From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv2 02/14] Thermal: Move thermal_instance to thermal_core.h
Date: Mon, 27 Aug 2012 09:58:14 +0530
Message-ID: <1346041706-29642-3-git-send-email-durgadoss.r@intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22698 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780Ab2H0E3I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2012 00:29:08 -0400
In-Reply-To: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch creates a thermal_core.h file which can contain
all defines used by the core thermal framework files. For
now, move the thermal_instance structure to thermal_core.h
This structure is used by files under drivers/thermal/.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_core.h |   53 ++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_sys.c  |   23 ++---------------
 2 files changed, 55 insertions(+), 21 deletions(-)
 create mode 100644 drivers/thermal/thermal_core.h

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
new file mode 100644
index 0000000..0d3205a
--- /dev/null
+++ b/drivers/thermal/thermal_core.h
@@ -0,0 +1,53 @@
+/*
+ *  thermal_core.h
+ *
+ *  Copyright (C) 2012  Intel Corp
+ *  Author: Durgadoss R <durgadoss.r@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+#ifndef __THERMAL_CORE_H__
+#define __THERMAL_CORE_H__
+
+#include <linux/device.h>
+#include <linux/thermal.h>
+
+/* Initial state of a cooling device during binding */
+#define THERMAL_NO_TARGET -1UL
+
+/*
+ * This structure is used to describe the behavior of
+ * a certain cooling device on a certain trip point
+ * in a certain thermal zone
+ */
+struct thermal_instance {
+	int id;
+	char name[THERMAL_NAME_LENGTH];
+	struct thermal_zone_device *tz;
+	struct thermal_cooling_device *cdev;
+	int trip;
+	unsigned long upper;	/* Highest cooling state for this trip point */
+	unsigned long lower;	/* Lowest cooling state for this trip point */
+	unsigned long target;	/* expected cooling state */
+	char attr_name[THERMAL_NAME_LENGTH];
+	struct device_attribute attr;
+	struct list_head tz_node; /* node in tz->thermal_instances */
+	struct list_head cdev_node; /* node in cdev->thermal_instances */
+};
+
+#endif /* __THERMAL_CORE_H__ */
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 5be8728..0e71b00 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -37,31 +37,12 @@
 #include <net/netlink.h>
 #include <net/genetlink.h>
 
+#include "thermal_core.h"
+
 MODULE_AUTHOR("Zhang Rui");
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
 MODULE_LICENSE("GPL");
 
-#define THERMAL_NO_TARGET -1UL
-/*
- * This structure is used to describe the behavior of
- * a certain cooling device on a certain trip point
- * in a certain thermal zone
- */
-struct thermal_instance {
-	int id;
-	char name[THERMAL_NAME_LENGTH];
-	struct thermal_zone_device *tz;
-	struct thermal_cooling_device *cdev;
-	int trip;
-	unsigned long upper;	/* Highest cooling state for this trip point */
-	unsigned long lower;	/* Lowest cooling state for this trip point */
-	unsigned long target;	/* expected cooling state */
-	char attr_name[THERMAL_NAME_LENGTH];
-	struct device_attribute attr;
-	struct list_head tz_node; /* node in tz->thermal_instances */
-	struct list_head cdev_node; /* node in cdev->thermal_instances */
-};
-
 static DEFINE_IDR(thermal_tz_idr);
 static DEFINE_IDR(thermal_cdev_idr);
 static DEFINE_MUTEX(thermal_idr_lock);
-- 
1.7.9.5

