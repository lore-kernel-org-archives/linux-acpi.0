From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] ACPI : remove CONFIG_ACPI_PROCFS_POWER and AC/Battery
 procfs I/F
Date: Wed, 23 Mar 2011 09:34:23 +0800
Message-ID: <1300844063.31379.4.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13905 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773Ab1CWBeh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Mar 2011 21:34:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Remove CONFIG_ACPI_PROCFS_POWER and the ACPI AC/Battery procfs I/F in 2.6.39.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/feature-removal-schedule.txt |   11 
 drivers/acpi/Kconfig                       |   17 -
 drivers/acpi/Makefile                      |    1 
 drivers/acpi/ac.c                          |  128 -----------
 drivers/acpi/battery.c                     |  326 ----------------------------
 drivers/acpi/cm_sbs.c                      |  105 ---------
 drivers/acpi/sbs.c                         |  331 -----------------------------
 7 files changed, 5 insertions(+), 914 deletions(-)

Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -57,23 +57,6 @@ config ACPI_PROCFS
 
 	  Say N to delete /proc/acpi/ files that have moved to /sys/
 
-config ACPI_PROCFS_POWER
-	bool "Deprecated power /proc/acpi directories"
-	depends on PROC_FS
-	help
-	  For backwards compatibility, this option allows
-          deprecated power /proc/acpi/ directories to exist, even when
-          they have been replaced by functions in /sys.
-          The deprecated directories (and their replacements) include:
-	  /proc/acpi/battery/* (/sys/class/power_supply/*)
-	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*)
-	  This option has no effect on /proc/acpi/ directories
-	  and functions, which do not yet exist in /sys
-	  This option, together with the proc directories, will be
-	  deleted in 2.6.39.
-
-	  Say N to delete power /proc/acpi/ directories that have moved to /sys/
-
 config ACPI_POWER_METER
 	tristate "ACPI 4.0 power meter"
 	depends on HWMON
Index: linux-2.6/drivers/acpi/Makefile
===================================================================
--- linux-2.6.orig/drivers/acpi/Makefile
+++ linux-2.6/drivers/acpi/Makefile
@@ -41,7 +41,6 @@ acpi-y				+= event.o
 acpi-y				+= sysfs.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
-acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 ifdef CONFIG_ACPI_VIDEO
 acpi-y				+= video_detect.o
 endif
Index: linux-2.6/drivers/acpi/ac.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ac.c
+++ linux-2.6/drivers/acpi/ac.c
@@ -28,10 +28,6 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#ifdef CONFIG_ACPI_PROCFS_POWER
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#endif
 #include <linux/power_supply.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -53,12 +49,6 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI AC Adapter Driver");
 MODULE_LICENSE("GPL");
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-extern struct proc_dir_entry *acpi_lock_ac_dir(void);
-extern void *acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir);
-static int acpi_ac_open_fs(struct inode *inode, struct file *file);
-#endif
-
 static int acpi_ac_add(struct acpi_device *device);
 static int acpi_ac_remove(struct acpi_device *device, int type);
 static int acpi_ac_resume(struct acpi_device *device);
@@ -91,16 +81,6 @@ struct acpi_ac {
 
 #define to_acpi_ac(x) container_of(x, struct acpi_ac, charger);
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-static const struct file_operations acpi_ac_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_ac_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#endif
-
 /* --------------------------------------------------------------------------
                                AC Adapter Management
    -------------------------------------------------------------------------- */
@@ -152,83 +132,6 @@ static enum power_supply_property ac_pro
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-/* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-
-static struct proc_dir_entry *acpi_ac_dir;
-
-static int acpi_ac_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_ac *ac = seq->private;
-
-
-	if (!ac)
-		return 0;
-
-	if (acpi_ac_get_state(ac)) {
-		seq_puts(seq, "ERROR: Unable to read AC Adapter state\n");
-		return 0;
-	}
-
-	seq_puts(seq, "state:                   ");
-	switch (ac->state) {
-	case ACPI_AC_STATUS_OFFLINE:
-		seq_puts(seq, "off-line\n");
-		break;
-	case ACPI_AC_STATUS_ONLINE:
-		seq_puts(seq, "on-line\n");
-		break;
-	default:
-		seq_puts(seq, "unknown\n");
-		break;
-	}
-
-	return 0;
-}
-
-static int acpi_ac_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_ac_seq_show, PDE(inode)->data);
-}
-
-static int acpi_ac_add_fs(struct acpi_device *device)
-{
-	struct proc_dir_entry *entry = NULL;
-
-	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for AC is loaded,"
-			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
-	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
-						     acpi_ac_dir);
-		if (!acpi_device_dir(device))
-			return -ENODEV;
-	}
-
-	/* 'state' [R] */
-	entry = proc_create_data(ACPI_AC_FILE_STATE,
-				 S_IRUGO, acpi_device_dir(device),
-				 &acpi_ac_fops, acpi_driver_data(device));
-	if (!entry)
-		return -ENODEV;
-	return 0;
-}
-
-static int acpi_ac_remove_fs(struct acpi_device *device)
-{
-
-	if (acpi_device_dir(device)) {
-		remove_proc_entry(ACPI_AC_FILE_STATE, acpi_device_dir(device));
-
-		remove_proc_entry(acpi_device_bid(device), acpi_ac_dir);
-		acpi_device_dir(device) = NULL;
-	}
-
-	return 0;
-}
-#endif
-
 /* --------------------------------------------------------------------------
                                    Driver Model
    -------------------------------------------------------------------------- */
