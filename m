From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 2/5] acpi: battery: make optional power_supply register
Date: Wed, 29 Jun 2016 17:00:16 -0700
Message-ID: <1467244819-19046-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1467244819-19046-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51184 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbcF2X6y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2016 19:58:54 -0400
In-Reply-To: <1467244819-19046-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added additional paramater to acpi_battery_common_add(), which makes it
optional to register with power_supply class or /proc/acpi/battery.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/battery.c        |  7 ++++++-
 drivers/acpi/battery.h        |  2 +-
 drivers/acpi/battery_common.c | 27 +++++++++++++++++----------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index a5c9bde..5482d50 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -85,13 +85,18 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 
 static SIMPLE_DEV_PM_OPS(acpi_battery_pm, NULL, acpi_battery_common_resume);
 
+static int acpi_battery_add(struct acpi_device *device)
+{
+	return acpi_battery_common_add(device, true);
+}
+
 static struct acpi_driver acpi_battery_driver = {
 	.name = "battery",
 	.class = ACPI_BATTERY_CLASS,
 	.ids = battery_device_ids,
 	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
-		.add = acpi_battery_common_add,
+		.add = acpi_battery_add,
 		.remove = acpi_battery_common_remove,
 		.notify = acpi_battery_common_notify,
 		},
diff --git a/drivers/acpi/battery.h b/drivers/acpi/battery.h
index 99cac62..626093c 100644
--- a/drivers/acpi/battery.h
+++ b/drivers/acpi/battery.h
@@ -26,7 +26,7 @@ extern int battery_bix_broken_package;
 extern int battery_notification_delay_ms;
 extern struct proc_dir_entry *acpi_battery_dir;
 
-int acpi_battery_common_add(struct acpi_device *device);
+int acpi_battery_common_add(struct acpi_device *device, bool power_supply_register);
 int acpi_battery_common_remove(struct acpi_device *device);
 int acpi_battery_common_resume(struct device *dev);
 void acpi_battery_common_notify(struct acpi_device *device, u32 event);
diff --git a/drivers/acpi/battery_common.c b/drivers/acpi/battery_common.c
index 868621a..873b104 100644
--- a/drivers/acpi/battery_common.c
+++ b/drivers/acpi/battery_common.c
@@ -141,6 +141,7 @@ struct acpi_battery {
 	int state;
 	int power_unit;
 	unsigned long flags;
+	bool power_supply_register;
 };
 
 #define to_acpi_battery(x) power_supply_get_drvdata(x)
@@ -1190,7 +1191,7 @@ static int acpi_battery_update_retry(struct acpi_battery *battery)
 	return ret;
 }
 
-int acpi_battery_common_add(struct acpi_device *device)
+int acpi_battery_common_add(struct acpi_device *device, bool power_supply_register)
 {
 	int result = 0;
 	struct acpi_battery *battery = NULL;
@@ -1212,18 +1213,22 @@ int acpi_battery_common_add(struct acpi_device *device)
 	mutex_init(&battery->sysfs_lock);
 	if (acpi_has_method(battery->device->handle, "_BIX"))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
-	result = acpi_battery_update_retry(battery);
-	if (result)
-		goto fail;
+
+	battery->power_supply_register = power_supply_register;
+	if (power_supply_register) {
+		result = acpi_battery_update_retry(battery);
+		if (result)
+			goto fail;
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
-	result = acpi_battery_add_fs(device);
+		result = acpi_battery_add_fs(device);
 #endif
-	if (result) {
+		if (result) {
 #ifdef CONFIG_ACPI_PROCFS_POWER
-		acpi_battery_remove_fs(device);
+			acpi_battery_remove_fs(device);
 #endif
-		goto fail;
+			goto fail;
+		}
 	}
 	pr_info(PREFIX "%s Slot [%s] (battery %s)\n",
 		ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
@@ -1254,10 +1259,12 @@ int acpi_battery_common_remove(struct acpi_device *device)
 	device_init_wakeup(&device->dev, 0);
 	battery = acpi_driver_data(device);
 	unregister_pm_notifier(&battery->pm_nb);
+	if (battery->power_supply_register) {
 #ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_battery_remove_fs(device);
+		acpi_battery_remove_fs(device);
 #endif
-	sysfs_remove_battery(battery);
+		sysfs_remove_battery(battery);
+	}
 	mutex_destroy(&battery->lock);
 	mutex_destroy(&battery->sysfs_lock);
 	kfree(battery);
-- 
2.5.0

