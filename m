From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 7/9] ACPI processor: remove deprecated ACPI procfs I/F
Date: Thu, 15 Jul 2010 10:46:41 +0800
Message-ID: <1279162001.4537.8520.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32223 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128Ab0GOCof (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jul 2010 22:44:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venki@google.com>, "Zhang, Rui" <rui.zhang@intel.com>


Remove deprecated ACPI processor procfs I/F, including:
/proc/acpi/processor/CPUX/power
/proc/acpi/processor/CPUX/limit
/proc/acpi/processor/CPUX/info

/proc/acpi/processor/CPUX/throttling still exists,
as we don't have sysfs I/F available for now.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig                |    3 -
 drivers/acpi/processor_driver.c     |   85 -------------------------------
 drivers/acpi/processor_idle.c       |   96 ------------------------------------
 drivers/acpi/processor_thermal.c    |   83 -------------------------------
 drivers/acpi/processor_throttling.c |    2 
 include/acpi/processor.h            |    1 
 6 files changed, 270 deletions(-)

Index: linux-2.6/drivers/acpi/processor_driver.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_driver.c
+++ linux-2.6/drivers/acpi/processor_driver.c
@@ -83,9 +83,6 @@ MODULE_LICENSE("GPL");
 
 static int acpi_processor_add(struct acpi_device *device);
 static int acpi_processor_remove(struct acpi_device *device, int type);
-#ifdef CONFIG_ACPI_PROCFS
-static int acpi_processor_info_open_fs(struct inode *inode, struct file *file);
-#endif
 static void acpi_processor_notify(struct acpi_device *device, u32 event);
 static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
 static int acpi_processor_handle_eject(struct acpi_processor *pr);
@@ -113,15 +110,6 @@ static struct acpi_driver acpi_processor
 
 #define INSTALL_NOTIFY_HANDLER		1
 #define UNINSTALL_NOTIFY_HANDLER	2
-#ifdef CONFIG_ACPI_PROCFS
-static const struct file_operations acpi_processor_info_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_processor_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#endif
 
 DEFINE_PER_CPU(struct acpi_processor *, processors);
 EXPORT_PER_CPU_SYMBOL(processors);
@@ -256,44 +244,8 @@ static int acpi_processor_errata(struct 
 	return result;
 }
 
-/* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-
-#ifdef CONFIG_ACPI_PROCFS
 static struct proc_dir_entry *acpi_processor_dir = NULL;
 
-static int acpi_processor_info_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_processor *pr = seq->private;
-
-
-	if (!pr)
-		goto end;
-
-	seq_printf(seq, "processor id:            %d\n"
-		   "acpi id:                 %d\n"
-		   "bus mastering control:   %s\n"
-		   "power management:        %s\n"
-		   "throttling control:      %s\n"
-		   "limit interface:         %s\n",
-		   pr->id,
-		   pr->acpi_id,
-		   pr->flags.bm_control ? "yes" : "no",
-		   pr->flags.power ? "yes" : "no",
-		   pr->flags.throttling ? "yes" : "no",
-		   pr->flags.limit ? "yes" : "no");
-
-      end:
-	return 0;
-}
-
-static int acpi_processor_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_processor_info_seq_show,
-			   PDE(inode)->data);
-}
-
 static int __cpuinit acpi_processor_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *entry = NULL;
@@ -306,14 +258,6 @@ static int __cpuinit acpi_processor_add_
 			return -ENODEV;
 	}
 
-	/* 'info' [R] */
-	entry = proc_create_data(ACPI_PROCESSOR_FILE_INFO,
-				 S_IRUGO, acpi_device_dir(device),
-				 &acpi_processor_info_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		return -EIO;
-
 	/* 'throttling' [R/W] */
 	entry = proc_create_data(ACPI_PROCESSOR_FILE_THROTTLING,
 				 S_IFREG | S_IRUGO | S_IWUSR,
@@ -322,43 +266,20 @@ static int __cpuinit acpi_processor_add_
 				 acpi_driver_data(device));
 	if (!entry)
 		return -EIO;
-
-	/* 'limit' [R/W] */
-	entry = proc_create_data(ACPI_PROCESSOR_FILE_LIMIT,
-				 S_IFREG | S_IRUGO | S_IWUSR,
-				 acpi_device_dir(device),
-				 &acpi_processor_limit_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		return -EIO;
 	return 0;
 }
 static int acpi_processor_remove_fs(struct acpi_device *device)
 {
 
 	if (acpi_device_dir(device)) {
-		remove_proc_entry(ACPI_PROCESSOR_FILE_INFO,
-				  acpi_device_dir(device));
 		remove_proc_entry(ACPI_PROCESSOR_FILE_THROTTLING,
 				  acpi_device_dir(device));
-		remove_proc_entry(ACPI_PROCESSOR_FILE_LIMIT,
-				  acpi_device_dir(device));
 		remove_proc_entry(acpi_device_bid(device), acpi_processor_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
 	return 0;
 }
-#else
-static inline int acpi_processor_add_fs(struct acpi_device *device)
-{
-	return 0;
-}
-static inline int acpi_processor_remove_fs(struct acpi_device *device)
-{
-	return 0;
-}
-#endif
 
 /* --------------------------------------------------------------------------
                                  Driver Interface
@@ -921,11 +842,9 @@ static int __init acpi_processor_init(vo
 
 	memset(&errata, 0, sizeof(errata));
 
-#ifdef CONFIG_ACPI_PROCFS
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
 		return -ENOMEM;
-#endif
 
 	if (!cpuidle_register_driver(&acpi_idle_driver)) {
 		printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
@@ -952,9 +871,7 @@ static int __init acpi_processor_init(vo
 out_cpuidle:
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
-#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-#endif
 
 	return result;
 }
@@ -974,9 +891,7 @@ static void __exit acpi_processor_exit(v
 
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
-#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-#endif
 
 	return;
 }
Index: linux-2.6/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_idle.c
+++ linux-2.6/drivers/acpi/processor_idle.c
@@ -33,8 +33,6 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
@@ -80,10 +78,6 @@ module_param(nocst, uint, 0000);
 static unsigned int latency_factor __read_mostly = 2;
 module_param(latency_factor, uint, 0644);
 
-static u64 us_to_pm_timer_ticks(s64 t)
-{
-	return div64_u64(t * PM_TIMER_FREQUENCY, 1000000);
-}
 /*
  * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
  * For now disable this. Probably a bug somewhere else.
@@ -684,78 +678,6 @@ static int acpi_processor_get_power_info
 	return 0;
 }
 
-#ifdef CONFIG_ACPI_PROCFS
-static int acpi_processor_power_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_processor *pr = seq->private;
-	unsigned int i;
-
-
-	if (!pr)
-		goto end;
-
-	seq_printf(seq, "active state:            C%zd\n"
-		   "max_cstate:              C%d\n"
-		   "maximum allowed latency: %d usec\n",
-		   pr->power.state ? pr->power.state - pr->power.states : 0,
-		   max_cstate, pm_qos_request(PM_QOS_CPU_DMA_LATENCY));
-
-	seq_puts(seq, "states:\n");
-
-	for (i = 1; i <= pr->power.count; i++) {
-		seq_printf(seq, "   %cC%d:                  ",
-			   (&pr->power.states[i] ==
-			    pr->power.state ? '*' : ' '), i);
-
-		if (!pr->power.states[i].valid) {
-			seq_puts(seq, "<not supported>\n");
-			continue;
-		}
-
-		switch (pr->power.states[i].type) {
-		case ACPI_STATE_C1:
-			seq_printf(seq, "type[C1] ");
-			break;
-		case ACPI_STATE_C2:
-			seq_printf(seq, "type[C2] ");
-			break;
-		case ACPI_STATE_C3:
-			seq_printf(seq, "type[C3] ");
-			break;
-		default:
-			seq_printf(seq, "type[--] ");
-			break;
-		}
-
-		seq_puts(seq, "promotion[--] ");
-
-		seq_puts(seq, "demotion[--] ");
-
-		seq_printf(seq, "latency[%03d] usage[%08d] duration[%020Lu]\n",
-			   pr->power.states[i].latency,
-			   pr->power.states[i].usage,
-			   us_to_pm_timer_ticks(pr->power.states[i].time));
-	}
-
-      end:
-	return 0;
-}
-
-static int acpi_processor_power_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_processor_power_seq_show,
-			   PDE(inode)->data);
-}
-
-static const struct file_operations acpi_processor_power_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_processor_power_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#endif
-
 /**
  * acpi_idle_bm_check - checks if bus master activity was detected
  */
@@ -1164,9 +1086,6 @@ int __cpuinit acpi_processor_power_init(
 {
 	acpi_status status = 0;
 	static int first_run;
-#ifdef CONFIG_ACPI_PROCFS
-	struct proc_dir_entry *entry = NULL;
-#endif
 
 	if (boot_option_idle_override)
 		return 0;
@@ -1215,15 +1134,6 @@ int __cpuinit acpi_processor_power_init(
 		if (cpuidle_register_device(&pr->power.dev))
 			return -EIO;
 	}
-#ifdef CONFIG_ACPI_PROCFS
-	/* 'power' [R] */
-	entry = proc_create_data(ACPI_PROCESSOR_FILE_POWER,
-				 S_IRUGO, acpi_device_dir(device),
-				 &acpi_processor_power_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		return -EIO;
-#endif
 	return 0;
 }
 
@@ -1236,11 +1146,5 @@ int acpi_processor_power_exit(struct acp
 	cpuidle_unregister_device(&pr->power.dev);
 	pr->flags.power_setup_done = 0;
 
-#ifdef CONFIG_ACPI_PROCFS
-	if (acpi_device_dir(device))
-		remove_proc_entry(ACPI_PROCESSOR_FILE_POWER,
-				  acpi_device_dir(device));
-#endif
-
 	return 0;
 }
Index: linux-2.6/drivers/acpi/processor_thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_thermal.c
+++ linux-2.6/drivers/acpi/processor_thermal.c
@@ -30,8 +30,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/cpufreq.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
 #include <linux/sysdev.h>
 
 #include <asm/uaccess.h>
@@ -438,84 +436,3 @@ struct thermal_cooling_device_ops proces
 	.get_cur_state = processor_get_cur_state,
 	.set_cur_state = processor_set_cur_state,
 };
-
-/* /proc interface */
-#ifdef CONFIG_ACPI_PROCFS
-static int acpi_processor_limit_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_processor *pr = seq->private;
-
-	if (!pr)
-		goto end;
-
-	if (!pr->flags.limit) {
-		seq_puts(seq, "<not supported>\n");
-		goto end;
-	}
-
-	seq_printf(seq, "active limit:            P%d:T%d\n"
-		   "user limit:              P%d:T%d\n"
-		   "thermal limit:           P%d:T%d\n",
-		   pr->limit.state.px, pr->limit.state.tx,
-		   pr->limit.user.px, pr->limit.user.tx,
-		   pr->limit.thermal.px, pr->limit.thermal.tx);
-
-      end:
-	return 0;
-}
-
-static int acpi_processor_limit_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_processor_limit_seq_show,
-			   PDE(inode)->data);
-}
-
-static ssize_t acpi_processor_write_limit(struct file * file,
-					  const char __user * buffer,
-					  size_t count, loff_t * data)
-{
-	int result = 0;
-	struct seq_file *m = file->private_data;
-	struct acpi_processor *pr = m->private;
-	char limit_string[25] = { '\0' };
-	int px = 0;
-	int tx = 0;
-
-
-	if (!pr || (count > sizeof(limit_string) - 1)) {
-		return -EINVAL;
-	}
-
-	if (copy_from_user(limit_string, buffer, count)) {
-		return -EFAULT;
-	}
-
-	limit_string[count] = '\0';
-
-	if (sscanf(limit_string, "%d:%d", &px, &tx) != 2) {
-		printk(KERN_ERR PREFIX "Invalid data format\n");
-		return -EINVAL;
-	}
-
-	if (pr->flags.throttling) {
-		if ((tx < 0) || (tx > (pr->throttling.state_count - 1))) {
-			printk(KERN_ERR PREFIX "Invalid tx\n");
-			return -EINVAL;
-		}
-		pr->limit.user.tx = tx;
-	}
-
-	result = acpi_processor_apply_limit(pr);
-
-	return count;
-}
-
-const struct file_operations acpi_processor_limit_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_processor_limit_open_fs,
-	.read = seq_read,
-	.write = acpi_processor_write_limit,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#endif
Index: linux-2.6/include/acpi/processor.h
===================================================================
--- linux-2.6.orig/include/acpi/processor.h
+++ linux-2.6/include/acpi/processor.h
@@ -337,7 +337,6 @@ extern struct cpuidle_driver acpi_idle_d
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
-extern const struct file_operations acpi_processor_limit_fops;
 extern struct thermal_cooling_device_ops processor_cooling_ops;
 #ifdef CONFIG_CPU_FREQ
 void acpi_thermal_cpufreq_init(void);
Index: linux-2.6/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6/drivers/acpi/processor_throttling.c
@@ -1215,7 +1215,6 @@ int acpi_processor_get_throttling_info(s
 }
 
 /* proc interface */
-#ifdef CONFIG_ACPI_PROCFS
 static int acpi_processor_throttling_seq_show(struct seq_file *seq,
 					      void *offset)
 {
@@ -1323,4 +1322,3 @@ const struct file_operations acpi_proces
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-#endif
Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -54,9 +54,6 @@ config ACPI_PROCFS
 	  they have been replaced by functions in /sys.
 	  The deprecated files (and their replacements) include:
 
-	  /proc/acpi/processor/*/power (/sys/devices/system/cpu/*/cpuidle/*)
-	  /proc/acpi/processor/*/performance (/sys/devices/system/cpu/*/
-		cpufreq/*)
 	  /proc/acpi/processor/*/throttling (/sys/class/thermal/
 		cooling_device*/*)
 	  This option has no effect on /proc/acpi/ files


