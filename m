From: Len Brown <lenb@kernel.org>
Subject: [PATCH 42/60] ACPI battery: support percentage battery remaining
 capacity
Date: Mon, 25 Oct 2010 02:20:50 -0400
Message-ID: <557d58687dcdee6bc00c1a8f1fd4e0eac8fefce9.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab0JYHLT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:19 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:12 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

According to the ACPI spec, some kinds of primary battery can
report percentage battery remaining capacity directly to OS.

In this case, it reports the LastFullChargedCapacity == 100,
BatteryPresentRate = 0xFFFFFFFF, and BatteryRemaingCapacity a
percentage value, which actually means RemainingBatteryPercentage.

Now we found some battery follows this rule even if it's a rechargeable.
https://bugzilla.kernel.org/show_bug.cgi?id=15979

Handle these batteries correctly in ACPI battery driver
so that they won't break userspace.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 7b8787b..0b2707e 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -95,6 +95,7 @@ enum {
 	 * due to bad math.
 	 */
 	ACPI_BATTERY_QUIRK_SIGNED16_CURRENT,
+	ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY,
 };
 
 struct acpi_battery {
@@ -405,6 +406,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		result = extract_package(battery, buffer.pointer,
 				info_offsets, ARRAY_SIZE(info_offsets));
 	kfree(buffer.pointer);
+	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags))
+		battery->full_charge_capacity = battery->design_capacity;
 	return result;
 }
 
@@ -441,6 +444,10 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	    battery->rate_now != -1)
 		battery->rate_now = abs((s16)battery->rate_now);
 
+	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
+	    && battery->capacity_now >= 0 && battery->capacity_now <= 100)
+		battery->capacity_now = (battery->capacity_now *
+				battery->full_charge_capacity) / 100;
 	return result;
 }
 
@@ -552,6 +559,33 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
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
@@ -573,7 +607,9 @@ static int acpi_battery_update(struct acpi_battery *battery)
 	}
 	if (!battery->bat.dev)
 		sysfs_add_battery(battery);
-	return acpi_battery_get_state(battery);
+	result = acpi_battery_get_state(battery);
+	acpi_battery_quirks2(battery);
+	return result;
 }
 
 /* --------------------------------------------------------------------------
-- 
1.7.3.2.90.gd4c43

