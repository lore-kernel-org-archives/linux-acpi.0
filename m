From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND 1/6] ACPI ac/battery/sbs: sysfs I/F always built in,
 procfs I/F disabled by default
Date: Fri, 08 Oct 2010 13:54:57 +0800
Message-ID: <1286517297.2111.3796.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:34993 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab0JHF5J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Oct 2010 01:57:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>


ACPI AC/Battery/SBS driver has different kernel option for procfs and sysfs I/F.

This patch,
1. Change CONFIG_ACPI_PROCFS_POWER to 'n' by default so that we can remove it in the next release or two.
2. Remove CONFIG_ACPI_SYSFS_POWER and always build in the sysfs I/F of these drivers.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig   |   11 +++--------
 drivers/acpi/ac.c      |   14 --------------
 drivers/acpi/battery.c |   21 ---------------------
 drivers/acpi/sbs.c     |   25 -------------------------
 4 files changed, 3 insertions(+), 68 deletions(-)

Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -66,7 +66,6 @@ config ACPI_PROCFS
 config ACPI_PROCFS_POWER
 	bool "Deprecated power /proc/acpi directories"
 	depends on PROC_FS
-	default y
 	help
 	  For backwards compatibility, this option allows
           deprecated power /proc/acpi/ directories to exist, even when
@@ -90,13 +89,6 @@ config ACPI_POWER_METER
 	  To compile this driver as a module, choose M here:
 	  the module will be called power-meter.
 
-config ACPI_SYSFS_POWER
-	bool "Future power /sys interface"
-	select POWER_SUPPLY
-	default y
-	help
-	  Say N to disable power /sys interface
-
 config ACPI_EC_DEBUGFS
 	tristate "EC read/write access through /sys/kernel/debug/ec"
 	default n
@@ -136,6 +128,7 @@ config ACPI_PROC_EVENT
 config ACPI_AC
 	tristate "AC Adapter"
 	depends on X86
+	select POWER_SUPPLY
 	default y
 	help
 	  This driver supports the AC Adapter object, which indicates
@@ -148,6 +141,7 @@ config ACPI_AC
 config ACPI_BATTERY
 	tristate "Battery"
 	depends on X86
+	select POWER_SUPPLY
 	default y
 	help
 	  This driver adds support for battery information through
@@ -364,6 +358,7 @@ config ACPI_HOTPLUG_MEMORY
 config ACPI_SBS
 	tristate "Smart Battery System"
 	depends on X86
+	select POWER_SUPPLY
 	help
 	  This driver supports the Smart Battery System, another
 	  type of access to battery information, found on some laptops.
Index: linux-2.6/drivers/acpi/ac.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ac.c
+++ linux-2.6/drivers/acpi/ac.c
@@ -32,9 +32,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #endif
-#ifdef CONFIG_ACPI_SYSFS_POWER
 #include <linux/power_supply.h>
-#endif
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -86,9 +84,7 @@ static struct acpi_driver acpi_ac_driver
 };
 
 struct acpi_ac {
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	struct power_supply charger;
-#endif
 	struct acpi_device * device;
 	unsigned long long state;
 };
@@ -104,7 +100,6 @@ static const struct file_operations acpi
 	.release = single_release,
 };
 #endif
-#ifdef CONFIG_ACPI_SYSFS_POWER
 static int get_ac_property(struct power_supply *psy,
 			   enum power_supply_property psp,
 			   union power_supply_propval *val)
@@ -123,7 +118,6 @@ static int get_ac_property(struct power_
 static enum power_supply_property ac_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
-#endif
 /* --------------------------------------------------------------------------
                                AC Adapter Management
    -------------------------------------------------------------------------- */
@@ -247,9 +241,7 @@ static void acpi_ac_notify(struct acpi_d
 						  dev_name(&device->dev), event,
 						  (u32) ac->state);
 		acpi_notifier_call_chain(device, event, (u32) ac->state);
-#ifdef CONFIG_ACPI_SYSFS_POWER
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
-#endif
 	}
 
 	return;
