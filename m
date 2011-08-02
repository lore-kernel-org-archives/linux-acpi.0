From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/27] ACPI / Battery: Add the power unit macro
Date: Tue, 02 Aug 2011 16:53:11 -0400
Message-ID: <ae6f61870490c10a0b0436e5afffa00c9dacffef.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:41687 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254Ab1HBUy2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 16:54:28 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB005XEJE9P571@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 15:54:25 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, Len Brown <len.brown@intel.com>

From: Lan Tianyu <tianyu.lan@intel.com>

This patch is cosmetic only, and makes no functional change.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fcc13ac..611434f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -55,6 +55,9 @@
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
 #define ACPI_BATTERY_NOTIFY_THRESHOLD   0x82
 
+/* Battery power unit: 0 means mW, 1 means mA */
+#define ACPI_BATTERY_POWER_UNIT_MA	1
+
 #define _COMPONENT		ACPI_BATTERY_COMPONENT
 
 ACPI_MODULE_NAME("battery");
@@ -301,7 +304,8 @@ static enum power_supply_property energy_battery_props[] = {
 #ifdef CONFIG_ACPI_PROCFS_POWER
 inline char *acpi_battery_units(struct acpi_battery *battery)
 {
-	return (battery->power_unit)?"mA":"mW";
+	return (battery->power_unit == ACPI_BATTERY_POWER_UNIT_MA) ?
+		"mA" : "mW";
 }
 #endif
 
@@ -544,7 +548,7 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 {
 	int result;
 
-	if (battery->power_unit) {
+	if (battery->power_unit == ACPI_BATTERY_POWER_UNIT_MA) {
 		battery->bat.properties = charge_battery_props;
 		battery->bat.num_properties =
 			ARRAY_SIZE(charge_battery_props);
@@ -575,7 +579,8 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 
 static void acpi_battery_quirks(struct acpi_battery *battery)
 {
-	if (dmi_name_in_vendors("Acer") && battery->power_unit) {
+	if (dmi_name_in_vendors("Acer") &&
+		battery->power_unit == ACPI_BATTERY_POWER_UNIT_MA) {
 		set_bit(ACPI_BATTERY_QUIRK_SIGNED16_CURRENT, &battery->flags);
 	}
 }
-- 
1.7.6.396.ge0613

