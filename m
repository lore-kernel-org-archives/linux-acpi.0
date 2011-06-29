From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 1/6] ACPI / Battery: Add the power unit macro
Date: Wed, 29 Jun 2011 16:17:49 +0800
Message-ID: <1309335469-26316-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:5918 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702Ab1F2IRc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2011 04:17:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, tianyu.lan@intel.com, rui.zhang@intel.com

This patch is cosmetic only, and makes no functional change.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
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
1.7.6.rc2.8.g28eb

