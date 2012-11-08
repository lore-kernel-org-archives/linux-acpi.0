From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI: Add debugfs support for ACPICA boot time measurement.
Date: Thu,  8 Nov 2012 09:49:22 +0800
Message-ID: <a4f15c34285624904d483e22b9b7a10c7d97fc3d.1352339077.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59853 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720Ab2KHBtj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Nov 2012 20:49:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

ACPICA defines the following initialization steps that must be called to
make ACPICA functional:
  1. acpi_initialize_tables
  2. acpi_initialize_subsystem
  3. acpi_load_tables
  4. acpi_enable_subsystem
  5. acpi_initialize_objects
  6. OSPM specific bus scanning
  7. acpi_update_all_gpes
This patch allows developers to check the execution time of such bootup
steps through /sys/kernel/debug/acpi/acpica_init_time.

The ACPICA 20121018 release measurement result is as follows:
========================================
    0.000000 acpi_initialize_tables
    0.000034 acpi_initialize_subsystem
    0.004822 acpi_load_tables
    0.003351 acpi_enable_subsystem
    0.003204 acpi_initialize_objects
    0.045082 acpi_bus_scan
    0.000023 acpi_bus_scan_fixed
    0.000017 acpi_update_all_gpes
========================================
The left column is the execution time in timeval (sec.usec) format.
The right column indicates the name of the initialization step.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/Kconfig      |   11 +++++
 drivers/acpi/Makefile     |    1 +
 drivers/acpi/acpica_sys.c |  112 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c        |   10 ++--
 drivers/acpi/debugfs.c    |    1 +
 drivers/acpi/scan.c       |    6 +--
 drivers/acpi/tables.c     |    3 +-
 include/linux/acpi.h      |   42 +++++++++++++++++
 8 files changed, 177 insertions(+), 9 deletions(-)
 create mode 100644 drivers/acpi/acpica_sys.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 119d58d..a692f38 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -109,6 +109,17 @@ config ACPI_PROC_EVENT
 	  Say Y here to retain the old behaviour.  Say N if your
 	  user-space is newer than kernel 2.6.23 (September 2007).
 
+config ACPICA_DEBUGFS
+	bool "Debugfs entries for ACPICA"
+	default n
+	help
+	  These entries include:
+	  1. Time measurement of the initialization steps:
+	     ACPICA defines several boot steps. This build option
+	     enables the measurement and recording for the
+	     execution time of these steps.
+	  If unsure, say N here.
+
 config ACPI_AC
 	tristate "AC Adapter"
 	depends on X86
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 227c82b..65eaace 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -41,6 +41,7 @@ acpi-y				+= power.o
 acpi-y				+= event.o
 acpi-y				+= sysfs.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
