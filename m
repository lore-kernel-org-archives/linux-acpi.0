From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/32] ACPI: Battery: Add sysfs support
Date: Fri, 21 Sep 2007 23:46:28 -0400
Message-ID: <1190432816575-git-send-email-lenb@kernel.org>
References: <11904327981905-git-send-email-lenb@kernel.org>
 <11904327991059-git-send-email-lenb@kernel.org>
 <11904328003655-git-send-email-lenb@kernel.org>
 <11904328012791-git-send-email-lenb@kernel.org>
 <11904328011699-git-send-email-lenb@kernel.org>
 <1190432802575-git-send-email-lenb@kernel.org>
 <11904328031107-git-send-email-lenb@kernel.org>
 <11904328041498-git-send-email-lenb@kernel.org>
 <11904328052010-git-send-email-lenb@kernel.org>
 <11904328061489-git-send-email-lenb@kernel.org>
 <119043280633-git-send-email-lenb@kernel.org>
 <1190432807843-git-send-email-lenb@kernel.org>
 <1190432808586-git-send-email-lenb@kernel.org>
 <11904328092328-git-send-email-lenb@kernel.org>
 <11904328102889-git-send-email-lenb@kernel.org>
 <1190432811241-git-send-email-lenb@kernel.org>
 <11904328111749-git-send-email-lenb@kernel.org>
 <11904328122495-git-send-email-lenb@kernel.org>
 <1190432813700-git-send-email-lenb@kernel.org>
 <11904328141573-git-send-email-lenb@kernel.org>
 <11904328153830-git-send-email-lenb@kernel.org>
 <11904328151023-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18767 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756708AbXIVDrA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:47:00 -0400
In-Reply-To: <11904328151023-git-send-email-lenb@kernel.org>
Message-Id: <063a87f8cab5e3fd3ddbd979da7a15746947add2.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikivskiy@suse.de>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikivskiy@suse.de>

Refer to Documentation/power_supply_class.txt for interface description.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |  201 ++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 179 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index db725bf..b77180a 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -30,13 +30,21 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/jiffies.h>
+
+#ifdef CONFIG_ACPI_PROCFS
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
+#endif
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#if defined(CONFIG_POWER_SUPPLY) || defined(CONFIG_POWER_SUPPLY_MODULE)
+#define ENABLE_POWER_SUPPLY
+#include <linux/power_supply.h>
+#endif
+
 #define ACPI_BATTERY_VALUE_UNKNOWN 0xFFFFFFFF
 
 #define ACPI_BATTERY_COMPONENT		0x00040000
@@ -58,9 +66,19 @@ static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 
+#ifdef CONFIG_ACPI_PROCFS
 extern struct proc_dir_entry *acpi_lock_battery_dir(void);
 extern void *acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 
