From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 2/2] ACPI / SBS: Correct the value of power_now and power_avg in the sysfs
Date: Fri,  1 Jul 2011 16:03:39 +0800
Message-ID: <1309507419-19247-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:6431 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122Ab1GAIDj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Jul 2011 04:03:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, tianyu.lan@intel.com, rui.zhang@intel.com

https://bugzilla.kernel.org/show_bug.cgi?id=24492

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/sbs.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 01dad1b..c517ec8 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -230,11 +230,17 @@ static int acpi_sbs_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_POWER_NOW:
 		val->intval = abs(battery->rate_now) *
 				acpi_battery_ipscale(battery) * 1000;
+		val->intval *= (acpi_battery_mode(battery)) ?
+				(battery->voltage_now *
+				acpi_battery_vscale(battery) / 1000) : 1;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 	case POWER_SUPPLY_PROP_POWER_AVG:
 		val->intval = abs(battery->rate_avg) *
 				acpi_battery_ipscale(battery) * 1000;
+		val->intval *= (acpi_battery_mode(battery)) ?
+				(battery->voltage_now *
+				acpi_battery_vscale(battery) / 1000) : 1;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		val->intval = battery->state_of_charge;
-- 
1.7.6.rc2.8.g28eb