@@ -282,11 +185,6 @@ static int acpi_ac_add(struct acpi_devic
 	if (result)
 		goto end;
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	result = acpi_ac_add_fs(device);
-#endif
-	if (result)
-		goto end;
 	ac->charger.name = acpi_device_bid(device);
 	ac->charger.type = POWER_SUPPLY_TYPE_MAINS;
 	ac->charger.properties = ac_props;
@@ -299,12 +197,8 @@ static int acpi_ac_add(struct acpi_devic
 	       ac->state ? "on-line" : "off-line");
 
       end:
-	if (result) {
-#ifdef CONFIG_ACPI_PROCFS_POWER
-		acpi_ac_remove_fs(device);
-#endif
+	if (result)
 		kfree(ac);
-	}
 
 	return result;
 }
@@ -336,9 +230,6 @@ static int acpi_ac_remove(struct acpi_de
 
 	if (ac->charger.dev)
 		power_supply_unregister(&ac->charger);
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_ac_remove_fs(device);
-#endif
 
 	kfree(ac);
 
@@ -352,19 +243,9 @@ static int __init acpi_ac_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_ac_dir = acpi_lock_ac_dir();
-	if (!acpi_ac_dir)
-		return -ENODEV;
-#endif
-
 	result = acpi_bus_register_driver(&acpi_ac_driver);
-	if (result < 0) {
-#ifdef CONFIG_ACPI_PROCFS_POWER
-		acpi_unlock_ac_dir(acpi_ac_dir);
-#endif
+	if (result < 0)
 		return -ENODEV;
-	}
 
 	return 0;
 }
@@ -373,11 +254,6 @@ static void __exit acpi_ac_exit(void)
 {
 
 	acpi_bus_unregister_driver(&acpi_ac_driver);
-
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_unlock_ac_dir(acpi_ac_dir);
-#endif
-
 	return;
 }
 
