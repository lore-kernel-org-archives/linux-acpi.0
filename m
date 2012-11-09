From: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Subject: [PATCH 4/4] thermal: exynos: Use the new thermal trend type for quick cooling action.
Date: Fri,  9 Nov 2012 10:34:04 +0530
Message-ID: <1352437444-13546-1-git-send-email-amit.kachhap@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, durgadoss.r@intel.com, lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org, amit.kachhap@linaro.org, jonghwa3.lee@samsung.com
List-Id: linux-acpi@vger.kernel.org

This patch uses the quick thermal cooling trend type macros. This is needed
as exynos5 and other thermal sensors now supports only interrupt method for
thresold temperature check.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
---
 drivers/thermal/exynos_thermal.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index bbaff56..097c218 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -287,7 +287,7 @@ static int exynos_bind(struct thermal_zone_device *thermal,
 		case MONITOR_ZONE:
 		case WARN_ZONE:
 			if (thermal_zone_bind_cooling_device(thermal, i, cdev,
-								level, level)) {
+								level, 0)) {
 				pr_err("error binding cdev inst %d\n", i);
 				ret = -EINVAL;
 			}
@@ -373,9 +373,9 @@ static int exynos_get_trend(struct thermal_zone_device *thermal,
 		return ret;
 
 	if (thermal->temperature >= trip_temp)
-		*trend = THERMAL_TREND_RAISING;
+		*trend = THERMAL_TREND_RAISE_FULL;
 	else
-		*trend = THERMAL_TREND_DROPPING;
+		*trend = THERMAL_TREND_DROP_FULL;
 
 	return ret;
 }
-- 
1.7.1