+acpi-$(CONFIG_ACPICA_DEBUGFS)	+= acpica_sys.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 ifdef CONFIG_ACPI_VIDEO
diff --git a/drivers/acpi/acpica_sys.c b/drivers/acpi/acpica_sys.c
new file mode 100644
index 0000000..d47efaa
--- /dev/null
+++ b/drivers/acpi/acpica_sys.c
@@ -0,0 +1,112 @@
+/*
+ * acpi/chrono.c - ACPICA boot steps measurement support
+ *
+ * Copyright (c) 2012, Intel Corporation
+ * Author: Lv Zheng <lv.zheng@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#define pr_fmt(fmt)	"ACPI: " KBUILD_MODNAME ": " fmt
+
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/debugfs.h>
+#include <linux/time.h>
+#include <linux/acpi.h>
+#include "internal.h"
+
+struct acpi_chrono {
+	const char *name;
+	u64 ts_nsec;		/* Execution time */
+	u64 clock_enter;	/* Clock of the entrance */
+};
+
+#define ACPI_CHRONO_INIT(step)	\
+	[ACPI_CHRONO_##step] = { .name = __stringify(step), }
+
+struct acpi_chrono acpi_chronos[ACPI_MAX_CHRONOS] = {
+	ACPI_CHRONO_INIT(initialize_tables),
+	ACPI_CHRONO_INIT(initialize_subsystem),
+	ACPI_CHRONO_INIT(load_tables),
+	ACPI_CHRONO_INIT(enable_subsystem),
+	ACPI_CHRONO_INIT(initialize_objects),
+	ACPI_CHRONO_INIT(bus_scan),
+	ACPI_CHRONO_INIT(bus_scan_fixed),
+	ACPI_CHRONO_INIT(update_all_gpes),
+};
+
+/**
+ * acpi_chrono_log_enter - Mark the enter point of the initialization step.
+ * @step: ACPI initialization step.
+ *
+ * Check and record the 'enter' time for the given initialization step.
+ */
+void acpi_chrono_log_enter(int step)
+{
+	acpi_chronos[step].clock_enter = local_clock();
+}
+EXPORT_SYMBOL(acpi_chrono_log_enter);
+
+/**
+ * acpi_chrono_log_exit - Mark the exit point of the initialization step.
+ * @step: ACPI initialization step.
+ *
+ * Check the 'exit' time and record the sum of the time in nano seconds for
+ * the given initialization step.
+ */
+void acpi_chrono_log_exit(int step)
+{
+	acpi_chronos[step].ts_nsec +=
+		local_clock() - acpi_chronos[step].clock_enter;
+}
+EXPORT_SYMBOL(acpi_chrono_log_exit);
+
+static int acpica_init_time_show(struct seq_file *m, void *v)
+{
+	int i;
+
+	for (i = 0; i < ACPI_MAX_CHRONOS; i++) {
+		u64 ts = acpi_chronos[i].ts_nsec;
+		unsigned long rem_nsec;
+
+		rem_nsec = do_div(ts, 1000000000);
+		seq_printf(m, "%5lu.%06lu acpi_%s\n",
+			   (unsigned long)ts, rem_nsec / 1000,
+			   acpi_chronos[i].name ? : "unknown");
+	}
+
+	return 0;
+}
+
+static int acpica_init_time_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, acpica_init_time_show, NULL);
+}
+
+static const struct file_operations acpica_init_time_fops = {
+	.open		= acpica_init_time_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+int __init acpica_debugfs_init(void)
+{
+	struct dentry *fentry;
+
+	fentry = debugfs_create_file("acpica_init_time", S_IRUSR,
+				     acpi_debugfs_dir, NULL,
+				     &acpica_init_time_fops);
+	if (fentry) {
+		pr_debug("ACPI boot time measurement started.\n");
+		return 0;
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d59175e..ff88767 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -922,14 +922,14 @@ void __init acpi_early_init(void)
 		goto error0;
 	}
 
-	status = acpi_initialize_subsystem();
+	status = ACPICA_INIT_STEP(initialize_subsystem);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX
 		       "Unable to initialize the ACPI Interpreter\n");
 		goto error0;
 	}
 
-	status = acpi_load_tables();
+	status = ACPICA_INIT_STEP(load_tables);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX
 		       "Unable to load the System Description Tables\n");
@@ -955,7 +955,7 @@ void __init acpi_early_init(void)
 	}
 #endif
 
-	status = acpi_enable_subsystem(~ACPI_NO_ACPI_ENABLE);
+	status = ACPICA_INIT_STEP(enable_subsystem, ~ACPI_NO_ACPI_ENABLE);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to enable ACPI\n");
 		goto error0;
@@ -976,7 +976,7 @@ static int __init acpi_bus_init(void)
 
 	acpi_os_initialize1();
 
-	status = acpi_enable_subsystem(ACPI_NO_ACPI_ENABLE);
+	status = ACPICA_INIT_STEP(enable_subsystem, ACPI_NO_ACPI_ENABLE);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX
 		       "Unable to start the ACPI Interpreter\n");
