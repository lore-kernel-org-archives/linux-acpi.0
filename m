From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 12/16] Thermal: Rename thermal_instance.node to thermal_instance.tz_node.
Date: Thu, 19 Jul 2012 14:31:16 +0800
Message-ID: <1342679480-5336-13-git-send-email-rui.zhang@intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61928 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802Ab2GSGcB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 02:32:01 -0400
In-Reply-To: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>

thermal_instance should be referenced by both thermal zone devices
and thermal cooling devices.

Rename thermal_instance.node to thermal_instance.tz_node in this patch
and thermal_instanace.cdev_node will be introduced in next patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 1836039..5a5f916 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -56,7 +56,7 @@ struct thermal_instance {
 	unsigned long lower;	/* Lowest cooling state for this trip point */
 	char attr_name[THERMAL_NAME_LENGTH];
 	struct device_attribute attr;
-	struct list_head node;
+	struct list_head tz_node; /* node in tz->instances */
 };
 
 static DEFINE_IDR(thermal_tz_idr);
@@ -746,7 +746,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
 		/* Heating up? */
 		if (trend > 0) {
 			list_for_each_entry(instance, &tz->instances,
-					    node) {
+					    tz_node) {
 				if (instance->trip != trip)
 					continue;
 				cdev = instance->cdev;
@@ -757,7 +757,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
 			}
 		} else if (trend < 0) { /* Cooling off? */
 			list_for_each_entry(instance, &tz->instances,
-					    node) {
+					    tz_node) {
 				if (instance->trip != trip)
 					continue;
 				cdev = instance->cdev;
@@ -777,7 +777,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
 	 * and avoid thrashing around the passive trip point.  Note that we
 	 * assume symmetry.
 	 */
-	list_for_each_entry(instance, &tz->instances, node) {
+	list_for_each_entry(instance, &tz->instances, tz_node) {
 		if (instance->trip != trip)
 			continue;
 		cdev = instance->cdev;
@@ -873,13 +873,13 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 		goto remove_symbol_link;
 
 	mutex_lock(&tz->lock);
-	list_for_each_entry(pos, &tz->instances, node)
+	list_for_each_entry(pos, &tz->instances, tz_node)
 	    if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 		result = -EEXIST;
 		break;
 	}
 	if (!result)
-		list_add_tail(&dev->node, &tz->instances);
+		list_add_tail(&dev->tz_node, &tz->instances);
 	mutex_unlock(&tz->lock);
 
 	if (!result)
@@ -912,9 +912,9 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 	struct thermal_instance *pos, *next;
 
 	mutex_lock(&tz->lock);
-	list_for_each_entry_safe(pos, next, &tz->instances, node) {
+	list_for_each_entry_safe(pos, next, &tz->instances, tz_node) {
 		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
-			list_del(&pos->node);
+			list_del(&pos->tz_node);
 			mutex_unlock(&tz->lock);
 			goto unbind;
 		}
@@ -1106,7 +1106,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
 	if (temp >= trip_temp) {
 		thermal_get_trend(tz, trip, &trend);
 
-		list_for_each_entry(instance, &tz->instances, node) {
+		list_for_each_entry(instance, &tz->instances, tz_node) {
 			if (instance->trip != trip)
 				continue;
 
@@ -1125,7 +1125,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
 			cdev->ops->set_cur_state(cdev, cur_state);
 		}
 	} else {	/* below trip */
-		list_for_each_entry(instance, &tz->instances, node) {
+		list_for_each_entry(instance, &tz->instances, tz_node) {
 			if (instance->trip != trip)
 				continue;
 
-- 
1.7.9.5

