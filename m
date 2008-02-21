From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/26] thermal: validate input parameters
Date: Thu, 21 Feb 2008 04:37:48 -0500
Message-ID: <c751670902c3dd9abbed279170a832e6a1e6cf94.1203586624.git.len.brown@intel.com>
References: <1203586691-1234-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22155 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbYBUJiz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 04:38:55 -0500
In-Reply-To: <1203586691-1234-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Sujith <sujith.thomas@intel.com>

Added sanity check to make sure that thermal zone
and cooling device exists.

Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/thermal.c b/drivers/thermal/thermal.c
index e782b3e..5f1d318 100644
--- a/drivers/thermal/thermal.c
+++ b/drivers/thermal/thermal.c
@@ -306,12 +306,23 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 {
 	struct thermal_cooling_device_instance *dev;
 	struct thermal_cooling_device_instance *pos;
+	struct thermal_zone_device *pos1;
+	struct thermal_cooling_device *pos2;
 	int result;
 
 	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
 		return -EINVAL;
 
-	if (!tz || !cdev)
+	list_for_each_entry(pos1, &thermal_tz_list, node) {
+		if (pos1 == tz)
+			break;
+	}
+	list_for_each_entry(pos2, &thermal_cdev_list, node) {
+		if (pos2 == cdev)
+			break;
+	}
+
+	if (tz != pos1 || cdev != pos2)
 		return -EINVAL;
 
 	dev =
-- 
1.5.4

