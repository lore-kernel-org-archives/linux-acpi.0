From: Len Brown <lenb@kernel.org>
Subject: [PATCH 96/98] ACPI: battery: add power_{now,avg} properties to
 power_class
Date: Sat, 28 Mar 2009 00:32:11 -0400
Message-ID: <7faa144a518c456e2057918f030f50100144ccc6.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38357 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbZC1Ed7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:59 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7008PS8OD6IQG@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:50 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

ACPI has smart batteries, which work in units of energy and measure
rate of (dis)charge as power, thus it is not appropriate to export it
as a current_now. Current_now will still be exported to allow
for userland applications to match.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c             |   12 +++++++-----
 drivers/acpi/sbs.c                 |   27 ++++++++++++++++-----------
 drivers/power/power_supply_sysfs.c |    2 ++
 include/linux/power_supply.h       |    2 ++
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 69cbc57..09a2240 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -92,7 +92,7 @@ struct acpi_battery {
 #endif
 	struct acpi_device *device;
 	unsigned long update_time;
-	int current_now;
+	int rate_now;
 	int capacity_now;
 	int voltage_now;
 	int design_capacity;
@@ -196,7 +196,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		val->intval = battery->voltage_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		val->intval = battery->current_now * 1000;
+	case POWER_SUPPLY_PROP_POWER_NOW:
+		val->intval = battery->rate_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
@@ -247,6 +248,7 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_POWER_NOW,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_FULL,
 	POWER_SUPPLY_PROP_ENERGY_NOW,
@@ -273,7 +275,7 @@ struct acpi_offsets {
 
 static struct acpi_offsets state_offsets[] = {
 	{offsetof(struct acpi_battery, state), 0},
-	{offsetof(struct acpi_battery, current_now), 0},
+	{offsetof(struct acpi_battery, rate_now), 0},
 	{offsetof(struct acpi_battery, capacity_now), 0},
 	{offsetof(struct acpi_battery, voltage_now), 0},
 };
@@ -605,11 +607,11 @@ static int acpi_battery_print_state(struct seq_file *seq, int result)
 	else
 		seq_printf(seq, "charging state:          charged\n");
 
-	if (battery->current_now == ACPI_BATTERY_VALUE_UNKNOWN)
+	if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "present rate:            unknown\n");
 	else
 		seq_printf(seq, "present rate:            %d %s\n",
-			   battery->current_now, acpi_battery_units(battery));
+			   battery->rate_now, acpi_battery_units(battery));
 
 	if (battery->capacity_now == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "remaining capacity:      unknown\n");
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 6050ce4..3963cb6 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -102,8 +102,8 @@ struct acpi_battery {
 	u16 cycle_count;
 	u16 temp_now;
 	u16 voltage_now;
-	s16 current_now;
-	s16 current_avg;
+	s16 rate_now;
+	s16 rate_avg;
 	u16 capacity_now;
 	u16 state_of_charge;
 	u16 state;
@@ -202,9 +202,9 @@ static int acpi_sbs_battery_get_property(struct power_supply *psy,
 		return -ENODEV;
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		if (battery->current_now < 0)
+		if (battery->rate_now < 0)
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
-		else if (battery->current_now > 0)
+		else if (battery->rate_now > 0)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_FULL;
@@ -224,11 +224,13 @@ static int acpi_sbs_battery_get_property(struct power_supply *psy,
 				acpi_battery_vscale(battery) * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		val->intval = abs(battery->current_now) *
+	case POWER_SUPPLY_PROP_POWER_NOW:
+		val->intval = abs(battery->rate_now) *
 				acpi_battery_ipscale(battery) * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
-		val->intval = abs(battery->current_avg) *
+	case POWER_SUPPLY_PROP_POWER_AVG:
+		val->intval = abs(battery->rate_avg) *
 				acpi_battery_ipscale(battery) * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
@@ -293,6 +295,8 @@ static enum power_supply_property sbs_energy_battery_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_POWER_AVG,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_FULL,
@@ -301,6 +305,7 @@ static enum power_supply_property sbs_energy_battery_props[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
+
 #endif
 
 /* --------------------------------------------------------------------------
@@ -330,8 +335,8 @@ static struct acpi_battery_reader info_readers[] = {
 static struct acpi_battery_reader state_readers[] = {
 	{0x08, SMBUS_READ_WORD, offsetof(struct acpi_battery, temp_now)},
 	{0x09, SMBUS_READ_WORD, offsetof(struct acpi_battery, voltage_now)},
-	{0x0a, SMBUS_READ_WORD, offsetof(struct acpi_battery, current_now)},
-	{0x0b, SMBUS_READ_WORD, offsetof(struct acpi_battery, current_avg)},
+	{0x0a, SMBUS_READ_WORD, offsetof(struct acpi_battery, rate_now)},
+	{0x0b, SMBUS_READ_WORD, offsetof(struct acpi_battery, rate_avg)},
 	{0x0f, SMBUS_READ_WORD, offsetof(struct acpi_battery, capacity_now)},
 	{0x0e, SMBUS_READ_WORD, offsetof(struct acpi_battery, state_of_charge)},
 	{0x16, SMBUS_READ_WORD, offsetof(struct acpi_battery, state)},
@@ -589,9 +594,9 @@ static int acpi_battery_read_state(struct seq_file *seq, void *offset)
 	seq_printf(seq, "capacity state:          %s\n",
 		   (battery->state & 0x0010) ? "critical" : "ok");
 	seq_printf(seq, "charging state:          %s\n",
-		   (battery->current_now < 0) ? "discharging" :
-		   ((battery->current_now > 0) ? "charging" : "charged"));
-	rate = abs(battery->current_now) * acpi_battery_ipscale(battery);
+		   (battery->rate_now < 0) ? "discharging" :
+		   ((battery->rate_now > 0) ? "charging" : "charged"));
+	rate = abs(battery->rate_now) * acpi_battery_ipscale(battery);
 	rate *= (acpi_battery_mode(battery))?(battery->voltage_now *
 			acpi_battery_vscale(battery)/1000):1;
 	seq_printf(seq, "present rate:            %d%s\n", rate,
diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index ac01e06..da73591 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -93,6 +93,8 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(voltage_avg),
 	POWER_SUPPLY_ATTR(current_now),
 	POWER_SUPPLY_ATTR(current_avg),
+	POWER_SUPPLY_ATTR(power_now),
+	POWER_SUPPLY_ATTR(power_avg),
 	POWER_SUPPLY_ATTR(charge_full_design),
 	POWER_SUPPLY_ATTR(charge_empty_design),
 	POWER_SUPPLY_ATTR(charge_full),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 8ff25e0..594c494 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -73,6 +73,8 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_VOLTAGE_AVG,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_POWER_AVG,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
-- 
1.6.0.6

