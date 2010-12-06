From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/7] ACPI: delete CONFIG_ACPI_PROCFS_POWER
Date: Mon, 06 Dec 2010 15:04:13 +0800
Message-ID: <1291619053.19296.575.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21936 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab0LFHHX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Dec 2010 02:07:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


CONFIG_ACPI_PROCFS_POWER is introduced to use the ac and battery driver
procfs I/F even if CONFIG_ACPI_PROCFS is cleared.
This is not useful anymore because we want to use the sysfs I/F of
these drivers, and remove the deprecated procfs I/F permanently in 2.6.39.

So delete this kernel config and fold into CONFIG_ACPI_PROCFS.

Sign-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig   |   15 ---------------
 drivers/acpi/Makefile  |    2 +-
 drivers/acpi/ac.c      |   20 ++++++++++----------
 drivers/acpi/battery.c |   20 ++++++++++----------
 drivers/acpi/sbs.c     |   20 ++++++++++----------
 5 files changed, 31 insertions(+), 46 deletions(-)

Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -62,21 +62,6 @@ config ACPI_PROCFS
 
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
-
-	  Say N to delete power /proc/acpi/ directories that have moved to /sys/
-
 config ACPI_POWER_METER
 	tristate "ACPI 4.0 power meter"
 	depends on HWMON
Index: linux-2.6/drivers/acpi/ac.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ac.c
+++ linux-2.6/drivers/acpi/ac.c
@@ -28,7 +28,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #endif
@@ -53,7 +53,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI AC Adapter Driver");
 MODULE_LICENSE("GPL");
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 extern struct proc_dir_entry *acpi_lock_ac_dir(void);
 extern void *acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir);
 static int acpi_ac_open_fs(struct inode *inode, struct file *file);
