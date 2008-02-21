From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/26] thermal: use ERR_PTR for returning error
Date: Thu, 21 Feb 2008 04:25:16 -0500
Message-ID: <3e6fda5c1159823fc02463eceb564c8bfc0e7a0e.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36627 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756306AbYBUJ3G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:06 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Sujith <sujith.thomas@intel.com>

Need to return using ERR_PTR instead of NULL
in case of errors.

Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/thermal.c b/drivers/thermal/thermal.c
index 5f1d318..8b86e53 100644
--- a/drivers/thermal/thermal.c
+++ b/drivers/thermal/thermal.c
@@ -448,20 +448,20 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *type,
 	int result;
 
 	if (strlen(type) >= THERMAL_NAME_LENGTH)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
 	    !ops->set_cur_state)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	cdev = kzalloc(sizeof(struct thermal_cooling_device), GFP_KERNEL);
 	if (!cdev)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	result = get_idr(&thermal_cdev_idr, &thermal_idr_lock, &cdev->id);
 	if (result) {
 		kfree(cdev);
-		return NULL;
+		return ERR_PTR(result);
 	}
 
 	strcpy(cdev->type, type);
@@ -473,7 +473,7 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *type,
 	if (result) {
 		release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
 		kfree(cdev);
-		return NULL;
+		return ERR_PTR(result);
 	}
 
 	/* sys I/F */
@@ -509,7 +509,7 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *type,
       unregister:
 	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
 	device_unregister(&cdev->device);
-	return NULL;
+	return ERR_PTR(result);
 }
 
 EXPORT_SYMBOL(thermal_cooling_device_register);
@@ -581,17 +581,17 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 	int count;
 
 	if (strlen(type) >= THERMAL_NAME_LENGTH)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	if (trips > THERMAL_MAX_TRIPS || trips < 0)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	if (!ops || !ops->get_temp)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	tz = kzalloc(sizeof(struct thermal_zone_device), GFP_KERNEL);
 	if (!tz)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&tz->cooling_devices);
 	idr_init(&tz->idr);
@@ -599,7 +599,7 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 	result = get_idr(&thermal_tz_idr, &thermal_idr_lock, &tz->id);
 	if (result) {
 		kfree(tz);
-		return NULL;
+		return ERR_PTR(result);
 	}
 
 	strcpy(tz->type, type);
@@ -612,7 +612,7 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 	if (result) {
 		release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
 		kfree(tz);
-		return NULL;
+		return ERR_PTR(result);
 	}
 
 	/* sys I/F */
@@ -654,7 +654,7 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
       unregister:
 	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
 	device_unregister(&tz->device);
-	return NULL;
+	return ERR_PTR(result);
 }
 
 EXPORT_SYMBOL(thermal_zone_device_register);
-- 
1.5.4.2

