From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: [PATCH 2/2] ACPI / battery: check AC adapter's state when battery state changes
Date: Sat,  8 Feb 2014 02:28:53 +0700
Message-ID: <1391801333-18519-2-git-send-email-mezin.alexander@gmail.com>
References: <1391801333-18519-1-git-send-email-mezin.alexander@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:34376 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbaBGTb1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Feb 2014 14:31:27 -0500
Received: by mail-la0-f45.google.com with SMTP id b8so3048045lan.32
        for <linux-acpi@vger.kernel.org>; Fri, 07 Feb 2014 11:31:26 -0800 (PST)
In-Reply-To: <1391801333-18519-1-git-send-email-mezin.alexander@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexander Mezin <mezin.alexander@gmail.com>

When battery state changes (i. e. it starts to charge/discharge),
it could indicate that AC adapter has been plugged or unplugged.

When POWER_SUPPLY_PROP_ONLINE is read, AC driver should check actual
adapter state, and emit notification if the state has changed
(my previous patch).

This patch finally solves the problem with AC notifications on my
HP Pavilion dv6-6179er.

Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
---
 drivers/acpi/battery.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 470e754..68b263c 100644
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
+		 * Some BIOSes don't send notifications when ac adapter
+		 * is plugged or unplugged.
+		 * If battery changes its state, this could indicate that
+		 * AC adapter's state has changed too.
+		 */
+		class_for_each_device(power_supply_class, NULL, NULL,
+				      &acpi_battery_check_ac_state);
 	return result;
 }
 
-- 
1.8.5.4

