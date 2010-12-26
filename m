From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/33] thermal: make ops constant
Date: Sun, 26 Dec 2010 17:43:24 -0500
Message-ID: <5b275ce27077d6463ca28c9671dce7c2c1f622e2.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:46222 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab0LZWoL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:44:11 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE20080Z4HL4WS0@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:44:10 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Alan Cox <alan@linux.intel.com>

And while touching that function definition do something about the disaster
of formatting there.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |   17 +++++------------
 include/linux/thermal.h       |   15 +++++----------
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 13c72c6..bde3477 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -823,11 +823,8 @@ static struct class thermal_class = {
  * @devdata:	device private data.
  * @ops:		standard thermal cooling devices callbacks.
  */
-struct thermal_cooling_device *thermal_cooling_device_register(char *type,
-							       void *devdata,
-							       struct
-							       thermal_cooling_device_ops
-							       *ops)
+struct thermal_cooling_device *thermal_cooling_device_register(
+     char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos;
@@ -1048,13 +1045,9 @@ EXPORT_SYMBOL(thermal_zone_device_update);
  * section 11.1.5.1 of the ACPI specification 3.0.
  */
 struct thermal_zone_device *thermal_zone_device_register(char *type,
-							 int trips,
-							 void *devdata, struct
-							 thermal_zone_device_ops
-							 *ops, int tc1, int
-							 tc2,
-							 int passive_delay,
-							 int polling_delay)
+	int trips, void *devdata,
+	const struct thermal_zone_device_ops *ops,
+	int tc1, int tc2, int passive_delay, int polling_delay)
 {
 	struct thermal_zone_device *tz;
 	struct thermal_cooling_device *pos;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 1de8b9e..0662690 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -77,7 +77,7 @@ struct thermal_cooling_device {
 	char type[THERMAL_NAME_LENGTH];
 	struct device device;
 	void *devdata;
-	struct thermal_cooling_device_ops *ops;
+	const struct thermal_cooling_device_ops *ops;
 	struct list_head node;
 };
 
@@ -114,7 +114,7 @@ struct thermal_zone_device {
 	int last_temperature;
 	bool passive;
 	unsigned int forced_passive;
-	struct thermal_zone_device_ops *ops;
+	const struct thermal_zone_device_ops *ops;
 	struct list_head cooling_devices;
 	struct idr idr;
 	struct mutex lock;	/* protect cooling devices list */
@@ -129,11 +129,8 @@ struct thermal_zone_device {
 };
 
 struct thermal_zone_device *thermal_zone_device_register(char *, int, void *,
-							 struct
-							 thermal_zone_device_ops
-							 *, int tc1, int tc2,
-							 int passive_freq,
-							 int polling_freq);
+		const struct thermal_zone_device_ops *, int tc1, int tc2,
+		int passive_freq, int polling_freq);
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
@@ -142,9 +139,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *);
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
-							       struct
-							       thermal_cooling_device_ops
-							       *);
+		const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 
 #endif /* __THERMAL_H__ */
-- 
1.7.3.3.557.gb5c17

