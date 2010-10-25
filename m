From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/60] ACPI thermal: remove deprecated procfs I/F
Date: Mon, 25 Oct 2010 02:20:33 -0400
Message-ID: <c57b62f5b1e6dd69ff8c96f6db7f86ea31c0e21f.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:63743 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0JYILM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 04:11:12 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00AR06QCM6U2@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 03:11:11 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Remove the deprecated ACPI thermal driver procfs I/F,
as stated in the changelog of commit 43d9f87b79804f2d75d9d8a81c862b179f055a15

sysfs I/F is available at /sys/class/thermal/thermal_zoneX/

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |  436 +-----------------------------------------------
 1 files changed, 1 insertions(+), 435 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 2f8f171..5a27b0a 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -37,12 +37,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-
-#ifdef CONFIG_ACPI_PROCFS
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#endif
-
 #include <linux/jiffies.h>
 #include <linux/kmod.h>
 #include <linux/reboot.h>
@@ -195,61 +189,6 @@ struct acpi_thermal {
 	struct mutex lock;
 };
 
-#ifdef CONFIG_ACPI_PROCFS
-static int acpi_thermal_state_open_fs(struct inode *inode, struct file *file);
-static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file);
-static int acpi_thermal_trip_open_fs(struct inode *inode, struct file *file);
-static int acpi_thermal_cooling_open_fs(struct inode *inode, struct file *file);
-static ssize_t acpi_thermal_write_cooling_mode(struct file *,
-					       const char __user *, size_t,
-					       loff_t *);
-static int acpi_thermal_polling_open_fs(struct inode *inode, struct file *file);
-static ssize_t acpi_thermal_write_polling(struct file *, const char __user *,
-					  size_t, loff_t *);
-
-static const struct file_operations acpi_thermal_state_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_thermal_state_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static const struct file_operations acpi_thermal_temp_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_thermal_temp_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static const struct file_operations acpi_thermal_trip_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_thermal_trip_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static const struct file_operations acpi_thermal_cooling_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_thermal_cooling_open_fs,
-	.read = seq_read,
-	.write = acpi_thermal_write_cooling_mode,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static const struct file_operations acpi_thermal_polling_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_thermal_polling_open_fs,
-	.read = seq_read,
-	.write = acpi_thermal_write_polling,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#endif /* CONFIG_ACPI_PROCFS*/
-
 /* --------------------------------------------------------------------------
                              Thermal Zone Management
    -------------------------------------------------------------------------- */
