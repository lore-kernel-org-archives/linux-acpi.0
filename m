From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] drivers/thermal/thermal.c: fix a check-after-use
Date: Wed, 20 Feb 2008 02:14:04 +0200
Message-ID: <20080220001404.GW31955@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:41114 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761989AbYBTAOl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Feb 2008 19:14:41 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes a check-after-use spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
570462ca4441d8d63dfd46efe6e5b2b1c251a611 diff --git a/drivers/thermal/thermal.c b/drivers/thermal/thermal.c
index e782b3e..958654b 100644
--- a/drivers/thermal/thermal.c
+++ b/drivers/thermal/thermal.c
@@ -308,10 +308,10 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	struct thermal_cooling_device_instance *pos;
 	int result;
 
-	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
+	if (!tz || !cdev)
 		return -EINVAL;
 
-	if (!tz || !cdev)
+	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
 		return -EINVAL;
 
 	dev =

