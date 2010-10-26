From: "R.Durgadoss" <durgadoss.r@intel.com>
Subject: [PATCH] Adding_event_notification_to_thermal_framework
Date: Wed, 27 Oct 2010 03:33:29 +0530
Message-ID: <1288130609-2508-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:37796 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830Ab0JZKZZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Oct 2010 06:25:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: alan@linux.intel.com, linux-acpi@vger.kernel.org, rui.zhang@intel.com, ramesh.agarwal@intel.com, durgadoss.r@intel.com

This patch adds event notification support to the generic
thermal sysfs framework in the kernel. The notification is in the
form of a netlink event.

Signed-off-by: R.Durgadoss <durgadoss.r@intel.com>
---
 Documentation/ABI/stable/thermal-notification |    4 +
 Documentation/thermal/sysfs-api.txt           |   12 +++
 drivers/thermal/thermal_sys.c                 |  103 ++++++++++++++++++++++++-
 include/linux/thermal.h                       |   32 ++++++++
 4 files changed, 150 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/ABI/stable/thermal-notification

diff --git a/Documentation/ABI/stable/thermal-notification b/Documentation/ABI/stable/thermal-notification
new file mode 100644
index 0000000..9723e8b
--- /dev/null
+++ b/Documentation/ABI/stable/thermal-notification
@@ -0,0 +1,4 @@
+What:		A notification mechanism for thermal related events
+Description:
+	This interface enables notification for thermal related events.
+	The notification is in the form of a netlink event.
diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index cb3d15b..b61e46f 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -278,3 +278,15 @@ method, the sys I/F structure will be built like this:
     |---name:			acpitz
     |---temp1_input:		37000
     |---temp1_crit:		100000
+
+4. Event Notification
+
+The framework includes a simple notification mechanism, in the form of a
+netlink event. Netlink socket initialization is done during the _init_
+of the framework. Drivers which intend to use the notification mechanism
+just need to call generate_netlink_event() with two arguments viz
+(originator, event). Typically the originator will be an integer assigned
+to a thermal_zone_device when it registers itself with the framework. The
+event will be one of:{THERMAL_AUX0, THERMAL_AUX1, THERMAL_CRITICAL,
+THERMAL_DEV_FAULT}. Notification can be sent when the current temperature
+crosses any of the configured thresholds.
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 13c72c6..760e045 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -32,6 +32,8 @@
 #include <linux/thermal.h>
 #include <linux/spinlock.h>
 #include <linux/reboot.h>
+#include <net/netlink.h>
+#include <net/genetlink.h>
 
 MODULE_AUTHOR("Zhang Rui");
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
@@ -58,6 +60,22 @@ static LIST_HEAD(thermal_tz_list);
 static LIST_HEAD(thermal_cdev_list);
 static DEFINE_MUTEX(thermal_list_lock);
 
