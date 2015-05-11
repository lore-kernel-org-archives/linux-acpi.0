From: Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH] ACPI / battery: ensure acpi_battery_init() has finish
Date: Mon, 11 May 2015 22:49:05 +0100
Message-ID: <1431380945-2923-1-git-send-email-luis.henriques@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <luis.henriques@canonical.com>
List-Id: linux-acpi@vger.kernel.org

Make sure that async function scheduled with async_schedule() has already
been executed.

Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/acpi/battery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9c676a6f32ce..547e627611e0 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -70,6 +70,7 @@ MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("ACPI Battery Driver");
 MODULE_LICENSE("GPL");
 
+static async_cookie_t async_cookie;
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
 static unsigned int cache_time = 1000;
@@ -1313,12 +1314,13 @@ static int __init acpi_battery_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
-	async_schedule(acpi_battery_init_async, NULL);
+	async_cookie = async_schedule(acpi_battery_init_async, NULL);
 	return 0;
 }
 
 static void __exit acpi_battery_exit(void)
 {
+	async_synchronize_cookie(async_cookie);
 	acpi_bus_unregister_driver(&acpi_battery_driver);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_unlock_battery_dir(acpi_battery_dir);
