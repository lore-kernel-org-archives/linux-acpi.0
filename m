From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 2/2] thermal: core: introduce thermal zone device mode control
Date: Mon,  3 Jul 2017 10:00:40 +0200
Message-ID: <20170703080040.13750-2-enric.balletbo@collabora.com>
References: <20170703080040.13750-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170703080040.13750-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guenter Roeck <groeck@chromium.org>, Sameer Nanda <snanda@chromium.org>
List-Id: linux-acpi@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Thermal "mode" sysfs attribute is introduced to enable/disable a thermal zone,
and .get_mode()/.set_mode() callback is introduced for platform thermal driver
to enable/disable the hardware thermal control logic. And thermal core takes
no action upon thermal zone enable/disable.

Actually, this is not quite right because thermal core still pokes those
disabled thermal zones occasionally, e.g. upon system resume.

To fix this, a new flag 'mode' is introduced in struct thermal_zone_device
to represent the thermal zone mode, and several decisions have been made
based on this flag, including
1. check the thermal zone mode right after it's registered.
2. skip updating thermal zone if the zone is disabled
3. stop the polling timer when the thermal zone is disabled

Note: basically, this patch doesn't affect the existing always-enabled
thermal zones much, with just one exception -
thermal zone .get_mode() must be well prepared to reflect the real thermal
zone status upon the thermal zone registration.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v2:
 - Rework by Zhang Rui.
Changes since v1:
 - Implement in thermal subsystem instead of ACPI thermal driver (Zhang Rui)

 drivers/thermal/thermal_core.c  | 37 +++++++++++++++++++++++++++++++++++--
 drivers/thermal/thermal_sysfs.c | 22 ++++++----------------
 include/linux/thermal.h         |  3 +++
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5a51c74..1959257 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -306,9 +306,9 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 {
 	mutex_lock(&tz->lock);
 
-	if (tz->passive)
+	if (tz->mode == THERMAL_DEVICE_ENABLED && tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay);
-	else if (tz->polling_delay)
+	else if (tz->mode == THERMAL_DEVICE_ENABLED && tz->polling_delay)
 		thermal_zone_device_set_polling(tz, tz->polling_delay);
 	else
 		thermal_zone_device_set_polling(tz, 0);
@@ -464,11 +464,35 @@ static void thermal_zone_device_reset(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
+int thermal_zone_set_mode(struct thermal_zone_device *tz,
+				 enum thermal_device_mode mode)
+{
+	int result;
+
+	if (!tz->ops->set_mode)
+		return -EPERM;
+
+	result = tz->ops->set_mode(tz, mode);
+	if (result)
+		return result;
+
+	if (tz->mode != mode) {
+		tz->mode = mode;
+		monitor_thermal_zone(tz);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_set_mode);
+
 void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
 	int count;
 
+	/* Do nothing if the thermal zone is disabled */
+	if (tz->mode == THERMAL_DEVICE_DISABLED)
+		return;
+
 	if (atomic_read(&in_suspend))
 		return;
 
@@ -1287,6 +1311,15 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
 	thermal_zone_device_reset(tz);
+
+	if (tz->ops->get_mode) {
+		enum thermal_device_mode mode;
+
+		result = tz->ops->get_mode(tz, &mode);
+		tz->mode = result ? THERMAL_DEVICE_ENABLED : mode;
+	} else
+		tz->mode = THERMAL_DEVICE_ENABLED;
+
 	/* Update the new thermal zone and mark it as already updated. */
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
 		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index a694de9..1b25dc8 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -51,17 +51,8 @@ static ssize_t
 mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	enum thermal_device_mode mode;
-	int result;
-
-	if (!tz->ops->get_mode)
-		return -EPERM;
 
-	result = tz->ops->get_mode(tz, &mode);
-	if (result)
-		return result;
-
-	return sprintf(buf, "%s\n", mode == THERMAL_DEVICE_ENABLED ? "enabled"
+	return sprintf(buf, "%s\n", tz->mode == THERMAL_DEVICE_ENABLED ? "enabled"
 		       : "disabled");
 }
 
@@ -70,18 +61,17 @@ mode_store(struct device *dev, struct device_attribute *attr,
 	   const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	enum thermal_device_mode mode;
 	int result;
 
-	if (!tz->ops->set_mode)
-		return -EPERM;
-
 	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
-		result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
+		mode = THERMAL_DEVICE_ENABLED;
 	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
-		result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
+		mode = THERMAL_DEVICE_DISABLED;
 	else
-		result = -EINVAL;
+		return -EINVAL;
 
+	result = thermal_zone_set_mode(tz, mode);
 	if (result)
 		return result;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index dab11f9..2f427de 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -210,6 +210,7 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_type_attrs;
 	struct thermal_attr *trip_hyst_attrs;
 	void *devdata;
+	enum thermal_device_mode mode;
 	int trips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
 	int passive_delay;
@@ -465,6 +466,8 @@ struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
+int thermal_zone_set_mode(struct thermal_zone_device *tz,
+			  enum thermal_device_mode mode);
 
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
-- 
2.9.3
