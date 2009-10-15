From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 3/4] ACPI: SBS: Export cycle_count
Date: Thu, 15 Oct 2009 14:31:37 +0400
Message-ID: <20091015103137.3853.65255.stgit@thinkpad>
References: <20091015103122.3853.34760.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:37217 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757117AbZJOKcP (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 15 Oct 2009 06:32:15 -0400
In-Reply-To: <20091015103122.3853.34760.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
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

