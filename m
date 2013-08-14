From: tianyu.lan@intel.com
Subject: [PATCH 3/3] ACPI/Thermal: Use THERMAL_TRIPS_NONE macro to replace number
Date: Wed, 14 Aug 2013 21:00:39 +0800
Message-ID: <1376485239-18312-3-git-send-email-tianyu.lan@intel.com>
References: <1376485239-18312-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15522 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932282Ab3HNNLT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Aug 2013 09:11:19 -0400
In-Reply-To: <1376485239-18312-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, rui.zhang@intel.com

From: Lan Tianyu <tianyu.lan@intel.com>

It's unreadable to pass "-1" as trip param directly to thermal_zone_bind_cooling_device.
So use THERMAL_TRIPS_NONE to replace it.

Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 71ab083..9063239 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -833,12 +833,13 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 		if (ACPI_SUCCESS(status) && (dev == device)) {
 			if (bind)
 				result = thermal_zone_bind_cooling_device
-						(thermal, -1, cdev,
-						 THERMAL_NO_LIMIT,
+						(thermal, THERMAL_TRIPS_NONE,
+						 cdev, THERMAL_NO_LIMIT,
 						 THERMAL_NO_LIMIT);
 			else
 				result = thermal_zone_unbind_cooling_device
-						(thermal, -1, cdev);
+						(thermal, THERMAL_TRIPS_NONE,
+						 cdev);
 			if (result)
 				goto failed;
 		}
-- 
1.8.4.rc0.1.g8f6a3e5.dirty