Index: linux-2.6/drivers/acpi/battery.c
===================================================================
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -34,12 +34,6 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <asm/uaccess.h>
-#endif
-
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <linux/power_supply.h>
@@ -67,19 +61,6 @@ static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-extern struct proc_dir_entry *acpi_lock_battery_dir(void);
-extern void *acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
-
-enum acpi_battery_files {
-	info_tag = 0,
-	state_tag,
-	alarm_tag,
-	ACPI_BATTERY_NUMFILES,
-};
-
-#endif
-
 static const struct acpi_device_id battery_device_ids[] = {
 	{"PNP0C0A", 0},
 	{"", 0},
@@ -296,13 +277,6 @@ static enum power_supply_property energy
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-inline char *acpi_battery_units(struct acpi_battery *battery)
-{
-	return (battery->power_unit)?"mA":"mW";
-}
-#endif
-
 /* --------------------------------------------------------------------------
                                Battery Management
    -------------------------------------------------------------------------- */
@@ -643,279 +617,6 @@ static void acpi_battery_refresh(struct
 }
 
 /* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-
-#ifdef CONFIG_ACPI_PROCFS_POWER
-static struct proc_dir_entry *acpi_battery_dir;
-
-static int acpi_battery_print_info(struct seq_file *seq, int result)
-{
-	struct acpi_battery *battery = seq->private;
-
-	if (result)
-		goto end;
-
-	seq_printf(seq, "present:                 %s\n",
-		   acpi_battery_present(battery)?"yes":"no");
-	if (!acpi_battery_present(battery))
-		goto end;
-	if (battery->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "design capacity:         unknown\n");
-	else
-		seq_printf(seq, "design capacity:         %d %sh\n",
-			   battery->design_capacity,
-			   acpi_battery_units(battery));
-
-	if (battery->full_charge_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "last full capacity:      unknown\n");
-	else
-		seq_printf(seq, "last full capacity:      %d %sh\n",
-			   battery->full_charge_capacity,
-			   acpi_battery_units(battery));
-
-	seq_printf(seq, "battery technology:      %srechargeable\n",
-		   (!battery->technology)?"non-":"");
-
-	if (battery->design_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "design voltage:          unknown\n");
-	else
-		seq_printf(seq, "design voltage:          %d mV\n",
-			   battery->design_voltage);
-	seq_printf(seq, "design capacity warning: %d %sh\n",
-		   battery->design_capacity_warning,
-		   acpi_battery_units(battery));
-	seq_printf(seq, "design capacity low:     %d %sh\n",
-		   battery->design_capacity_low,
-		   acpi_battery_units(battery));
-	seq_printf(seq, "cycle count:		  %i\n", battery->cycle_count);
-	seq_printf(seq, "capacity granularity 1:  %d %sh\n",
-		   battery->capacity_granularity_1,
-		   acpi_battery_units(battery));
-	seq_printf(seq, "capacity granularity 2:  %d %sh\n",
-		   battery->capacity_granularity_2,
-		   acpi_battery_units(battery));
-	seq_printf(seq, "model number:            %s\n", battery->model_number);
-	seq_printf(seq, "serial number:           %s\n", battery->serial_number);
-	seq_printf(seq, "battery type:            %s\n", battery->type);
-	seq_printf(seq, "OEM info:                %s\n", battery->oem_info);
-      end:
-	if (result)
-		seq_printf(seq, "ERROR: Unable to read battery info\n");
-	return result;
-}
-
-static int acpi_battery_print_state(struct seq_file *seq, int result)
-{
-	struct acpi_battery *battery = seq->private;
-
-	if (result)
-		goto end;
-
-	seq_printf(seq, "present:                 %s\n",
-		   acpi_battery_present(battery)?"yes":"no");
-	if (!acpi_battery_present(battery))
-		goto end;
-
-	seq_printf(seq, "capacity state:          %s\n",
-			(battery->state & 0x04)?"critical":"ok");
-	if ((battery->state & 0x01) && (battery->state & 0x02))
-		seq_printf(seq,
-			   "charging state:          charging/discharging\n");
-	else if (battery->state & 0x01)
-		seq_printf(seq, "charging state:          discharging\n");
-	else if (battery->state & 0x02)
-		seq_printf(seq, "charging state:          charging\n");
-	else
-		seq_printf(seq, "charging state:          charged\n");
-
-	if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "present rate:            unknown\n");
-	else
-		seq_printf(seq, "present rate:            %d %s\n",
-			   battery->rate_now, acpi_battery_units(battery));
-
-	if (battery->capacity_now == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "remaining capacity:      unknown\n");
-	else
-		seq_printf(seq, "remaining capacity:      %d %sh\n",
-			   battery->capacity_now, acpi_battery_units(battery));
-	if (battery->voltage_now == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "present voltage:         unknown\n");
-	else
-		seq_printf(seq, "present voltage:         %d mV\n",
-			   battery->voltage_now);
-      end:
-	if (result)
-		seq_printf(seq, "ERROR: Unable to read battery state\n");
-
-	return result;
-}
-
-static int acpi_battery_print_alarm(struct seq_file *seq, int result)
-{
-	struct acpi_battery *battery = seq->private;
-
-	if (result)
-		goto end;
-
-	if (!acpi_battery_present(battery)) {
-		seq_printf(seq, "present:                 no\n");
-		goto end;
-	}
-	seq_printf(seq, "alarm:                   ");
-	if (!battery->alarm)
-		seq_printf(seq, "unsupported\n");
-	else
-		seq_printf(seq, "%u %sh\n", battery->alarm,
-				acpi_battery_units(battery));
-      end:
-	if (result)
-		seq_printf(seq, "ERROR: Unable to read battery alarm\n");
-	return result;
-}
-
-static ssize_t acpi_battery_write_alarm(struct file *file,
-					const char __user * buffer,
-					size_t count, loff_t * ppos)
-{
-	int result = 0;
-	char alarm_string[12] = { '\0' };
-	struct seq_file *m = file->private_data;
-	struct acpi_battery *battery = m->private;
-
-	if (!battery || (count > sizeof(alarm_string) - 1))
-		return -EINVAL;
-	if (!acpi_battery_present(battery)) {
-		result = -ENODEV;
-		goto end;
-	}
-	if (copy_from_user(alarm_string, buffer, count)) {
-		result = -EFAULT;
-		goto end;
-	}
-	alarm_string[count] = '\0';
-	battery->alarm = simple_strtol(alarm_string, NULL, 0);
-	result = acpi_battery_set_alarm(battery);
-      end:
-	if (!result)
-		return count;
-	return result;
-}
-
-typedef int(*print_func)(struct seq_file *seq, int result);
-
-static print_func acpi_print_funcs[ACPI_BATTERY_NUMFILES] = {
-	acpi_battery_print_info,
-	acpi_battery_print_state,
-	acpi_battery_print_alarm,
-};
-
-static int acpi_battery_read(int fid, struct seq_file *seq)
-{
-	struct acpi_battery *battery = seq->private;
-	int result = acpi_battery_update(battery);
-	return acpi_print_funcs[fid](seq, result);
-}
-
-#define DECLARE_FILE_FUNCTIONS(_name) \
-static int acpi_battery_read_##_name(struct seq_file *seq, void *offset) \
-{ \
-	return acpi_battery_read(_name##_tag, seq); \
-} \
-static int acpi_battery_##_name##_open_fs(struct inode *inode, struct file *file) \
-{ \
-	return single_open(file, acpi_battery_read_##_name, PDE(inode)->data); \
-}
-
-DECLARE_FILE_FUNCTIONS(info);
-DECLARE_FILE_FUNCTIONS(state);
-DECLARE_FILE_FUNCTIONS(alarm);
-
-#undef DECLARE_FILE_FUNCTIONS
-
-#define FILE_DESCRIPTION_RO(_name) \
-	{ \
-	.name = __stringify(_name), \
-	.mode = S_IRUGO, \
-	.ops = { \
-		.open = acpi_battery_##_name##_open_fs, \
-		.read = seq_read, \
-		.llseek = seq_lseek, \
-		.release = single_release, \
-		.owner = THIS_MODULE, \
-		}, \
-	}
-
-#define FILE_DESCRIPTION_RW(_name) \
-	{ \
-	.name = __stringify(_name), \
-	.mode = S_IFREG | S_IRUGO | S_IWUSR, \
-	.ops = { \
-		.open = acpi_battery_##_name##_open_fs, \
-		.read = seq_read, \
-		.llseek = seq_lseek, \
-		.write = acpi_battery_write_##_name, \
-		.release = single_release, \
-		.owner = THIS_MODULE, \
-		}, \
-	}
-
-static struct battery_file {
-	struct file_operations ops;
-	mode_t mode;
-	const char *name;
-} acpi_battery_file[] = {
-	FILE_DESCRIPTION_RO(info),
-	FILE_DESCRIPTION_RO(state),
-	FILE_DESCRIPTION_RW(alarm),
-};
-
-#undef FILE_DESCRIPTION_RO
-#undef FILE_DESCRIPTION_RW
-
-static int acpi_battery_add_fs(struct acpi_device *device)
-{
-	struct proc_dir_entry *entry = NULL;
-	int i;
-
-	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for battery is loaded,"
-			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
-	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
-						     acpi_battery_dir);
-		if (!acpi_device_dir(device))
-			return -ENODEV;
-	}
-
-	for (i = 0; i < ACPI_BATTERY_NUMFILES; ++i) {
-		entry = proc_create_data(acpi_battery_file[i].name,
-					 acpi_battery_file[i].mode,
-					 acpi_device_dir(device),
-					 &acpi_battery_file[i].ops,
-					 acpi_driver_data(device));
-		if (!entry)
-			return -ENODEV;
-	}
-	return 0;
-}
-
-static void acpi_battery_remove_fs(struct acpi_device *device)
-{
-	int i;
-	if (!acpi_device_dir(device))
-		return;
-	for (i = 0; i < ACPI_BATTERY_NUMFILES; ++i)
-		remove_proc_entry(acpi_battery_file[i].name,
-				  acpi_device_dir(device));
-
-	remove_proc_entry(acpi_device_bid(device), acpi_battery_dir);
-	acpi_device_dir(device) = NULL;
-}
-
-#endif
-
-/* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
@@ -959,19 +660,12 @@ static int acpi_battery_add(struct acpi_
 			"_BIX", &handle)))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 	acpi_battery_update(battery);
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	result = acpi_battery_add_fs(device);
-#endif
 	if (!result) {
 		printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
 			ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
 			device->status.battery_present ? "present" : "absent");
-	} else {
-#ifdef CONFIG_ACPI_PROCFS_POWER
-		acpi_battery_remove_fs(device);
-#endif
+	} else
 		kfree(battery);
-	}
 	return result;
 }
 
@@ -982,9 +676,6 @@ static int acpi_battery_remove(struct ac
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 	battery = acpi_driver_data(device);
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_battery_remove_fs(device);
-#endif
 	sysfs_remove_battery(battery);
 	mutex_destroy(&battery->lock);
 	kfree(battery);
@@ -1020,17 +711,7 @@ static void __init acpi_battery_init_asy
 {
 	if (acpi_disabled)
 		return;
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_battery_dir = acpi_lock_battery_dir();
-	if (!acpi_battery_dir)
-		return;
-#endif
-	if (acpi_bus_register_driver(&acpi_battery_driver) < 0) {
-#ifdef CONFIG_ACPI_PROCFS_POWER
-		acpi_unlock_battery_dir(acpi_battery_dir);
-#endif
-		return;
-	}
+	acpi_bus_register_driver(&acpi_battery_driver);
 	return;
 }
 
@@ -1043,9 +724,6 @@ static int __init acpi_battery_init(void
 static void __exit acpi_battery_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_battery_driver);
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_unlock_battery_dir(acpi_battery_dir);
-#endif
 }
 
 module_init(acpi_battery_init);
Index: linux-2.6/drivers/acpi/cm_sbs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/cm_sbs.c
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or (at
- *  your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/acpi.h>
-#include <linux/types.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <acpi/acpi_bus.h>
-#include <acpi/acpi_drivers.h>
-
-#define PREFIX "ACPI: "
-
-ACPI_MODULE_NAME("cm_sbs");
-#define ACPI_AC_CLASS		"ac_adapter"
-#define ACPI_BATTERY_CLASS	"battery"
-#define _COMPONENT		ACPI_SBS_COMPONENT
-static struct proc_dir_entry *acpi_ac_dir;
-static struct proc_dir_entry *acpi_battery_dir;
-
-static DEFINE_MUTEX(cm_sbs_mutex);
-
-static int lock_ac_dir_cnt;
-static int lock_battery_dir_cnt;
-
-struct proc_dir_entry *acpi_lock_ac_dir(void)
-{
-	mutex_lock(&cm_sbs_mutex);
-	if (!acpi_ac_dir)
-		acpi_ac_dir = proc_mkdir(ACPI_AC_CLASS, acpi_root_dir);
-	if (acpi_ac_dir) {
-		lock_ac_dir_cnt++;
-	} else {
-		printk(KERN_ERR PREFIX
-				  "Cannot create %s\n", ACPI_AC_CLASS);
-	}
-	mutex_unlock(&cm_sbs_mutex);
-	return acpi_ac_dir;
-}
-EXPORT_SYMBOL(acpi_lock_ac_dir);
-
-void acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir_param)
-{
-	mutex_lock(&cm_sbs_mutex);
-	if (acpi_ac_dir_param)
-		lock_ac_dir_cnt--;
-	if (lock_ac_dir_cnt == 0 && acpi_ac_dir_param && acpi_ac_dir) {
-		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
-		acpi_ac_dir = NULL;
-	}
-	mutex_unlock(&cm_sbs_mutex);
-}
-EXPORT_SYMBOL(acpi_unlock_ac_dir);
-
-struct proc_dir_entry *acpi_lock_battery_dir(void)
-{
-	mutex_lock(&cm_sbs_mutex);
-	if (!acpi_battery_dir) {
-		acpi_battery_dir =
-		    proc_mkdir(ACPI_BATTERY_CLASS, acpi_root_dir);
-	}
-	if (acpi_battery_dir) {
-		lock_battery_dir_cnt++;
-	} else {
-		printk(KERN_ERR PREFIX
-				  "Cannot create %s\n", ACPI_BATTERY_CLASS);
-	}
-	mutex_unlock(&cm_sbs_mutex);
-	return acpi_battery_dir;
-}
-EXPORT_SYMBOL(acpi_lock_battery_dir);
-
-void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir_param)
-{
-	mutex_lock(&cm_sbs_mutex);
-	if (acpi_battery_dir_param)
-		lock_battery_dir_cnt--;
-	if (lock_battery_dir_cnt == 0 && acpi_battery_dir_param
-	    && acpi_battery_dir) {
-		remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
-		acpi_battery_dir = NULL;
-	}
-	mutex_unlock(&cm_sbs_mutex);
-	return;
-}
-EXPORT_SYMBOL(acpi_unlock_battery_dir);
Index: linux-2.6/drivers/acpi/sbs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sbs.c
+++ linux-2.6/drivers/acpi/sbs.c
@@ -29,13 +29,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
-
-#ifdef CONFIG_ACPI_PROCFS_POWER
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <asm/uaccess.h>
-#endif
-
 #include <linux/acpi.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
@@ -84,9 +77,6 @@ MODULE_DEVICE_TABLE(acpi, sbs_device_ids
 struct acpi_battery {
 	struct power_supply bat;
 	struct acpi_sbs *sbs;
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	struct proc_dir_entry *proc_entry;
-#endif
 	unsigned long update_time;
 	char name[8];
 	char manufacturer_name[ACPI_SBS_BLOCK_MAX];
@@ -119,9 +109,6 @@ struct acpi_sbs {
 	struct acpi_device *device;
 	struct acpi_smb_hc *hc;
 	struct mutex lock;
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	struct proc_dir_entry *charger_entry;
-#endif
 	struct acpi_battery battery[MAX_SBS_BAT];
 	u8 batteries_supported:4;
 	u8 manager_present:1;
@@ -471,274 +458,6 @@ static struct device_attribute alarm_att
 };
 
 /* --------------------------------------------------------------------------
-                              FS Interface (/proc/acpi)
-   -------------------------------------------------------------------------- */
-
-#ifdef CONFIG_ACPI_PROCFS_POWER
-/* Generic Routines */
-static int
-acpi_sbs_add_fs(struct proc_dir_entry **dir,
-		struct proc_dir_entry *parent_dir,
-		char *dir_name,
-		const struct file_operations *info_fops,
-		const struct file_operations *state_fops,
-		const struct file_operations *alarm_fops, void *data)
-{
-	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for SBS is loaded,"
-			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
-	if (!*dir) {
-		*dir = proc_mkdir(dir_name, parent_dir);
-		if (!*dir) {
-			return -ENODEV;
-		}
-	}
-
-	/* 'info' [R] */
-	if (info_fops)
-		proc_create_data(ACPI_SBS_FILE_INFO, S_IRUGO, *dir,
-				 info_fops, data);
-
-	/* 'state' [R] */
-	if (state_fops)
-		proc_create_data(ACPI_SBS_FILE_STATE, S_IRUGO, *dir,
-				 state_fops, data);
-
-	/* 'alarm' [R/W] */
-	if (alarm_fops)
-		proc_create_data(ACPI_SBS_FILE_ALARM, S_IRUGO, *dir,
-				 alarm_fops, data);
-	return 0;
-}
-
-static void
-acpi_sbs_remove_fs(struct proc_dir_entry **dir,
-			   struct proc_dir_entry *parent_dir)
-{
-	if (*dir) {
-		remove_proc_entry(ACPI_SBS_FILE_INFO, *dir);
-		remove_proc_entry(ACPI_SBS_FILE_STATE, *dir);
-		remove_proc_entry(ACPI_SBS_FILE_ALARM, *dir);
-		remove_proc_entry((*dir)->name, parent_dir);
-		*dir = NULL;
-	}
-}
-
-/* Smart Battery Interface */
-static struct proc_dir_entry *acpi_battery_dir = NULL;
-
-static inline char *acpi_battery_units(struct acpi_battery *battery)
-{
-	return acpi_battery_mode(battery) ? " mW" : " mA";
-}
-
-
-static int acpi_battery_read_info(struct seq_file *seq, void *offset)
-{
-	struct acpi_battery *battery = seq->private;
-	struct acpi_sbs *sbs = battery->sbs;
-	int result = 0;
-
-	mutex_lock(&sbs->lock);
-
-	seq_printf(seq, "present:                 %s\n",
-		   (battery->present) ? "yes" : "no");
-	if (!battery->present)
-		goto end;
-
-	seq_printf(seq, "design capacity:         %i%sh\n",
-		   battery->design_capacity * acpi_battery_scale(battery),
-		   acpi_battery_units(battery));
-	seq_printf(seq, "last full capacity:      %i%sh\n",
-		   battery->full_charge_capacity * acpi_battery_scale(battery),
-		   acpi_battery_units(battery));
-	seq_printf(seq, "battery technology:      rechargeable\n");
-	seq_printf(seq, "design voltage:          %i mV\n",
-		   battery->design_voltage * acpi_battery_vscale(battery));
-	seq_printf(seq, "design capacity warning: unknown\n");
-	seq_printf(seq, "design capacity low:     unknown\n");
-	seq_printf(seq, "cycle count:		  %i\n", battery->cycle_count);
-	seq_printf(seq, "capacity granularity 1:  unknown\n");
-	seq_printf(seq, "capacity granularity 2:  unknown\n");
-	seq_printf(seq, "model number:            %s\n", battery->device_name);
-	seq_printf(seq, "serial number:           %i\n",
-		   battery->serial_number);
-	seq_printf(seq, "battery type:            %s\n",
-		   battery->device_chemistry);
-	seq_printf(seq, "OEM info:                %s\n",
-		   battery->manufacturer_name);
-      end:
-	mutex_unlock(&sbs->lock);
-	return result;
-}
-
-static int acpi_battery_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_battery_read_info, PDE(inode)->data);
-}
-
-static int acpi_battery_read_state(struct seq_file *seq, void *offset)
-{
-	struct acpi_battery *battery = seq->private;
-	struct acpi_sbs *sbs = battery->sbs;
-	int rate;
-
-	mutex_lock(&sbs->lock);
-	seq_printf(seq, "present:                 %s\n",
-		   (battery->present) ? "yes" : "no");
-	if (!battery->present)
-		goto end;
-
-	acpi_battery_get_state(battery);
-	seq_printf(seq, "capacity state:          %s\n",
-		   (battery->state & 0x0010) ? "critical" : "ok");
-	seq_printf(seq, "charging state:          %s\n",
-		   (battery->rate_now < 0) ? "discharging" :
-		   ((battery->rate_now > 0) ? "charging" : "charged"));
-	rate = abs(battery->rate_now) * acpi_battery_ipscale(battery);
-	rate *= (acpi_battery_mode(battery))?(battery->voltage_now *
-			acpi_battery_vscale(battery)/1000):1;
-	seq_printf(seq, "present rate:            %d%s\n", rate,
-		   acpi_battery_units(battery));
-	seq_printf(seq, "remaining capacity:      %i%sh\n",
-		   battery->capacity_now * acpi_battery_scale(battery),
-		   acpi_battery_units(battery));
-	seq_printf(seq, "present voltage:         %i mV\n",
-		   battery->voltage_now * acpi_battery_vscale(battery));
-
-      end:
-	mutex_unlock(&sbs->lock);
-	return 0;
-}
-
-static int acpi_battery_state_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_battery_read_state, PDE(inode)->data);
-}
-
-static int acpi_battery_read_alarm(struct seq_file *seq, void *offset)
-{
-	struct acpi_battery *battery = seq->private;
-	struct acpi_sbs *sbs = battery->sbs;
-	int result = 0;
-
-	mutex_lock(&sbs->lock);
-
-	if (!battery->present) {
-		seq_printf(seq, "present:                 no\n");
-		goto end;
-	}
-
-	acpi_battery_get_alarm(battery);
-	seq_printf(seq, "alarm:                   ");
-	if (battery->alarm_capacity)
-		seq_printf(seq, "%i%sh\n",
-			   battery->alarm_capacity *
-			   acpi_battery_scale(battery),
-			   acpi_battery_units(battery));
-	else
-		seq_printf(seq, "disabled\n");
-      end:
-	mutex_unlock(&sbs->lock);
-	return result;
-}
-
-static ssize_t
-acpi_battery_write_alarm(struct file *file, const char __user * buffer,
-			 size_t count, loff_t * ppos)
-{
-	struct seq_file *seq = file->private_data;
-	struct acpi_battery *battery = seq->private;
-	struct acpi_sbs *sbs = battery->sbs;
-	char alarm_string[12] = { '\0' };
-	int result = 0;
-	mutex_lock(&sbs->lock);
-	if (!battery->present) {
-		result = -ENODEV;
-		goto end;
-	}
-	if (count > sizeof(alarm_string) - 1) {
-		result = -EINVAL;
-		goto end;
-	}
-	if (copy_from_user(alarm_string, buffer, count)) {
-		result = -EFAULT;
-		goto end;
-	}
-	alarm_string[count] = 0;
-	battery->alarm_capacity = simple_strtoul(alarm_string, NULL, 0) /
-					acpi_battery_scale(battery);
-	acpi_battery_set_alarm(battery);
-      end:
-	mutex_unlock(&sbs->lock);
-	if (result)
-		return result;
-	return count;
-}
-
-static int acpi_battery_alarm_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_battery_read_alarm, PDE(inode)->data);
-}
-
-static const struct file_operations acpi_battery_info_fops = {
-	.open = acpi_battery_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static const struct file_operations acpi_battery_state_fops = {
-	.open = acpi_battery_state_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static const struct file_operations acpi_battery_alarm_fops = {
-	.open = acpi_battery_alarm_open_fs,
-	.read = seq_read,
-	.write = acpi_battery_write_alarm,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-/* Legacy AC Adapter Interface */
-
-static struct proc_dir_entry *acpi_ac_dir = NULL;
-
-static int acpi_ac_read_state(struct seq_file *seq, void *offset)
-{
-
-	struct acpi_sbs *sbs = seq->private;
-
-	mutex_lock(&sbs->lock);
-
-	seq_printf(seq, "state:                   %s\n",
-		   sbs->charger_present ? "on-line" : "off-line");
-
-	mutex_unlock(&sbs->lock);
-	return 0;
-}
-
-static int acpi_ac_state_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_ac_read_state, PDE(inode)->data);
-}
-
-static const struct file_operations acpi_ac_state_fops = {
-	.open = acpi_ac_state_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-#endif
-
-/* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
 static int acpi_battery_read(struct acpi_battery *battery)
@@ -783,12 +502,6 @@ static int acpi_battery_add(struct acpi_
 		return result;
 
 	sprintf(battery->name, ACPI_BATTERY_DIR_NAME, id);
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_sbs_add_fs(&battery->proc_entry, acpi_battery_dir,
-			battery->name, &acpi_battery_info_fops,
-			&acpi_battery_state_fops, &acpi_battery_alarm_fops,
-			battery);
-#endif
 	battery->bat.name = battery->name;
 	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
 	if (!acpi_battery_mode(battery)) {
@@ -824,10 +537,6 @@ static void acpi_battery_remove(struct a
 			device_remove_file(battery->bat.dev, &alarm_attr);
 		power_supply_unregister(&battery->bat);
 	}
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	if (battery->proc_entry)
-		acpi_sbs_remove_fs(&battery->proc_entry, acpi_battery_dir);
-#endif
 }
 
 static int acpi_charger_add(struct acpi_sbs *sbs)
@@ -837,13 +546,6 @@ static int acpi_charger_add(struct acpi_
 	result = acpi_ac_get_present(sbs);
 	if (result)
 		goto end;
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	result = acpi_sbs_add_fs(&sbs->charger_entry, acpi_ac_dir,
-				 ACPI_AC_DIR_NAME, NULL,
-				 &acpi_ac_state_fops, NULL, sbs);
-	if (result)
-		goto end;
-#endif
 	sbs->charger.name = "sbs-charger";
 	sbs->charger.type = POWER_SUPPLY_TYPE_MAINS;
 	sbs->charger.properties = sbs_ac_props;
@@ -861,10 +563,6 @@ static void acpi_charger_remove(struct a
 {
 	if (sbs->charger.dev)
 		power_supply_unregister(&sbs->charger);
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	if (sbs->charger_entry)
-		acpi_sbs_remove_fs(&sbs->charger_entry, acpi_ac_dir);
-#endif
 }
 
 static void acpi_sbs_callback(void *context)
@@ -965,20 +663,6 @@ static int acpi_sbs_remove(struct acpi_d
 	return 0;
 }
 
-static void acpi_sbs_rmdirs(void)
-{
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	if (acpi_ac_dir) {
-		acpi_unlock_ac_dir(acpi_ac_dir);
-		acpi_ac_dir = NULL;
-	}
-	if (acpi_battery_dir) {
-		acpi_unlock_battery_dir(acpi_battery_dir);
-		acpi_battery_dir = NULL;
-	}
-#endif
-}
-
 static int acpi_sbs_resume(struct acpi_device *device)
 {
 	struct acpi_sbs *sbs;
@@ -1006,28 +690,15 @@ static int __init acpi_sbs_init(void)
 
 	if (acpi_disabled)
 		return -ENODEV;
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_ac_dir = acpi_lock_ac_dir();
-	if (!acpi_ac_dir)
-		return -ENODEV;
-	acpi_battery_dir = acpi_lock_battery_dir();
-	if (!acpi_battery_dir) {
-		acpi_sbs_rmdirs();
-		return -ENODEV;
-	}
-#endif
 	result = acpi_bus_register_driver(&acpi_sbs_driver);
-	if (result < 0) {
-		acpi_sbs_rmdirs();
+	if (result < 0)
 		return -ENODEV;
-	}
 	return 0;
 }
 
 static void __exit acpi_sbs_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_sbs_driver);
-	acpi_sbs_rmdirs();
 	return;
 }
 
Index: linux-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.orig/Documentation/feature-removal-schedule.txt
+++ linux-2.6/Documentation/feature-removal-schedule.txt
@@ -248,17 +248,6 @@ Who:	Zhang Rui <rui.zhang@intel.com>
 
 ---------------------------
 
-What:	CONFIG_ACPI_PROCFS_POWER
-When:	2.6.39
-Why:	sysfs I/F for ACPI power devices, including AC and Battery,
-        has been working in upstream kenrel since 2.6.24, Sep 2007.
-	In 2.6.37, we make the sysfs I/F always built in and this option
-	disabled by default.
-	Remove this option and the ACPI power procfs interface in 2.6.39.
-Who:	Zhang Rui <rui.zhang@intel.com>
-
----------------------------
-
 What:	/proc/acpi/button
 When:	August 2007
 Why:	/proc/acpi/button has been replaced by events to the input layer


