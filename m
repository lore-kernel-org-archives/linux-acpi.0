From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/8] ACPI: Make sysfs interface in ACPI power optional.
Date: Fri, 11 Jan 2008 15:11:29 -0500
Message-ID: <97749cd9adbb2985e4b2aee1a59d6b970fe9c3a7.1200082104.git.len.brown@intel.com>
References: <1200082294-29742-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:58901 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760660AbYAKUkd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jan 2008 15:40:33 -0500
In-Reply-To: <1200082294-29742-1-git-send-email-lenb@kernel.org>
In-Reply-To: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
References: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=9494

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig   |    9 ++++++---
 drivers/acpi/ac.c      |   16 ++++++++++++++--
 drivers/acpi/battery.c |   31 +++++++++++++++++++++++++------
 drivers/acpi/sbs.c     |   23 ++++++++++++++++++++++-
 4 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b9f923e..ccf6ea9 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -82,6 +82,12 @@ config ACPI_PROCFS_POWER
 	  and functions, which do not yet exist in /sys
 
 	  Say N to delete power /proc/acpi/ folders that have moved to /sys/
+config ACPI_SYSFS_POWER
+	bool "Future power /sys interface"
+	select POWER_SUPPLY
+	default y
+	---help---
+	  Say N to disable power /sys interface
 config ACPI_PROC_EVENT
 	bool "Deprecated /proc/acpi/event support"
 	depends on PROC_FS
@@ -103,7 +109,6 @@ config ACPI_PROC_EVENT
 config ACPI_AC
 	tristate "AC Adapter"
 	depends on X86
-	select POWER_SUPPLY
 	default y
 	help
 	  This driver adds support for the AC Adapter object, which indicates
@@ -113,7 +118,6 @@ config ACPI_AC
 config ACPI_BATTERY
 	tristate "Battery"
 	depends on X86
-	select POWER_SUPPLY
 	default y
 	help
 	  This driver adds support for battery information through
@@ -368,7 +372,6 @@ config ACPI_HOTPLUG_MEMORY
 config ACPI_SBS
 	tristate "Smart Battery System"
 	depends on X86
-	select POWER_SUPPLY
 	help
 	  This driver adds support for the Smart Battery System, another
 	  type of access to battery information, found on some laptops.
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 76ed4f5..76b9bea 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -31,7 +31,9 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #endif
+#ifdef CONFIG_ACPI_SYSFS_POWER
 #include <linux/power_supply.h>
+#endif
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -79,7 +81,9 @@ static struct acpi_driver acpi_ac_driver = {
 };
 
 struct acpi_ac {
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	struct power_supply charger;
+#endif
 	struct acpi_device * device;
 	unsigned long state;
 };
@@ -94,7 +98,7 @@ static const struct file_operations acpi_ac_fops = {
 	.release = single_release,
 };
 #endif
-
+#ifdef CONFIG_ACPI_SYSFS_POWER
 static int get_ac_property(struct power_supply *psy,
 			   enum power_supply_property psp,
 			   union power_supply_propval *val)
@@ -113,7 +117,7 @@ static int get_ac_property(struct power_supply *psy,
 static enum power_supply_property ac_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
-
+#endif
 /* --------------------------------------------------------------------------
                                AC Adapter Management
    -------------------------------------------------------------------------- */
@@ -241,7 +245,9 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  device->dev.bus_id, event,
 						  (u32) ac->state);
+#ifdef CONFIG_ACPI_SYSFS_POWER
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
+#endif
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -280,12 +286,14 @@ static int acpi_ac_add(struct acpi_device *device)
 #endif
 	if (result)
 		goto end;
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	ac->charger.name = acpi_device_bid(device);
 	ac->charger.type = POWER_SUPPLY_TYPE_MAINS;
 	ac->charger.properties = ac_props;
 	ac->charger.num_properties = ARRAY_SIZE(ac_props);
 	ac->charger.get_property = get_ac_property;
 	power_supply_register(&ac->device->dev, &ac->charger);
+#endif
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_ALL_NOTIFY, acpi_ac_notify,
 					     ac);
@@ -319,8 +327,10 @@ static int acpi_ac_resume(struct acpi_device *device)
 	old_state = ac->state;
 	if (acpi_ac_get_state(ac))
 		return 0;
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (old_state != ac->state)
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
+#endif
 	return 0;
 }
 