@@ -958,358 +897,6 @@ static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 
 
 /* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-#ifdef CONFIG_ACPI_PROCFS
-static struct proc_dir_entry *acpi_thermal_dir;
-
-static int acpi_thermal_state_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_thermal *tz = seq->private;
-
-
-	if (!tz)
-		goto end;
-
-	seq_puts(seq, "state:                   ");
-
-	if (!tz->state.critical && !tz->state.hot && !tz->state.passive
-	    && !tz->state.active)
-		seq_puts(seq, "ok\n");
-	else {
-		if (tz->state.critical)
-			seq_puts(seq, "critical ");
-		if (tz->state.hot)
-			seq_puts(seq, "hot ");
-		if (tz->state.passive)
-			seq_puts(seq, "passive ");
-		if (tz->state.active)
-			seq_printf(seq, "active[%d]", tz->state.active_index);
-		seq_puts(seq, "\n");
-	}
-
-      end:
-	return 0;
-}
-
-static int acpi_thermal_state_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_thermal_state_seq_show, PDE(inode)->data);
-}
-
-static int acpi_thermal_temp_seq_show(struct seq_file *seq, void *offset)
-{
-	int result = 0;
-	struct acpi_thermal *tz = seq->private;
-
-
-	if (!tz)
-		goto end;
-
-	result = acpi_thermal_get_temperature(tz);
-	if (result)
-		goto end;
-
-	seq_printf(seq, "temperature:             %ld C\n",
-		   KELVIN_TO_CELSIUS(tz->temperature));
-
-      end:
-	return 0;
-}
-
-static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_thermal_temp_seq_show, PDE(inode)->data);
-}
-
-static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_thermal *tz = seq->private;
-	struct acpi_device *device;
-	acpi_status status;
-
-	int i = 0;
-	int j = 0;
-
-
-	if (!tz)
-		goto end;
-
-	if (tz->trips.critical.flags.valid)
-		seq_printf(seq, "critical (S5):           %ld C%s",
-			   KELVIN_TO_CELSIUS(tz->trips.critical.temperature),
-			   nocrt ? " <disabled>\n" : "\n");
-
-	if (tz->trips.hot.flags.valid)
-		seq_printf(seq, "hot (S4):                %ld C%s",
-			   KELVIN_TO_CELSIUS(tz->trips.hot.temperature),
-			   nocrt ? " <disabled>\n" : "\n");
-
-	if (tz->trips.passive.flags.valid) {
-		seq_printf(seq,
-			   "passive:                 %ld C: tc1=%lu tc2=%lu tsp=%lu devices=",
-			   KELVIN_TO_CELSIUS(tz->trips.passive.temperature),
-			   tz->trips.passive.tc1, tz->trips.passive.tc2,
-			   tz->trips.passive.tsp);
-		for (j = 0; j < tz->trips.passive.devices.count; j++) {
-			status = acpi_bus_get_device(tz->trips.passive.devices.
-						     handles[j], &device);
-			seq_printf(seq, "%4.4s ", status ? "" :
-				   acpi_device_bid(device));
-		}
-		seq_puts(seq, "\n");
-	} else {
-		seq_printf(seq, "passive (forced):");
-		if (tz->thermal_zone->forced_passive)
-			seq_printf(seq, "        %i C\n",
-				   tz->thermal_zone->forced_passive / 1000);
-		else
-			seq_printf(seq, "<not set>\n");
-	}
-
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!(tz->trips.active[i].flags.valid))
-			break;
-		seq_printf(seq, "active[%d]:               %ld C: devices=",
-			   i,
-			   KELVIN_TO_CELSIUS(tz->trips.active[i].temperature));
-		for (j = 0; j < tz->trips.active[i].devices.count; j++){
-			status = acpi_bus_get_device(tz->trips.active[i].
-						     devices.handles[j],
-						     &device);
-			seq_printf(seq, "%4.4s ", status ? "" :
-				   acpi_device_bid(device));
-		}
-		seq_puts(seq, "\n");
-	}
-
-      end:
-	return 0;
-}
-
-static int acpi_thermal_trip_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_thermal_trip_seq_show, PDE(inode)->data);
-}
-
-static int acpi_thermal_cooling_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_thermal *tz = seq->private;
-
-
-	if (!tz)
-		goto end;
-
-	if (!tz->flags.cooling_mode)
-		seq_puts(seq, "<setting not supported>\n");
-	else
-		seq_puts(seq, "0 - Active; 1 - Passive\n");
-
-      end:
-	return 0;
-}
-
-static int acpi_thermal_cooling_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_thermal_cooling_seq_show,
-			   PDE(inode)->data);
-}
-
-static ssize_t
-acpi_thermal_write_cooling_mode(struct file *file,
-				const char __user * buffer,
-				size_t count, loff_t * ppos)
-{
-	struct seq_file *m = file->private_data;
-	struct acpi_thermal *tz = m->private;
-	int result = 0;
-	char mode_string[12] = { '\0' };
-
-
-	if (!tz || (count > sizeof(mode_string) - 1))
-		return -EINVAL;
-
-	if (!tz->flags.cooling_mode)
-		return -ENODEV;
-
-	if (copy_from_user(mode_string, buffer, count))
-		return -EFAULT;
-
-	mode_string[count] = '\0';
-
-	result = acpi_thermal_set_cooling_mode(tz,
-					       simple_strtoul(mode_string, NULL,
-							      0));
-	if (result)
-		return result;
-
-	acpi_thermal_check(tz);
-
-	return count;
-}
-
-static int acpi_thermal_polling_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_thermal *tz = seq->private;
-
-
-	if (!tz)
-		goto end;
-
-	if (!tz->thermal_zone->polling_delay) {
-		seq_puts(seq, "<polling disabled>\n");
-		goto end;
-	}
-
-	seq_printf(seq, "polling frequency:       %d seconds\n",
-		   (tz->thermal_zone->polling_delay / 1000));
-
-      end:
-	return 0;
-}
-
-static int acpi_thermal_polling_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_thermal_polling_seq_show,
-			   PDE(inode)->data);
-}
-
-static int acpi_thermal_set_polling(struct acpi_thermal *tz, int seconds)
-{
-	if (!tz)
-		return -EINVAL;
-
-	/* Convert value to deci-seconds */
-	tz->polling_frequency = seconds * 10;
-
-	tz->thermal_zone->polling_delay = seconds * 1000;
-
-	if (tz->tz_enabled)
-		thermal_zone_device_update(tz->thermal_zone);
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Polling frequency set to %lu seconds\n",
-			  tz->polling_frequency/10));
-
-	return 0;
-}
-
-static ssize_t
-acpi_thermal_write_polling(struct file *file,
-			   const char __user * buffer,
-			   size_t count, loff_t * ppos)
-{
-	struct seq_file *m = file->private_data;
-	struct acpi_thermal *tz = m->private;
-	int result = 0;
-	char polling_string[12] = { '\0' };
-	int seconds = 0;
-
-
-	if (!tz || (count > sizeof(polling_string) - 1))
-		return -EINVAL;
-
-	if (copy_from_user(polling_string, buffer, count))
-		return -EFAULT;
-
-	polling_string[count] = '\0';
-
-	seconds = simple_strtoul(polling_string, NULL, 0);
-
-	result = acpi_thermal_set_polling(tz, seconds);
-	if (result)
-		return result;
-
-	acpi_thermal_check(tz);
-
-	return count;
-}
-
-static int acpi_thermal_add_fs(struct acpi_device *device)
-{
-	struct proc_dir_entry *entry = NULL;
-
-
-	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
-						     acpi_thermal_dir);
-		if (!acpi_device_dir(device))
-			return -ENODEV;
-	}
-
-	/* 'state' [R] */
-	entry = proc_create_data(ACPI_THERMAL_FILE_STATE,
-				 S_IRUGO, acpi_device_dir(device),
-				 &acpi_thermal_state_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		return -ENODEV;
-
-	/* 'temperature' [R] */
-	entry = proc_create_data(ACPI_THERMAL_FILE_TEMPERATURE,
-				 S_IRUGO, acpi_device_dir(device),
-				 &acpi_thermal_temp_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		return -ENODEV;
-
-	/* 'trip_points' [R] */
-	entry = proc_create_data(ACPI_THERMAL_FILE_TRIP_POINTS,
-				 S_IRUGO,
-				 acpi_device_dir(device),
-				 &acpi_thermal_trip_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		return -ENODEV;
-
-	/* 'cooling_mode' [R/W] */
-	entry = proc_create_data(ACPI_THERMAL_FILE_COOLING_MODE,
-				 S_IFREG | S_IRUGO | S_IWUSR,
-				 acpi_device_dir(device),
-				 &acpi_thermal_cooling_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		return -ENODEV;
-
-	/* 'polling_frequency' [R/W] */
-	entry = proc_create_data(ACPI_THERMAL_FILE_POLLING_FREQ,
-				 S_IFREG | S_IRUGO | S_IWUSR,
-				 acpi_device_dir(device),
-				 &acpi_thermal_polling_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		return -ENODEV;
-	return 0;
-}
-
-static int acpi_thermal_remove_fs(struct acpi_device *device)
-{
-
-	if (acpi_device_dir(device)) {
-		remove_proc_entry(ACPI_THERMAL_FILE_POLLING_FREQ,
-				  acpi_device_dir(device));
-		remove_proc_entry(ACPI_THERMAL_FILE_COOLING_MODE,
-				  acpi_device_dir(device));
-		remove_proc_entry(ACPI_THERMAL_FILE_TRIP_POINTS,
-				  acpi_device_dir(device));
-		remove_proc_entry(ACPI_THERMAL_FILE_TEMPERATURE,
-				  acpi_device_dir(device));
-		remove_proc_entry(ACPI_THERMAL_FILE_STATE,
-				  acpi_device_dir(device));
-		remove_proc_entry(acpi_device_bid(device), acpi_thermal_dir);
-		acpi_device_dir(device) = NULL;
-	}
-
-	return 0;
-}
-#else
-static inline int acpi_thermal_add_fs(struct acpi_device *device) { return 0; }
-static inline int acpi_thermal_remove_fs(struct acpi_device *device)
-{
-	return 0;
-}
-#endif /* CONFIG_ACPI_PROCFS */
-/* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
@@ -1428,17 +1015,11 @@ static int acpi_thermal_add(struct acpi_device *device)
 	if (result)
 		goto free_memory;
 
-	result = acpi_thermal_add_fs(device);
-	if (result)
-		goto unregister_thermal_zone;
-
 	printk(KERN_INFO PREFIX "%s [%s] (%ld C)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
 	       KELVIN_TO_CELSIUS(tz->temperature));
 	goto end;
 
-unregister_thermal_zone:
-	thermal_zone_device_unregister(tz->thermal_zone);
 free_memory:
 	kfree(tz);
 end:
@@ -1454,7 +1035,6 @@ static int acpi_thermal_remove(struct acpi_device *device, int type)
 
 	tz = acpi_driver_data(device);
 
-	acpi_thermal_remove_fs(device);
 	acpi_thermal_unregister_thermal_zone(tz);
 	mutex_destroy(&tz->lock);
 	kfree(tz);
@@ -1580,19 +1160,9 @@ static int __init acpi_thermal_init(void)
 		return -ENODEV;
 	}
 
-#ifdef CONFIG_ACPI_PROCFS
-	acpi_thermal_dir = proc_mkdir(ACPI_THERMAL_CLASS, acpi_root_dir);
-	if (!acpi_thermal_dir)
-		return -ENODEV;
-#endif
-
 	result = acpi_bus_register_driver(&acpi_thermal_driver);
-	if (result < 0) {
-#ifdef CONFIG_ACPI_PROCFS
-		remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
-#endif
+	if (result < 0)
 		return -ENODEV;
-	}
 
 	return 0;
 }
@@ -1602,10 +1172,6 @@ static void __exit acpi_thermal_exit(void)
 
 	acpi_bus_unregister_driver(&acpi_thermal_driver);
 
-#ifdef CONFIG_ACPI_PROCFS
-	remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
-#endif
-
 	return;
 }
 
-- 
1.7.3.2.90.gd4c43

