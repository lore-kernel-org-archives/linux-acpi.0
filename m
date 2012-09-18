From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv4 04/15] Thermal: Add platform level information to thermal.h
Date: Tue, 18 Sep 2012 11:04:55 +0530
Message-ID: <1347946506-18449-5-git-send-email-durgadoss.r@intel.com>
References: <1347946506-18449-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28021 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791Ab2IRFgL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2012 01:36:11 -0400
In-Reply-To: <1347946506-18449-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch adds platform level information to thermal.h
by introducing two structures to hold:
 * bind parameters for a thermal zone,
 * zone level platform parameters

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 include/linux/thermal.h |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 32af124..4caa32e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -157,6 +157,7 @@ struct thermal_zone_device {
 	int passive;
 	unsigned int forced_passive;
 	const struct thermal_zone_device_ops *ops;
+	const struct thermal_zone_params *tzp;
 	struct list_head thermal_instances;
 	struct idr idr;
 	struct mutex lock; /* protect thermal_instances list */
@@ -164,6 +165,34 @@ struct thermal_zone_device {
 	struct delayed_work poll_queue;
 };
 
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
+	int num_tbps;	/* Number of tbp entries */
+	struct thermal_bind_params *tbp;
+};
+
 struct thermal_genl_event {
 	u32 orig;
 	enum events event;
-- 
1.7.9.5

