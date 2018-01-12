From: Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>
Subject: [PATCH 3/4] ACPI / battery: use specialized print macros
Date: Fri, 12 Jan 2018 15:58:46 +0200
Message-ID: <20180112135847.14989-4-dmitry.rozhkov@linux.intel.com>
References: <20180112135847.14989-1-dmitry.rozhkov@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8703 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933582AbeALN7e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jan 2018 08:59:34 -0500
In-Reply-To: <20180112135847.14989-1-dmitry.rozhkov@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com, Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>

The kernel provides specialized macros for printing
info and warning messages which make the code shorter.

Use the specialized macros instead of bare printk()'s.

Also format one user visible string literal into a searchable one
line string.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>
---
 drivers/acpi/battery.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index e2c3ec690af1..36c525bc38ba 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -554,8 +554,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 		battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
 		(s16)(battery->rate_now) < 0) {
 		battery->rate_now = abs((s16)battery->rate_now);
-		printk_once(KERN_WARNING FW_BUG
-			    "battery: (dis)charge rate invalid.\n");
+		pr_warn_once(FW_BUG "battery: (dis)charge rate invalid.\n");
 	}
 
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
@@ -1056,8 +1055,7 @@ static int acpi_battery_add_fs(struct acpi_device *device)
 	struct proc_dir_entry *entry = NULL;
 	int i;
 
-	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for battery is loaded,"
-			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
+	pr_warning(PREFIX "Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_battery_dir);
@@ -1269,7 +1267,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	}
 #endif
 
-	printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
+	pr_info(PREFIX "%s Slot [%s] (battery %s)\n",
 		ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
 		device->status.battery_present ? "present" : "absent");
 
-- 
2.13.6

