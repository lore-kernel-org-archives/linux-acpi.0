From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: Battery: remove cycle from battery removal.
Date: Tue, 13 Nov 2007 12:23:06 +0300
Message-ID: <20071113092306.6242.1237.stgit@localhost.localdomain>
References: <473961C6.4090407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:57715 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750853AbXKMJXR (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 13 Nov 2007 04:23:17 -0500
In-Reply-To: <473961C6.4090407@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: Linux-acpi@vger.kernel.orgLinux-acpi@vger.kernel.org

get_property() should not call battery_update(),
it also should call get_status() only if battery is present to
avoid cycle and oops.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Tested-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Acked-by: Johannes Weiner <hannes@saeurebad.de>
---

 drivers/acpi/battery.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index c2ce0ad..192c244 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -132,7 +132,7 @@ static int acpi_battery_technology(struct acpi_battery *battery)
 	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 }
 
-static int acpi_battery_update(struct acpi_battery *battery);
+static int acpi_battery_get_state(struct acpi_battery *battery);
 
 static int acpi_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
@@ -140,10 +140,11 @@ static int acpi_battery_get_property(struct power_supply *psy,
 {
 	struct acpi_battery *battery = to_acpi_battery(psy);
 
-	if ((!acpi_battery_present(battery)) &&
-	     psp != POWER_SUPPLY_PROP_PRESENT)
+	if (acpi_battery_present(battery)) {
+		/* run battery update only if it is present */
+		acpi_battery_get_state(battery);
+	} else if (psp != POWER_SUPPLY_PROP_PRESENT)
 		return -ENODEV;
-	acpi_battery_update(battery);
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		if (battery->state & 0x01)
@@ -457,6 +458,7 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 		return;
 	device_remove_file(battery->bat.dev, &alarm_attr);
 	power_supply_unregister(&battery->bat);
+	battery->bat.dev = NULL;
 }
 
 static int acpi_battery_update(struct acpi_battery *battery)

