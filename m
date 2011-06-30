From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [v2 2/6] ACPI / Battery: Change 16-bit signed negative battery current into correct value
Date: Thu, 30 Jun 2011 11:33:12 +0800
Message-ID: <1309404792-15745-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19541 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921Ab1F3DdE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2011 23:33:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, tianyu.lan@intel.com, rui.zhang@intel.com

This patch is for some machines which report the battery current
as a 16-bit signed negative when it is charging. This is caused
by DSDT bug. The commit bc76f90b8a5cf4aceedf210d08d5e8292f820cec
has resolved the problem for Acer laptops. But some other machines
also have such problem.

    https://bugzilla.kernel.org/show_bug.cgi?id=33722

Since it is improper that the current is above 32A on laptops
whether on AC or on battery, this patch is to check the current and
 take its absolute value as current and producing a message when it
is negative in s16.

Remove Acer quirk, as this workaround handles Acer too.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/battery.c |   26 ++++++++++----------------
 1 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 611434f..ff1ff70 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -94,11 +94,6 @@ MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 enum {
 	ACPI_BATTERY_ALARM_PRESENT,
 	ACPI_BATTERY_XINFO_PRESENT,
-	/* For buggy DSDTs that report negative 16-bit values for either
-	 * charging or discharging current and/or report 0 as 65536
-	 * due to bad math.
-	 */
-	ACPI_BATTERY_QUIRK_SIGNED16_CURRENT,
 	ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY,
 };
 
@@ -465,9 +460,17 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	battery->update_time = jiffies;
 	kfree(buffer.pointer);
 
-	if (test_bit(ACPI_BATTERY_QUIRK_SIGNED16_CURRENT, &battery->flags) &&
-	    battery->rate_now != -1)
+	/* For buggy DSDTs that report negative 16-bit values for either
+	 * charging or discharging current and/or report 0 as 65536
+	 * due to bad math.
+	 */
+	if (battery->power_unit == ACPI_BATTERY_POWER_UNIT_MA &&
+		battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
+		(s16)(battery->rate_now) < 0) {
 		battery->rate_now = abs((s16)battery->rate_now);
+		printk_once(KERN_WARNING FW_BUG "battery: (dis)charge rate"
+			" invalid.\n");
+	}
 
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
 	    && battery->capacity_now >= 0 && battery->capacity_now <= 100)
@@ -577,14 +580,6 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 	battery->bat.dev = NULL;
 }
 
-static void acpi_battery_quirks(struct acpi_battery *battery)
-{
-	if (dmi_name_in_vendors("Acer") &&
-		battery->power_unit == ACPI_BATTERY_POWER_UNIT_MA) {
-		set_bit(ACPI_BATTERY_QUIRK_SIGNED16_CURRENT, &battery->flags);
-	}
-}
-
 /*
  * According to the ACPI spec, some kinds of primary batteries can
  * report percentage battery remaining capacity directly to OS.
@@ -628,7 +623,6 @@ static int acpi_battery_update(struct acpi_battery *battery)
 		result = acpi_battery_get_info(battery);
 		if (result)
 			return result;
-		acpi_battery_quirks(battery);
 		acpi_battery_init_alarm(battery);
 	}
 	if (!battery->bat.dev)
-- 
1.7.6.rc2.8.g28eb

