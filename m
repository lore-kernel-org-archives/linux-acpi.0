From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/30] Thermal: Introduce multiple cooling states support
Date: Tue,  9 Oct 2012 01:53:51 -0400
Message-ID: <e3f25e6e5836c4790fbe395ff42e241f372d859d.1349761836.git.len.brown@intel.com>
References: <1349762060-25334-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349762060-25334-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

This is because general active cooling devices, like fans,
may have multiple speeds, which can be mapped to different cooling states.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>
Reviewed-by: Valentin, Eduardo <eduardo.valentin@ti.com>
---
 drivers/thermal/thermal_sys.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 2ab31e4..dc4044b 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1059,6 +1059,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 	enum thermal_trip_type trip_type;
 	struct thermal_cooling_device_instance *instance;
 	struct thermal_cooling_device *cdev;
+	unsigned long cur_state, max_state;
 
 	mutex_lock(&tz->lock);
 
@@ -1098,10 +1099,17 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 
 				cdev = instance->cdev;
 
+				cdev->ops->get_cur_state(cdev, &cur_state);
+				cdev->ops->get_max_state(cdev, &max_state);
+
 				if (temp >= trip_temp)
-					cdev->ops->set_cur_state(cdev, 1);
+					cur_state = cur_state < max_state ?
+						(cur_state + 1) : max_state;
 				else
-					cdev->ops->set_cur_state(cdev, 0);
+					cur_state = cur_state > 0 ?
+						(cur_state - 1) : 0;
+
+				cdev->ops->set_cur_state(cdev, cur_state);
 			}
 			break;
 		case THERMAL_TRIP_PASSIVE:
-- 
1.8.0.rc1
