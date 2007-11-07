From: Roland Dreier <roland@digitalvampire.org>
Subject: ACPI: Always return valid 'status' from acpi_battery_get_property()
Date: Wed, 07 Nov 2007 15:09:09 -0800
Message-ID: <87640d1wmi.fsf@shaolin.home.digitalvampire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:37033
	"EHLO QMTA07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753445AbXKGXQN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Nov 2007 18:16:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

If a battery is at a critical charge level and not being charged or
discharged, then the ACPI _BST method will return a state of 4, and
the current acpi_battery_get_property() code will not set any property
value for POWER_SUPPLY_PROP_STATUS.  This will cause an oops in
power_supply_show_property() when it reads off the end of the
status_text array.  This actually was causing a 100% reproducible
crash on boot on my laptop with two batteries, when one battery was
completely drained and the laptop was not plugged in.

Fix this by making sure acpi_battery_get_property() returns
POWER_SUPPLY_STATUS_UNKNOWN for any battery state it doesn't already
handle explicitly.  There doesn't seem to be any status enum value
defined that makes more sense than 'unknown' for a battery at a
critical charge level.

Signed-off-by: Roland Dreier <roland@digitalvampire.org>
---
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index c2ce0ad..cbb27b4 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -152,6 +152,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else if (battery->state == 0)
 			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = acpi_battery_present(battery);