@@ -337,8 +347,10 @@ static int acpi_ac_remove(struct acpi_device *device, int type)
 
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY, acpi_ac_notify);
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (ac->charger.dev)
 		power_supply_unregister(&ac->charger);
+#endif
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_ac_remove_fs(device);
 #endif
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 8f7505d..c4a769d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -40,7 +40,9 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#ifdef CONFIG_ACPI_SYSFS_POWER
 #include <linux/power_supply.h>
+#endif
 
 #define ACPI_BATTERY_VALUE_UNKNOWN 0xFFFFFFFF
 
@@ -86,7 +88,9 @@ MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
 struct acpi_battery {
 	struct mutex lock;
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	struct power_supply bat;
+#endif
 	struct acpi_device *device;
 	unsigned long update_time;
 	int current_now;
@@ -117,6 +121,7 @@ inline int acpi_battery_present(struct acpi_battery *battery)
 	return battery->device->status.battery_present;
 }
 
+#ifdef CONFIG_ACPI_SYSFS_POWER
 static int acpi_battery_technology(struct acpi_battery *battery)
 {
 	if (!strcasecmp("NiCd", battery->type))
@@ -222,6 +227,7 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
+#endif
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
 inline char *acpi_battery_units(struct acpi_battery *battery)
@@ -398,6 +404,7 @@ static int acpi_battery_init_alarm(struct acpi_battery *battery)
 	return acpi_battery_set_alarm(battery);
 }
 
+#ifdef CONFIG_ACPI_SYSFS_POWER
 static ssize_t acpi_battery_alarm_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -429,11 +436,6 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 {
 	int result;
 
-	battery->update_time = 0;
-	result = acpi_battery_get_info(battery);
-	acpi_battery_init_alarm(battery);
-	if (result)
-		return result;
 	if (battery->power_unit) {
 		battery->bat.properties = charge_battery_props;
 		battery->bat.num_properties =
@@ -462,18 +464,31 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 	power_supply_unregister(&battery->bat);
 	battery->bat.dev = NULL;
 }
+#endif
 
 static int acpi_battery_update(struct acpi_battery *battery)
 {
-	int result = acpi_battery_get_status(battery);
+	int result;
+	result = acpi_battery_get_status(battery);
 	if (result)
 		return result;
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (!acpi_battery_present(battery)) {
 		sysfs_remove_battery(battery);
+		battery->update_time = 0;
 		return 0;
 	}
+#endif
+	if (!battery->update_time) {
+		result = acpi_battery_get_info(battery);
+		if (result)
+			return result;
+		acpi_battery_init_alarm(battery);
+	}
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (!battery->bat.dev)
 		sysfs_add_battery(battery);
+#endif
 	return acpi_battery_get_state(battery);
 }
 
@@ -767,9 +782,11 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
 					device->dev.bus_id, event,
 					acpi_battery_present(battery));
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	/* acpi_batter_update could remove power_supply object */
 	if (battery->bat.dev)
 		kobject_uevent(&battery->bat.dev->kobj, KOBJ_CHANGE);
+#endif
 }
 
 static int acpi_battery_add(struct acpi_device *device)
@@ -828,7 +845,9 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_battery_remove_fs(device);
 #endif
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	sysfs_remove_battery(battery);
+#endif
 	mutex_destroy(&battery->lock);
 	kfree(battery);
 	return 0;
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 22cb95b..f136c7d 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -40,7 +40,9 @@
 #include <linux/jiffies.h>
 #include <linux/delay.h>
 
+#ifdef CONFIG_ACPI_SYSFS_POWER
 #include <linux/power_supply.h>
+#endif
 
 #include "sbshc.h"
 
