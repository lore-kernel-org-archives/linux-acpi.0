From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/32] ACPI: SBS: Add support for power_supply class (and sysfs)
Date: Fri, 21 Sep 2007 23:46:19 -0400
Message-ID: <11904328092328-git-send-email-lenb@kernel.org>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:2443 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756868AbXIVDqv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:46:51 -0400
In-Reply-To: <1190432808586-git-send-email-lenb@kernel.org>
Message-Id: <fa5e2338bbbe17700781e6fdabf6cc158667c987.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <aystarik@gmail.com>

Add support for power_supply class and sysfs interface of it.
Refer to Documentation/power_supply_class.txt for interface description.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbs.c |  331 +++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 250 insertions(+), 81 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 3351dea..74abfd3 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -28,17 +28,23 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
+
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
+
 #include <linux/acpi.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
 
+#if defined(CONFIG_POWER_SUPPLY) || defined (CONFIG_POWER_SUPPLY_MODULE)
+#define ENABLE_POWER_SUPPLY
+#include <linux/power_supply.h>
+#endif
+
 #include "sbshc.h"
 
-#define ACPI_SBS_COMPONENT		0x00080000
 #define ACPI_SBS_CLASS			"sbs"
 #define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_BATTERY_CLASS		"battery"
@@ -58,8 +64,6 @@ enum acpi_sbs_device_addr {
 #define ACPI_SBS_NOTIFY_STATUS		0x80
 #define ACPI_SBS_NOTIFY_INFO		0x81
 
-ACPI_MODULE_NAME("sbs");
-
 MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("Smart Battery System ACPI interface driver");
 MODULE_LICENSE("GPL");
@@ -76,28 +80,16 @@ extern void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 #define MAX_SBS_BAT			4
 #define ACPI_SBS_BLOCK_MAX		32
 
-static int acpi_sbs_add(struct acpi_device *device);
-static int acpi_sbs_remove(struct acpi_device *device, int type);
-static int acpi_sbs_resume(struct acpi_device *device);
-
 static const struct acpi_device_id sbs_device_ids[] = {
 	{"ACPI0002", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, sbs_device_ids);
 
-static struct acpi_driver acpi_sbs_driver = {
-	.name = "sbs",
-	.class = ACPI_SBS_CLASS,
-	.ids = sbs_device_ids,
-	.ops = {
-		.add = acpi_sbs_add,
-		.remove = acpi_sbs_remove,
-		.resume = acpi_sbs_resume,
-		},
-};
-
 struct acpi_battery {
+#ifdef ENABLE_POWER_SUPPLY
+	struct power_supply bat;
+#endif
 	struct acpi_sbs *sbs;
 	struct proc_dir_entry *proc_entry;
 	unsigned long update_time;
@@ -105,7 +97,7 @@ struct acpi_battery {
 	char manufacturer_name[ACPI_SBS_BLOCK_MAX];
 	char device_name[ACPI_SBS_BLOCK_MAX];
 	char device_chemistry[ACPI_SBS_BLOCK_MAX];
-	u32 alarm_capacity;
+	u16 alarm_capacity;
 	u16 full_charge_capacity;
 	u16 design_capacity;
 	u16 design_voltage;
@@ -124,7 +116,12 @@ struct acpi_battery {
 	u8 present:1;
 };
 
+#define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
+
 struct acpi_sbs {
+#ifdef ENABLE_POWER_SUPPLY
+	struct power_supply charger;
+#endif
 	struct acpi_device *device;
 	struct acpi_smb_hc *hc;
 	struct mutex lock;
@@ -135,6 +132,8 @@ struct acpi_sbs {
 	u8 charger_present:1;
 };
 
+#define to_acpi_sbs(x) container_of(x, struct acpi_sbs, charger)
+
 static inline int battery_scale(int log)
 {
 	int scale = 1;
@@ -164,6 +163,146 @@ static inline int acpi_battery_scale(struct acpi_battery *battery)
 	    acpi_battery_ipscale(battery);
 }
 
+#ifdef ENABLE_POWER_SUPPLY
+static int sbs_get_ac_property(struct power_supply *psy,
+			       enum power_supply_property psp,
+			       union power_supply_propval *val)
+{
+	struct acpi_sbs *sbs = to_acpi_sbs(psy);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = sbs->charger_present;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int acpi_battery_technology(struct acpi_battery *battery)
+{
+	if (!strcasecmp("NiCd", battery->device_chemistry))
+		return POWER_SUPPLY_TECHNOLOGY_NiCd;
+	if (!strcasecmp("NiMH", battery->device_chemistry))
+		return POWER_SUPPLY_TECHNOLOGY_NiMH;
+	if (!strcasecmp("LION", battery->device_chemistry))
+		return POWER_SUPPLY_TECHNOLOGY_LION;
+	if (!strcasecmp("LiP", battery->device_chemistry))
+		return POWER_SUPPLY_TECHNOLOGY_LIPO;
+	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
+}
+
+static int acpi_sbs_battery_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	struct acpi_battery *battery = to_acpi_battery(psy);
+
+	if ((!battery->present) && psp != POWER_SUPPLY_PROP_PRESENT)
+		return -ENODEV;
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (battery->current_now < 0)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (battery->current_now > 0)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = battery->present;
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = acpi_battery_technology(battery);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = battery->design_voltage *
+			acpi_battery_vscale(battery) * 1000;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = battery->voltage_now *
+				acpi_battery_vscale(battery) * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = abs(battery->current_now) *
+				acpi_battery_ipscale(battery) * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		val->intval = abs(battery->current_avg) *
+				acpi_battery_ipscale(battery) * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = battery->state_of_charge;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+		val->intval = battery->design_capacity *
+			acpi_battery_scale(battery) * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+	case POWER_SUPPLY_PROP_ENERGY_FULL:
+		val->intval = battery->full_charge_capacity *
+			acpi_battery_scale(battery) * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+	case POWER_SUPPLY_PROP_ENERGY_NOW:
+		val->intval = battery->capacity_now *
+				acpi_battery_scale(battery) * 1000;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = battery->temp_now - 2730;	// dK -> dC
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = battery->device_name;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = battery->manufacturer_name;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property sbs_ac_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static enum power_supply_property sbs_charge_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static enum power_supply_property sbs_energy_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
+	POWER_SUPPLY_PROP_ENERGY_FULL,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+#endif
+
 /* --------------------------------------------------------------------------
                             Smart Battery System Management
    -------------------------------------------------------------------------- */
@@ -204,7 +343,7 @@ static int acpi_manager_get_info(struct acpi_sbs *sbs)
 	u16 battery_system_info;
 
 	result = acpi_smbus_read(sbs->hc, SMBUS_READ_WORD, ACPI_SBS_MANAGER,
-				 0x04, (u8 *) & battery_system_info);
+				 0x04, (u8 *)&battery_system_info);
 	if (!result)
 		sbs->batteries_supported = battery_system_info & 0x000f;
 	return result;
@@ -215,9 +354,12 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	int i, result = 0;
 
 	for (i = 0; i < ARRAY_SIZE(info_readers); ++i) {
-		result = acpi_smbus_read(battery->sbs->hc, info_readers[i].mode,
-				    ACPI_SBS_BATTERY, info_readers[i].command,
-				    (u8 *) battery + info_readers[i].offset);
+		result = acpi_smbus_read(battery->sbs->hc,
+					 info_readers[i].mode,
+					 ACPI_SBS_BATTERY,
+					 info_readers[i].command,
+					 (u8 *) battery +
+						info_readers[i].offset);
 		if (result)
 			break;
 	}
@@ -228,7 +370,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 {
 	int i, result = 0;
 
-	if (time_before(jiffies, battery->update_time +
+	if (battery->update_time &&
+	    time_before(jiffies, battery->update_time +
 				msecs_to_jiffies(cache_time)))
 		return 0;
 	for (i = 0; i < ARRAY_SIZE(state_readers); ++i) {
@@ -250,26 +393,36 @@ static int acpi_battery_get_alarm(struct acpi_battery *battery)
 {
 	return acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
 				 ACPI_SBS_BATTERY, 0x01,
-				 (u8 *) & battery->alarm_capacity);
+				 (u8 *)&battery->alarm_capacity);
 }
 
 static int acpi_battery_set_alarm(struct acpi_battery *battery)
 {
 	struct acpi_sbs *sbs = battery->sbs;
-	u16 value;
-	return 0;
+	u16 value, sel = 1 << (battery->id + 12);
+
+	int ret;
+
 
 	if (sbs->manager_present) {
-		acpi_smbus_read(sbs->hc, SMBUS_READ_WORD, ACPI_SBS_MANAGER,
+		ret = acpi_smbus_read(sbs->hc, SMBUS_READ_WORD, ACPI_SBS_MANAGER,
 				0x01, (u8 *)&value);
-		value &= 0x0fff;
-		value |= 1 << (battery->id + 12);
-		acpi_smbus_write(sbs->hc, SMBUS_WRITE_WORD, ACPI_SBS_MANAGER,
-				0x01, (u8 *)&value, 2);
+		if (ret)
+			goto end;
+		if ((value & 0xf000) != sel) {
+			value &= 0x0fff;
+			value |= sel;
+		ret = acpi_smbus_write(sbs->hc, SMBUS_WRITE_WORD,
+					 ACPI_SBS_MANAGER,
+					 0x01, (u8 *)&value, 2);
+		if (ret)
+			goto end;
+		}
 	}
-	value = battery->alarm_capacity / (acpi_battery_mode(battery) ? 10 : 1);
-	return acpi_smbus_write(sbs->hc, SMBUS_WRITE_WORD, ACPI_SBS_BATTERY,
-				0x01, (u8 *)&value, 2);
+	ret = acpi_smbus_write(sbs->hc, SMBUS_WRITE_WORD, ACPI_SBS_BATTERY,
+				0x01, (u8 *)&battery->alarm_capacity, 2);
+      end:
+	return ret;
 }
 
 static int acpi_ac_get_present(struct acpi_sbs *sbs)
@@ -289,22 +442,19 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
    -------------------------------------------------------------------------- */
 
 /* Generic Routines */
-
 static int
 acpi_sbs_add_fs(struct proc_dir_entry **dir,
-			struct proc_dir_entry *parent_dir,
-			char *dir_name,
-			struct file_operations *info_fops,
-			struct file_operations *state_fops,
-			struct file_operations *alarm_fops, void *data)
+		struct proc_dir_entry *parent_dir,
+		char *dir_name,
+		struct file_operations *info_fops,
+		struct file_operations *state_fops,
+		struct file_operations *alarm_fops, void *data)
 {
 	struct proc_dir_entry *entry = NULL;
 
 	if (!*dir) {
 		*dir = proc_mkdir(dir_name, parent_dir);
 		if (!*dir) {
-			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"proc_mkdir() failed"));
 			return -ENODEV;
 		}
 		(*dir)->owner = THIS_MODULE;
@@ -313,10 +463,7 @@ acpi_sbs_add_fs(struct proc_dir_entry **dir,
 	/* 'info' [R] */
 	if (info_fops) {
 		entry = create_proc_entry(ACPI_SBS_FILE_INFO, S_IRUGO, *dir);
-		if (!entry) {
-			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"create_proc_entry() failed"));
-		} else {
+		if (entry) {
 			entry->proc_fops = info_fops;
 			entry->data = data;
 			entry->owner = THIS_MODULE;
@@ -326,10 +473,7 @@ acpi_sbs_add_fs(struct proc_dir_entry **dir,
 	/* 'state' [R] */
 	if (state_fops) {
 		entry = create_proc_entry(ACPI_SBS_FILE_STATE, S_IRUGO, *dir);
-		if (!entry) {
-			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"create_proc_entry() failed"));
-		} else {
+		if (entry) {
 			entry->proc_fops = state_fops;
 			entry->data = data;
 			entry->owner = THIS_MODULE;
@@ -339,16 +483,12 @@ acpi_sbs_add_fs(struct proc_dir_entry **dir,
 	/* 'alarm' [R/W] */
 	if (alarm_fops) {
 		entry = create_proc_entry(ACPI_SBS_FILE_ALARM, S_IRUGO, *dir);
-		if (!entry) {
-			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"create_proc_entry() failed"));
-		} else {
+		if (entry) {
 			entry->proc_fops = alarm_fops;
 			entry->data = data;
 			entry->owner = THIS_MODULE;
 		}
 	}
-
 	return 0;
 }
 
@@ -356,7 +496,6 @@ static void
 acpi_sbs_remove_fs(struct proc_dir_entry **dir,
 			   struct proc_dir_entry *parent_dir)
 {
-
 	if (*dir) {
 		remove_proc_entry(ACPI_SBS_FILE_INFO, *dir);
 		remove_proc_entry(ACPI_SBS_FILE_STATE, *dir);
@@ -364,11 +503,9 @@ acpi_sbs_remove_fs(struct proc_dir_entry **dir,
 		remove_proc_entry((*dir)->name, parent_dir);
 		*dir = NULL;
 	}
-
 }
 
 /* Smart Battery Interface */
-
 static struct proc_dir_entry *acpi_battery_dir = NULL;
 
 static inline char *acpi_battery_units(struct acpi_battery *battery)
@@ -506,7 +643,8 @@ acpi_battery_write_alarm(struct file *file, const char __user * buffer,
 		goto end;
 	}
 	alarm_string[count] = 0;
-	battery->alarm_capacity = simple_strtoul(alarm_string, NULL, 0);
+	battery->alarm_capacity = simple_strtoul(alarm_string, NULL, 0) /
+					acpi_battery_scale(battery);
 	acpi_battery_set_alarm(battery);
       end:
 	mutex_unlock(&sbs->lock);
@@ -579,9 +717,6 @@ static struct file_operations acpi_ac_state_fops = {
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
-
-/* Smart Battery */
-
 static int acpi_battery_read(struct acpi_battery *battery)
 {
 	int result = 0, saved_present = battery->present;
@@ -611,13 +746,14 @@ static int acpi_battery_read(struct acpi_battery *battery)
 	return result;
 }
 
+/* Smart Battery */
 static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 {
-	int result;
 	struct acpi_battery *battery = &sbs->battery[id];
+	int result;
+
 	battery->id = id;
 	battery->sbs = sbs;
-	battery->update_time = 0;
 	result = acpi_battery_read(battery);
 	if (result)
 		return result;
@@ -627,6 +763,21 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 			battery->name, &acpi_battery_info_fops,
 			&acpi_battery_state_fops, &acpi_battery_alarm_fops,
 			battery);
+#ifdef ENABLE_POWER_SUPPLY
+	battery->bat.name = battery->name;
+	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
+	if (!acpi_battery_mode(battery)) {
+		battery->bat.properties = sbs_charge_battery_props;
+		battery->bat.num_properties =
+		    ARRAY_SIZE(sbs_charge_battery_props);
+	} else {
+		battery->bat.properties = sbs_energy_battery_props;
+		battery->bat.num_properties =
+		    ARRAY_SIZE(sbs_energy_battery_props);
+	}
+	battery->bat.get_property = acpi_sbs_battery_get_property;
+	result = power_supply_register(&sbs->device->dev, &battery->bat);
+#endif
 	printk(KERN_INFO PREFIX "%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
 	       battery->name, sbs->battery->present ? "present" : "absent");
@@ -635,7 +786,10 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 
 static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
-
+#ifdef ENABLE_POWER_SUPPLY
+	if (sbs->battery[id].bat.dev)
+		power_supply_unregister(&sbs->battery[id].bat);
+#endif
 	if (sbs->battery[id].proc_entry) {
 		acpi_sbs_remove_fs(&(sbs->battery[id].proc_entry),
 				   acpi_battery_dir);
@@ -654,6 +808,14 @@ static int acpi_charger_add(struct acpi_sbs *sbs)
 				 &acpi_ac_state_fops, NULL, sbs);
 	if (result)
 		goto end;
+#ifdef ENABLE_POWER_SUPPLY
+	sbs->charger.name = "sbs-charger";
+	sbs->charger.type = POWER_SUPPLY_TYPE_MAINS;
+	sbs->charger.properties = sbs_ac_props;
+	sbs->charger.num_properties = ARRAY_SIZE(sbs_ac_props);
+	sbs->charger.get_property = sbs_get_ac_property;
+	power_supply_register(&sbs->device->dev, &sbs->charger);
+#endif
 	printk(KERN_INFO PREFIX "%s [%s]: AC Adapter [%s] (%s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
 	       ACPI_AC_DIR_NAME, sbs->charger_present ? "on-line" : "off-line");
@@ -663,7 +825,10 @@ static int acpi_charger_add(struct acpi_sbs *sbs)
 
 static void acpi_charger_remove(struct acpi_sbs *sbs)
 {
-
+#ifdef ENABLE_POWER_SUPPLY
+	if (sbs->charger.dev)
+		power_supply_unregister(&sbs->charger);
+#endif
 	if (sbs->charger_entry)
 		acpi_sbs_remove_fs(&sbs->charger_entry, acpi_ac_dir);
 }
@@ -680,6 +845,9 @@ void acpi_sbs_callback(void *context)
 		acpi_bus_generate_proc_event4(ACPI_AC_CLASS, ACPI_AC_DIR_NAME,
 					      ACPI_SBS_NOTIFY_STATUS,
 					      sbs->charger_present);
+#ifdef ENABLE_POWER_SUPPLY
+		kobject_uevent(&sbs->charger.dev->kobj, KOBJ_CHANGE);
+#endif
 	}
 	if (sbs->manager_present) {
 		for (id = 0; id < MAX_SBS_BAT; ++id) {
@@ -694,6 +862,9 @@ void acpi_sbs_callback(void *context)
 						      bat->name,
 						      ACPI_SBS_NOTIFY_STATUS,
 						      bat->present);
+#ifdef ENABLE_POWER_SUPPLY
+			kobject_uevent(&bat->bat.dev->kobj, KOBJ_CHANGE);
+#endif
 		}
 	}
 }
@@ -782,45 +953,43 @@ static int acpi_sbs_resume(struct acpi_device *device)
 	return 0;
 }
 
+static struct acpi_driver acpi_sbs_driver = {
+	.name = "sbs",
+	.class = ACPI_SBS_CLASS,
+	.ids = sbs_device_ids,
+	.ops = {
+		.add = acpi_sbs_add,
+		.remove = acpi_sbs_remove,
+		.resume = acpi_sbs_resume,
+		},
+};
+
 static int __init acpi_sbs_init(void)
 {
 	int result = 0;
 
 	if (acpi_disabled)
 		return -ENODEV;
-
 	acpi_ac_dir = acpi_lock_ac_dir();
-	if (!acpi_ac_dir) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_lock_ac_dir() failed"));
+	if (!acpi_ac_dir)
 		return -ENODEV;
-	}
-
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_lock_battery_dir() failed"));
 		acpi_sbs_rmdirs();
 		return -ENODEV;
 	}
-
 	result = acpi_bus_register_driver(&acpi_sbs_driver);
 	if (result < 0) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_bus_register_driver() failed"));
 		acpi_sbs_rmdirs();
 		return -ENODEV;
 	}
-
 	return 0;
 }
 
 static void __exit acpi_sbs_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_sbs_driver);
-
 	acpi_sbs_rmdirs();
-
 	return;
 }
 
-- 
1.5.3.1.27.g57543
