From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 02/13] Thermal: Move thermal_instance to thermal.h
Date: Thu,  9 Aug 2012 18:15:54 +0530
Message-ID: <1344516365-7230-3-git-send-email-durgadoss.r@intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14321 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932467Ab2HIMqQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2012 08:46:16 -0400
In-Reply-To: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com, Durgadoss R <durgadoss.r@intel.com>

This patch moves the thermal_instance structure
to thermal.h so that thermal management files
(other than thermal_sys.c) can also access it.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |   21 ---------------------
 include/linux/thermal.h       |   23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 5be8728..a0e20f9 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -41,27 +41,6 @@ MODULE_AUTHOR("Zhang Rui");
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
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 8611e3e..f25df23 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -33,6 +33,9 @@
 #define THERMAL_MAX_TRIPS	12
 #define THERMAL_NAME_LENGTH	20
 
+/* Initial state of a cooling device during binding */
+#define THERMAL_NO_TARGET	-1UL
+
 /* No upper/lower limit requirement */
 #define THERMAL_NO_LIMIT	-1UL
 
@@ -164,6 +167,26 @@ struct thermal_zone_device {
 	struct delayed_work poll_queue;
 };
 
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
 struct thermal_genl_event {
 	u32 orig;
 	enum events event;
-- 
1.7.9.5

