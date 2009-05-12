From: akpm@linux-foundation.org
Subject: [patch for 2.6.30? 1/1] acpi thermal: fix off-by-1 error in trip point trigger condition
Date: Tue, 12 May 2009 13:25:03 -0700
Message-ID: <200905122044.n4CKiJd2027310@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50663 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750939AbZELUsf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 May 2009 16:48:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, eightgraph@gmail.com, rui.zhang@intel.com

From: Vladimir Zajac <eightgraph@gmail.com>

Fix a regression caused by commit b1569e99c795bf83b4ddf41c4f1c42761ab7f75e
("ACPI: move thermal trip handling to generic thermal layer") which
accidentally changed trip point trigger condition to temp > trip_temp

This patch changes the trigger condition back to
  temp >= trip_temp

Signed-off-by: Vladimir Zajac <eightgraph@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/thermal/thermal_sys.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/thermal/thermal_sys.c~acpi-thermal-fix-off-by-1-error-in-trip-point-trigger-condition drivers/thermal/thermal_sys.c
--- a/drivers/thermal/thermal_sys.c~acpi-thermal-fix-off-by-1-error-in-trip-point-trigger-condition
+++ a/drivers/thermal/thermal_sys.c
@@ -961,7 +961,7 @@ void thermal_zone_device_update(struct t
 
 		switch (trip_type) {
 		case THERMAL_TRIP_CRITICAL:
-			if (temp > trip_temp) {
+			if (temp >= trip_temp) {
 				if (tz->ops->notify)
 					ret = tz->ops->notify(tz, count,
 							      trip_type);
@@ -974,7 +974,7 @@ void thermal_zone_device_update(struct t
 			}
 			break;
 		case THERMAL_TRIP_HOT:
-			if (temp > trip_temp)
+			if (temp >= trip_temp)
 				if (tz->ops->notify)
 					tz->ops->notify(tz, count, trip_type);
 			break;
@@ -986,14 +986,14 @@ void thermal_zone_device_update(struct t
 
 				cdev = instance->cdev;
 
-				if (temp > trip_temp)
+				if (temp >= trip_temp)
 					cdev->ops->set_cur_state(cdev, 1);
 				else
 					cdev->ops->set_cur_state(cdev, 0);
 			}
 			break;
 		case THERMAL_TRIP_PASSIVE:
-			if (temp > trip_temp || tz->passive)
+			if (temp >= trip_temp || tz->passive)
 				thermal_zone_device_passive(tz, temp,
 							    trip_temp, count);
 			break;
_
