From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [RFC][PATCH] ACPI: battery: add power_{now,
	avg} properties to power_class
Date: Tue, 16 Dec 2008 00:38:56 +0300
Message-ID: <20081215213855.8414.9349.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:39134 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756045AbYLOVi7 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 15 Dec 2008 16:38:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

ACPI has smart batteries, which work in units of energy and measure
rate of (dis)charge as power, thus it is not appropriate to export it
as a current_now.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c             |    3 ++-
 drivers/acpi/sbs.c                 |    6 ++++--
 drivers/power/power_supply_sysfs.c |    2 ++
 include/linux/power_supply.h       |    2 ++
 4 files changed, 10 insertions(+), 3 deletions(-)


diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 1423b0c..88f1fb5 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -173,6 +173,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		val->intval = battery->voltage_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_POWER_NOW:
 		val->intval = battery->current_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
@@ -223,7 +224,7 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_POWER_NOW,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_FULL,
 	POWER_SUPPLY_PROP_ENERGY_NOW,
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 6050ce4..994c04e 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -224,10 +224,12 @@ static int acpi_sbs_battery_get_property(struct power_supply *psy,
 				acpi_battery_vscale(battery) * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_POWER_NOW:
 		val->intval = abs(battery->current_now) *
 				acpi_battery_ipscale(battery) * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
+	case POWER_SUPPLY_PROP_POWER_AVG:
 		val->intval = abs(battery->current_avg) *
 				acpi_battery_ipscale(battery) * 1000;
 		break;
@@ -291,8 +293,8 @@ static enum power_supply_property sbs_energy_battery_props[] = {
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
-	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_POWER_AVG,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_FULL,
diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index 23ae846..7aa8b4e 100644
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
index f9348cb..105a707 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -72,6 +72,8 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_VOLTAGE_AVG,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_POWER_AVG,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL,

