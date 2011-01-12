From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/48] ACPI processor: remove processor throttling control
 procfs I/F
Date: Wed, 12 Jan 2011 05:19:01 -0500
Message-ID: <cef6e8a3790d6bdc305496629c357a56001d59a6.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:34601 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab1ALKUE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 05:20:04 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEW000QFNDEYMT4@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 04:20:04 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Remove deprecated ACPI process procfs I/F for throttling control.

This is because the t-state control should only be done in kernel,
when system is in a overheating state.

Now users can only change the processor t-state indirectly,
by poking the cooling device sysfs I/F of the processor.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig                |    4 -
 drivers/acpi/processor_driver.c     |   75 +----------------------
 drivers/acpi/processor_throttling.c |  114 -----------------------------------
 3 files changed, 1 insertions(+), 192 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 3f3489c..5959077 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -53,10 +53,6 @@ config ACPI_PROCFS
 	  they have been replaced by functions in /sys.
 	  The deprecated files (and their replacements) include:
 
-	  /proc/acpi/processor/*/throttling (/sys/class/thermal/
-		cooling_device*/*)
-	  /proc/acpi/video/*/brightness (/sys/class/backlight/)
-	  /proc/acpi/thermal_zone/*/* (/sys/class/thermal/)
 	  This option has no effect on /proc/acpi/ files
 	  and functions which do not yet exist in /sys.
 
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 85e4804..29572de 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -40,10 +40,6 @@
 #include <linux/pm.h>
 #include <linux/cpufreq.h>
 #include <linux/cpu.h>
-#ifdef CONFIG_ACPI_PROCFS
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#endif
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/cpuidle.h>
@@ -246,53 +242,6 @@ static int acpi_processor_errata(struct acpi_processor *pr)
 	return result;
 }
 
-#ifdef CONFIG_ACPI_PROCFS
-static struct proc_dir_entry *acpi_processor_dir = NULL;
-
-static int __cpuinit acpi_processor_add_fs(struct acpi_device *device)
-{
-	struct proc_dir_entry *entry = NULL;
-
-
-	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
-						     acpi_processor_dir);
-		if (!acpi_device_dir(device))
-			return -ENODEV;
-	}
-
-	/* 'throttling' [R/W] */
-	entry = proc_create_data(ACPI_PROCESSOR_FILE_THROTTLING,
-				 S_IFREG | S_IRUGO | S_IWUSR,
-				 acpi_device_dir(device),
-				 &acpi_processor_throttling_fops,
-				 acpi_driver_data(device));
-	if (!entry)
-		return -EIO;
-	return 0;
-}
-static int acpi_processor_remove_fs(struct acpi_device *device)
-{
-
-	if (acpi_device_dir(device)) {
-		remove_proc_entry(ACPI_PROCESSOR_FILE_THROTTLING,
-				  acpi_device_dir(device));
-		remove_proc_entry(acpi_device_bid(device), acpi_processor_dir);
-		acpi_device_dir(device) = NULL;
-	}
-
-	return 0;
-}
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
    -------------------------------------------------------------------------- */
@@ -537,14 +486,10 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 
 	per_cpu(processors, pr->id) = pr;
 
-	result = acpi_processor_add_fs(device);
-	if (result)
-		goto err_free_cpumask;
-
 	sysdev = get_cpu_sysdev(pr->id);
 	if (sysfs_create_link(&device->dev.kobj, &sysdev->kobj, "sysdev")) {
 		result = -EFAULT;
-		goto err_remove_fs;
+		goto err_free_cpumask;
 	}
 
 #ifdef CONFIG_CPU_FREQ
@@ -590,8 +535,6 @@ err_thermal_unregister:
 	thermal_cooling_device_unregister(pr->cdev);
 err_power_exit:
 	acpi_processor_power_exit(pr, device);
-err_remove_fs:
-	acpi_processor_remove_fs(device);
 err_free_cpumask:
 	free_cpumask_var(pr->throttling.shared_cpu_map);
 
@@ -620,8 +563,6 @@ static int acpi_processor_remove(struct acpi_device *device, int type)
 
 	sysfs_remove_link(&device->dev.kobj, "sysdev");
 
