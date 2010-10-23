From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH] ACPI / Battery: Return -ENODEV for unknown values in get_property()
Date: Sat, 23 Oct 2010 19:35:15 +0200
Message-ID: <201010231935.16178.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46626 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753744Ab0JWRgG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Oct 2010 13:36:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Zhang Rui <rui.zhang@intel.com>, Sitsofe Wheeler <sitsofe@yahoo.com>

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
---
 drivers/acpi/battery.c |   35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/acpi/battery.c
===================================================================
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -186,6 +186,7 @@ static int acpi_battery_get_property(str
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
 {
+	int ret = 0;
 	struct acpi_battery *battery = to_acpi_battery(psy);
 
 	if (acpi_battery_present(battery)) {
@@ -214,26 +215,44 @@ static int acpi_battery_get_property(str
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
@@ -245,9 +264,9 @@ static int acpi_battery_get_property(str
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
