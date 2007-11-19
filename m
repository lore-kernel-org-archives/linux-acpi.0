From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: Split out control for /proc/acpi entries from battery,
	ac, and sbs.
Date: Mon, 19 Nov 2007 16:33:45 +0300
Message-ID: <20071119133345.20314.2476.stgit@localhost.localdomain>
References: <200711190046.06607.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:37272 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752107AbXKSNdZ (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 19 Nov 2007 08:33:25 -0500
In-Reply-To: <200711190046.06607.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Introduce new ACPI_PROCFS_POWER (default Yes) config option and move 
procfs code in battery, ac, and sbs drivers under it.
This is done to allow ACPI_PROCFS to be default No. 

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/Kconfig   |   16 +++++++++++++++-
 drivers/acpi/Makefile  |    2 +-
 drivers/acpi/ac.c      |   20 ++++++++++----------
 drivers/acpi/battery.c |   20 ++++++++++----------
 drivers/acpi/sbs.c     |   20 ++++++++++----------
 5 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 087a702..497e92d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -69,7 +69,21 @@ config ACPI_PROCFS
 	  and functions which do not yet exist in /sys.
 
 	  Say N to delete /proc/acpi/ files that have moved to /sys/
-
+config ACPI_PROCFS_POWER
+	bool "Deprecated power /proc/acpi folders"
+	depends on PROC_FS
+	default y
+	---help---
+	  For backwards compatibility, this option allows
+          deprecated power /proc/acpi/ folders to exist, even when
+          they have been replaced by functions in /sys.
+          The deprecated folders (and their replacements) include:
+	  /proc/acpi/battery/* (/sys/class/power_supply/*)
+	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*)
+	  This option has no effect on /proc/acpi/ folders
+	  and functions, which do not yet exist in /sys
+
+	  Say N to delete power /proc/acpi/ folders that have moved to /sys/
 config ACPI_PROC_EVENT
 	bool "Deprecated /proc/acpi/event support"
 	depends on PROC_FS
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 54e3ab0..456446f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -58,6 +58,6 @@ obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
-obj-y				+= cm_sbs.o
+obj-$(CONFIG_ACPI_PROCFS_POWER)	+= cm_sbs.o
 obj-$(CONFIG_ACPI_SBS)		+= sbs.o
 obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 30238f6..76ed4f5 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -27,7 +27,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #endif
@@ -51,7 +51,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI AC Adapter Driver");
 MODULE_LICENSE("GPL");
 
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 extern struct proc_dir_entry *acpi_lock_ac_dir(void);
 extern void *acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir);
 static int acpi_ac_open_fs(struct inode *inode, struct file *file);
@@ -86,7 +86,7 @@ struct acpi_ac {
 
 #define to_acpi_ac(x) container_of(x, struct acpi_ac, charger);
 
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 static const struct file_operations acpi_ac_fops = {
 	.open = acpi_ac_open_fs,
 	.read = seq_read,
@@ -136,7 +136,7 @@ static int acpi_ac_get_state(struct acpi_ac *ac)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -275,7 +275,7 @@ static int acpi_ac_add(struct acpi_device *device)
 	if (result)
 		goto end;
 
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	result = acpi_ac_add_fs(device);
 #endif
 	if (result)
@@ -300,7 +300,7 @@ static int acpi_ac_add(struct acpi_device *device)
 
       end:
 	if (result) {
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 		acpi_ac_remove_fs(device);
 #endif
 		kfree(ac);
@@ -339,7 +339,7 @@ static int acpi_ac_remove(struct acpi_device *device, int type)
 					    ACPI_ALL_NOTIFY, acpi_ac_notify);
 	if (ac->charger.dev)
 		power_supply_unregister(&ac->charger);
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_ac_remove_fs(device);
 #endif
 
@@ -355,7 +355,7 @@ static int __init acpi_ac_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
 		return -ENODEV;
@@ -363,7 +363,7 @@ static int __init acpi_ac_init(void)
 
 	result = acpi_bus_register_driver(&acpi_ac_driver);
 	if (result < 0) {
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 		acpi_unlock_ac_dir(acpi_ac_dir);
 #endif
 		return -ENODEV;
@@ -377,7 +377,7 @@ static void __exit acpi_ac_exit(void)
 
 	acpi_bus_unregister_driver(&acpi_ac_driver);
 
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_unlock_ac_dir(acpi_ac_dir);
 #endif
 
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 064d80b..bc168a4 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -31,7 +31,7 @@
 #include <linux/types.h>
 #include <linux/jiffies.h>
 
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
@@ -63,7 +63,7 @@ static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 extern struct proc_dir_entry *acpi_lock_battery_dir(void);
 extern void *acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 
@@ -221,7 +221,7 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 inline char *acpi_battery_units(struct acpi_battery *battery)
 {
 	return (battery->power_unit)?"mA":"mW";
@@ -479,7 +479,7 @@ static int acpi_battery_update(struct acpi_battery *battery)
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 static struct proc_dir_entry *acpi_battery_dir;
 
 static int acpi_battery_print_info(struct seq_file *seq, int result)
@@ -786,7 +786,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	acpi_driver_data(device) = battery;
 	mutex_init(&battery->lock);
 	acpi_battery_update(battery);
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	result = acpi_battery_add_fs(device);
 	if (result)
 		goto end;
@@ -804,7 +804,7 @@ static int acpi_battery_add(struct acpi_device *device)
 	       device->status.battery_present ? "present" : "absent");
       end:
 	if (result) {
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 		acpi_battery_remove_fs(device);
 #endif
 		kfree(battery);
@@ -823,7 +823,7 @@ static int acpi_battery_remove(struct acpi_device *device, int type)
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY,
 					    acpi_battery_notify);
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_battery_remove_fs(device);
 #endif
 	sysfs_remove_battery(battery);
@@ -859,13 +859,13 @@ static int __init acpi_battery_init(void)
 {
 	if (acpi_disabled)
 		return -ENODEV;
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir)
 		return -ENODEV;
 #endif
 	if (acpi_bus_register_driver(&acpi_battery_driver) < 0) {
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 		acpi_unlock_battery_dir(acpi_battery_dir);
 #endif
 		return -ENODEV;
@@ -876,7 +876,7 @@ static int __init acpi_battery_init(void)
 static void __exit acpi_battery_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_battery_driver);
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_unlock_battery_dir(acpi_battery_dir);
 #endif
 }
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 90fd09c..278d20f 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -29,7 +29,7 @@
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
@@ -88,7 +88,7 @@ MODULE_DEVICE_TABLE(acpi, sbs_device_ids);
 struct acpi_battery {
 	struct power_supply bat;
 	struct acpi_sbs *sbs;
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	struct proc_dir_entry *proc_entry;
 #endif
 	unsigned long update_time;
@@ -122,7 +122,7 @@ struct acpi_sbs {
 	struct acpi_device *device;
 	struct acpi_smb_hc *hc;
 	struct mutex lock;
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	struct proc_dir_entry *charger_entry;
 #endif
 	struct acpi_battery battery[MAX_SBS_BAT];
@@ -468,7 +468,7 @@ static struct device_attribute alarm_attr = {
                               FS Interface (/proc/acpi)
    -------------------------------------------------------------------------- */
 
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 /* Generic Routines */
 static int
 acpi_sbs_add_fs(struct proc_dir_entry **dir,
@@ -789,7 +789,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		return result;
 
 	sprintf(battery->name, ACPI_BATTERY_DIR_NAME, id);
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_sbs_add_fs(&battery->proc_entry, acpi_battery_dir,
 			battery->name, &acpi_battery_info_fops,
 			&acpi_battery_state_fops, &acpi_battery_alarm_fops,
@@ -820,7 +820,7 @@ static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 	if (sbs->battery[id].bat.dev)
 		device_remove_file(sbs->battery[id].bat.dev, &alarm_attr);
 		power_supply_unregister(&sbs->battery[id].bat);
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	if (sbs->battery[id].proc_entry) {
 		acpi_sbs_remove_fs(&(sbs->battery[id].proc_entry),
 				   acpi_battery_dir);
@@ -835,7 +835,7 @@ static int acpi_charger_add(struct acpi_sbs *sbs)
 	result = acpi_ac_get_present(sbs);
 	if (result)
 		goto end;
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	result = acpi_sbs_add_fs(&sbs->charger_entry, acpi_ac_dir,
 				 ACPI_AC_DIR_NAME, NULL,
 				 &acpi_ac_state_fops, NULL, sbs);
@@ -859,7 +859,7 @@ static void acpi_charger_remove(struct acpi_sbs *sbs)
 {
 	if (sbs->charger.dev)
 		power_supply_unregister(&sbs->charger);
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	if (sbs->charger_entry)
 		acpi_sbs_remove_fs(&sbs->charger_entry, acpi_ac_dir);
 #endif
@@ -965,7 +965,7 @@ static int acpi_sbs_remove(struct acpi_device *device, int type)
 
 static void acpi_sbs_rmdirs(void)
 {
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	if (acpi_ac_dir) {
 		acpi_unlock_ac_dir(acpi_ac_dir);
 		acpi_ac_dir = NULL;
@@ -1004,7 +1004,7 @@ static int __init acpi_sbs_init(void)
 
 	if (acpi_disabled)
 		return -ENODEV;
-#ifdef CONFIG_ACPI_PROCFS
+#ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
 		return -ENODEV;