-	acpi_processor_remove_fs(device);
-
 	if (pr->cdev) {
 		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
 		sysfs_remove_link(&pr->cdev->device.kobj, "device");
@@ -854,12 +795,6 @@ static int __init acpi_processor_init(void)
 
 	memset(&errata, 0, sizeof(errata));
 
-#ifdef CONFIG_ACPI_PROCFS
-	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-	if (!acpi_processor_dir)
-		return -ENOMEM;
-#endif
-
 	if (!cpuidle_register_driver(&acpi_idle_driver)) {
 		printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
 			acpi_idle_driver.name);
@@ -885,10 +820,6 @@ static int __init acpi_processor_init(void)
 out_cpuidle:
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
-#ifdef CONFIG_ACPI_PROCFS
-	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-#endif
-
 	return result;
 }
 
@@ -907,10 +838,6 @@ static void __exit acpi_processor_exit(void)
 
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
-#ifdef CONFIG_ACPI_PROCFS
-	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-#endif
-
 	return;
 }
 
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index ff36327..4a0eec5 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -32,10 +32,6 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/cpufreq.h>
-#ifdef CONFIG_ACPI_PROCFS
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#endif
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -1216,113 +1212,3 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 	return result;
 }
 
-#ifdef CONFIG_ACPI_PROCFS
-/* proc interface */
-static int acpi_processor_throttling_seq_show(struct seq_file *seq,
-					      void *offset)
-{
-	struct acpi_processor *pr = seq->private;
-	int i = 0;
-	int result = 0;
-
-	if (!pr)
-		goto end;
-
-	if (!(pr->throttling.state_count > 0)) {
-		seq_puts(seq, "<not supported>\n");
-		goto end;
-	}
-
-	result = acpi_processor_get_throttling(pr);
-
-	if (result) {
-		seq_puts(seq,
-			 "Could not determine current throttling state.\n");
-		goto end;
-	}
-
-	seq_printf(seq, "state count:             %d\n"
-		   "active state:            T%d\n"
-		   "state available: T%d to T%d\n",
-		   pr->throttling.state_count, pr->throttling.state,
-		   pr->throttling_platform_limit,
-		   pr->throttling.state_count - 1);
-
-	seq_puts(seq, "states:\n");
-	if (pr->throttling.acpi_processor_get_throttling ==
-			acpi_processor_get_throttling_fadt) {
-		for (i = 0; i < pr->throttling.state_count; i++)
-			seq_printf(seq, "   %cT%d:                  %02d%%\n",
-				   (i == pr->throttling.state ? '*' : ' '), i,
-				   (pr->throttling.states[i].performance ? pr->
-				    throttling.states[i].performance / 10 : 0));
-	} else {
-		for (i = 0; i < pr->throttling.state_count; i++)
-			seq_printf(seq, "   %cT%d:                  %02d%%\n",
-				   (i == pr->throttling.state ? '*' : ' '), i,
-				   (int)pr->throttling.states_tss[i].
-				   freqpercentage);
-	}
-
-      end:
-	return 0;
-}
-
-static int acpi_processor_throttling_open_fs(struct inode *inode,
-					     struct file *file)
-{
-	return single_open(file, acpi_processor_throttling_seq_show,
-			   PDE(inode)->data);
-}
-
-static ssize_t acpi_processor_write_throttling(struct file *file,
-					       const char __user * buffer,
-					       size_t count, loff_t * data)
-{
-	int result = 0;
-	struct seq_file *m = file->private_data;
-	struct acpi_processor *pr = m->private;
-	char state_string[5] = "";
-	char *charp = NULL;
-	size_t state_val = 0;
-	char tmpbuf[5] = "";
-
-	if (!pr || (count > sizeof(state_string) - 1))
-		return -EINVAL;
-
-	if (copy_from_user(state_string, buffer, count))
-		return -EFAULT;
-
-	state_string[count] = '\0';
-	if ((count > 0) && (state_string[count-1] == '\n'))
-		state_string[count-1] = '\0';
-
-	charp = state_string;
-	if ((state_string[0] == 't') || (state_string[0] == 'T'))
-		charp++;
-
-	state_val = simple_strtoul(charp, NULL, 0);
-	if (state_val >= pr->throttling.state_count)
-		return -EINVAL;
-
-	snprintf(tmpbuf, 5, "%zu", state_val);
-
-	if (strcmp(tmpbuf, charp) != 0)
-		return -EINVAL;
-
-	result = acpi_processor_set_throttling(pr, state_val, false);
-	if (result)
-		return result;
-
-	return count;
-}
-
-const struct file_operations acpi_processor_throttling_fops = {
-	.owner = THIS_MODULE,
-	.open = acpi_processor_throttling_open_fs,
-	.read = seq_read,
-	.write = acpi_processor_write_throttling,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#endif
-- 
1.7.4.rc1.7.g2cf08

