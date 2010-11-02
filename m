From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.35..2.6.36.stable] ACPI battery: support percentage battery
 remaining capacity
Date: Mon, 01 Nov 2010 22:50:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1011012245390.14926@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:50402 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab0KBCuy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Nov 2010 22:50:54 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LB8006FHL8JGKB4@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Nov 2010 21:50:43 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

upstream 557d58687dcdee6bc00c1a8f1fd4e0eac8fefce9

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
Tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>

---
drivers/acpi/battery.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

Index: linux-2.6.35.y/drivers/acpi/battery.c
===================================================================
--- linux-2.6.35.y.orig/drivers/acpi/battery.c
+++ linux-2.6.35.y/drivers/acpi/battery.c
@@ -98,6 +98,7 @@ enum {
 	 * due to bad math.
 	 */
 	ACPI_BATTERY_QUIRK_SIGNED16_CURRENT,
+	ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY,
 };
 
 struct acpi_battery {
@@ -413,6 +414,8 @@ static int acpi_battery_get_info(struct 
 		result = extract_package(battery, buffer.pointer,
 				info_offsets, ARRAY_SIZE(info_offsets));
 	kfree(buffer.pointer);
+	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags))
+		battery->full_charge_capacity = battery->design_capacity;
 	return result;
 }
 
@@ -449,6 +452,10 @@ static int acpi_battery_get_state(struct
 	    battery->rate_now != -1)
 		battery->rate_now = abs((s16)battery->rate_now);
 
+	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
+	    && battery->capacity_now >= 0 && battery->capacity_now <= 100)
+		battery->capacity_now = (battery->capacity_now *
+				battery->full_charge_capacity) / 100;
 	return result;
 }
 
@@ -562,6 +569,33 @@ static void acpi_battery_quirks(struct a
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
@@ -587,7 +621,9 @@ static int acpi_battery_update(struct ac
 	if (!battery->bat.dev)
 		sysfs_add_battery(battery);
 #endif
-	return acpi_battery_get_state(battery);
+	result = acpi_battery_get_state(battery);
+	acpi_battery_quirks2(battery);
+	return result;
 }
 
 /* --------------------------------------------------------------------------
