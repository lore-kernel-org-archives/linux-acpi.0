From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv2] Thermal: Fix synchronization issues in thermal_sys.c
Date: Thu, 27 Sep 2012 12:08:08 +0530
Message-ID: <1348727888-11196-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, dan.carpenter@oracle.com, hughd@google.com, linux-next@vger.kernel.org, Durgadoss R <durgadoss.r@intel.com>
List-Id: linux-acpi@vger.kernel.org

This patch fixes the following mutex and NULL pointer
problems in thermal_sys.c:
 * mutex_unlock fix in update_temperature function
 * mutex_unlock fix in bind_cdev function
 * NULL check fix in bind_tz function

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
v2:
 * Removed unnecessary NULL check in bind_cdev
 * Added 'Reported-by' tags for Sedat and Hugh
 drivers/thermal/thermal_sys.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 4f77d89..e1179d3 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -253,7 +253,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 
 		tzp = pos->tzp;
 		if (!tzp->tbp)
-			return;
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
