From: srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH] ACPI Battery: Added capacity
Date: Thu,  5 Apr 2012 17:38:54 -0700
Message-ID: <1333672734-10536-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11192 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967Ab2DFAvc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Apr 2012 20:51:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>

Added Capacity field, which is a pre-defined power_supply
property. Calculating capacity using current charge/energy and
full charge/energy.
Some user mode implementations are relying on capacity field to
show battery strength and power down decision.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/acpi/battery.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fcc13ac..997b369 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -251,6 +251,13 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		else
 			val->intval = battery->capacity_now * 1000;
 		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		if (battery->capacity_now && battery->full_charge_capacity)
+			val->intval = battery->capacity_now * 100/
+					battery->full_charge_capacity;
+		else
+			val->intval = 0;
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = battery->model_number;
 		break;
@@ -277,6 +284,7 @@ static enum power_supply_property charge_battery_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
@@ -293,6 +301,7 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_FULL,
 	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
-- 
1.7.4.4

