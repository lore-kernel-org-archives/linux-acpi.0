From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv4 01/15] Thermal: Refactor thermal.h file
Date: Tue, 18 Sep 2012 11:04:52 +0530
Message-ID: <1347946506-18449-2-git-send-email-durgadoss.r@intel.com>
References: <1347946506-18449-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28021 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791Ab2IRFgE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2012 01:36:04 -0400
In-Reply-To: <1347946506-18449-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch rearranges the code in thermal.h file,
in the following order, so that it is easy to
read/maintain.
1. All #defines
2. All enums
3. All fops structures
4. All device structures
5. All function declarations

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 include/linux/thermal.h |   78 ++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 91b3481..8611e3e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -29,6 +29,23 @@
 #include <linux/device.h>
 #include <linux/workqueue.h>
 
+#define THERMAL_TRIPS_NONE	-1
+#define THERMAL_MAX_TRIPS	12
+#define THERMAL_NAME_LENGTH	20
+
+/* No upper/lower limit requirement */
+#define THERMAL_NO_LIMIT	-1UL
+
+/* Unit conversion macros */
+#define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
+				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
+#define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
+
+/* Adding event notification support elements */
+#define THERMAL_GENL_FAMILY_NAME                "thermal_event"
+#define THERMAL_GENL_VERSION                    0x01
+#define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_group"
+
 struct thermal_zone_device;
 struct thermal_cooling_device;
 
@@ -50,6 +67,30 @@ enum thermal_trend {
 	THERMAL_TREND_DROPPING, /* temperature is dropping */
 };
 
+/* Events supported by Thermal Netlink */
+enum events {
+	THERMAL_AUX0,
+	THERMAL_AUX1,
+	THERMAL_CRITICAL,
+	THERMAL_DEV_FAULT,
+};
+
+/* attributes of thermal_genl_family */
+enum {
+	THERMAL_GENL_ATTR_UNSPEC,
+	THERMAL_GENL_ATTR_EVENT,
+	__THERMAL_GENL_ATTR_MAX,
+};
+#define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
+
+/* commands supported by the thermal_genl_family */
+enum {
+	THERMAL_GENL_CMD_UNSPEC,
+	THERMAL_GENL_CMD_EVENT,
+	__THERMAL_GENL_CMD_MAX,
+};
+#define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
+
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
@@ -83,11 +124,6 @@ struct thermal_cooling_device_ops {
 	int (*set_cur_state) (struct thermal_cooling_device *, unsigned long);
 };
 
-#define THERMAL_NO_LIMIT -1UL /* no upper/lower limit requirement */
-
-#define THERMAL_TRIPS_NONE -1
-#define THERMAL_MAX_TRIPS 12
-#define THERMAL_NAME_LENGTH 20
 struct thermal_cooling_device {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
@@ -100,10 +136,6 @@ struct thermal_cooling_device {
 	struct list_head node;
 };
 
-#define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
-				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
-#define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
-
 struct thermal_attr {
 	struct device_attribute attr;
 	char name[THERMAL_NAME_LENGTH];
@@ -131,38 +163,13 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 };
-/* Adding event notification support elements */
-#define THERMAL_GENL_FAMILY_NAME                "thermal_event"
-#define THERMAL_GENL_VERSION                    0x01
-#define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_group"
-
-enum events {
-	THERMAL_AUX0,
-	THERMAL_AUX1,
-	THERMAL_CRITICAL,
-	THERMAL_DEV_FAULT,
-};
 
 struct thermal_genl_event {
 	u32 orig;
 	enum events event;
 };
-/* attributes of thermal_genl_family */
-enum {
-	THERMAL_GENL_ATTR_UNSPEC,
-	THERMAL_GENL_ATTR_EVENT,
-	__THERMAL_GENL_ATTR_MAX,
-};
-#define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
-
-/* commands supported by the thermal_genl_family */
-enum {
-	THERMAL_GENL_CMD_UNSPEC,
-	THERMAL_GENL_CMD_EVENT,
-	__THERMAL_GENL_CMD_MAX,
-};
-#define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
 
+/* Function declarations */
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, const struct thermal_zone_device_ops *, int, int);
 void thermal_zone_device_unregister(struct thermal_zone_device *);
@@ -173,6 +180,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *);
+
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 		const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
-- 
1.7.9.5

