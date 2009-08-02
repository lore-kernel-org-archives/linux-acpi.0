From: Michael Brunner <mibru@gmx.de>
Subject: [PATCH] thermal_sys: check get_temp return value
Date: Sun, 2 Aug 2009 14:06:52 +0200
Message-ID: <20090802140652.16effa08@mail.gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752695AbZHBMG4@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The return value of the get_temp function is not checked when doing a
thermal zone update. This may lead to a critical shutdown if get_temp
fails and the content of the temp variable is incorrectly set higher
than the critical trip point.
This has been observed on a system with incorrect ACPI implementation
where the corresponding methods were not serialized and therefore
sometimes triggered ACPI errors (AE_ALREADY_EXISTS). The following
critical shutdowns indicated a temperature of 2097 C, which was
obviously wrong.

The patch adds a return value check that jumps over all trip point
evaluations printing a warning if get_temp fails. The trip points are
evaluated again on the next polling interval with successful get_temp
execution.

Signed-off-by: Michael Brunner <mibru@gmx.de>

---

 drivers/thermal/thermal_sys.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 0a69672..4e83c29 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -953,7 +953,12 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 
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
@@ -1005,6 +1010,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 					    THERMAL_TRIPS_NONE);
 
 	tz->last_temperature = temp;
+
+      leave:
 	if (tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay);
 	else if (tz->polling_delay)
