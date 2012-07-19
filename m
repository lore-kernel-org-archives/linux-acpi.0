From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 04/16] Thermal: Introduce multiple cooling states support
Date: Thu, 19 Jul 2012 14:31:08 +0800
Message-ID: <1342679480-5336-5-git-send-email-rui.zhang@intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61928 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab2GSGbn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 02:31:43 -0400
In-Reply-To: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>

This is because general active cooling devices, like fans,
may have multiple speeds, which can be mapped to different cooling states.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 95e0d63..63927e3 100644
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
1.7.9.5