@@ -994,7 +994,7 @@ static int __init acpi_bus_init(void)
 	status = acpi_ec_ecdt_probe();
 	/* Ignore result. Not having an ECDT is not fatal. */
 
-	status = acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
+	status = ACPICA_INIT_STEP(initialize_objects, ACPI_FULL_INITIALIZATION);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to initialize ACPI objects\n");
 		goto error1;
diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
index b55d6a2..20e0cbb 100644
--- a/drivers/acpi/debugfs.c
+++ b/drivers/acpi/debugfs.c
@@ -16,4 +16,5 @@ EXPORT_SYMBOL_GPL(acpi_debugfs_dir);
 void __init acpi_debugfs_init(void)
 {
 	acpi_debugfs_dir = debugfs_create_dir("acpi", NULL);
+	acpica_debugfs_init();
 }
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e7afba1..bce2cb7 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1745,15 +1745,15 @@ int __init acpi_scan_init(void)
 	/*
 	 * Enumerate devices in the ACPI namespace.
 	 */
-	result = acpi_bus_scan(ACPI_ROOT_OBJECT, &ops, &acpi_root);
+	result = ACPI_INIT_STEP(bus_scan, ACPI_ROOT_OBJECT, &ops, &acpi_root);
 
 	if (!result)
-		result = acpi_bus_scan_fixed();
+		result = ACPI_INIT_STEP(bus_scan_fixed);
 
 	if (result)
 		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);
 	else
-		acpi_update_all_gpes();
+		ACPICA_INIT_STEP(update_all_gpes);
 
 	return result;
 }
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2572d97..6b3402d 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -349,7 +349,8 @@ int __init acpi_table_init(void)
 {
 	acpi_status status;
 
-	status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
+	status = ACPICA_INIT_STEP(initialize_tables,
+				  initial_tables, ACPI_MAX_TABLES, 0);
 	if (ACPI_FAILURE(status))
 		return 1;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b54c262..d49b287 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -462,4 +462,46 @@ acpi_status acpi_os_prepare_sleep(u8 sleep_state,
 #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
 #endif
 
+#ifdef CONFIG_ACPICA_DEBUGFS
+/* Time measurement of ACPICA initialization steps. */
+#define ACPI_CHRONO_initialize_tables			0x00
+#define ACPI_CHRONO_initialize_subsystem		0x01
+#define ACPI_CHRONO_load_tables				0x02
+#define ACPI_CHRONO_enable_subsystem			0x03
+#define ACPI_CHRONO_initialize_objects			0x04
+#define ACPI_CHRONO_bus_scan				0x05
+#define ACPI_CHRONO_bus_scan_fixed			0x06
+#define ACPI_CHRONO_update_all_gpes			0x07
+#define ACPI_MAX_CHRONOS				0x08
+
+void acpi_chrono_log_enter(int step);
+void acpi_chrono_log_exit(int step);
+
+#define ACPICA_INIT_STEP(step, ...)			\
+({							\
+	acpi_status status;				\
+	acpi_chrono_log_enter(ACPI_CHRONO_##step);	\
+	status = acpi_##step(__VA_ARGS__);		\
+	acpi_chrono_log_exit(ACPI_CHRONO_##step);	\
+	status;						\
+})
+#define ACPI_INIT_STEP(step, ...)			\
+({							\
+	int result;					\
+	acpi_chrono_log_enter(ACPI_CHRONO_##step);	\
+	result = acpi_##step(__VA_ARGS__);		\
+	acpi_chrono_log_exit(ACPI_CHRONO_##step);	\
+	result;						\
+})
+
+/* ACPICA debugfs entry. */
+int __init acpica_debugfs_init(void);
+#else
+#define ACPICA_INIT_STEP(step, ...)	acpi_##step(__VA_ARGS__)
+#define ACPI_INIT_STEP(step, ...)	acpi_##step(__VA_ARGS__)
+
+static inline int acpica_debugfs_init(void)
+{ return 0; }
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
1.7.10

