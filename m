From: akpm@linux-foundation.org
Subject: [patch for 2.6.25? 3/3] acpi thermal trip points increased to 12
Date: Thu, 10 Apr 2008 21:30:16 -0700
Message-ID: <200804110430.m3B4UGxR000422@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52417 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750729AbYDKEam (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Apr 2008 00:30:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, krzysztof.h1@wp.pl, rjw@sisk.pl, rui.zhang@intel.com

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The THERMAL_MAX_TRIPS value is set to 10.  It is too few for the Compaq AP550
machine which has 12 trip points.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/thermal/thermal.c |    4 ++++
 include/linux/thermal.h   |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff -puN drivers/thermal/thermal.c~acpi-thermal-trip-points-increased-to-12 drivers/thermal/thermal.c
--- a/drivers/thermal/thermal.c~acpi-thermal-trip-points-increased-to-12
+++ a/drivers/thermal/thermal.c
@@ -196,6 +196,10 @@ static struct device_attribute trip_poin
 	__ATTR(trip_point_8_temp, 0444, trip_point_temp_show, NULL),
 	__ATTR(trip_point_9_type, 0444, trip_point_type_show, NULL),
 	__ATTR(trip_point_9_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_10_type, 0444, trip_point_type_show, NULL),
+	__ATTR(trip_point_10_temp, 0444, trip_point_temp_show, NULL),
+	__ATTR(trip_point_11_type, 0444, trip_point_type_show, NULL),
+	__ATTR(trip_point_11_temp, 0444, trip_point_temp_show, NULL),
 };
 
 #define TRIP_POINT_ATTR_ADD(_dev, _index, result)     \
diff -puN include/linux/thermal.h~acpi-thermal-trip-points-increased-to-12 include/linux/thermal.h
--- a/include/linux/thermal.h~acpi-thermal-trip-points-increased-to-12
+++ a/include/linux/thermal.h
@@ -50,7 +50,7 @@ struct thermal_cooling_device_ops {
 };
 
 #define THERMAL_TRIPS_NONE -1
-#define THERMAL_MAX_TRIPS 10
+#define THERMAL_MAX_TRIPS 12
 #define THERMAL_NAME_LENGTH 20
 struct thermal_cooling_device {
 	int id;
_
