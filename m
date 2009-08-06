From: akpm@linux-foundation.org
Subject: [patch 1/9] acpi battery: work around negative s16 battery current on Acer
Date: Thu, 06 Aug 2009 15:57:48 -0700
Message-ID: <200908062257.n76Mvm4P024072@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35907 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756431AbZHFW7K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2009 18:59:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, hector@marcansoft.com, astarikovskiy@suse.de

From: Hector Martin <hector@marcansoft.com>

Acer Aspire 8930G laptops (and possibly others) report the battery current
as a 16-bit signed negative when it is charging.  It also reports it as
0x10000 when the current is 0.  This patch adds a quirk for this which
takes the absolute value of the reported current cast to an s16.  This is
a DSDT bug present in the latest BIOS revision (the EC register is 16 bits
signed and the DSDT attempts to take the 16-bit two's complement of this,
which works for discharge but not charge.  It also breaks zero values
because a 32-bit register is used and the high bits aren't thrown away).

I've enabled this for all Acer systems which report in mA units.  This
should be safe since it won't break compliant systems unless they report a
current above 32A, which is insane.  The patch also detects the valid
32-bit value -1, which indicates unknown status, and does not attempt the
fix in that case (note that this does not conflict with 16-bit -1, which
is 65535 as read normally and gets translated to 1mA).

Signed-off-by: Hector Martin <hector@marcansoft.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/battery.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff -puN drivers/acpi/battery.c~acpi-battery-work-around-negative-s16-battery-current-on-acer drivers/acpi/battery.c
--- a/drivers/acpi/battery.c~acpi-battery-work-around-negative-s16-battery-current-on-acer
+++ a/drivers/acpi/battery.c
@@ -85,6 +85,10 @@ static const struct acpi_device_id batte
 
 MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
+/* For buggy DSDTs that report negative 16-bit values for either charging
+ * or discharging current and/or report 0 as 65536 due to bad math.
+ */
+#define QUIRK_SIGNED16_CURRENT 0x0001
 
 struct acpi_battery {
 	struct mutex lock;
@@ -112,6 +116,7 @@ struct acpi_battery {
 	int state;
 	int power_unit;
 	u8 alarm_present;
+	long quirks;
 };
 
 #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
@@ -390,6 +395,11 @@ static int acpi_battery_get_state(struct
 				 state_offsets, ARRAY_SIZE(state_offsets));
 	battery->update_time = jiffies;
 	kfree(buffer.pointer);
+
+	if ((battery->quirks & QUIRK_SIGNED16_CURRENT) &&
+	    battery->rate_now != -1)
+		battery->rate_now = abs((s16)battery->rate_now);
+
 	return result;
 }
 
@@ -495,6 +505,14 @@ static void sysfs_remove_battery(struct 
 }
 #endif
 
+static void acpi_battery_quirks(struct acpi_battery *battery)
+{
+	battery->quirks = 0;
+	if (dmi_name_in_vendors("Acer") && battery->power_unit) {
+		battery->quirks |= QUIRK_SIGNED16_CURRENT;
+	}
+}
+
 static int acpi_battery_update(struct acpi_battery *battery)
 {
 	int result, old_present = acpi_battery_present(battery);
@@ -513,6 +531,7 @@ static int acpi_battery_update(struct ac
 		result = acpi_battery_get_info(battery);
 		if (result)
 			return result;
+		acpi_battery_quirks(battery);
 		acpi_battery_init_alarm(battery);
 	}
 #ifdef CONFIG_ACPI_SYSFS_POWER
_
