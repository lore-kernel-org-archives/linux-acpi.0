From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: [PATCH 1/2] ACPI / battery: use callback for setting up quirks
Date: Wed,  4 Jun 2014 02:01:22 +0700
Message-ID: <1401822083-4866-1-git-send-email-mezin.alexander@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:48727 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaFCTCH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jun 2014 15:02:07 -0400
Received: by mail-lb0-f180.google.com with SMTP id p9so3739785lbv.11
        for <linux-acpi@vger.kernel.org>; Tue, 03 Jun 2014 12:02:05 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexander Mezin <mezin.alexander@gmail.com>

Use callback for setting up quirk instead of checking return code
of dmi_check_system(). This change will allow using bat_dmi_table
for other quirks.

Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
---
 drivers/acpi/battery.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6e7b2a1..f17bc7e 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1058,8 +1058,15 @@ static int battery_notify(struct notifier_block *nb,
 	return 0;
 }
 
+static int battery_bix_broken_package_quirk(const struct dmi_system_id *d)
+{
+	battery_bix_broken_package = 1;
+	return 0;
+}
+
 static struct dmi_system_id bat_dmi_table[] = {
 	{
+		.callback = battery_bix_broken_package_quirk,
 		.ident = "NEC LZ750/LS",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
@@ -1176,8 +1183,7 @@ static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
 	if (acpi_disabled)
 		return;
 
-	if (dmi_check_system(bat_dmi_table))
-		battery_bix_broken_package = 1;
+	dmi_check_system(bat_dmi_table);
 	
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_battery_dir = acpi_lock_battery_dir();
-- 
2.0.0