@@ -91,7 +91,7 @@ struct acpi_ac {
 
 #define to_acpi_ac(x) container_of(x, struct acpi_ac, charger);
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 static const struct file_operations acpi_ac_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_ac_open_fs,
@@ -140,7 +140,7 @@ static int acpi_ac_get_state(struct acpi
 	return 0;
 }
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -269,7 +269,7 @@ static int acpi_ac_add(struct acpi_devic
 	if (result)
 		goto end;
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	result = acpi_ac_add_fs(device);
 #endif
 	if (result)
@@ -287,7 +287,7 @@ static int acpi_ac_add(struct acpi_devic
 
       end:
 	if (result) {
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 		acpi_ac_remove_fs(device);
 #endif
 		kfree(ac);
@@ -323,7 +323,7 @@ static int acpi_ac_remove(struct acpi_de
 
 	if (ac->charger.dev)
 		power_supply_unregister(&ac->charger);
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_ac_remove_fs(device);
 #endif
 
@@ -339,7 +339,7 @@ static int __init acpi_ac_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
 		return -ENODEV;
@@ -347,7 +347,7 @@ static int __init acpi_ac_init(void)
 
 	result = acpi_bus_register_driver(&acpi_ac_driver);
 	if (result < 0) {
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 		acpi_unlock_ac_dir(acpi_ac_dir);
 #endif
 		return -ENODEV;
@@ -361,7 +361,7 @@ static void __exit acpi_ac_exit(void)
 
 	acpi_bus_unregister_driver(&acpi_ac_driver);
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_unlock_ac_dir(acpi_ac_dir);
 #endif
 
Index: linux-2.6/drivers/acpi/battery.c
===================================================================
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -34,7 +34,7 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
@@ -67,7 +67,7 @@ static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 extern struct proc_dir_entry *acpi_lock_battery_dir(void);
 extern void *acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 
@@ -296,7 +296,7 @@ static enum power_supply_property energy
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 inline char *acpi_battery_units(struct acpi_battery *battery)
 {
 	return (battery->power_unit)?"mA":"mW";
@@ -635,7 +635,7 @@ static int acpi_battery_update(struct ac
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 static struct proc_dir_entry *acpi_battery_dir;
 
 static int acpi_battery_print_info(struct seq_file *seq, int result)
@@ -944,7 +944,7 @@ static int acpi_battery_add(struct acpi_
 			"_BIX", &handle)))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 	acpi_battery_update(battery);
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	result = acpi_battery_add_fs(device);
 #endif
 	if (!result) {
@@ -952,7 +952,7 @@ static int acpi_battery_add(struct acpi_
 			ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
 			device->status.battery_present ? "present" : "absent");
 	} else {
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 		acpi_battery_remove_fs(device);
 #endif
 		kfree(battery);
@@ -967,7 +967,7 @@ static int acpi_battery_remove(struct ac
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 	battery = acpi_driver_data(device);
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_battery_remove_fs(device);
 #endif
 	sysfs_remove_battery(battery);
@@ -1005,13 +1005,13 @@ static void __init acpi_battery_init_asy
 {
 	if (acpi_disabled)
 		return;
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir)
 		return;
 #endif
 	if (acpi_bus_register_driver(&acpi_battery_driver) < 0) {
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 		acpi_unlock_battery_dir(acpi_battery_dir);
 #endif
 		return;
@@ -1028,7 +1028,7 @@ static int __init acpi_battery_init(void
 static void __exit acpi_battery_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_battery_driver);
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_unlock_battery_dir(acpi_battery_dir);
 #endif
 }
Index: linux-2.6/drivers/acpi/sbs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sbs.c
+++ linux-2.6/drivers/acpi/sbs.c
@@ -30,7 +30,7 @@
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
@@ -84,7 +84,7 @@ MODULE_DEVICE_TABLE(acpi, sbs_device_ids
 struct acpi_battery {
 	struct power_supply bat;
 	struct acpi_sbs *sbs;
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	struct proc_dir_entry *proc_entry;
 #endif
 	unsigned long update_time;
@@ -119,7 +119,7 @@ struct acpi_sbs {
 	struct acpi_device *device;
 	struct acpi_smb_hc *hc;
 	struct mutex lock;
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	struct proc_dir_entry *charger_entry;
 #endif
 	struct acpi_battery battery[MAX_SBS_BAT];
@@ -474,7 +474,7 @@ static struct device_attribute alarm_att
                               FS Interface (/proc/acpi)
    -------------------------------------------------------------------------- */
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 /* Generic Routines */
 static int
 acpi_sbs_add_fs(struct proc_dir_entry **dir,
@@ -781,7 +781,7 @@ static int acpi_battery_add(struct acpi_
 		return result;
 
 	sprintf(battery->name, ACPI_BATTERY_DIR_NAME, id);
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_sbs_add_fs(&battery->proc_entry, acpi_battery_dir,
 			battery->name, &acpi_battery_info_fops,
 			&acpi_battery_state_fops, &acpi_battery_alarm_fops,
@@ -822,7 +822,7 @@ static void acpi_battery_remove(struct a
 			device_remove_file(battery->bat.dev, &alarm_attr);
 		power_supply_unregister(&battery->bat);
 	}
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	if (battery->proc_entry)
 		acpi_sbs_remove_fs(&battery->proc_entry, acpi_battery_dir);
 #endif
@@ -835,7 +835,7 @@ static int acpi_charger_add(struct acpi_
 	result = acpi_ac_get_present(sbs);
 	if (result)
 		goto end;
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	result = acpi_sbs_add_fs(&sbs->charger_entry, acpi_ac_dir,
 				 ACPI_AC_DIR_NAME, NULL,
 				 &acpi_ac_state_fops, NULL, sbs);
@@ -859,7 +859,7 @@ static void acpi_charger_remove(struct a
 {
 	if (sbs->charger.dev)
 		power_supply_unregister(&sbs->charger);
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	if (sbs->charger_entry)
 		acpi_sbs_remove_fs(&sbs->charger_entry, acpi_ac_dir);
 #endif
@@ -965,7 +965,7 @@ static int acpi_sbs_remove(struct acpi_d
 
 static void acpi_sbs_rmdirs(void)
 {
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	if (acpi_ac_dir) {
 		acpi_unlock_ac_dir(acpi_ac_dir);
 		acpi_ac_dir = NULL;
@@ -1004,7 +1004,7 @@ static int __init acpi_sbs_init(void)
 
 	if (acpi_disabled)
 		return -ENODEV;
-#ifdef CONFIG_ACPI_PROCFS_POWER
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
 		return -ENODEV;
Index: linux-2.6/drivers/acpi/Makefile
===================================================================
--- linux-2.6.orig/drivers/acpi/Makefile
+++ linux-2.6/drivers/acpi/Makefile
@@ -41,7 +41,7 @@ acpi-y				+= event.o
 acpi-y				+= sysfs.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
-acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
+acpi-$(CONFIG_ACPI_PROCFS) += cm_sbs.o
 ifdef CONFIG_ACPI_VIDEO
 acpi-y				+= video_detect.o
 endif