@@ -282,14 +274,12 @@ static int acpi_ac_add(struct acpi_devic
 #endif
 	if (result)
 		goto end;
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	ac->charger.name = acpi_device_bid(device);
 	ac->charger.type = POWER_SUPPLY_TYPE_MAINS;
 	ac->charger.properties = ac_props;
 	ac->charger.num_properties = ARRAY_SIZE(ac_props);
 	ac->charger.get_property = get_ac_property;
 	power_supply_register(&ac->device->dev, &ac->charger);
-#endif
 
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
@@ -316,10 +306,8 @@ static int acpi_ac_resume(struct acpi_de
 	old_state = ac->state;
 	if (acpi_ac_get_state(ac))
 		return 0;
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (old_state != ac->state)
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
-#endif
 	return 0;
 }
 
@@ -333,10 +321,8 @@ static int acpi_ac_remove(struct acpi_de
 
 	ac = acpi_driver_data(device);
 
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (ac->charger.dev)
 		power_supply_unregister(&ac->charger);
-#endif
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_ac_remove_fs(device);
 #endif
Index: linux-2.6/drivers/acpi/battery.c
===================================================================
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -42,10 +42,7 @@
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
-
-#ifdef CONFIG_ACPI_SYSFS_POWER
 #include <linux/power_supply.h>
-#endif
 
 #define PREFIX "ACPI: "
 
@@ -102,9 +99,7 @@ enum {
 
 struct acpi_battery {
 	struct mutex lock;
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	struct power_supply bat;
-#endif
 	struct acpi_device *device;
 	unsigned long update_time;
 	int rate_now;
@@ -141,7 +136,6 @@ inline int acpi_battery_present(struct a
 	return battery->device->status.battery_present;
 }
 
-#ifdef CONFIG_ACPI_SYSFS_POWER
 static int acpi_battery_technology(struct acpi_battery *battery)
 {
 	if (!strcasecmp("NiCd", battery->type))
@@ -281,7 +275,6 @@ static enum power_supply_property energy
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
-#endif
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
 inline char *acpi_battery_units(struct acpi_battery *battery)
@@ -492,7 +485,6 @@ static int acpi_battery_init_alarm(struc
 	return acpi_battery_set_alarm(battery);
 }
 
-#ifdef CONFIG_ACPI_SYSFS_POWER
 static ssize_t acpi_battery_alarm_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -552,7 +544,6 @@ static void sysfs_remove_battery(struct 
 	power_supply_unregister(&battery->bat);
 	battery->bat.dev = NULL;
 }
-#endif
 
 static void acpi_battery_quirks(struct acpi_battery *battery)
 {
@@ -568,9 +559,7 @@ static int acpi_battery_update(struct ac
 	if (result)
 		return result;
 	if (!acpi_battery_present(battery)) {
-#ifdef CONFIG_ACPI_SYSFS_POWER
 		sysfs_remove_battery(battery);
-#endif
 		battery->update_time = 0;
 		return 0;
 	}
@@ -582,10 +571,8 @@ static int acpi_battery_update(struct ac
 		acpi_battery_quirks(battery);
 		acpi_battery_init_alarm(battery);
 	}
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (!battery->bat.dev)
 		sysfs_add_battery(battery);
-#endif
 	return acpi_battery_get_state(battery);
 }
 
@@ -867,26 +854,20 @@ static void acpi_battery_remove_fs(struc
 static void acpi_battery_notify(struct acpi_device *device, u32 event)
 {
 	struct acpi_battery *battery = acpi_driver_data(device);
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	struct device *old;
-#endif
 
 	if (!battery)
 		return;
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	old = battery->bat.dev;
-#endif
 	acpi_battery_update(battery);
 	acpi_bus_generate_proc_event(device, event,
 				     acpi_battery_present(battery));
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	/* acpi_battery_update could remove power_supply object */
 	if (old && battery->bat.dev)
 		power_supply_changed(&battery->bat);
-#endif
 }
 
 static int acpi_battery_add(struct acpi_device *device)
@@ -934,9 +915,7 @@ static int acpi_battery_remove(struct ac
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_battery_remove_fs(device);
 #endif
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	sysfs_remove_battery(battery);
-#endif
 	mutex_destroy(&battery->lock);
 	kfree(battery);
 	return 0;
Index: linux-2.6/drivers/acpi/sbs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sbs.c
+++ linux-2.6/drivers/acpi/sbs.c
@@ -40,10 +40,7 @@
 #include <linux/timer.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
-
-#ifdef CONFIG_ACPI_SYSFS_POWER
 #include <linux/power_supply.h>
-#endif
 
 #include "sbshc.h"
 
@@ -85,9 +82,7 @@ static const struct acpi_device_id sbs_d
 MODULE_DEVICE_TABLE(acpi, sbs_device_ids);
 
 struct acpi_battery {
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	struct power_supply bat;
-#endif
 	struct acpi_sbs *sbs;
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	struct proc_dir_entry *proc_entry;
@@ -120,9 +115,7 @@ struct acpi_battery {
 #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
 
 struct acpi_sbs {
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	struct power_supply charger;
-#endif
 	struct acpi_device *device;
 	struct acpi_smb_hc *hc;
 	struct mutex lock;
@@ -166,7 +159,6 @@ static inline int acpi_battery_scale(str
 	    acpi_battery_ipscale(battery);
 }
 
-#ifdef CONFIG_ACPI_SYSFS_POWER
 static int sbs_get_ac_property(struct power_supply *psy,
 			       enum power_supply_property psp,
 			       union power_supply_propval *val)
@@ -313,7 +305,6 @@ static enum power_supply_property sbs_en
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-#endif
 
 /* --------------------------------------------------------------------------
                             Smart Battery System Management
@@ -449,7 +440,6 @@ static int acpi_ac_get_present(struct ac
 	return result;
 }
 
-#ifdef CONFIG_ACPI_SYSFS_POWER
 static ssize_t acpi_battery_alarm_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -479,7 +469,6 @@ static struct device_attribute alarm_att
 	.show = acpi_battery_alarm_show,
 	.store = acpi_battery_alarm_store,
 };
-#endif
 
 /* --------------------------------------------------------------------------
                               FS Interface (/proc/acpi)
@@ -798,7 +787,6 @@ static int acpi_battery_add(struct acpi_
 			&acpi_battery_state_fops, &acpi_battery_alarm_fops,
 			battery);
 #endif
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	battery->bat.name = battery->name;
 	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
 	if (!acpi_battery_mode(battery)) {
@@ -819,7 +807,6 @@ static int acpi_battery_add(struct acpi_
 		goto end;
 	battery->have_sysfs_alarm = 1;
       end:
-#endif
 	printk(KERN_INFO PREFIX "%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
 	       battery->name, battery->present ? "present" : "absent");
@@ -828,17 +815,13 @@ static int acpi_battery_add(struct acpi_
 
 static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
-#if defined(CONFIG_ACPI_SYSFS_POWER) || defined(CONFIG_ACPI_PROCFS_POWER)
 	struct acpi_battery *battery = &sbs->battery[id];
-#endif
 
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (battery->bat.dev) {
 		if (battery->have_sysfs_alarm)
 			device_remove_file(battery->bat.dev, &alarm_attr);
 		power_supply_unregister(&battery->bat);
 	}
-#endif
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	if (battery->proc_entry)
 		acpi_sbs_remove_fs(&battery->proc_entry, acpi_battery_dir);
@@ -859,14 +842,12 @@ static int acpi_charger_add(struct acpi_
 	if (result)
 		goto end;
 #endif
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	sbs->charger.name = "sbs-charger";
 	sbs->charger.type = POWER_SUPPLY_TYPE_MAINS;
 	sbs->charger.properties = sbs_ac_props;
 	sbs->charger.num_properties = ARRAY_SIZE(sbs_ac_props);
 	sbs->charger.get_property = sbs_get_ac_property;
 	power_supply_register(&sbs->device->dev, &sbs->charger);
-#endif
 	printk(KERN_INFO PREFIX "%s [%s]: AC Adapter [%s] (%s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
 	       ACPI_AC_DIR_NAME, sbs->charger_present ? "on-line" : "off-line");
@@ -876,10 +857,8 @@ static int acpi_charger_add(struct acpi_
 
 static void acpi_charger_remove(struct acpi_sbs *sbs)
 {
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (sbs->charger.dev)
 		power_supply_unregister(&sbs->charger);
-#endif
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	if (sbs->charger_entry)
 		acpi_sbs_remove_fs(&sbs->charger_entry, acpi_ac_dir);
@@ -900,9 +879,7 @@ static void acpi_sbs_callback(void *cont
 					      ACPI_SBS_NOTIFY_STATUS,
 					      sbs->charger_present);
 #endif
-#ifdef CONFIG_ACPI_SYSFS_POWER
 		kobject_uevent(&sbs->charger.dev->kobj, KOBJ_CHANGE);
-#endif
 	}
 	if (sbs->manager_present) {
 		for (id = 0; id < MAX_SBS_BAT; ++id) {
@@ -919,9 +896,7 @@ static void acpi_sbs_callback(void *cont
 						      ACPI_SBS_NOTIFY_STATUS,
 						      bat->present);
 #endif
-#ifdef CONFIG_ACPI_SYSFS_POWER
 			kobject_uevent(&bat->bat.dev->kobj, KOBJ_CHANGE);
-#endif
 		}
 	}
 }


