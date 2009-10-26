From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 5/6] thermal: Only set passive_delay for forced_passive cooling
Date: Mon, 26 Oct 2009 08:39:03 +0100
Message-ID: <1256542744-26569-6-git-send-email-elendil@planet.nl>
References: <1256542744-26569-1-git-send-email-elendil@planet.nl>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755026AbZJZHkG@vger.kernel.org>
In-Reply-To: <1256542744-26569-1-git-send-email-elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, Frans Pop <elendil@planet.nl>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

Setting polling_delay is useless as passive_delay has priority,
so the value shown in proc isn't the actual polling delay. It
also gives the impression to the user that he can change the
polling interval through proc, while in fact he can't.

Also, unset passive_delay when the forced passive trip point is
unbound to allow polling to be disabled.

Signed-off-by: Frans Pop <elendil@planet.nl>
Acked-by: Matthew Garrett <mjg@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 74d2eb5..fc5e92e 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -241,6 +241,8 @@ passive_store(struct device *dev, struct device_attribute *attr,
 								 cdev);
 		}
 		mutex_unlock(&thermal_list_lock);
+		if (!tz->passive_delay)
+			tz->passive_delay = 1000;
 	} else if (!state && tz->forced_passive) {
 		mutex_lock(&thermal_list_lock);
 		list_for_each_entry(cdev, &thermal_cdev_list, node) {
@@ -251,17 +253,12 @@ passive_store(struct device *dev, struct device_attribute *attr,
 								   cdev);
 		}
 		mutex_unlock(&thermal_list_lock);
+		tz->passive_delay = 0;
 	}
 
 	tz->tc1 = 1;
 	tz->tc2 = 1;
 
-	if (!tz->passive_delay)
-		tz->passive_delay = 1000;
-
-	if (!tz->polling_delay)
-		tz->polling_delay = 10000;
-
 	tz->forced_passive = state;
 
 	thermal_zone_device_update(tz);
-- 
1.5.6.5
