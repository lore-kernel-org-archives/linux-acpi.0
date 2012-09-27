From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH] Thermal: Fix synchronization issues in thermal_sys.c
Date: Thu, 27 Sep 2012 11:38:03 +0530
Message-ID: <1348726083-8540-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15124 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755095Ab2I0GJE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Sep 2012 02:09:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, dan.carpenter@oracle.com, hughd@google.com, linux-next@vger.kernel.org, Durgadoss R <durgadoss.r@intel.com>

This patch fixes the following mutex and NULL pointer
problems in thermal_sys.c:
 * mutex_unlock fix in update_temperature function
 * mutex_unlock/NULL check fix in bind_cdev function
 * NULL check fix in bind_tz function

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 4f77d89..848553d 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -252,8 +252,8 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 		}
 
 		tzp = pos->tzp;
-		if (!tzp->tbp)
-			return;
+		if (!tzp || !tzp->tbp)
+			continue;
 
 		for (i = 0; i < tzp->num_tbps; i++) {
 			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
@@ -289,7 +289,7 @@ static void bind_tz(struct thermal_zone_device *tz)
 		goto exit;
 	}
 
-	if (!tzp->tbp)
+	if (!tzp || !tzp->tbp)
 		goto exit;
 
 	list_for_each_entry(pos, &thermal_cdev_list, node) {
@@ -390,12 +390,13 @@ static void update_temperature(struct thermal_zone_device *tz)
 	ret = tz->ops->get_temp(tz, &temp);
 	if (ret) {
 		pr_warn("failed to read out thermal zone %d\n", tz->id);
-		return;
+		goto exit;
 	}
 
 	tz->last_temperature = tz->temperature;
 	tz->temperature = temp;
 
+exit:
 	mutex_unlock(&tz->lock);
 }
 
-- 
1.7.9.5

