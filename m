From: "lan,Tianyu" <tianyu.lan@intel.com>
Subject: [PATCH 1/3] ACPI / Battery: Change 16-bit signed negative battery
 current into correct value
Date: Mon, 20 Jun 2011 14:56:37 +0800
Message-ID: <1308552997.18731.26.camel@lantianyu-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16828 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab1FTG55 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Jun 2011 02:57:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

This patch is for some machine which report the battery current
as a 16-bit signed negative when it is charging. This is caused
by DSDT bug. The commit bc76f90b8a5cf4aceedf210d08d5e8292f820cec
has resolved the problem for Acer laptops. But some other machines
also have such problem.
    https://bugzilla.kernel.org/show_bug.cgi?id=33722
Since it is improssible that the current is above 32A on laptops
whether on AC or on battery, this patch is to check the current and 
take its absolute value as current and producing a message when it
is negative in s16.

Signed-off-by: Lan Tianyu < tianyu.lan@intel.com >
---
 drivers/acpi/battery.c |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fcc13ac..d6a3de9 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -91,11 +91,6 @@ MODULE_DEVICE_TABLE(acpi, battery_device_ids);
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
 
@@ -461,9 +456,16 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	battery->update_time = jiffies;
 	kfree(buffer.pointer);
 
-	if (test_bit(ACPI_BATTERY_QUIRK_SIGNED16_CURRENT, &battery->flags) &&
-	    battery->rate_now != -1)
+	/* For buggy DSDTs that report negative 16-bit values for either
+	 * charging or discharging current and/or report 0 as 65536
+	 * due to bad math.
+	 */
+	if (battery->power_unit == 1 && (s16)(battery->rate_now) < 0
+	    && battery->rate_now != -1) {
 		battery->rate_now = abs((s16)battery->rate_now);
+		printk_once(KERN_WARNING PREFIX "Found 16-bit signed negative "
+			"battery current. Taking its absoulte value as current.\n");
+	}
 
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
 	    && battery->capacity_now >= 0 && battery->capacity_now <= 100)
@@ -573,13 +575,6 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 	battery->bat.dev = NULL;
 }
 
-static void acpi_battery_quirks(struct acpi_battery *battery)
-{
-	if (dmi_name_in_vendors("Acer") && battery->power_unit) {
-		set_bit(ACPI_BATTERY_QUIRK_SIGNED16_CURRENT, &battery->flags);
-	}
-}
-
 /*
  * According to the ACPI spec, some kinds of primary batteries can
  * report percentage battery remaining capacity directly to OS.
@@ -623,7 +618,6 @@ static int acpi_battery_update(struct acpi_battery *battery)
 		result = acpi_battery_get_info(battery);
 		if (result)
 			return result;
-		acpi_battery_quirks(battery);
 		acpi_battery_init_alarm(battery);
 	}
 	if (!battery->bat.dev)
-- 
1.7.1


