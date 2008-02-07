From: Len Brown <lenb@kernel.org>
Subject: [PATCH 007/112] export thermal notification to userspace when nocrt is set
Date: Thu,  7 Feb 2008 04:33:29 -0500
Message-ID: <223630fe3dc564b94e51ff4eb839828c9083f2f6.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754670AbYBGJfZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:25 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

module parameter is used to prevent the thermal_zone action upon
critical trip points.
But exporting this notification to userspace is still useful.
By setting nocrt with this patch applied, ACPI will take no action
but exporting the events to userspace upon critical/hot trip points.

http://bugzilla.kernel.org/show_bug.cgi?id=9139

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 5f79b44..3a0af9a 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -492,7 +492,7 @@ static int acpi_thermal_get_devices(struct acpi_thermal *tz)
 
 static int acpi_thermal_critical(struct acpi_thermal *tz)
 {
-	if (!tz || !tz->trips.critical.flags.valid || nocrt)
+	if (!tz || !tz->trips.critical.flags.valid)
 		return -EINVAL;
 
 	if (tz->temperature >= tz->trips.critical.temperature) {
@@ -501,9 +501,6 @@ static int acpi_thermal_critical(struct acpi_thermal *tz)
 	} else if (tz->trips.critical.flags.enabled)
 		tz->trips.critical.flags.enabled = 0;
 
-	printk(KERN_EMERG
-	       "Critical temperature reached (%ld C), shutting down.\n",
-	       KELVIN_TO_CELSIUS(tz->temperature));
 	acpi_bus_generate_proc_event(tz->device, ACPI_THERMAL_NOTIFY_CRITICAL,
 				tz->trips.critical.flags.enabled);
 	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
@@ -511,14 +508,20 @@ static int acpi_thermal_critical(struct acpi_thermal *tz)
 					  ACPI_THERMAL_NOTIFY_CRITICAL,
 					  tz->trips.critical.flags.enabled);
 
-	orderly_poweroff(true);
+	/* take no action if nocrt is set */
+	if(!nocrt) {
+		printk(KERN_EMERG
+			"Critical temperature reached (%ld C), shutting down.\n",
+			KELVIN_TO_CELSIUS(tz->temperature));
+		orderly_poweroff(true);
+	}
 
 	return 0;
 }
 
 static int acpi_thermal_hot(struct acpi_thermal *tz)
 {
-	if (!tz || !tz->trips.hot.flags.valid || nocrt)
+	if (!tz || !tz->trips.hot.flags.valid)
 		return -EINVAL;
 
 	if (tz->temperature >= tz->trips.hot.temperature) {
@@ -534,7 +537,7 @@ static int acpi_thermal_hot(struct acpi_thermal *tz)
 					  ACPI_THERMAL_NOTIFY_HOT,
 					  tz->trips.hot.flags.enabled);
 
-	/* TBD: Call user-mode "sleep(S4)" function */
+	/* TBD: Call user-mode "sleep(S4)" function if nocrt is cleared */
 
 	return 0;
 }
-- 
1.5.4.23.gef5b9

