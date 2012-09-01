From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv3 12/15] Thermal: Register a governor for user space
Date: Sat,  1 Sep 2012 17:21:33 +0530
Message-ID: <1346500296-25200-13-git-send-email-durgadoss.r@intel.com>
References: <1346500296-25200-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:45763 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755530Ab2IALws (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Sep 2012 07:52:48 -0400
In-Reply-To: <1346500296-25200-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch registers a governor which will let the
user land manage the platform thermals. Whenever a
trip happens, this governor just notifies the user
space using kobj_uevent().

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |   18 ++++++++++++++++++
 include/linux/thermal.h       |    2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 936b025..93672aa 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -130,6 +130,15 @@ exit:
 }
 EXPORT_SYMBOL_GPL(thermal_unregister_governor);
 
+static int notify_user_space(struct thermal_zone_device *tz, int trip)
+{
+	mutex_lock(&tz->lock);
+	kobject_uevent(&tz->device.kobj, KOBJ_CHANGE);
+	mutex_unlock(&tz->lock);
+
+	return 0;
+}
+
 static int get_idr(struct idr *idr, struct mutex *lock, int *id)
 {
 	int err;
@@ -1860,6 +1869,12 @@ static inline int genetlink_init(void) { return 0; }
 static inline void genetlink_exit(void) {}
 #endif /* !CONFIG_NET */
 
+struct thermal_governor thermal_gov_user_space = {
+	.name		= USER_SPACE_THERMAL_GOVERNOR,
+	.throttle	= notify_user_space,
+	.owner		= THIS_MODULE,
+};
+
 static int __init thermal_init(void)
 {
 	int result = 0;
@@ -1871,6 +1886,8 @@ static int __init thermal_init(void)
 		mutex_destroy(&thermal_idr_lock);
 		mutex_destroy(&thermal_list_lock);
 	}
+	/* Register a governor to notify user space */
+	thermal_register_governor(&thermal_gov_user_space);
 	result = genetlink_init();
 	return result;
 }
@@ -1882,6 +1899,7 @@ static void __exit thermal_exit(void)
 	idr_destroy(&thermal_cdev_idr);
 	mutex_destroy(&thermal_idr_lock);
 	mutex_destroy(&thermal_list_lock);
+	thermal_unregister_governor(&thermal_gov_user_space);
 	genetlink_exit();
 }
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 2bd9158..aa903dd 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -48,6 +48,8 @@
 
 /* Default Thermal Governor: Does Linear Throttling */
 #define DEFAULT_THERMAL_GOVERNOR	"step_wise"
+/* User space Thermal governor */
+#define USER_SPACE_THERMAL_GOVERNOR	"user_space"
 
 struct thermal_zone_device;
 struct thermal_cooling_device;
-- 
1.7.9.5