+static unsigned int thermal_event_seqnum;
+
+static struct genl_family thermal_event_genl_family = {
+	.id = GENL_ID_GENERATE,
+	.name = THERMAL_GENL_FAMILY_NAME,
+	.version = THERMAL_GENL_VERSION,
+	.maxattr = THERMAL_GENL_ATTR_MAX,
+};
+
+static struct genl_multicast_group thermal_event_mcgrp = {
+	.name = THERMAL_GENL_MCAST_GROUP_NAME,
+};
+
+static int genetlink_init(void);
+static void genetlink_exit(void);
+
 static int get_idr(struct idr *idr, struct mutex *lock, int *id)
 {
 	int err;
@@ -1214,6 +1232,82 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 EXPORT_SYMBOL(thermal_zone_device_unregister);
 
+int generate_netlink_event(u32 orig, enum events event)
+{
+	struct sk_buff *skb;
+	struct nlattr *attr;
+	struct thermal_genl_event *thermal_event;
+	void *msg_header;
+	int size;
+	int result;
+
+	/* allocate memory */
+	size = nla_total_size(sizeof(struct thermal_genl_event)) + \
+				nla_total_size(0);
+
+	skb = genlmsg_new(size, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	/* add the genetlink message header */
+	msg_header = genlmsg_put(skb, 0, thermal_event_seqnum++,
+				 &thermal_event_genl_family, 0,
+				 THERMAL_GENL_CMD_EVENT);
+	if (!msg_header) {
+		nlmsg_free(skb);
+		return -ENOMEM;
+	}
+
+	/* fill the data */
+	attr = nla_reserve(skb, THERMAL_GENL_ATTR_EVENT, \
+			sizeof(struct thermal_genl_event));
+
+	if (!attr) {
+		nlmsg_free(skb);
+		return -EINVAL;
+	}
+
+	thermal_event = nla_data(attr);
+	if (!thermal_event) {
+		nlmsg_free(skb);
+		return -EINVAL;
+	}
+
+	memset(thermal_event, 0, sizeof(struct thermal_genl_event));
+
+	thermal_event->orig = orig;
+	thermal_event->event = event;
+
+	/* send multicast genetlink message */
+	result = genlmsg_end(skb, msg_header);
+	if (result < 0) {
+		nlmsg_free(skb);
+		return result;
+	}
+
+	result = genlmsg_multicast(skb, 0, thermal_event_mcgrp.id, GFP_ATOMIC);
+	if (result)
+		printk(KERN_INFO "failed to send netlink event:%d", result);
+
+	return result;
+}
+EXPORT_SYMBOL(generate_netlink_event);
+
+static int genetlink_init(void)
+{
+	int result;
+
+	result = genl_register_family(&thermal_event_genl_family);
+	if (result)
+		return result;
+
+	result = genl_register_mc_group(&thermal_event_genl_family,
+					&thermal_event_mcgrp);
+	if (result)
+		genl_unregister_family(&thermal_event_genl_family);
+	return result;
+}
+
 static int __init thermal_init(void)
 {
 	int result = 0;
@@ -1225,9 +1319,15 @@ static int __init thermal_init(void)
 		mutex_destroy(&thermal_idr_lock);
 		mutex_destroy(&thermal_list_lock);
 	}
+	result = genetlink_init();
 	return result;
 }
 
+static void genetlink_exit(void)
+{
+	genl_unregister_family(&thermal_event_genl_family);
+}
+
 static void __exit thermal_exit(void)
 {
 	class_unregister(&thermal_class);
@@ -1235,7 +1335,8 @@ static void __exit thermal_exit(void)
 	idr_destroy(&thermal_cdev_idr);
 	mutex_destroy(&thermal_idr_lock);
 	mutex_destroy(&thermal_list_lock);
+	genetlink_exit();
 }
 
-subsys_initcall(thermal_init);
+fs_initcall(thermal_init);
 module_exit(thermal_exit);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 1de8b9e..7846449 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -127,6 +127,37 @@ struct thermal_zone_device {
 	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
 #endif
 };
+/* Adding event notification support elements */
+#define THERMAL_GENL_FAMILY_NAME                "thermal_event"
+#define THERMAL_GENL_VERSION                    0x01
+#define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_group"
+
+enum events {
+	THERMAL_AUX0,
+	THERMAL_AUX1,
+	THERMAL_CRITICAL,
+	THERMAL_DEV_FAULT,
+};
+
+struct thermal_genl_event {
+	u32 orig;
+	enum events event;
+};
+/* attributes of thermal_genl_family */
+enum {
+	THERMAL_GENL_ATTR_UNSPEC,
+	THERMAL_GENL_ATTR_EVENT,
+	__THERMAL_GENL_ATTR_MAX,
+};
+#define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
+
+/* commands supported by the thermal_genl_family */
+enum {
+	THERMAL_GENL_CMD_UNSPEC,
+	THERMAL_GENL_CMD_EVENT,
+	__THERMAL_GENL_CMD_MAX,
+};
+#define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
 
 struct thermal_zone_device *thermal_zone_device_register(char *, int, void *,
 							 struct
@@ -146,5 +177,6 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 							       thermal_cooling_device_ops
 							       *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
+extern int generate_netlink_event(u32 orig, enum events event);
 
 #endif /* __THERMAL_H__ */
-- 
1.7.2.3

