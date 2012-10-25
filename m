From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH] Thermal: Remove raw netlink based notification
Date: Thu, 25 Oct 2012 10:45:04 +0530
Message-ID: <1351142104-29944-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44903 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947Ab2JYF0z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Oct 2012 01:26:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, Durgadoss R <durgadoss.r@intel.com>

This patch removes the raw netlink based notification
from the generic thermal layer. Since the thermal
layer has a generic UEvent based notification
mechanism, the old implementation is not required
anymore.

Also, change the initcall to subsys_initcall, which
was there before the netlink change was introduced
in the generic thermal layer.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
* Since we are cleaning up the thermal_sys.c a lot,
  these days, it would be a good time for this change to
  go now.
* Patch is based on Rui's -next tree.
* Patch is only compile tested for various x86 configurations.
 drivers/thermal/thermal_sys.c |  104 +----------------------------------------
 include/linux/thermal.h       |   44 -----------------
 2 files changed, 1 insertion(+), 147 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 8f0f37b..ad4a31a 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -34,8 +34,6 @@
 #include <linux/thermal.h>
 #include <linux/spinlock.h>
 #include <linux/reboot.h>
-#include <net/netlink.h>
-#include <net/genetlink.h>
 
 #include "thermal_core.h"
 
@@ -1698,104 +1696,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL(thermal_zone_device_unregister);
 
-#ifdef CONFIG_NET
-static struct genl_family thermal_event_genl_family = {
-	.id = GENL_ID_GENERATE,
-	.name = THERMAL_GENL_FAMILY_NAME,
-	.version = THERMAL_GENL_VERSION,
-	.maxattr = THERMAL_GENL_ATTR_MAX,
-};
-
-static struct genl_multicast_group thermal_event_mcgrp = {
-	.name = THERMAL_GENL_MCAST_GROUP_NAME,
-};
-
-int thermal_generate_netlink_event(u32 orig, enum events event)
-{
-	struct sk_buff *skb;
-	struct nlattr *attr;
-	struct thermal_genl_event *thermal_event;
-	void *msg_header;
-	int size;
-	int result;
-	static unsigned int thermal_event_seqnum;
-
-	/* allocate memory */
-	size = nla_total_size(sizeof(struct thermal_genl_event)) +
-	       nla_total_size(0);
-
-	skb = genlmsg_new(size, GFP_ATOMIC);
-	if (!skb)
-		return -ENOMEM;
-
-	/* add the genetlink message header */
-	msg_header = genlmsg_put(skb, 0, thermal_event_seqnum++,
-				 &thermal_event_genl_family, 0,
-				 THERMAL_GENL_CMD_EVENT);
-	if (!msg_header) {
-		nlmsg_free(skb);
-		return -ENOMEM;
-	}
-
-	/* fill the data */
-	attr = nla_reserve(skb, THERMAL_GENL_ATTR_EVENT,
-			   sizeof(struct thermal_genl_event));
-
-	if (!attr) {
-		nlmsg_free(skb);
-		return -EINVAL;
-	}
-
-	thermal_event = nla_data(attr);
-	if (!thermal_event) {
-		nlmsg_free(skb);
-		return -EINVAL;
-	}
-
-	memset(thermal_event, 0, sizeof(struct thermal_genl_event));
-
-	thermal_event->orig = orig;
-	thermal_event->event = event;
-
-	/* send multicast genetlink message */
-	result = genlmsg_end(skb, msg_header);
-	if (result < 0) {
-		nlmsg_free(skb);
-		return result;
-	}
-
-	result = genlmsg_multicast(skb, 0, thermal_event_mcgrp.id, GFP_ATOMIC);
-	if (result)
-		pr_info("failed to send netlink event:%d\n", result);
-
-	return result;
-}
-EXPORT_SYMBOL(thermal_generate_netlink_event);
-
-static int genetlink_init(void)
-{
-	int result;
-
-	result = genl_register_family(&thermal_event_genl_family);
-	if (result)
-		return result;
-
-	result = genl_register_mc_group(&thermal_event_genl_family,
-					&thermal_event_mcgrp);
-	if (result)
-		genl_unregister_family(&thermal_event_genl_family);
-	return result;
-}
-
-static void genetlink_exit(void)
-{
-	genl_unregister_family(&thermal_event_genl_family);
-}
-#else /* !CONFIG_NET */
-static inline int genetlink_init(void) { return 0; }
-static inline void genetlink_exit(void) {}
-#endif /* !CONFIG_NET */
-
 static int __init thermal_init(void)
 {
 	int result = 0;
@@ -1807,7 +1707,6 @@ static int __init thermal_init(void)
 		mutex_destroy(&thermal_idr_lock);
 		mutex_destroy(&thermal_list_lock);
 	}
-	result = genetlink_init();
 	return result;
 }
 
@@ -1818,8 +1717,7 @@ static void __exit thermal_exit(void)
 	idr_destroy(&thermal_cdev_idr);
 	mutex_destroy(&thermal_idr_lock);
 	mutex_destroy(&thermal_list_lock);
-	genetlink_exit();
 }
 
-fs_initcall(thermal_init);
+subsys_initcall(thermal_init);
 module_exit(thermal_exit);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 807f214..d04564f 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -41,11 +41,6 @@
 				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
 #define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
 
-/* Adding event notification support elements */
-#define THERMAL_GENL_FAMILY_NAME                "thermal_event"
-#define THERMAL_GENL_VERSION                    0x01
-#define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_group"
-
 /* Default Thermal Governor: Does Linear Throttling */
 #define DEFAULT_THERMAL_GOVERNOR	"step_wise"
 
@@ -70,30 +65,6 @@ enum thermal_trend {
 	THERMAL_TREND_DROPPING, /* temperature is dropping */
 };
 
-/* Events supported by Thermal Netlink */
-enum events {
-	THERMAL_AUX0,
-	THERMAL_AUX1,
-	THERMAL_CRITICAL,
-	THERMAL_DEV_FAULT,
-};
-
-/* attributes of thermal_genl_family */
-enum {
-	THERMAL_GENL_ATTR_UNSPEC,
-	THERMAL_GENL_ATTR_EVENT,
-	__THERMAL_GENL_ATTR_MAX,
-};
-#define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
-
-/* commands supported by the thermal_genl_family */
-enum {
-	THERMAL_GENL_CMD_UNSPEC,
-	THERMAL_GENL_CMD_EVENT,
-	__THERMAL_GENL_CMD_MAX,
-};
-#define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
-
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
@@ -206,11 +177,6 @@ struct thermal_zone_params {
 	struct thermal_bind_params *tbp;
 };
 
-struct thermal_genl_event {
-	u32 orig;
-	enum events event;
-};
-
 /* Function declarations */
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, const struct thermal_zone_device_ops *,
@@ -236,14 +202,4 @@ void notify_thermal_framework(struct thermal_zone_device *, int);
 
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
-
-#ifdef CONFIG_NET
-extern int thermal_generate_netlink_event(u32 orig, enum events event);
-#else
-static inline int thermal_generate_netlink_event(u32 orig, enum events event)
-{
-	return 0;
-}
-#endif
-
 #endif /* __THERMAL_H__ */
-- 
1.7.9.5

