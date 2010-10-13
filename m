From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI battery: handle batteries tht report percentage
 remaining capacity correctly
Date: Wed, 13 Oct 2010 08:18:41 +0800
Message-ID: <1286929121.2111.4092.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19534 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606Ab0JMAVg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Oct 2010 20:21:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, sitsofe@yahoo.com


According to the ACPI spec, some kind of primary battery can
report percentage battery remaining capacity directly to OS.

In this case, it reports the LastFullChargedCapacity == 100,
BatteryPresentRate == 0xFFFFFFFF, and BatteryRemaingCapacity a
percentage value, which actually means RemainingBatteryPercentage.

Now we found some battery follows this rule even if it's rechargeable.
https://bugzilla.kernel.org/show_bug.cgi?id=15979

Handle these batteries correctly in ACPI battery driver
so that they won't break userspace.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/battery.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/battery.c
===================================================================
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -98,6 +98,7 @@ enum {
 	 * due to bad math.
 	 */
 	ACPI_BATTERY_QUIRK_SIGNED16_CURRENT,
+	ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY,
 };
 
 struct acpi_battery {
@@ -412,6 +413,8 @@ static int acpi_battery_get_info(struct 
 		result = extract_package(battery, buffer.pointer,
 				info_offsets, ARRAY_SIZE(info_offsets));
 	kfree(buffer.pointer);
+	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags))
+		battery->full_charge_capacity = battery->design_capacity;
 	return result;
 }
 
@@ -448,6 +451,10 @@ static int acpi_battery_get_state(struct
 	    battery->rate_now != -1)
 		battery->rate_now = abs((s16)battery->rate_now);
 
+	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
+	    && battery->capacity_now >= 0 && battery->capacity_now <= 100)
+		battery->capacity_now = (battery->capacity_now *
+				battery->full_charge_capacity) / 100;
 	return result;
 }
 
@@ -561,6 +568,33 @@ static void acpi_battery_quirks(struct a
 	}
 }
 
+/*
+ * According to the ACPI spec, some kinds of primary batteries can
+ * report percentage battery remaining capacity directly to OS.
+ * In this case, it reports the Last Full Charged Capacity == 100
+ * and BatteryPresentRate == 0xFFFFFFFF.
+ *
+ * Now we found some battery reports percentage remaining capacity
+ * even if it's rechargeable.
+ * https://bugzilla.kernel.org/show_bug.cgi?id=15979
+ *
+ * Handle this correctly so that they won't break userspace.
+ */
+static void acpi_battery_quirks2(struct acpi_battery *battery)
+{
+	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags))
+		return ;
+
+        if (battery->full_charge_capacity == 100 &&
+            battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN &&
+            battery->capacity_now >=0 && battery->capacity_now <= 100) {
+		set_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags);
+		battery->full_charge_capacity = battery->design_capacity;
+		battery->capacity_now = (battery->capacity_now *
+				battery->full_charge_capacity) / 100;
+	}
+}
+
 static int acpi_battery_update(struct acpi_battery *battery)
 {
 	int result, old_present = acpi_battery_present(battery);
@@ -586,7 +620,9 @@ static int acpi_battery_update(struct ac
 	if (!battery->bat.dev)
 		sysfs_add_battery(battery);
 #endif
-	return acpi_battery_get_state(battery);
+	result = acpi_battery_get_state(battery);
+	acpi_battery_quirks2(battery);
+	return result;
 }
 
 /* --------------------------------------------------------------------------


