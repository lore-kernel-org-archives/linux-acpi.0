From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/60] ACPI processor: make /proc/acpi/processor/*/throttle
 depends on CONFIG_ACPI_PROCFS
Date: Mon, 25 Oct 2010 02:20:35 -0400
Message-ID: <d5c6887c7fbaf7a149c3bf441338fa833c529fb4.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab0JYHLR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:17 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:11 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

As a feature that would only be used when system is overheating,
the processor t-state control should not be exported to user space.
Make /proc/acpi/processor/*/throttle depends on CONFIG_ACPI_PROCFS,
which is cleared by default.
And we will remove this I/F in 2.6.38.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_driver.c     |   20 +++++++++++++++++++-
 drivers/acpi/processor_throttling.c |    4 ++++
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 347eb21..356c320 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
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
@@ -244,6 +246,7 @@ static int acpi_processor_errata(struct acpi_processor *pr)
 	return result;
 }
 
+#ifdef CONFIG_ACPI_PROCFS
 static struct proc_dir_entry *acpi_processor_dir = NULL;
 
 static int __cpuinit acpi_processor_add_fs(struct acpi_device *device)
@@ -280,7 +283,16 @@ static int acpi_processor_remove_fs(struct acpi_device *device)
 
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
@@ -842,9 +854,11 @@ static int __init acpi_processor_init(void)
 
 	memset(&errata, 0, sizeof(errata));
 
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
 		return -ENOMEM;
+#endif
 
 	if (!cpuidle_register_driver(&acpi_idle_driver)) {
 		printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
@@ -871,7 +885,9 @@ static int __init acpi_processor_init(void)
 out_cpuidle:
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
+#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+#endif
 
 	return result;
 }
@@ -891,7 +907,9 @@ static void __exit acpi_processor_exit(void)
 
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
+#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+#endif
 
 	return;
 }
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 7308638..ff36327 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
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
@@ -1214,6 +1216,7 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 	return result;
 }
 
+#ifdef CONFIG_ACPI_PROCFS
 /* proc interface */
 static int acpi_processor_throttling_seq_show(struct seq_file *seq,
 					      void *offset)
@@ -1322,3 +1325,4 @@ const struct file_operations acpi_processor_throttling_fops = {
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif
-- 
1.7.3.2.90.gd4c43

