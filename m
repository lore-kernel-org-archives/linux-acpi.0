From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [REPOST] [PATCH] acpi thermal fix result check
Date: Mon, 7 Apr 2008 23:55:30 +0200
Message-ID: <20080407235530.60630d2b.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:14597 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbYDGVqf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2008 17:46:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The  thermal_zone_device_register() uses ERR_PTR macro
to return values. A correct check is to use the IS_ERR macro.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This patch was done against 2.6.25-rc8.
The 2.6.25 kernels panic on Compaq AP550 without this patch
as it has more then 10 (THERMAL_MAX_TRIPS) trip points (there are 12).

diff -urp linux-2.6.24/drivers/acpi/thermal.c linux-2.6.25/drivers/acpi/thermal.c
--- linux-2.6.24/drivers/acpi/thermal.c	2008-04-07 23:17:24.145477887 +0200
+++ linux-2.6.25/drivers/acpi/thermal.c	2008-04-07 23:24:04.341336464 +0200
@@ -1125,7 +1125,7 @@ static int acpi_thermal_register_thermal
 			tz->trips.active[i].flags.valid; i++, trips++);
 	tz->thermal_zone = thermal_zone_device_register("ACPI thermal zone",
 					trips, tz, &acpi_thermal_zone_ops);
-	if (!tz->thermal_zone)
+	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
 	result = sysfs_create_link(&tz->device->dev.kobj,
