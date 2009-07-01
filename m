From: Hector Martin <hector@marcansoft.com>
Subject: [PATCH] Work around negative s16 battery current on Acer
Date: Wed, 01 Jul 2009 20:20:41 +0200
Message-ID: <4A4BA8F9.9070803@marcansoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040603090503000706090101"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from marcansoft.com ([80.68.93.119]:59188 "EHLO smtp.marcansoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815AbZGAS31 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2009 14:29:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

This is a multi-part message in MIME format.
--------------040603090503000706090101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

My Acer Aspire 8930G laptop reports the battery current as a 16-bit
signed negative when it is charging. It also reports it as 0x10000 when
the current is 0. This patch adds a quirk for this which takes the
absolute value of the reported current cast to an s16. This is a DSDT
bug present in the latest BIOS revision (the EC register is 16 bits
signed and the DSDT attempts to take the 16-bit two's complement of
this, which works for discharge but not charge. It also breaks zero
values because a 32-bit register is used and the high bits aren't thrown
away).

I've enabled this for all Acer systems which report in mA units. This
should be safe since it won't break compliant systems unless they report
a current above 32A, which is insane.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc


--------------040603090503000706090101
Content-Type: text/plain;
 name="acpi-battery-acer-rate-quirk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-battery-acer-rate-quirk.patch"

Signed-off-by: Hector Martin <hector@marcansoft.com>
--- linux/drivers/acpi/battery.c.old	2009-07-01 19:17:33.000000000 +0200
+++ linux/drivers/acpi/battery.c	2009-07-01 19:52:43.000000000 +0200
@@ -84,6 +84,10 @@
 
 MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
+/* For buggy DSDTs that report negative 16-bit values for either charging
+ * or discharging and/or report 0 as 65536 due to bad math.
+ */
+#define QUIRK_SIGNED16_CURRENT 0x0001
 
 struct acpi_battery {
 	struct mutex lock;
@@ -111,6 +115,7 @@
 	int state;
 	int power_unit;
 	u8 alarm_present;
+	long quirks;
 };
 
 #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
@@ -387,6 +392,10 @@
 				 state_offsets, ARRAY_SIZE(state_offsets));
 	battery->update_time = jiffies;
 	kfree(buffer.pointer);
+
+	if (battery->quirks & QUIRK_SIGNED16_CURRENT)
+		battery->current_now = abs((s16)battery->current_now);
+
 	return result;
 }
 
@@ -492,6 +501,14 @@
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
@@ -510,6 +527,7 @@
 		result = acpi_battery_get_info(battery);
 		if (result)
 			return result;
+		acpi_battery_quirks(battery);
 		acpi_battery_init_alarm(battery);
 	}
 #ifdef CONFIG_ACPI_SYSFS_POWER

--------------040603090503000706090101--
