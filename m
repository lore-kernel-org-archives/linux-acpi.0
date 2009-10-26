From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 4/6] thermal: add sanity check for the passive attribute
Date: Mon, 26 Oct 2009 08:39:02 +0100
Message-ID: <1256542744-26569-5-git-send-email-elendil@planet.nl>
References: <1256542744-26569-1-git-send-email-elendil@planet.nl>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754958AbZJZHjN@vger.kernel.org>
In-Reply-To: <1256542744-26569-1-git-send-email-elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, Frans Pop <elendil@planet.nl>, Matthew Garrett <mjg@redhat.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

Values below 1000 milli-celsius don't make sense and can cause the
system to go into a thermal heart attack: the actual temperature
will always be lower and thus the system will be throttled down to
its lowest setting.

An additional problem is that values below 1000 will show as 0 in
/proc/acpi/thermal/TZx/trip_points:passive.

cat passive
0
echo -n 90 >passive
bash: echo: write error: Invalid argument
echo -n 90000 >passive
cat passive
90000

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/thermal/sysfs-api.txt |    1 +
 drivers/thermal/thermal_sys.c       |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index a87dc27..cb3d15b 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -206,6 +206,7 @@ passive
 	passive trip point for the zone. Activation is done by polling with
 	an interval of 1 second.
 	Unit: millidegrees Celsius
+	Valid values: 0 (disabled) or greater than 1000
 	RW, Optional
 
 *****************************
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 4e83c29..74d2eb5 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -225,6 +225,12 @@ passive_store(struct device *dev, struct device_attribute *attr,
 	if (!sscanf(buf, "%d\n", &state))
 		return -EINVAL;
 
+	/* sanity check: values below 1000 millicelcius don't make sense
+	 * and can cause the system to go into a thermal heart attack
+	 */
+	if (state && state < 1000)
+		return -EINVAL;
+
 	if (state && !tz->forced_passive) {
 		mutex_lock(&thermal_list_lock);
 		list_for_each_entry(cdev, &thermal_cdev_list, node) {
-- 
1.5.6.5
