From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/3] thermal: Create CONFIG_THERMAL_HWMON=n
Date: Sat, 28 Jun 2008 01:32:43 -0400
Message-ID: <16d752397301b95abaa95cbaf9e785d221872311.1214631090.git.len.brown@intel.com>
References: <1214631165-1436-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:58399 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbYF1FdE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:33:04 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500BGDREPMUC1@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:32:50 -0500 (CDT)
In-reply-to: <1214631165-1436-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Rene Herman <rene.herman@keyaccess.nl>, Rene Herman <rene.herman@gmail.com>, Len Brown <len.brown@intel.com>

From: Rene Herman <rene.herman@keyaccess.nl>

A bug in libsensors <= 2.10.6 is exposed
when this new hwmon I/F is enabled.
Create CONFIG_THERMAL_HWMON=n
until some time after libsensors 2.10.7 ships
so those users can run the latest kernel.

libsensors 3.x is already fixed -- those users
can use CONFIG_THERMAL_HWMON=y now.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
Acked-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 drivers/thermal/Kconfig                    |    9 +++++++++
 drivers/thermal/thermal_sys.c              |    4 ++--
 include/linux/thermal.h                    |    6 ++----
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 5b3f31f..46ece3f 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -312,3 +312,12 @@ When:	2.6.26
 Why:	Implementation became generic; users should now include
 	linux/semaphore.h instead.
 Who:	Matthew Wilcox <willy@linux.intel.com>
+
+---------------------------
+
+What:	CONFIG_THERMAL_HWMON
+When:	January 2009
+Why:	This option was introduced just to allow older lm-sensors userspace
+	to keep working over the upgrade to 2.6.26. At the scheduled time of
+	removal fixed lm-sensors (2.x or 3.x) should be readily available.
+Who:	Rene Herman <rene.herman@gmail.com>
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 4b62852..a86e952 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -12,3 +12,12 @@ menuconfig THERMAL
 	  cooling devices.
 	  All platforms with ACPI thermal support can use this driver.
 	  If you want this support, you should say Y or M here.
+
+config THERMAL_HWMON
+	bool "Hardware monitoring support"
+	depends on HWMON=y || HWMON=THERMAL
+	help
+	  The generic thermal sysfs driver's hardware monitoring support
+	  requires a 2.10.7/3.0.2 or later lm-sensors userspace.
+
+	  Say Y if your user-space is new enough.
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 6098787..fe07462 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -295,8 +295,8 @@ thermal_cooling_device_trip_point_show(struct device *dev,
 
 /* Device management */
 
-#if defined(CONFIG_HWMON) ||	\
-	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
+#if defined(CONFIG_THERMAL_HWMON)
+
 /* hwmon sys I/F */
 #include <linux/hwmon.h>
 static LIST_HEAD(thermal_hwmon_list);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 06d3e6e..917707e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -66,8 +66,7 @@ struct thermal_cooling_device {
 				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
 #define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
 
-#if defined(CONFIG_HWMON) ||	\
-	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
+#if defined(CONFIG_THERMAL_HWMON)
 /* thermal zone devices with the same type share one hwmon device */
 struct thermal_hwmon_device {
 	char type[THERMAL_NAME_LENGTH];
@@ -94,8 +93,7 @@ struct thermal_zone_device {
 	struct idr idr;
 	struct mutex lock;	/* protect cooling devices list */
 	struct list_head node;
-#if defined(CONFIG_HWMON) ||	\
-	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
+#if defined(CONFIG_THERMAL_HWMON)
 	struct list_head hwmon_node;
 	struct thermal_hwmon_device *hwmon;
 	struct thermal_hwmon_attr temp_input;	/* hwmon sys attr */
-- 
1.5.6.1.89.gd544

