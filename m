From: akpm@linux-foundation.org
Subject: [patch 08/12] thermal: add sanity check for the passive attribute
Date: Tue, 17 Nov 2009 14:27:35 -0800
Message-ID: <200911172227.nAHMRZX8023365@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59529 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756411AbZKQW3F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 17:29:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, elendil@planet.nl, mjg@redhat.com, rui.zhang@intel.com

From: Frans Pop <elendil@planet.nl>

Values below 1000 milli-celsius don't make sense and can cause the system
to go into a thermal heart attack: the actual temperature will always be
lower and thus the system will be throttled down to its lowest setting.

An additional problem is that values below 1000 will show as 0 in
/proc/acpi/thermal/TZx/trip_points:passive.

cat passive
0
echo -n 90 >passive
bash: echo: write error: Invalid argument
echo -n 90000 >passive
cat passive
90000

Addresses http://bugzilla.kernel.org/show_bug.cgi?id=13918

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/thermal/sysfs-api.txt |    1 +
 drivers/thermal/thermal_sys.c       |    6 ++++++
 2 files changed, 7 insertions(+)

diff -puN Documentation/thermal/sysfs-api.txt~thermal-add-sanity-check-for-the-passive-attribute Documentation/thermal/sysfs-api.txt
--- a/Documentation/thermal/sysfs-api.txt~thermal-add-sanity-check-for-the-passive-attribute
+++ a/Documentation/thermal/sysfs-api.txt
@@ -206,6 +206,7 @@ passive
 	passive trip point for the zone. Activation is done by polling with
 	an interval of 1 second.
 	Unit: millidegrees Celsius
+	Valid values: 0 (disabled) or greater than 1000
 	RW, Optional
 
 *****************************
diff -puN drivers/thermal/thermal_sys.c~thermal-add-sanity-check-for-the-passive-attribute drivers/thermal/thermal_sys.c
--- a/drivers/thermal/thermal_sys.c~thermal-add-sanity-check-for-the-passive-attribute
+++ a/drivers/thermal/thermal_sys.c
@@ -225,6 +225,12 @@ passive_store(struct device *dev, struct
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
_
