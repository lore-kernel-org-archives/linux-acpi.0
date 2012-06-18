From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] Thermal: undo throttling at exit of forced passive mode
Date: Mon, 18 Jun 2012 14:29:24 -0700
Message-ID: <1340054964-25685-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64513 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557Ab2FRVaO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Jun 2012 17:30:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <len.brown@intel.com>, ACPI <linux-acpi@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>

When a thermal zone is in forced passive mode and temperature is above
passive trip point, processors are throttled to various states. However,
when user disables forced passive throttling, the processors could be
left in throttling state even when temperature is below passive trip
points.

This patch fixes the issue by always undo processor throttling when user
exits force passive mode. It is safe in that any subsequent thermal conditions
will still be handled according to trip point settings

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/thermal_sys.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 022bacb..ea867ff 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -250,10 +250,12 @@ passive_store(struct device *dev, struct device_attribute *attr,
 		mutex_lock(&thermal_list_lock);
 		list_for_each_entry(cdev, &thermal_cdev_list, node) {
 			if (!strncmp("Processor", cdev->type,
-				     sizeof("Processor")))
+					sizeof("Processor"))) {
 				thermal_zone_unbind_cooling_device(tz,
 								   THERMAL_TRIPS_NONE,
 								   cdev);
+				cdev->ops->set_cur_state(cdev, 0);
+			}
 		}
 		mutex_unlock(&thermal_list_lock);
 		tz->passive_delay = 0;
-- 
1.7.5.4

