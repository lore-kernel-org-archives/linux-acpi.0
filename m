From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/11] ACPI: battery: Convert discharge energy rate to current
 properly
Date: Thu, 27 Nov 2008 02:25:07 -0500
Message-ID: <558073dd56707864f09d563b64e7c37c021e89d2.1227770639.git.len.brown@intel.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:42287 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbYK0HZV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 02:25:21 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAZ007N2DY7AGD3@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Nov 2008 01:25:20 -0600 (CST)
In-reply-to: <1227770716-26525-1-git-send-email-lenb@kernel.org>
In-reply-to: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
References: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <aystarik@gmail.com>

ACPI battery interface reports its state either in mW or in mA, and
discharge rate in your case is reported in mW. power_supply interface
does not have such a parameter, so current_now parameter is used
for all cases. But in case of mW, reported discharge should
be converted into mA.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Tested-by: Ferenc Wagner <wferi@niif.hu>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 1423b0c..a0a178d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -174,6 +174,15 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		val->intval = battery->current_now * 1000;
+		/* if power units are mW, convert to mA by
+		   dividing by current voltage (mV/1000) */
+		if (!battery->power_unit) {
+			if (battery->voltage_now) {
+				val->intval /= battery->voltage_now;
+				val->intval *= 1000;
+			} else
+				val->intval = -1;
+		}
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
-- 
1.5.6.5

