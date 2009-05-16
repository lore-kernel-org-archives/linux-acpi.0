From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/19] thermal: fix off-by-1 error in trip point trigger
 condition
Date: Sat, 16 May 2009 02:02:09 -0400
Message-ID: <29321357ac6db54eeb8574da1f6c3e0ce8cfbb60.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:16412 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbZEPGC2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:28 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ008WJ3G2FF0L@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:26 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Vladimir Zajac <eightgraph@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Vladimir Zajac <eightgraph@gmail.com>

This patch fixes a regression caused by commit
b1569e99c795bf83b4ddf41c4f1c42761ab7f75e
"ACPI: move thermal trip handling to generic thermal layer"
which accidentally changed trip point trigger condition to
  temp > trip_temp

This patch changes the trigger condition back to
  temp >= trip_temp

Signed-off-by: Vladimir Zajac <eightgraph@gmail.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index d0b093b..5e38ba1 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -961,7 +961,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 
 		switch (trip_type) {
 		case THERMAL_TRIP_CRITICAL:
-			if (temp > trip_temp) {
+			if (temp >= trip_temp) {
 				if (tz->ops->notify)
 					ret = tz->ops->notify(tz, count,
 							      trip_type);
@@ -974,7 +974,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 			}
 			break;
 		case THERMAL_TRIP_HOT:
-			if (temp > trip_temp)
+			if (temp >= trip_temp)
 				if (tz->ops->notify)
 					tz->ops->notify(tz, count, trip_type);
 			break;
@@ -986,14 +986,14 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 
 				cdev = instance->cdev;
 
-				if (temp > trip_temp)
+				if (temp >= trip_temp)
 					cdev->ops->set_cur_state(cdev, 1);
 				else
 					cdev->ops->set_cur_state(cdev, 0);
 			}
 			break;
 		case THERMAL_TRIP_PASSIVE:
-			if (temp > trip_temp || tz->passive)
+			if (temp >= trip_temp || tz->passive)
 				thermal_zone_device_passive(tz, temp,
 							    trip_temp, count);
 			break;
-- 
1.6.0.6

