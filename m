From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 4/6] thermal: add sanity check for the passive attribute
Date: Wed, 26 Aug 2009 18:17:23 +0200
Message-ID: <1251303445-25317-5-git-send-email-elendil@planet.nl>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751917AbZHZQR4@vger.kernel.org>
In-Reply-To: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, Matthew Garrett <mjg@redhat.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

Values below 40000 milli-celsius (limit is somewhat arbitrary)
don't make sense and can cause the system to go into a thermal
heart attack: the actual temperature will always be lower and
thus the system will be throttled down to its lowest setting.

For values below 1000 an additional problem is that they would
show as 0 in /proc/acpi/thermal/TZx/trip_points:passive.

cat passive
0
echo -n 90000 >passive
cat passive
90000
echo -n 30000 >passive
bash: echo: write error: Invalid argument

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 2a036eb..09d5c88 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -206,6 +206,7 @@ passive
 	point for the zone. Activation is done by polling with an interval
 	of 1 second.
 	Unit: millidegrees Celsius
+	Minimum value: 40000
 	RW, Optional
 
 *****************************
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 0a69672..2d13d0d 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -225,6 +225,12 @@ passive_store(struct device *dev, struct device_attribute *attr,
 	if (!sscanf(buf, "%d\n", &state))
 		return -EINVAL;
 
+	/* sanity check: values below 40000 millicelcius don't make sense
+	 * and can cause the system to go into a thermal heart attack
+	 */
+	if (state && state < 40000)
+		return -EINVAL;
+
 	if (state && !tz->forced_passive) {
 		mutex_lock(&thermal_list_lock);
 		list_for_each_entry(cdev, &thermal_cdev_list, node) {
