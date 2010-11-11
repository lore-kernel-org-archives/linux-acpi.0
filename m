From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] thermal: make ops constant
Date: Thu, 11 Nov 2010 15:27:29 +0000
Message-ID: <20101111152714.11105.2101.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33057 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab0KKPrz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Nov 2010 10:47:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, rui.zhang@intel.com

From: Alan Cox <alan@linux.intel.com>

And while touching that function definition do something about the disaster
of formatting there.

Signed-off-by: Alan Cox <alan@linux.intel.com>
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

