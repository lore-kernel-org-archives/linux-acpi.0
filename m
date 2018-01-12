From: Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>
Subject: [PATCH 4/4] ACPI / battery: get rid of negations in conditions
Date: Fri, 12 Jan 2018 15:58:47 +0200
Message-ID: <20180112135847.14989-5-dmitry.rozhkov@linux.intel.com>
References: <20180112135847.14989-1-dmitry.rozhkov@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8703 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933582AbeALN7g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jan 2018 08:59:36 -0500
In-Reply-To: <20180112135847.14989-1-dmitry.rozhkov@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com, Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>

Simple conditions without negations inflict less cognitive load
on readers.

Rework conditional branches not to use negations. Also add braces
around single statement branches where their counterpart else-branches
consist of more than one statement as suggested in the paragraph 3 of
the coding style.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>
---
 drivers/acpi/battery.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 36c525bc38ba..38b5eed72685 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -848,7 +848,7 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 			   acpi_battery_units(battery));
 
 	seq_printf(seq, "battery technology:      %srechargeable\n",
-		   (!battery->technology)?"non-":"");
+		   battery->technology ? "" : "non-");
 
 	if (battery->design_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "design voltage:          unknown\n");
@@ -1135,7 +1135,9 @@ static int battery_notify(struct notifier_block *nb,
 		if (!acpi_battery_present(battery))
 			return 0;
 
-		if (!battery->bat) {
+		if (battery->bat) {
+			acpi_battery_refresh(battery);
+		} else {
 			result = acpi_battery_get_info(battery);
 			if (result)
 				return result;
@@ -1143,8 +1145,7 @@ static int battery_notify(struct notifier_block *nb,
 			result = sysfs_add_battery(battery);
 			if (result)
 				return result;
-		} else
-			acpi_battery_refresh(battery);
+		}
 
 		acpi_battery_init_alarm(battery);
 		acpi_battery_get_state(battery);
-- 
2.13.6

