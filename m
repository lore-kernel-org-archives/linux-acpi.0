From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/34] ACPI: Battery: Add bit flags
Date: Sun, 14 Mar 2010 21:40:44 -0400
Message-ID: <7b3bcc4a1a7cd2d53b403ca29d06ceb5fa617eb7.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:10893 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab0COBq3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:46:29 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA008JHVOAOLK1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:48:15 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index cada73f..b2b48f8 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -88,10 +88,13 @@ static const struct acpi_device_id battery_device_ids[] = {
 
 MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
-/* For buggy DSDTs that report negative 16-bit values for either charging
- * or discharging current and/or report 0 as 65536 due to bad math.
- */
-#define QUIRK_SIGNED16_CURRENT 0x0001
+enum {
+	ACPI_BATTERY_ALARM_PRESENT,
+	/* For buggy DSDTs that report negative 16-bit values for either charging
+	* or discharging current and/or report 0 as 65536 due to bad math.
+	*/
+	ACPI_BATTERY_QUIRK_SIGNED16_CURRENT,
+};
 
 struct acpi_battery {
 	struct mutex lock;
@@ -118,8 +121,7 @@ struct acpi_battery {
 	char oem_info[32];
 	int state;
 	int power_unit;
-	u8 alarm_present;
-	long quirks;
+	unsigned long flags;
 };
 
 #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
@@ -399,7 +401,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	battery->update_time = jiffies;
 	kfree(buffer.pointer);
 
-	if ((battery->quirks & QUIRK_SIGNED16_CURRENT) &&
+	if (test_bit(ACPI_BATTERY_QUIRK_SIGNED16_CURRENT, &battery->flags) &&
 	    battery->rate_now != -1)
 		battery->rate_now = abs((s16)battery->rate_now);
 
@@ -412,7 +414,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 	union acpi_object arg0 = { .type = ACPI_TYPE_INTEGER };
 	struct acpi_object_list arg_list = { 1, &arg0 };
 
-	if (!acpi_battery_present(battery)|| !battery->alarm_present)
+	if (!acpi_battery_present(battery)||
+	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
 		return -ENODEV;
 
 	arg0.integer.value = battery->alarm;
@@ -437,10 +440,10 @@ static int acpi_battery_init_alarm(struct acpi_battery *battery)
 	/* See if alarms are supported, and if so, set default */
 	status = acpi_get_handle(battery->device->handle, "_BTP", &handle);
 	if (ACPI_FAILURE(status)) {
-		battery->alarm_present = 0;
+		clear_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags);
 		return 0;
 	}
-	battery->alarm_present = 1;
+	set_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags);
 	if (!battery->alarm)
 		battery->alarm = battery->design_capacity_warning;
 	return acpi_battery_set_alarm(battery);
@@ -510,9 +513,8 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 
 static void acpi_battery_quirks(struct acpi_battery *battery)
 {
-	battery->quirks = 0;
 	if (dmi_name_in_vendors("Acer") && battery->power_unit) {
-		battery->quirks |= QUIRK_SIGNED16_CURRENT;
+		set_bit(ACPI_BATTERY_QUIRK_SIGNED16_CURRENT, &battery->flags);
 	}
 }
 
-- 
1.7.0.2.201.g80978

