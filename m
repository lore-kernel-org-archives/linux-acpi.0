From: Len Brown <len.brown@intel.com>
Subject: [PATCH 12/16] ACPI: Kconfig: fold /proc/acpi/sleep under CONFIG_ACPI_PROCFS
Date: Wed, 25 Jul 2007 01:51:21 -0400
Message-ID: <11853426981919-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9155 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091AbXGYFvl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:41 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <43532c8a46ae313c2da3baa7598a1de4d403ba83.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

/proc/acpi/sleep has had its own "default n" option,
ACPI_SLEEP_PROC_SLEEP, for many months.
Time to delete ACPI_SLEEP_PROC_SLEEP.

Users that still need /proc/acpi/sleep can still get it
along with the other deprecated /proc/acpi files
by enabling CONFIG_ACPI_PROCFS.

Also delete ACPI_SLEEP_PROC_FS, which was an umbrella
for /proc/acpi/sleep, wakeup, alarm, because it was
effectively just a synonym for ACPI_SLEEP.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig        |   14 +-------------
 drivers/acpi/sleep/Makefile |    2 +-
 drivers/acpi/sleep/proc.c   |   20 ++++++++++++++------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 8e42977..efd47ee 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -62,19 +62,6 @@ config ACPI_SLEEP
 	  This option is not recommended for anyone except those doing driver
 	  power management development.
 
-config ACPI_SLEEP_PROC_FS
-	bool
-	depends on ACPI_SLEEP && PROC_FS
-	default y
-
-config ACPI_SLEEP_PROC_SLEEP
-	bool "/proc/acpi/sleep (deprecated)"
-	depends on ACPI_SLEEP_PROC_FS
-	default n
-	---help---
-	  Create /proc/acpi/sleep
-	  Deprecated by /sys/power/state
-
 config ACPI_PROCFS
 	bool "Deprecated /proc/acpi files"
 	depends on PROC_FS
@@ -84,6 +71,7 @@ config ACPI_PROCFS
 	  they have been replaced by functions in /sys.
 	  The deprecated files (and their replacements) include:
 
+	  /proc/acpi/sleep (/sys/power/state)
 	  /proc/acpi/info (/sys/modules/acpi/parameters/acpica_version)
 	  /proc/acpi/dsdt (/sys/firmware/acpi/tables/DSDT)
 	  /proc/acpi/fadt (/sys/firmware/acpi/tables/FACP)
diff --git a/drivers/acpi/sleep/Makefile b/drivers/acpi/sleep/Makefile
index d6c0177..195a4f6 100644
--- a/drivers/acpi/sleep/Makefile
+++ b/drivers/acpi/sleep/Makefile
@@ -1,5 +1,5 @@
 obj-y					:= poweroff.o wakeup.o
 obj-$(CONFIG_ACPI_SLEEP)		+= main.o
-obj-$(CONFIG_ACPI_SLEEP_PROC_FS)	+= proc.o
+obj-$(CONFIG_ACPI_SLEEP)		+= proc.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 61f1822..ed58e11 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -14,8 +14,16 @@
 #include "sleep.h"
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
+
+/*
+ * this file provides support for:
+ * /proc/acpi/sleep
+ * /proc/acpi/alarm
+ * /proc/acpi/wakeup
+ */
+
 ACPI_MODULE_NAME("sleep")
-#ifdef	CONFIG_ACPI_SLEEP_PROC_SLEEP
+#ifdef	CONFIG_ACPI_PROCFS
 static int acpi_system_sleep_seq_show(struct seq_file *seq, void *offset)
 {
 	int i;
@@ -68,7 +76,7 @@ acpi_system_write_sleep(struct file *file,
       Done:
 	return error ? error : count;
 }
-#endif				/* CONFIG_ACPI_SLEEP_PROC_SLEEP */
+#endif				/* CONFIG_ACPI_PROCFS */
 
 #if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE)
 /* use /sys/class/rtc/rtcX/wakealarm instead; it's not ACPI-specific */
@@ -463,7 +471,7 @@ static const struct file_operations acpi_system_wakeup_device_fops = {
 	.release = single_release,
 };
 
-#ifdef	CONFIG_ACPI_SLEEP_PROC_SLEEP
+#ifdef	CONFIG_ACPI_PROCFS
 static const struct file_operations acpi_system_sleep_fops = {
 	.open = acpi_system_sleep_open_fs,
 	.read = seq_read,
@@ -471,7 +479,7 @@ static const struct file_operations acpi_system_sleep_fops = {
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-#endif				/* CONFIG_ACPI_SLEEP_PROC_SLEEP */
+#endif				/* CONFIG_ACPI_PROCFS */
 
 #ifdef	HAVE_ACPI_LEGACY_ALARM
 static const struct file_operations acpi_system_alarm_fops = {
@@ -498,14 +506,14 @@ static int __init acpi_sleep_proc_init(void)
 	if (acpi_disabled)
 		return 0;
 
-#ifdef	CONFIG_ACPI_SLEEP_PROC_SLEEP
+#ifdef	CONFIG_ACPI_PROCFS
 	/* 'sleep' [R/W] */
 	entry =
 	    create_proc_entry("sleep", S_IFREG | S_IRUGO | S_IWUSR,
 			      acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_sleep_fops;
-#endif
+#endif				/* CONFIG_ACPI_PROCFS */
 
 #ifdef	HAVE_ACPI_LEGACY_ALARM
 	/* 'alarm' [R/W] */
-- 
1.5.3.rc2.22.g69a9b
