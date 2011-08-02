From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/27] ACPI / SBS: Correct the value of power_now and power_avg
 in the sysfs
Date: Tue, 02 Aug 2011 16:53:10 -0400
Message-ID: <e4108292cc5b5ca07abc83af31a78338362810ca.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:47535 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320Ab1HBUyF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 16:54:05 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB0080HJE4DN52@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 15:54:05 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, Len Brown <len.brown@intel.com>

From: Lan Tianyu <tianyu.lan@intel.com>

https://bugzilla.kernel.org/show_bug.cgi?id=24492

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.7.6.396.ge0613

