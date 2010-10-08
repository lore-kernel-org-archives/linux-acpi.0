From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND 5/6] ACPI processor: make
 /proc/acpi/processor/*/throttle depends on CONFIG_ACPI_PROCFS
Date: Fri, 08 Oct 2010 13:55:15 +0800
Message-ID: <1286517315.2111.3800.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46454 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab0JHF51 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Oct 2010 01:57:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


As a feature that would only be used when system is overheating,
the processor t-state control should not be exported to user space.
Make /proc/acpi/processor/*/throttle depends on CONFIG_ACPI_PROCFS,
which is cleared by default.
And we will remove this I/F in 2.6.38.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/processor_driver.c     |   20 +++++++++++++++++++-
 drivers/acpi/processor_throttling.c |    4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/processor_driver.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_driver.c
+++ linux-2.6/drivers/acpi/processor_driver.c
@@ -40,8 +40,10 @@
 #include <linux/pm.h>
 #include <linux/cpufreq.h>
 #include <linux/cpu.h>
+#ifdef CONFIG_ACPI_PROCFS
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#endif
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/cpuidle.h>
@@ -244,6 +246,7 @@ static int acpi_processor_errata(struct 
 	return result;
 }
 
+#ifdef CONFIG_ACPI_PROCFS
 static struct proc_dir_entry *acpi_processor_dir = NULL;
 
 static int __cpuinit acpi_processor_add_fs(struct acpi_device *device)
@@ -280,7 +283,16 @@ static int acpi_processor_remove_fs(stru
 
 	return 0;
 }
-
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
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -842,9 +854,11 @@ static int __init acpi_processor_init(vo
 
 	memset(&errata, 0, sizeof(errata));
 
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
 		return -ENOMEM;
+#endif
 
 	if (!cpuidle_register_driver(&acpi_idle_driver)) {
 		printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
@@ -871,7 +885,9 @@ static int __init acpi_processor_init(vo
 out_cpuidle:
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
+#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+#endif
 
 	return result;
 }
@@ -891,7 +907,9 @@ static void __exit acpi_processor_exit(v
 
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
+#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+#endif
 
 	return;
 }
Index: linux-2.6/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6/drivers/acpi/processor_throttling.c
@@ -32,8 +32,10 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/cpufreq.h>
+#ifdef CONFIG_ACPI_PROCFS
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#endif
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -1214,6 +1216,7 @@ int acpi_processor_get_throttling_info(s
 	return result;
 }
 
+#ifdef CONFIG_ACPI_PROCFS
 /* proc interface */
 static int acpi_processor_throttling_seq_show(struct seq_file *seq,
 					      void *offset)
@@ -1322,3 +1325,4 @@ const struct file_operations acpi_proces
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif


