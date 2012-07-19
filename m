From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 13/16] Thermal: List thermal_instance in thermal_cooling_device.
Date: Thu, 19 Jul 2012 14:31:17 +0800
Message-ID: <1342679480-5336-14-git-send-email-rui.zhang@intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61928 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802Ab2GSGcF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 02:32:05 -0400
In-Reply-To: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>

so that cooling device can know the cooling state requirement
of all the thermal instances.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |    7 ++++++-
 include/linux/thermal.h       |    1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 5a5f916..48b2668 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -57,6 +57,7 @@ struct thermal_instance {
 	char attr_name[THERMAL_NAME_LENGTH];
 	struct device_attribute attr;
 	struct list_head tz_node; /* node in tz->instances */
+	struct list_head cdev_node; /* node in cdev->instances */
 };
 
 static DEFINE_IDR(thermal_tz_idr);
@@ -878,8 +879,10 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 		result = -EEXIST;
 		break;
 	}
-	if (!result)
+	if (!result) {
 		list_add_tail(&dev->tz_node, &tz->instances);
+		list_add_tail(&dev->cdev_node, &cdev->instances);
+	}
 	mutex_unlock(&tz->lock);
 
 	if (!result)
@@ -915,6 +918,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 	list_for_each_entry_safe(pos, next, &tz->instances, tz_node) {
 		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->tz_node);
+			list_del(&pos->cdev_node);
 			mutex_unlock(&tz->lock);
 			goto unbind;
 		}
@@ -984,6 +988,7 @@ thermal_cooling_device_register(char *type, void *devdata,
 	}
 
 	strcpy(cdev->type, type);
+	INIT_LIST_HEAD(&cdev->instances);
 	cdev->ops = ops;
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a15b83c..d8e069e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -92,6 +92,7 @@ struct thermal_cooling_device {
 	struct device device;
 	void *devdata;
 	const struct thermal_cooling_device_ops *ops;
+	struct list_head instances;
 	struct list_head node;
 };
 
-- 
1.7.9.5