+enum acpi_battery_files {
+	info_tag = 0,
+	state_tag,
+	alarm_tag,
+	ACPI_BATTERY_NUMFILES,
+};
+
+#endif
+
 static const struct acpi_device_id battery_device_ids[] = {
 	{"PNP0C0A", 0},
 	{"", 0},
@@ -68,22 +86,19 @@ static const struct acpi_device_id battery_device_ids[] = {
 
 MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
-enum acpi_battery_files {
-	info_tag = 0,
-	state_tag,
-	alarm_tag,
-	ACPI_BATTERY_NUMFILES,
-};
 
 struct acpi_battery {
 	struct mutex lock;
+#ifdef ENABLE_POWER_SUPPLY
+	struct power_supply bat;
+#endif
 	struct acpi_device *device;
 	unsigned long update_time;
-	int present_rate;
-	int remaining_capacity;
-	int present_voltage;
+	int current_now;
+	int capacity_now;
+	int voltage_now;
 	int design_capacity;
-	int last_full_capacity;
+	int full_charge_capacity;
 	int technology;
 	int design_voltage;
 	int design_capacity_warning;
@@ -100,15 +115,119 @@ struct acpi_battery {
 	u8 alarm_present;
 };
 
+#define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
+
 inline int acpi_battery_present(struct acpi_battery *battery)
 {
 	return battery->device->status.battery_present;
 }
 
+#ifdef ENABLE_POWER_SUPPLY
+static int acpi_battery_technology(struct acpi_battery *battery)
+{
+	if (!strcasecmp("NiCd", battery->type))
+		return POWER_SUPPLY_TECHNOLOGY_NiCd;
+	if (!strcasecmp("NiMH", battery->type))
+		return POWER_SUPPLY_TECHNOLOGY_NiMH;
+	if (!strcasecmp("LION", battery->type))
+		return POWER_SUPPLY_TECHNOLOGY_LION;
+	if (!strcasecmp("LiP", battery->type))
+		return POWER_SUPPLY_TECHNOLOGY_LIPO;
+	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
+}
+
+static int acpi_battery_get_property(struct power_supply *psy,
+				     enum power_supply_property psp,
+				     union power_supply_propval *val)
+{
+	struct acpi_battery *battery = to_acpi_battery(psy);
+
+	if ((!acpi_battery_present(battery)) &&
+	     psp != POWER_SUPPLY_PROP_PRESENT)
+		return -ENODEV;
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (battery->state & 0x01)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (battery->state & 0x02)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (battery->state == 0)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = acpi_battery_present(battery);
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = acpi_battery_technology(battery);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = battery->design_voltage * 1000;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = battery->voltage_now * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = battery->current_now * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+		val->intval = battery->design_capacity * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+	case POWER_SUPPLY_PROP_ENERGY_FULL:
+		val->intval = battery->full_charge_capacity * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+	case POWER_SUPPLY_PROP_ENERGY_NOW:
+		val->intval = battery->capacity_now * 1000;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = battery->model_number;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = battery->oem_info;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property charge_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static enum power_supply_property energy_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
+	POWER_SUPPLY_PROP_ENERGY_FULL,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+#endif
+
+#ifdef CONFIG_ACPI_PROCFS
 inline char *acpi_battery_units(struct acpi_battery *battery)
 {
 	return (battery->power_unit)?"mA":"mW";
 }
+#endif
 
 /* --------------------------------------------------------------------------
                                Battery Management
@@ -120,15 +239,15 @@ struct acpi_offsets {
 
 static struct acpi_offsets state_offsets[] = {
 	{offsetof(struct acpi_battery, state), 0},
-	{offsetof(struct acpi_battery, present_rate), 0},
-	{offsetof(struct acpi_battery, remaining_capacity), 0},
-	{offsetof(struct acpi_battery, present_voltage), 0},
+	{offsetof(struct acpi_battery, current_now), 0},
+	{offsetof(struct acpi_battery, capacity_now), 0},
+	{offsetof(struct acpi_battery, voltage_now), 0},
 };
 
 static struct acpi_offsets info_offsets[] = {
 	{offsetof(struct acpi_battery, power_unit), 0},
 	{offsetof(struct acpi_battery, design_capacity), 0},
-	{offsetof(struct acpi_battery, last_full_capacity), 0},
+	{offsetof(struct acpi_battery, full_charge_capacity), 0},
 	{offsetof(struct acpi_battery, technology), 0},
 	{offsetof(struct acpi_battery, design_voltage), 0},
 	{offsetof(struct acpi_battery, design_capacity_warning), 0},
@@ -285,6 +404,17 @@ static int acpi_battery_update(struct acpi_battery *battery)
 		result = acpi_battery_get_info(battery);
 		if (result)
 			return result;
+#ifdef ENABLE_POWER_SUPPLY
+		if (battery->power_unit) {
+			battery->bat.properties = charge_battery_props;
+			battery->bat.num_properties =
+				ARRAY_SIZE(charge_battery_props);
+		} else {
+			battery->bat.properties = energy_battery_props;
+			battery->bat.num_properties =
+				ARRAY_SIZE(energy_battery_props);
+		}
+#endif
 		acpi_battery_init_alarm(battery);
 	}
 	return acpi_battery_get_state(battery);
@@ -294,6 +424,7 @@ static int acpi_battery_update(struct acpi_battery *battery)
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
+#ifdef CONFIG_ACPI_PROCFS
 static struct proc_dir_entry *acpi_battery_dir;
 
 static int acpi_battery_print_info(struct seq_file *seq, int result)
@@ -314,11 +445,11 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 			   battery->design_capacity,
 			   acpi_battery_units(battery));
 
-	if (battery->last_full_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
+	if (battery->full_charge_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "last full capacity:      unknown\n");
 	else
 		seq_printf(seq, "last full capacity:      %d %sh\n",
-			   battery->last_full_capacity,
+			   battery->full_charge_capacity,
 			   acpi_battery_units(battery));
 
 	seq_printf(seq, "battery technology:      %srechargeable\n",
@@ -375,22 +506,22 @@ static int acpi_battery_print_state(struct seq_file *seq, int result)
 	else
 		seq_printf(seq, "charging state:          charged\n");
 
-	if (battery->present_rate == ACPI_BATTERY_VALUE_UNKNOWN)
+	if (battery->current_now == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "present rate:            unknown\n");
 	else
 		seq_printf(seq, "present rate:            %d %s\n",
-			   battery->present_rate, acpi_battery_units(battery));
+			   battery->current_now, acpi_battery_units(battery));
 
-	if (battery->remaining_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
+	if (battery->capacity_now == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "remaining capacity:      unknown\n");
 	else
 		seq_printf(seq, "remaining capacity:      %d %sh\n",
-			   battery->remaining_capacity, acpi_battery_units(battery));
-	if (battery->present_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
+			   battery->capacity_now, acpi_battery_units(battery));
+	if (battery->voltage_now == ACPI_BATTERY_VALUE_UNKNOWN)
 		seq_printf(seq, "present voltage:         unknown\n");
 	else
 		seq_printf(seq, "present voltage:         %d mV\n",
-			   battery->present_voltage);
+			   battery->voltage_now);
       end:
 	if (result)
 		seq_printf(seq, "ERROR: Unable to read battery state\n");
@@ -564,6 +695,7 @@ static void acpi_battery_remove_fs(struct acpi_device *device)
 	acpi_device_dir(device) = NULL;
 }
 
+#endif
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -581,6 +713,9 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
 					device->dev.bus_id, event,
 					acpi_battery_present(battery));
+#ifdef ENABLE_POWER_SUPPLY
+	kobject_uevent(&battery->bat.dev->kobj, KOBJ_CHANGE);
+#endif
 }
 
 static int acpi_battery_add(struct acpi_device *device)
@@ -599,9 +734,17 @@ static int acpi_battery_add(struct acpi_device *device)
 	acpi_driver_data(device) = battery;
 	mutex_init(&battery->lock);
 	acpi_battery_update(battery);
+#ifdef CONFIG_ACPI_PROCFS
 	result = acpi_battery_add_fs(device);
 	if (result)
 		goto end;
+#endif
+#ifdef ENABLE_POWER_SUPPLY
+	battery->bat.name = acpi_device_bid(device);
+	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
+	battery->bat.get_property = acpi_battery_get_property;
+	result = power_supply_register(&battery->device->dev, &battery->bat);
+#endif
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_ALL_NOTIFY,
 					     acpi_battery_notify, battery);
@@ -615,7 +758,9 @@ static int acpi_battery_add(struct acpi_device *device)
 	       device->status.battery_present ? "present" : "absent");
       end:
 	if (result) {
+#ifdef CONFIG_ACPI_PROCFS
 		acpi_battery_remove_fs(device);
+#endif
 		kfree(battery);
 	}
 	return result;
@@ -632,7 +777,13 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY,
 					    acpi_battery_notify);
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_battery_remove_fs(device);
+#endif
+#ifdef ENABLE_POWER_SUPPLY
+	if (battery->bat.dev)
+		power_supply_unregister(&battery->bat);
+#endif
 	mutex_destroy(&battery->lock);
 	kfree(battery);
 	return 0;
@@ -664,11 +815,15 @@ static int __init acpi_battery_init(void)
 {
 	if (acpi_disabled)
 		return -ENODEV;
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir)
 		return -ENODEV;
+#endif
 	if (acpi_bus_register_driver(&acpi_battery_driver) < 0) {
+#ifdef CONFIG_ACPI_PROCFS
 		acpi_unlock_battery_dir(acpi_battery_dir);
+#endif
 		return -ENODEV;
 	}
 	return 0;
@@ -677,7 +832,9 @@ static int __init acpi_battery_init(void)
 static void __exit acpi_battery_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_battery_driver);
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_unlock_battery_dir(acpi_battery_dir);
+#endif
 }
 
 module_init(acpi_battery_init);
-- 
1.5.3.1.27.g57543
