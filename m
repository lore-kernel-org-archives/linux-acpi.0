From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: [PATCH v2] ACPI / battery: trigger rechecking of AC adapter state when battery state changes.
Date: Sun,  2 Mar 2014 18:02:39 +0700
Message-ID: <1393758159-6934-1-git-send-email-mezin.alexander@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:44958 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbaCBLEh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Mar 2014 06:04:37 -0500
Received: by mail-la0-f47.google.com with SMTP id y1so3876059lam.34
        for <linux-acpi@vger.kernel.org>; Sun, 02 Mar 2014 03:04:36 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, Alexander Mezin <mezin.alexander@gmail.com>

On HP Pavilion dv6-6179er there are no notifications when AC adapter
is plugged/unplugged.

Output of acpi_listen, adapter is unplugged and then plugged in back:

battery PNP0C0A:00 00000001 00000001
battery PNP0C0A:00 00000080 00000001
 PNP0C14:00 00000080 00000000
processor LNXCPU:00 00000082 00000000
battery PNP0C0A:00 00000000 00000001
battery PNP0C0A:00 00000080 00000001
 PNP0C14:00 00000080 00000000
processor LNXCPU:00 00000082 00000000
battery PNP0C0A:00 00000080 00000001

The only way to trigger the notification is to read "online"
property in sysfs (/sys/class/power_supply/AC/online).

This patch triggers the notification by calling get_property for
every mains power supply.

Output of acpi_listen with this patch applied:

battery PNP0C0A:00 00000001 00000001
battery PNP0C0A:00 00000080 00000001
 PNP0C14:00 00000080 00000000
ac_adapter ACPI0003:00 00000000 00000000
processor LNXCPU:00 00000082 00000000
battery PNP0C0A:00 00000000 00000001
battery PNP0C0A:00 00000080 00000001
 PNP0C14:00 00000080 00000000
ac_adapter ACPI0003:00 00000000 00000001
processor LNXCPU:00 00000082 00000000
battery PNP0C0A:00 00000080 00000001

I'm using this patch for about a month, and didn't notice any
problems. I've tested it on top of both 3.13.5 and 3.14-rc4.

Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>

---
 v2: more verbose description

 drivers/acpi/battery.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 797a693..fb548f0 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -671,9 +671,22 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
 	}
 }
 
+static int acpi_battery_check_ac_state(struct device *dev, void *unused)
+{
+	struct power_supply *ps = dev_get_drvdata(dev);
+	union power_supply_propval temp;
+
+	if (ps->type != POWER_SUPPLY_TYPE_MAINS)
+		return 0;
+
+	ps->get_property(ps, POWER_SUPPLY_PROP_ONLINE, &temp);
+	return 0;
+}
+
 static int acpi_battery_update(struct acpi_battery *battery)
 {
 	int result, old_present = acpi_battery_present(battery);
+	int old_state = battery->state;
 	result = acpi_battery_get_status(battery);
 	if (result)
 		return result;
@@ -696,6 +709,15 @@ static int acpi_battery_update(struct acpi_battery *battery)
 	}
 	result = acpi_battery_get_state(battery);
 	acpi_battery_quirks(battery);
+	if (old_state != battery->state)
+		/*
+		 * Some BIOSes don't send notifications when AC adapter
+		 * is plugged or unplugged.
+		 * If battery changes its state, this could indicate that
+		 * AC adapter's state has changed too.
+		 */
+		class_for_each_device(power_supply_class, NULL, NULL,
+				      &acpi_battery_check_ac_state);
 	return result;
 }
 
-- 
1.9.0

