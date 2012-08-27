From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv2 04/14] Thermal: Add platform level information to thermal.h
Date: Mon, 27 Aug 2012 09:58:16 +0530
Message-ID: <1346041706-29642-5-git-send-email-durgadoss.r@intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4000 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab2H0E3M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2012 00:29:12 -0400
In-Reply-To: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch creates two structures; one to hold bind
bind parameters for a thermal zone, and another to
store platform layer data for a thermal zone, and
defines an extern function to retrieve these
parameters from thermal_sys.c. This patch also
defines an enum that describes various policies
for thermal throttling.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |    3 +++
 include/linux/thermal.h       |   46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 5e141b5..92a187c 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -51,6 +51,9 @@ static LIST_HEAD(thermal_tz_list);
 static LIST_HEAD(thermal_cdev_list);
 static DEFINE_MUTEX(thermal_list_lock);
 
+int (*get_platform_thermal_params)(struct thermal_zone_device *);
+EXPORT_SYMBOL(get_platform_thermal_params);
+
 static int get_idr(struct idr *idr, struct mutex *lock, int *id)
 {
 	int err;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 32af124..b644b8e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -67,6 +67,12 @@ enum thermal_trend {
 	THERMAL_TREND_DROPPING, /* temperature is dropping */
 };
 
+enum thermal_throttle_policy {
+	THERMAL_USER_SPACE,
+	THERMAL_FAIR_SHARE,
+	THERMAL_STEP_WISE,
+};
+
 /* Events supported by Thermal Netlink */
 enum events {
 	THERMAL_AUX0,
@@ -162,6 +168,37 @@ struct thermal_zone_device {
 	struct mutex lock; /* protect thermal_instances list */
 	struct list_head node;
 	struct delayed_work poll_queue;
+	struct thermal_zone_params *tzp;
+};
+
+/* Structure that holds binding parameters for a zone */
+struct thermal_bind_params {
+	struct thermal_cooling_device *cdev;
+
+	/*
+	 * This is a measure of 'how effectively these devices can
+	 * cool 'this' thermal zone. The shall be determined by platform
+	 * characterization. This is on a 'percentage' scale.
+	 * See Documentation/thermal/sysfs-api.txt for more information.
+	 */
+	int weight;
+
+	/*
+	 * This is a bit mask that gives the binding relation between this
+	 * thermal zone and cdev, for a particular trip point.
+	 * See Documentation/thermal/sysfs-api.txt for more information.
+	 */
+	int trip_mask;
+	int (*match) (struct thermal_zone_device *tz,
+			struct thermal_cooling_device *cdev);
+};
+
+/* Structure to define Thermal Zone parameters */
+struct thermal_zone_params {
+	const char *zone_name;
+	enum thermal_throttle_policy throttle_policy;
+	int num_tbps;	/* Number of tbp entries */
+	struct thermal_bind_params *tbp;
 };
 
 struct thermal_genl_event {
@@ -188,6 +225,15 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
 		struct thermal_cooling_device *, int);
+/*
+ * The platform layer shall define a 'function' that provides the
+ * parameters for all thermal zones in the platform. This pointer
+ * should point to that 'function'.
+ *
+ * In thermal_zone_device_register() we update the parameters
+ * for the particular thermal zone.
+ */
+extern int (*get_platform_thermal_params)(struct thermal_zone_device *);
 
 #ifdef CONFIG_NET
 extern int thermal_generate_netlink_event(u32 orig, enum events event);
-- 
1.7.9.5

