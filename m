From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/27] thermal: split hwmon lookup to a separate function
Date: Tue, 02 Aug 2011 16:53:26 -0400
Message-ID: <0d97d7a494d43be77f57e688369be0aae33d1ade.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab1HBVwI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:52:08 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00IROM2GJRGL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:52:07 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>, Rene Herman <rene.herman@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Jean Delvare <khali@linux-fr.org>

We'll soon need to reuse it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Rene Herman <rene.herman@gmail.com>
Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 0b1c82a..b6353d6 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -469,22 +469,35 @@ temp_crit_show(struct device *dev, struct device_attribute *attr,
 }
 
 
-static int
-thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+static struct thermal_hwmon_device *
+thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
 {
 	struct thermal_hwmon_device *hwmon;
-	int new_hwmon_device = 1;
-	int result;
 
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(hwmon, &thermal_hwmon_list, node)
 		if (!strcmp(hwmon->type, tz->type)) {
-			new_hwmon_device = 0;
 			mutex_unlock(&thermal_list_lock);
-			goto register_sys_interface;
+			return hwmon;
 		}
 	mutex_unlock(&thermal_list_lock);
 
+	return NULL;
+}
+
+static int
+thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+	struct thermal_hwmon_device *hwmon;
+	int new_hwmon_device = 1;
+	int result;
+
+	hwmon = thermal_hwmon_lookup_by_type(tz);
+	if (hwmon) {
+		new_hwmon_device = 0;
+		goto register_sys_interface;
+	}
+
 	hwmon = kzalloc(sizeof(struct thermal_hwmon_device), GFP_KERNEL);
 	if (!hwmon)
 		return -ENOMEM;
-- 
1.7.6.396.ge0613

