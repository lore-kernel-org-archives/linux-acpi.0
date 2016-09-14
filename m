From: Dave Lambley <linux@davel.me.uk>
Subject: [PATCH] Avoid _BIX ACPI method on Lenovo Yoga 300.
Date: Wed, 14 Sep 2016 09:40:16 +0100
Message-ID: <1473842416-5156-1-git-send-email-linux@davel.me.uk>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.the-lambleys.org.uk ([212.47.234.164]:35984 "EHLO
        smtp.the-lambleys.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbcINIt5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2016 04:49:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dave Lambley <linux@davel.me.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On the (current?) Yoga 300 firmware, the _BIX method fails with an error.
This prevents the kernel from correctly detecting the presence of a
battery.

[   28.641906] ACPI Exception: AE_AML_PACKAGE_LIMIT, Index (0x000000010) is beyond end of object (length 0xD) (20160422/exoparg2-427)
[   28.641924] ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.H_EC.BAT1._BIX] (Node ffff9145fb0b2230), AE_AML_PACKAGE_LIMIT (20160422/psparse-542)

Fortunately, the _BIF method can be used to get battery information. This
change causes the kernel to use the _BIF method to preference on the
Yogo 300, allowing the battery to be detected correctly.

Signed-off-by: Dave Lambley <linux@davel.me.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Len Brown <lenb@kernel.org>
---
 drivers/acpi/battery.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index ab23479..2b165a8 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -69,6 +69,7 @@ MODULE_LICENSE("GPL");
 static async_cookie_t async_cookie;
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
+static int battery_avoid_bix;
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
@@ -434,11 +435,16 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 {
 	int result = -EFAULT;
 	acpi_status status = 0;
-	char *name = test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags) ?
-			"_BIX" : "_BIF";
+	bool use_bix = !battery_avoid_bix &&
+			test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
+
+	char *name = use_bix ? "_BIX" : "_BIF";
 
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
+	if (battery_avoid_bix)
+		dev_dbg(&battery->device->dev, "ACPI _BIX method blacklisted on this hardware, avoiding.");
+
 	if (!acpi_battery_present(battery))
 		return 0;
 	mutex_lock(&battery->lock);
@@ -451,11 +457,11 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		return -ENODEV;
 	}
 
-	if (battery_bix_broken_package)
+	if (use_bix && battery_bix_broken_package)
 		result = extract_package(battery, buffer.pointer,
 				extended_info_offsets + 1,
 				ARRAY_SIZE(extended_info_offsets) - 1);
-	else if (test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags))
+	else if (use_bix)
 		result = extract_package(battery, buffer.pointer,
 				extended_info_offsets,
 				ARRAY_SIZE(extended_info_offsets));
@@ -1134,6 +1140,12 @@ battery_notification_delay_quirk(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init
+battery_avoid_bix_quirk(const struct dmi_system_id *d)
+{
+	battery_avoid_bix = 1;
+	return 0;
+}
 static const struct dmi_system_id bat_dmi_table[] __initconst = {
 	{
 		.callback = battery_bix_broken_package_quirk,
@@ -1151,6 +1163,15 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-573G"),
 		},
 	},
+	{
+		.callback = battery_avoid_bix_quirk,
+		.ident = "Lenovo Yogo 3000",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "80M1"),
+		},
+	},
+
 	{},
 };
 
-- 
2.7.4

