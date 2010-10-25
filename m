From: Len Brown <lenb@kernel.org>
Subject: [PATCH 54/60] ACPI / Battery: Return -ENODEV for unknown values in
 get_property()
Date: Mon, 25 Oct 2010 02:21:02 -0400
Message-ID: <a1b4bd694a803eba49d637de32bb249638ceadb4.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab0JYHLT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:19 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:13 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

The function acpi_battery_get_property() is called by the
power supply framework's function power_supply_show_property()
implementing the sysfs interface for power supply devices as the
ACPI battery driver's ->get_property() callback.  Thus it is supposed
to return error code if the value of the given property is unknown.
Unfortunately, however, it returns 0 in those cases and puts a
wrong (negative) value into the intval field of the
union power_supply_propval object provided by
power_supply_show_property().  In consequence, wrong negative
values are read by user space from the battery's sysfs files.

Fix this by making acpi_battery_get_property() return -ENODEV
for properties with unknown values (-ENODEV is returned, because
power_supply_uevent() returns with error for any other error code
returned by power_supply_show_property()).

Reported-and-tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   35 +++++++++++++++++++++++++++--------
 1 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9841720..ac74a7d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -186,6 +186,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
 {
+	int ret = 0;
 	struct acpi_battery *battery = to_acpi_battery(psy);
 
 	if (acpi_battery_present(battery)) {
@@ -214,26 +215,44 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		val->intval = battery->cycle_count;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-		val->intval = battery->design_voltage * 1000;
+		if (battery->design_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
+			ret = -ENODEV;
+		else
+			val->intval = battery->design_voltage * 1000;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = battery->voltage_now * 1000;
+		if (battery->voltage_now == ACPI_BATTERY_VALUE_UNKNOWN)
+			ret = -ENODEV;
+		else
+			val->intval = battery->voltage_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		val->intval = battery->rate_now * 1000;
+		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
+			ret = -ENODEV;
+		else
+			val->intval = battery->rate_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
-		val->intval = battery->design_capacity * 1000;
+		if (battery->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
+			ret = -ENODEV;
+		else
+			val->intval = battery->design_capacity * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 	case POWER_SUPPLY_PROP_ENERGY_FULL:
-		val->intval = battery->full_charge_capacity * 1000;
+		if (battery->full_charge_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
+			ret = -ENODEV;
+		else
+			val->intval = battery->full_charge_capacity * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
-		val->intval = battery->capacity_now * 1000;
+		if (battery->capacity_now == ACPI_BATTERY_VALUE_UNKNOWN)
+			ret = -ENODEV;
+		else
+			val->intval = battery->capacity_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = battery->model_number;
@@ -245,9 +264,9 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		val->strval = battery->serial_number;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
-	return 0;
+	return ret;
 }
 
 static enum power_supply_property charge_battery_props[] = {
-- 
1.7.3.2.90.gd4c43

