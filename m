From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/34] ACPI: SBS: Export cycle_count
Date: Sun, 14 Mar 2010 21:40:46 -0400
Message-ID: <16698857fba1b10af4890055272975adf5686e83.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:39609 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab0COBs3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:48:29 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA00MA7VOP0CG0@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:48:26 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbs.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 52b9db8..38412ec 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -217,6 +217,9 @@ static int acpi_sbs_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
 		val->intval = acpi_battery_technology(battery);
 		break;
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		val->intval = battery->cycle_count;
+		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		val->intval = battery->design_voltage *
 			acpi_battery_vscale(battery) * 1000;
@@ -276,6 +279,7 @@ static enum power_supply_property sbs_charge_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
@@ -560,6 +564,7 @@ static int acpi_battery_read_info(struct seq_file *seq, void *offset)
 		   battery->design_voltage * acpi_battery_vscale(battery));
 	seq_printf(seq, "design capacity warning: unknown\n");
 	seq_printf(seq, "design capacity low:     unknown\n");
+	seq_printf(seq, "cycle count:		  %i\n", battery->cycle_count);
 	seq_printf(seq, "capacity granularity 1:  unknown\n");
 	seq_printf(seq, "capacity granularity 2:  unknown\n");
 	seq_printf(seq, "model number:            %s\n", battery->device_name);
-- 
1.7.0.2.201.g80978

