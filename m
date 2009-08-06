From: akpm@linux-foundation.org
Subject: [patch for 2.6.31? 1/2] thermal_sys: check get_temp return value
Date: Thu, 06 Aug 2009 15:16:31 -0700
Message-ID: <200908062216.n76MGVL3019360@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59320 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754341AbZHFWRg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2009 18:17:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, mibru@gmx.de, rui.zhang@intel.com

From: Michael Brunner <mibru@gmx.de>

The return value of the get_temp function is not checked when doing a
thermal zone update.  This may lead to a critical shutdown if get_temp
fails and the content of the temp variable is incorrectly set higher than
the critical trip point.

This has been observed on a system with incorrect ACPI implementation
where the corresponding methods were not serialized and therefore
sometimes triggered ACPI errors (AE_ALREADY_EXISTS).  The following
critical shutdowns indicated a temperature of 2097 C, which was obviously
wrong.

The patch adds a return value check that jumps over all trip point
evaluations printing a warning if get_temp fails.  The trip points are
evaluated again on the next polling interval with successful get_temp
execution.

Signed-off-by: Michael Brunner <mibru@gmx.de>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/thermal/thermal_sys.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff -puN drivers/thermal/thermal_sys.c~thermal_sys-check-get_temp-return-value drivers/thermal/thermal_sys.c
--- a/drivers/thermal/thermal_sys.c~thermal_sys-check-get_temp-return-value
+++ a/drivers/thermal/thermal_sys.c
@@ -953,7 +953,12 @@ void thermal_zone_device_update(struct t
 
 	mutex_lock(&tz->lock);
 
-	tz->ops->get_temp(tz, &temp);
+	if (tz->ops->get_temp(tz, &temp)) {
+		/* get_temp failed - retry it later */
+		printk(KERN_WARNING PREFIX "failed to read out thermal zone "
+		       "%d\n", tz->id);
+		goto leave;
+	}
 
 	for (count = 0; count < tz->trips; count++) {
 		tz->ops->get_trip_type(tz, count, &trip_type);
@@ -1005,6 +1010,8 @@ void thermal_zone_device_update(struct t
 					    THERMAL_TRIPS_NONE);
 
 	tz->last_temperature = temp;
+
+      leave:
 	if (tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay);
 	else if (tz->polling_delay)
_
