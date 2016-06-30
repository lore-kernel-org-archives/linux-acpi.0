From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 3/5] acpi: battery: allow externel access of battery information
Date: Wed, 29 Jun 2016 17:00:17 -0700
Message-ID: <1467244819-19046-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1467244819-19046-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28023 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbcF2X65 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2016 19:58:57 -0400
In-Reply-To: <1467244819-19046-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Moved acpi_battery structure to battery.h, so that fields can be
accessed from other modules using battery_common. Also export
acpi_battery_update(), to read the latest battery information from
ACPI.
Removed include for battery.h from drivers/acpi/sbs, where it was not
used but has the same structure name for acpi_battery.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/battery.h        | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/battery_common.c | 43 ++-----------------------------------------
 drivers/acpi/sbs.c            |  1 -
 3 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/battery.h b/drivers/acpi/battery.h
index 626093c..fd2586a 100644
--- a/drivers/acpi/battery.h
+++ b/drivers/acpi/battery.h
@@ -16,12 +16,52 @@
 #ifndef __ACPI_BATTERY_H
 #define __ACPI_BATTERY_H
 
+#include <linux/acpi.h>
+#include <linux/power_supply.h>
+
 #define ACPI_BATTERY_CLASS "battery"
 
 #define ACPI_BATTERY_NOTIFY_STATUS	0x80
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
 #define ACPI_BATTERY_NOTIFY_THRESHOLD   0x82
 
+struct acpi_battery {
+	struct mutex lock;
+	struct mutex sysfs_lock;
+	struct power_supply *bat;
+	struct power_supply_desc bat_desc;
+	struct acpi_device *device;
+	struct notifier_block pm_nb;
+	unsigned long update_time;
+	int revision;
+	int rate_now;
+	int capacity_now;
+	int voltage_now;
+	int design_capacity;
+	int full_charge_capacity;
+	int technology;
+	int design_voltage;
+	int design_capacity_warning;
+	int design_capacity_low;
+	int cycle_count;
+	int measurement_accuracy;
+	int max_sampling_time;
+	int min_sampling_time;
+	int max_averaging_interval;
+	int min_averaging_interval;
+	int capacity_granularity_1;
+	int capacity_granularity_2;
+	int alarm;
+	char model_number[32];
+	char serial_number[32];
+	char type[32];
+	char oem_info[32];
+	int state;
+	int power_unit;
+	unsigned long flags;
+	bool power_supply_register;
+};
+
 extern int battery_bix_broken_package;
 extern int battery_notification_delay_ms;
 extern struct proc_dir_entry *acpi_battery_dir;
@@ -30,6 +70,7 @@ int acpi_battery_common_add(struct acpi_device *device, bool power_supply_regist
 int acpi_battery_common_remove(struct acpi_device *device);
 int acpi_battery_common_resume(struct device *dev);
 void acpi_battery_common_notify(struct acpi_device *device, u32 event);
+int acpi_battery_update(struct acpi_battery *battery, bool resume);
 
 /* Defined in cm_sbs.c */
 #ifdef CONFIG_ACPI_PROCFS_POWER
diff --git a/drivers/acpi/battery_common.c b/drivers/acpi/battery_common.c
index 873b104..aaf32ab 100644
--- a/drivers/acpi/battery_common.c
+++ b/drivers/acpi/battery_common.c
@@ -39,9 +39,6 @@
 #include <linux/uaccess.h>
 #endif
 
-#include <linux/acpi.h>
-#include <linux/power_supply.h>
-
 #include "battery.h"
 
 #define PREFIX "ACPI: "
@@ -107,43 +104,6 @@ enum {
 	ACPI_BATTERY_QUIRK_THINKPAD_MAH,
 };
 
-struct acpi_battery {
-	struct mutex lock;
-	struct mutex sysfs_lock;
-	struct power_supply *bat;
-	struct power_supply_desc bat_desc;
-	struct acpi_device *device;
-	struct notifier_block pm_nb;
-	unsigned long update_time;
-	int revision;
-	int rate_now;
-	int capacity_now;
-	int voltage_now;
-	int design_capacity;
-	int full_charge_capacity;
-	int technology;
-	int design_voltage;
-	int design_capacity_warning;
-	int design_capacity_low;
-	int cycle_count;
-	int measurement_accuracy;
-	int max_sampling_time;
-	int min_sampling_time;
-	int max_averaging_interval;
-	int min_averaging_interval;
-	int capacity_granularity_1;
-	int capacity_granularity_2;
-	int alarm;
-	char model_number[32];
-	char serial_number[32];
-	char type[32];
-	char oem_info[32];
-	int state;
-	int power_unit;
-	unsigned long flags;
-	bool power_supply_register;
-};
-
 #define to_acpi_battery(x) power_supply_get_drvdata(x)
 
 static inline int acpi_battery_present(struct acpi_battery *battery)
@@ -723,7 +683,7 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
 	}
 }
 
-static int acpi_battery_update(struct acpi_battery *battery, bool resume)
+int acpi_battery_update(struct acpi_battery *battery, bool resume)
 {
 	int result, old_present = acpi_battery_present(battery);
 
@@ -768,6 +728,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 
 	return result;
 }
+EXPORT_SYMBOL_GPL(acpi_battery_update);
 
 static void acpi_battery_refresh(struct acpi_battery *battery)
 {
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index ad0b13a..5fbeff2 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -34,7 +34,6 @@
 #include <linux/dmi.h>
 
 #include "sbshc.h"
-#include "battery.h"
 
 #define PREFIX "ACPI: "
 
-- 
2.5.0

