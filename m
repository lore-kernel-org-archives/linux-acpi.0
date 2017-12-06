From: Ognjen Galic <smclt30p@gmail.com>
Subject: [PATCH 2/3] battery: Add the ThinkPad "Not Charging" quirk
Date: Wed, 6 Dec 2017 23:53:01 +0100
Message-ID: <20171206225301.GA3837@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39888 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbdLFWxK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Dec 2017 17:53:10 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org

The EC/ACPI firmware on Lenovo ThinkPads used to report a status
of "Unknown" when the battery is between the charge start and
charge stop thresholds. On Windows, it reports "Not Charging"
so the quirk has been added to also report correctly.

Now the "status" attribute returns "Not Charging" when the
battery on ThinkPads is not physicaly charging.

Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
---
 drivers/acpi/battery.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 2951d07..1afc9c7 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -57,6 +57,13 @@
 #define ACPI_BATTERY_STATE_DISCHARGING	0x1
 #define ACPI_BATTERY_STATE_CHARGING	0x2
 #define ACPI_BATTERY_STATE_CRITICAL	0x4
+/*
+ * On Lenovo ThinkPads the ACPI firmware
+ * returns a custom response when the battery
+ * is configured with wear control and the battery
+ * is between the start and stop charge thresholds.
+ */
+#define ACPI_BATTERY_STATE_NOT_CHARGING 0x8
 
 #define _COMPONENT		ACPI_BATTERY_COMPONENT
 
@@ -71,6 +78,7 @@ static async_cookie_t async_cookie;
 static bool battery_driver_registered;
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
+static int battery_quirk_thinkpad_notcharging;
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
@@ -222,6 +230,9 @@ static int acpi_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else if (acpi_battery_is_charged(battery))
 			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else if (battery_quirk_thinkpad_notcharging &&
+				val->intval & ACPI_BATTERY_STATE_NOT_CHARGING)
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		break;
@@ -1301,6 +1312,13 @@ battery_notification_delay_quirk(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init
+battery_quirk_not_charging(const struct dmi_system_id *d)
+{
+	battery_quirk_thinkpad_notcharging = 1;
+	return 0;
+}
+
 static const struct dmi_system_id bat_dmi_table[] __initconst = {
 	{
 		.callback = battery_bix_broken_package_quirk,
@@ -1318,6 +1336,14 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-573G"),
 		},
 	},
+	{
+		.callback = battery_quirk_not_charging,
+		.ident = "Lenovo ThinkPad",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
+		},
+	},
 	{},
 };
 
-- 
2.7.4