@@ -80,7 +82,9 @@ static const struct acpi_device_id sbs_device_ids[] = {
 MODULE_DEVICE_TABLE(acpi, sbs_device_ids);
 
 struct acpi_battery {
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	struct power_supply bat;
+#endif
 	struct acpi_sbs *sbs;
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	struct proc_dir_entry *proc_entry;
@@ -113,7 +117,9 @@ struct acpi_battery {
 #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
 
 struct acpi_sbs {
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	struct power_supply charger;
+#endif
 	struct acpi_device *device;
 	struct acpi_smb_hc *hc;
 	struct mutex lock;
@@ -157,6 +163,7 @@ static inline int acpi_battery_scale(struct acpi_battery *battery)
 	    acpi_battery_ipscale(battery);
 }
 
+#ifdef CONFIG_ACPI_SYSFS_POWER
 static int sbs_get_ac_property(struct power_supply *psy,
 			       enum power_supply_property psp,
 			       union power_supply_propval *val)
@@ -294,6 +301,7 @@ static enum power_supply_property sbs_energy_battery_props[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
+#endif
 
 /* --------------------------------------------------------------------------
                             Smart Battery System Management
@@ -429,6 +437,7 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
 	return result;
 }
 
+#ifdef CONFIG_ACPI_SYSFS_POWER
 static ssize_t acpi_battery_alarm_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -458,6 +467,7 @@ static struct device_attribute alarm_attr = {
 	.show = acpi_battery_alarm_show,
 	.store = acpi_battery_alarm_store,
 };
+#endif
 
 /* --------------------------------------------------------------------------
                               FS Interface (/proc/acpi)
@@ -793,6 +803,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 			&acpi_battery_state_fops, &acpi_battery_alarm_fops,
 			battery);
 #endif
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	battery->bat.name = battery->name;
 	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
 	if (!acpi_battery_mode(battery)) {
@@ -813,6 +824,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		goto end;
 	battery->have_sysfs_alarm = 1;
       end:
+#endif
 	printk(KERN_INFO PREFIX "%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
 	       battery->name, sbs->battery->present ? "present" : "absent");
@@ -822,12 +834,13 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
 	struct acpi_battery *battery = &sbs->battery[id];
-
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (battery->bat.dev) {
 		if (battery->have_sysfs_alarm)
 			device_remove_file(battery->bat.dev, &alarm_attr);
 		power_supply_unregister(&battery->bat);
 	}
+#endif
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	if (battery->proc_entry)
 		acpi_sbs_remove_fs(&battery->proc_entry, acpi_battery_dir);
@@ -848,12 +861,14 @@ static int acpi_charger_add(struct acpi_sbs *sbs)
 	if (result)
 		goto end;
 #endif
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	sbs->charger.name = "sbs-charger";
 	sbs->charger.type = POWER_SUPPLY_TYPE_MAINS;
 	sbs->charger.properties = sbs_ac_props;
 	sbs->charger.num_properties = ARRAY_SIZE(sbs_ac_props);
 	sbs->charger.get_property = sbs_get_ac_property;
 	power_supply_register(&sbs->device->dev, &sbs->charger);
+#endif
 	printk(KERN_INFO PREFIX "%s [%s]: AC Adapter [%s] (%s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
 	       ACPI_AC_DIR_NAME, sbs->charger_present ? "on-line" : "off-line");
@@ -863,8 +878,10 @@ static int acpi_charger_add(struct acpi_sbs *sbs)
 
 static void acpi_charger_remove(struct acpi_sbs *sbs)
 {
+#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (sbs->charger.dev)
 		power_supply_unregister(&sbs->charger);
+#endif
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	if (sbs->charger_entry)
 		acpi_sbs_remove_fs(&sbs->charger_entry, acpi_ac_dir);
@@ -885,7 +902,9 @@ void acpi_sbs_callback(void *context)
 					      ACPI_SBS_NOTIFY_STATUS,
 					      sbs->charger_present);
 #endif
+#ifdef CONFIG_ACPI_SYSFS_POWER
 		kobject_uevent(&sbs->charger.dev->kobj, KOBJ_CHANGE);
+#endif
 	}
 	if (sbs->manager_present) {
 		for (id = 0; id < MAX_SBS_BAT; ++id) {
@@ -902,7 +921,9 @@ void acpi_sbs_callback(void *context)
 						      ACPI_SBS_NOTIFY_STATUS,
 						      bat->present);
 #endif
+#ifdef CONFIG_ACPI_SYSFS_POWER
 			kobject_uevent(&bat->bat.dev->kobj, KOBJ_CHANGE);
+#endif
 		}
 	}
 }
-- 
1.5.4.rc2.84.gf85fd

