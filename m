From: Laszlo Toth <laszlth@gmail.com>
Subject: [PATCH] ACPI: battery: do not export degraded capacity values over
 100
Date: Sat, 17 Feb 2018 22:22:05 +0100
Message-ID: <20180217212205.GA2748@laszlth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53551 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeBQVWJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Feb 2018 16:22:09 -0500
Received: by mail-wm0-f66.google.com with SMTP id t74so8848641wme.3
        for <linux-acpi@vger.kernel.org>; Sat, 17 Feb 2018 13:22:08 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

With a degraded battery, full_charge_capacity can be less
than design_capacity, however it's not sure that capacity_now's
max will follow.

Example from an affected machine:
/sys/class/power_supply/BAT0/charge_full        -> 4290000
/sys/class/power_supply/BAT0/charge_full_design -> 5900000
/sys/class/power_supply/BAT0/charge_now         -> 5900000
/sys/class/power_supply/BAT0/capacity           -> 137

The battery is a degraded one with a full charge, and
charge_now is the value of charge_full_design instead of
charge_full.

Added a new quirk to test and correct this, and
a new function to check if the battery is a degraded one
or not. This keeps the possibility to be over 100 if
it's really the case.

Signed-off-by: Laszlo Toth <laszlth@gmail.com>
---
 drivers/acpi/battery.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 7128488..b2729a5 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -116,6 +116,10 @@ enum {
 	   post-1.29 BIOS), but as of Nov. 2012, no such update is
 	   available for the 2010 models.  */
 	ACPI_BATTERY_QUIRK_THINKPAD_MAH,
+	/* for batteries reporting current capacity with design capacity
+	 * on a full charge, but showing degradation in full charge cap.
+	 */
+	ACPI_BATTERY_QUIRK_DESIGN_MAX_CAPACITY,
 };
 
 struct acpi_battery {
@@ -201,6 +205,13 @@ static int acpi_battery_is_charged(struct acpi_battery *battery)
 	return 0;
 }
 
+static inline int acpi_battery_is_degraded(struct acpi_battery *battery)
+{
+	if (battery->full_charge_capacity && battery->design_capacity)
+		return battery->full_charge_capacity < battery->design_capacity;
+	return 0;
+}
+
 static int acpi_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
@@ -475,6 +486,9 @@ static int extract_battery_info(const int use_bix,
 		   it's impossible to tell if they would need an adjustment
 		   or not if their values were higher.  */
 	}
+	if (test_bit(ACPI_BATTERY_QUIRK_DESIGN_MAX_CAPACITY, &battery->flags) &&
+	    battery->capacity_now > battery->full_charge_capacity)
+		battery->capacity_now = battery->full_charge_capacity;
 	return result;
 }
 
@@ -567,6 +581,10 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 		battery->capacity_now = battery->capacity_now *
 		    10000 / battery->design_voltage;
 	}
+	if (test_bit(ACPI_BATTERY_QUIRK_DESIGN_MAX_CAPACITY, &battery->flags) &&
+	    battery->capacity_now > battery->full_charge_capacity)
+		battery->capacity_now = battery->full_charge_capacity;
+
 	return result;
 }
 
@@ -743,6 +761,16 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
 			}
 		}
 	}
+
+	if (test_bit(ACPI_BATTERY_QUIRK_DESIGN_MAX_CAPACITY, &battery->flags))
+		return;
+
+	if (acpi_battery_is_degraded(battery) &&
+	    battery->capacity_now > battery->full_charge_capacity) {
+		set_bit(ACPI_BATTERY_QUIRK_DESIGN_MAX_CAPACITY,
+			&battery->flags);
+		battery->capacity_now = battery->full_charge_capacity;
+	}
 }
 
 static int acpi_battery_update(struct acpi_battery *battery, bool resume)
-- 
2.7.4

