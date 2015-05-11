From: Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH] ACPI / battery: drop useless return statements
Date: Mon, 11 May 2015 22:48:46 +0100
Message-ID: <1431380926-2880-1-git-send-email-luis.henriques@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <luis.henriques@canonical.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/acpi/battery.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 69b8e607ec35..9c676a6f32ce 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1292,20 +1292,20 @@ static struct acpi_driver acpi_battery_driver = {
 
 static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
 {
+	int result;
+
 	dmi_check_system(bat_dmi_table);
-	
+
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir)
 		return;
 #endif
-	if (acpi_bus_register_driver(&acpi_battery_driver) < 0) {
+	result = acpi_bus_register_driver(&acpi_battery_driver);
 #ifdef CONFIG_ACPI_PROCFS_POWER
+	if (result < 0)
 		acpi_unlock_battery_dir(acpi_battery_dir);
 #endif
-		return;
-	}
-	return;
 }
 
 static int __init acpi_battery_init(void)
