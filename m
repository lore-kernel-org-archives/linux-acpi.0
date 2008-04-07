From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] acpi thermal trip points increased to 12
Date: Mon, 7 Apr 2008 23:58:57 +0200
Message-ID: <20080407235857.2486f460.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:17313 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172AbYDGVuH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2008 17:50:07 -0400
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net) (krzysztof.h1@[87.99.61.239])
          (envelope-sender <krzysztof.h1@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with SMTP
          for <linux-acpi@vger.kernel.org>; 7 Apr 2008 23:50:04 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The THERMAL_MAX_TRIPS value is set to 10. It is too few
for the Compaq AP550 machine which has 12 trip points.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This patch was done against 2.6.25-rc8.

diff -urp linux-2.6.24/drivers/thermal/thermal.c linux-2.6.25/drivers/thermal/thermal.c
--- linux-2.6.24/drivers/thermal/thermal.c	2008-04-07 23:18:14.712300799 +0200
+++ linux-2.6.25/drivers/thermal/thermal.c	2008-04-07 23:47:23.531550750 +0200
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
diff -urp linux-2.6.24/include/linux/thermal.h linux-2.6.25/include/linux/thermal.h
--- linux-2.6.24/include/linux/thermal.h	2008-04-07 23:18:41.681807171 +0200
+++ linux-2.6.25/include/linux/thermal.h	2008-04-07 23:26:24.201330930 +0200
@@ -50,7 +50,7 @@ struct thermal_cooling_device_ops {
 };
 
 #define THERMAL_TRIPS_NONE -1
-#define THERMAL_MAX_TRIPS 10
+#define THERMAL_MAX_TRIPS 12
 #define THERMAL_NAME_LENGTH 20
 struct thermal_cooling_device {
 	int id;
