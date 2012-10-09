From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/30] thermal: Exynos: Fix NULL pointer dereference in exynos_unregister_thermal()
Date: Tue,  9 Oct 2012 01:54:15 -0400
Message-ID: <c072fed95c9855a920c114d7fa3351f0f54ea06e.1349761836.git.len.brown@intel.com>
References: <1349762060-25334-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349762060-25334-1-git-send-email-lenb@kernel.org>
In-Reply-To: <e3f25e6e5836c4790fbe395ff42e241f372d859d.1349761836.git.len.brown@intel.com>
References: <e3f25e6e5836c4790fbe395ff42e241f372d859d.1349761836.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Sachin Kamat <sachin.kamat@linaro.org>

exynos_unregister_thermal() is functional only when 'th_zone' is not
NULL (ensured by the NULL checks). However, in the event it is NULL, it
gets dereferenced in the for loop. This patch fixes this issue.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/thermal/exynos_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index e84acde..fd03e85 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -475,11 +475,14 @@ static void exynos_unregister_thermal(void)
 {
 	int i;
 
-	if (th_zone && th_zone->therm_dev)
+	if (!th_zone)
+		return;
+
+	if (th_zone->therm_dev)
 		thermal_zone_device_unregister(th_zone->therm_dev);
 
 	for (i = 0; i < th_zone->cool_dev_size; i++) {
-		if (th_zone && th_zone->cool_dev[i])
+		if (th_zone->cool_dev[i])
 			cpufreq_cooling_unregister(th_zone->cool_dev[i]);
 	}
 
-- 
1.8.0.rc1
