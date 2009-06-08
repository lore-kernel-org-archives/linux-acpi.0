From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Depreciate the ACPI processor proc I/F
Date: Mon, 08 Jun 2009 16:20:04 +0800
Message-ID: <1244449204.3636.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51377 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879AbZFHISs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jun 2009 04:18:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Now whether the ACPI processor proc I/F is registered depends on the
CONFIG_PROC instead of CONFIG_ACPI_PROCFS. It had better depend on the
CONFIG_ACPI_PROCFS. 
Depreciate the ACPI processor proc I/F. When the CONFIG_ACPI_PROCFS
is unset in kernel configuration, it won't be registered.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_core.c       |   25 +++++++++++++++++++++----
 drivers/acpi/processor_idle.c       |    8 ++++++--
 drivers/acpi/processor_thermal.c    |    3 ++-
 drivers/acpi/processor_throttling.c |    3 ++-
 4 files changed, 31 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c	2009-06-08 13:21:47.000000000 +0800
+++ linux-2.6/drivers/acpi/processor_core.c	2009-06-08 16:03:46.000000000 +0800
@@ -81,7 +81,9 @@
 static int acpi_processor_add(struct acpi_device *device);
 static int acpi_processor_start(struct acpi_device *device);
 static int acpi_processor_remove(struct acpi_device *device, int type);
+#ifdef CONFIG_ACPI_PROCFS
 static int acpi_processor_info_open_fs(struct inode *inode, struct file *file);
+#endif
 static void acpi_processor_notify(struct acpi_device *device, u32 event);
 static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
 static int acpi_processor_handle_eject(struct acpi_processor *pr);
@@ -110,7 +112,7 @@
 
 #define INSTALL_NOTIFY_HANDLER		1
 #define UNINSTALL_NOTIFY_HANDLER	2
-
+#ifdef CONFIG_ACPI_PROCFS
 static const struct file_operations acpi_processor_info_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_processor_info_open_fs,
@@ -118,6 +120,7 @@
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif
 
 DEFINE_PER_CPU(struct acpi_processor *, processors);
 struct acpi_processor_errata errata __read_mostly;
@@ -316,6 +319,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
+#ifdef CONFIG_ACPI_PROCFS
 static struct proc_dir_entry *acpi_processor_dir = NULL;
 
 static int acpi_processor_info_seq_show(struct seq_file *seq, void *offset)
@@ -388,7 +392,6 @@
 		return -EIO;
 	return 0;
 }
-
 static int acpi_processor_remove_fs(struct acpi_device *device)
 {
 
@@ -405,6 +408,16 @@
 
 	return 0;
 }
+#else
+static inline int acpi_processor_add_fs(struct acpi_device *device)
+{
+	return 0;
+}
+static inline int acpi_processor_remove_fs(struct acpi_device *device)
+{
+	return 0;
+}
+#endif
 
 /* Use the acpiid in MADT to map cpus in case of SMP */
 
@@ -1147,11 +1160,11 @@
 				(struct acpi_table_header **)&madt)))
 		madt = NULL;
 #endif
-
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
 		return -ENOMEM;
-
+#endif
 	/*
 	 * Check whether the system is DMI table. If yes, OSPM
 	 * should not use mwait for CPU-states.
@@ -1179,7 +1192,9 @@
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
 out_proc:
+#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+#endif
 
 	return result;
 }
@@ -1196,7 +1211,9 @@
 
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
+#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+#endif
 
 	return;
 }
Index: linux-2.6/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_idle.c	2009-06-08 13:21:47.000000000 +0800
+++ linux-2.6/drivers/acpi/processor_idle.c	2009-06-08 15:45:04.000000000 +0800
@@ -682,6 +682,7 @@
 	return 0;
 }
 
+#ifdef CONFIG_ACPI_PROCFS
 static int acpi_processor_power_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_processor *pr = seq->private;
@@ -761,7 +762,7 @@
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-
+#endif
 
 /**
  * acpi_idle_bm_check - checks if bus master activity was detected
@@ -1219,7 +1220,7 @@
 				       pr->power.states[i].type);
 		printk(")\n");
 	}
-
+#ifdef CONFIG_ACPI_PROCFS
 	/* 'power' [R] */
 	entry = proc_create_data(ACPI_PROCESSOR_FILE_POWER,
 				 S_IRUGO, acpi_device_dir(device),
@@ -1227,6 +1228,7 @@
 				 acpi_driver_data(device));
 	if (!entry)
 		return -EIO;
+#endif
 	return 0;
 }
 
@@ -1239,9 +1241,11 @@
 	cpuidle_unregister_device(&pr->power.dev);
 	pr->flags.power_setup_done = 0;
 
+#ifdef CONFIG_ACPI_PROCFS
 	if (acpi_device_dir(device))
 		remove_proc_entry(ACPI_PROCESSOR_FILE_POWER,
 				  acpi_device_dir(device));
+#endif
 
 	return 0;
 }
Index: linux-2.6/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_throttling.c	2009-06-08 08:57:35.000000000 +0800
+++ linux-2.6/drivers/acpi/processor_throttling.c	2009-06-08 15:19:24.000000000 +0800
@@ -1214,7 +1214,7 @@
 }
 
 /* proc interface */
-
+#ifdef CONFIG_ACPI_PROCFS
 static int acpi_processor_throttling_seq_show(struct seq_file *seq,
 					      void *offset)
 {
@@ -1322,3 +1322,4 @@
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif
Index: linux-2.6/drivers/acpi/processor_thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_thermal.c	2009-04-16 16:10:24.000000000 +0800
+++ linux-2.6/drivers/acpi/processor_thermal.c	2009-06-08 15:22:32.000000000 +0800
@@ -438,7 +438,7 @@
 };
 
 /* /proc interface */
-
+#ifdef CONFIG_ACPI_PROCFS
 static int acpi_processor_limit_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_processor *pr = (struct acpi_processor *)seq->private;
@@ -517,3 +517,4 @@
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif


