From: Len Brown <lenb@kernel.org>
Subject: [PATCH 40/48] ACPI / Fan: Rework the handling of power resources
Date: Wed, 12 Jan 2011 05:19:34 -0500
Message-ID: <488a76c52606199100adf09c8eb7cbedbd94e9d9.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49262 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547Ab1ALSA3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:29 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:26 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Use the new function acpi_bus_update_power() for manipulating power
resources used by ACPI fan devices, which allows them to be put into
the right state during initialization and resume.  Consequently,
remove the flags.force_power_state field from struct acpi_device,
which is not necessary any more.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    2 +-
 drivers/acpi/fan.c      |   27 +++++++--------------------
 drivers/acpi/thermal.c  |    5 +++--
 include/acpi/acpi_bus.h |    3 +--
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 4786401..2ee83b5 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -266,7 +266,7 @@ static int __acpi_bus_set_power(struct acpi_device *device, int state)
 
 	/* Make sure this is a valid target state */
 
-	if ((state == device->power.state) && !device->flags.force_power_state) {
+	if (state == device->power.state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
 				  state));
 		return 0;
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 6004908..467479f 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -86,7 +86,7 @@ static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
 	if (!device)
 		return -EINVAL;
 
-	result = acpi_bus_get_power(device->handle, &acpi_state);
+	result = acpi_bus_update_power(device->handle, &acpi_state);
 	if (result)
 		return result;
 
@@ -123,7 +123,6 @@ static struct thermal_cooling_device_ops fan_cooling_ops = {
 static int acpi_fan_add(struct acpi_device *device)
 {
 	int result = 0;
-	int state = 0;
 	struct thermal_cooling_device *cdev;
 
 	if (!device)
@@ -132,16 +131,12 @@ static int acpi_fan_add(struct acpi_device *device)
 	strcpy(acpi_device_name(device), "Fan");
 	strcpy(acpi_device_class(device), ACPI_FAN_CLASS);
 
-	result = acpi_bus_get_power(device->handle, &state);
+	result = acpi_bus_update_power(device->handle, NULL);
 	if (result) {
-		printk(KERN_ERR PREFIX "Reading power state\n");
+		printk(KERN_ERR PREFIX "Setting initial power state\n");
 		goto end;
 	}
 
-	device->flags.force_power_state = 1;
-	acpi_bus_set_power(device->handle, state);
-	device->flags.force_power_state = 0;
-
 	cdev = thermal_cooling_device_register("Fan", device,
 						&fan_cooling_ops);
 	if (IS_ERR(cdev)) {
@@ -200,22 +195,14 @@ static int acpi_fan_suspend(struct acpi_device *device, pm_message_t state)
 
 static int acpi_fan_resume(struct acpi_device *device)
 {
-	int result = 0;
-	int power_state = 0;
+	int result;
 
 	if (!device)
 		return -EINVAL;
 
-	result = acpi_bus_get_power(device->handle, &power_state);
-	if (result) {
-		printk(KERN_ERR PREFIX
-				  "Error reading fan power state\n");
-		return result;
-	}
-
-	device->flags.force_power_state = 1;
-	acpi_bus_set_power(device->handle, power_state);
-	device->flags.force_power_state = 0;
+	result = acpi_bus_update_power(device->handle, NULL);
+	if (result)
+		printk(KERN_ERR PREFIX "Error updating fan power state\n");
 
 	return result;
 }
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 5a27b0a..2607e17 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1059,8 +1059,9 @@ static int acpi_thermal_resume(struct acpi_device *device)
 			break;
 		tz->trips.active[i].flags.enabled = 1;
 		for (j = 0; j < tz->trips.active[i].devices.count; j++) {
-			result = acpi_bus_get_power(tz->trips.active[i].devices.
-			    handles[j], &power_state);
+			result = acpi_bus_update_power(
+					tz->trips.active[i].devices.handles[j],
+					&power_state);
 			if (result || (power_state != ACPI_STATE_D0)) {
 				tz->trips.active[i].flags.enabled = 0;
 				break;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 5d2c4c5..8912580 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -149,8 +149,7 @@ struct acpi_device_flags {
 	u32 power_manageable:1;
 	u32 performance_manageable:1;
 	u32 wake_capable:1;	/* Wakeup(_PRW) supported? */
-	u32 force_power_state:1;
-	u32 reserved:22;
+	u32 reserved:23;
 };
 
 /* File System */
-- 
1.7.4.rc1.7.g2cf08

