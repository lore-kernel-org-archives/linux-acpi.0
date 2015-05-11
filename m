From: Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH] ACPI / battery: abort initialization earlier if acpi_disabled
Date: Mon, 11 May 2015 22:48:38 +0100
Message-ID: <1431380918-2837-1-git-send-email-luis.henriques@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47437 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbbEKVsm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 May 2015 17:48:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <luis.henriques@canonical.com>

If ACPI is disabled there's no need to schedule an async function call,
the driver initialization can be aborted earlier in acpi_battery_init().

Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/acpi/battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 63d43677f644..69b8e607ec35 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1292,9 +1292,6 @@ static struct acpi_driver acpi_battery_driver = {
 
 static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
 {
-	if (acpi_disabled)
-		return;
-
 	dmi_check_system(bat_dmi_table);
 	
 #ifdef CONFIG_ACPI_PROCFS_POWER
@@ -1313,6 +1310,9 @@ static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
 
 static int __init acpi_battery_init(void)
 {
+	if (acpi_disabled)
+		return -ENODEV;
+
 	async_schedule(acpi_battery_init_async, NULL);
 	return 0;
 }
