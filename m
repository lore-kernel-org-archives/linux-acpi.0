From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v2 5/5] ACPI / debugger: Add module support for ACPI debugger
Date: Fri,  6 Nov 2015 14:47:24 +0800
Message-ID: <ad1a82db4b71e43711a56b133271eeab3b8cb616.1446790780.git.lv.zheng@intel.com>
References: <8c1016ca8a570ba7c7a1c9f0f88d73cd83cea490> <cover.1446790780.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446790780.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch converts AML debugger into a loadable module.

Note that, it implements driver unloading at the level dependent on the
module reference count. Which means if ACPI debugger is being used by a
userspace program, "rmmod acpi_dbg" should result in failure.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/Kconfig     |   11 +++
 drivers/acpi/Makefile    |    2 +-
 drivers/acpi/acpi_dbg.c  |   80 ++++++++++++------
 drivers/acpi/bus.c       |    3 +-
 drivers/acpi/osl.c       |  207 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/acpi.h     |   71 ++++++++++++++++
 include/linux/acpi_dbg.h |   52 ------------
 7 files changed, 338 insertions(+), 88 deletions(-)
 delete mode 100644 include/linux/acpi_dbg.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 2b89fd7..c4d4a05 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -66,6 +66,17 @@ config ACPI_DEBUGGER
 	  This is still under development, currently enabling this only
 	  results in the compilation of the ACPICA debugger files.
 
+if ACPI_DEBUGGER
+
+config ACPI_DEBUGGER_USER
+	tristate "Userspace debugger accessiblity"
+	depends on DEBUG_FS
+	help
+	  Export /sys/kernel/debug/acpi/acpidbg for userspace utilities
+	  to access the debugger functionalities.
+
+endif
+
 config ACPI_SLEEP
 	bool
 	depends on SUSPEND || HIBERNATION
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 102b5e6..c6f236f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -50,7 +50,6 @@ acpi-y				+= sysfs.o
 acpi-y				+= property.o
 acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
-acpi-$(CONFIG_ACPI_DEBUGGER)	+= acpi_dbg.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 acpi-y				+= acpi_lpat.o
@@ -80,6 +79,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
+obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index 853ea94..7ca3202 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -21,7 +21,7 @@
 #include <linux/proc_fs.h>
 #include <linux/debugfs.h>
 #include <linux/circ_buf.h>
-#include <linux/acpi_dbg.h>
+#include <linux/acpi.h>
 #include "internal.h"
 
 #define ACPI_AML_BUF_ALIGN	(sizeof (acpi_size))
@@ -307,7 +307,7 @@ static int acpi_aml_readb_kern(void)
  * the debugger output and store the output into the debugger interface
  * buffer. Return the size of stored logs or errno.
  */
-ssize_t acpi_aml_write_log(const char *msg)
+static ssize_t acpi_aml_write_log(const char *msg)
 {
 	int ret = 0;
 	int count = 0, size = 0;
@@ -350,7 +350,6 @@ again:
 	}
 	return size > 0 ? size : ret;
 }
-EXPORT_SYMBOL(acpi_aml_write_log);
 
 /*
  * acpi_aml_read_cmd() - Capture debugger input
@@ -361,7 +360,7 @@ EXPORT_SYMBOL(acpi_aml_write_log);
  * the debugger input commands and store the input commands into the
  * debugger interface buffer. Return the size of stored commands or errno.
  */
-ssize_t acpi_aml_read_cmd(char *msg, size_t count)
+static ssize_t acpi_aml_read_cmd(char *msg, size_t count)
 {
 	int ret = 0;
 	int size = 0;
@@ -403,7 +402,6 @@ again:
 	}
 	return size > 0 ? size : ret;
 }
-EXPORT_SYMBOL(acpi_aml_read_cmd);
 
 static int acpi_aml_thread(void *unsed)
 {
@@ -440,7 +438,7 @@ static int acpi_aml_thread(void *unsed)
  * This function should be used to implement acpi_os_execute() which is
  * used by the ACPICA debugger to create the debugger thread.
  */
-int acpi_aml_create_thread(acpi_osd_exec_callback function, void *context)
+static int acpi_aml_create_thread(acpi_osd_exec_callback function, void *context)
 {
 	struct task_struct *t;
 
@@ -462,30 +460,27 @@ int acpi_aml_create_thread(acpi_osd_exec_callback function, void *context)
 	mutex_unlock(&acpi_aml_io.lock);
 	return 0;
 }
-EXPORT_SYMBOL(acpi_aml_create_thread);
 
-int acpi_aml_wait_command_ready(void)
+static int acpi_aml_wait_command_ready(bool single_step,
+				       char *buffer, size_t length)
 {
 	acpi_status status;
 
-	if (!acpi_gbl_method_executing)
-		acpi_os_printf("%1c ", ACPI_DEBUGGER_COMMAND_PROMPT);
-	else
+	if (single_step)
 		acpi_os_printf("%1c ", ACPI_DEBUGGER_EXECUTE_PROMPT);
+	else
+		acpi_os_printf("%1c ", ACPI_DEBUGGER_COMMAND_PROMPT);
 
-	status = acpi_os_get_line(acpi_gbl_db_line_buf,
-				  ACPI_DB_LINE_BUFFER_SIZE, NULL);
+	status = acpi_os_get_line(buffer, length, NULL);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
 	return 0;
 }
-EXPORT_SYMBOL(acpi_aml_wait_command_ready);
 
-int acpi_aml_notify_command_complete(void)
+static int acpi_aml_notify_command_complete(void)
 {
 	return 0;
 }
-EXPORT_SYMBOL(acpi_aml_notify_command_complete);
 
 static int acpi_aml_open(struct inode *inode, struct file *file)
 {
@@ -759,10 +754,23 @@ static const struct file_operations acpi_aml_operations = {
 	.llseek		= generic_file_llseek,
 };
 
+static const struct acpi_debugger_ops acpi_aml_debugger = {
+	.create_thread		 = acpi_aml_create_thread,
+	.read_cmd		 = acpi_aml_read_cmd,
+	.write_log		 = acpi_aml_write_log,
+	.wait_command_ready	 = acpi_aml_wait_command_ready,
+	.notify_command_complete = acpi_aml_notify_command_complete,
+};
+
 int __init acpi_aml_init(void)
 {
-	if (!acpi_debugfs_dir)
-		return -ENOENT;
+	int ret = 0;
+
+	if (!acpi_debugfs_dir) {
+		ret = -ENOENT;
+		goto err_exit;
+	}
+
 	/* Initialize AML IO interface */
 	mutex_init(&acpi_aml_io.lock);
 	init_waitqueue_head(&acpi_aml_io.wait);
@@ -772,21 +780,39 @@ int __init acpi_aml_init(void)
 					      S_IFREG | S_IRUGO | S_IWUSR,
 					      acpi_debugfs_dir, NULL,
 					      &acpi_aml_operations);
-	if (acpi_aml_dentry == NULL)
-		return -ENODEV;
+	if (acpi_aml_dentry == NULL) {
+		ret = -ENODEV;
+		goto err_exit;
+	}
+	ret = acpi_register_debugger(THIS_MODULE, &acpi_aml_debugger);
+	if (ret)
+		goto err_fs;
 	acpi_aml_initialized = true;
-	return 0;
+
+err_fs:
+	if (ret) {
+		debugfs_remove(acpi_aml_dentry);
+		acpi_aml_dentry = NULL;
+	}
+err_exit:
+	return ret;
 }
 
-#if 0
 void __exit acpi_aml_exit(void)
 {
-	/* TODO: Stop the in kernel debugger */
-	if (acpi_aml_dentry)
-		debugfs_remove(acpi_aml_dentry);
-	acpi_aml_initialized = false;
+	if (acpi_aml_initialized) {
+		acpi_unregister_debugger(&acpi_aml_debugger);
+		if (acpi_aml_dentry) {
+			debugfs_remove(acpi_aml_dentry);
+			acpi_aml_dentry = NULL;
+		}
+		acpi_aml_initialized = false;
+	}
 }
 
 module_init(acpi_aml_init);
 module_exit(acpi_aml_exit);
-#endif
+
+MODULE_AUTHOR("Lv Zheng");
+MODULE_DESCRIPTION("ACPI debugger userspace IO driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 06fbba9..1a40111 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -37,7 +37,6 @@
 #include <acpi/apei.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
-#include <linux/acpi_dbg.h>
 
 #include "internal.h"
 
@@ -1095,7 +1094,7 @@ static int __init acpi_init(void)
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
-	acpi_aml_init();
+	acpi_debugger_init();
 	return 0;
 }
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 2de8f66..ce5ac00 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -40,7 +40,6 @@
 #include <linux/list.h>
 #include <linux/jiffies.h>
 #include <linux/semaphore.h>
-#include <linux/acpi_dbg.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -220,6 +219,7 @@ void acpi_os_printf(const char *fmt, ...)
 	acpi_os_vprintf(fmt, args);
 	va_end(args);
 }
+EXPORT_SYMBOL(acpi_os_printf);
 
 void acpi_os_vprintf(const char *fmt, va_list args)
 {
@@ -234,7 +234,7 @@ void acpi_os_vprintf(const char *fmt, va_list args)
 		printk(KERN_CONT "%s", buffer);
 	}
 #else
-	if (acpi_aml_write_log(buffer) < 0)
+	if (acpi_debugger_write_log(buffer) < 0)
 		printk(KERN_CONT "%s", buffer);
 #endif
 }
@@ -1100,6 +1100,200 @@ static void acpi_os_execute_deferred(struct work_struct *work)
 	kfree(dpc);
 }
 
+#ifdef CONFIG_ACPI_DEBUGGER
+static struct acpi_debugger acpi_debugger;
+static bool acpi_debugger_initialized;
+
+int acpi_register_debugger(struct module *owner,
+			   const struct acpi_debugger_ops *ops)
+{
+	int ret = 0;
+
+	mutex_lock(&acpi_debugger.lock);
+	if (acpi_debugger.ops) {
+		ret = -EBUSY;
+		goto err_lock;
+	}
+
+	acpi_debugger.owner = owner;
+	acpi_debugger.ops = ops;
+
+err_lock:
+	mutex_unlock(&acpi_debugger.lock);
+	return ret;
+}
+EXPORT_SYMBOL(acpi_register_debugger);
+
+void acpi_unregister_debugger(const struct acpi_debugger_ops *ops)
+{
+	mutex_lock(&acpi_debugger.lock);
+	if (ops == acpi_debugger.ops) {
+		acpi_debugger.ops = NULL;
+		acpi_debugger.owner = NULL;
+	}
+	mutex_unlock(&acpi_debugger.lock);
+}
+EXPORT_SYMBOL(acpi_unregister_debugger);
+
+int acpi_debugger_create_thread(acpi_osd_exec_callback function, void *context)
+{
+	int ret;
+	int (*func)(acpi_osd_exec_callback, void *);
+	struct module *owner;
+
+	if (!acpi_debugger_initialized)
+		return -ENODEV;
+	mutex_lock(&acpi_debugger.lock);
+	if (!acpi_debugger.ops) {
+		ret = -ENODEV;
+		goto err_lock;
+	}
+	if (!try_module_get(acpi_debugger.owner)) {
+		ret = -ENODEV;
+		goto err_lock;
+	}
+	func = acpi_debugger.ops->create_thread;
+	owner = acpi_debugger.owner;
+	mutex_unlock(&acpi_debugger.lock);
+
+	ret = func(function, context);
+
+	mutex_lock(&acpi_debugger.lock);
+	module_put(owner);
+err_lock:
+	mutex_unlock(&acpi_debugger.lock);
+	return ret;
+}
+
+ssize_t acpi_debugger_write_log(const char *msg)
+{
+	ssize_t ret;
+	ssize_t (*func)(const char *);
+	struct module *owner;
+
+	if (!acpi_debugger_initialized)
+		return -ENODEV;
+	mutex_lock(&acpi_debugger.lock);
+	if (!acpi_debugger.ops) {
+		ret = -ENODEV;
+		goto err_lock;
+	}
+	if (!try_module_get(acpi_debugger.owner)) {
+		ret = -ENODEV;
+		goto err_lock;
+	}
+	func = acpi_debugger.ops->write_log;
+	owner = acpi_debugger.owner;
+	mutex_unlock(&acpi_debugger.lock);
+
+	ret = func(msg);
+
+	mutex_lock(&acpi_debugger.lock);
+	module_put(owner);
+err_lock:
+	mutex_unlock(&acpi_debugger.lock);
+	return ret;
+}
+
+ssize_t acpi_debugger_read_cmd(char *buffer, size_t buffer_length)
+{
+	ssize_t ret;
+	ssize_t (*func)(char *, size_t);
+	struct module *owner;
+
+	if (!acpi_debugger_initialized)
+		return -ENODEV;
+	mutex_lock(&acpi_debugger.lock);
+	if (!acpi_debugger.ops) {
+		ret = -ENODEV;
+		goto err_lock;
+	}
+	if (!try_module_get(acpi_debugger.owner)) {
+		ret = -ENODEV;
+		goto err_lock;
+	}
+	func = acpi_debugger.ops->read_cmd;
+	owner = acpi_debugger.owner;
+	mutex_unlock(&acpi_debugger.lock);
+
+	ret = func(buffer, buffer_length);
+
+	mutex_lock(&acpi_debugger.lock);
+	module_put(owner);
+err_lock:
+	mutex_unlock(&acpi_debugger.lock);
+	return ret;
+}
+
+int acpi_debugger_wait_command_ready(void)
+{
+	int ret;
+	int (*func)(bool, char *, size_t);
+	struct module *owner;
+
+	if (!acpi_debugger_initialized)
+		return -ENODEV;
+	mutex_lock(&acpi_debugger.lock);
+	if (!acpi_debugger.ops) {
+		ret = -ENODEV;
+		goto err_lock;
+	}
+	if (!try_module_get(acpi_debugger.owner)) {
+		ret = -ENODEV;
+		goto err_lock;
+	}
+	func = acpi_debugger.ops->wait_command_ready;
+	owner = acpi_debugger.owner;
+	mutex_unlock(&acpi_debugger.lock);
+
+	ret = func(acpi_gbl_method_executing,
+		   acpi_gbl_db_line_buf, ACPI_DB_LINE_BUFFER_SIZE);
+
+	mutex_lock(&acpi_debugger.lock);
+	module_put(owner);
+err_lock:
+	mutex_unlock(&acpi_debugger.lock);
+	return ret;
+}
+
+int acpi_debugger_notify_command_complete(void)
+{
+	int ret;
+	int (*func)(void);
+	struct module *owner;
+
+	if (!acpi_debugger_initialized)
+		return -ENODEV;
+	mutex_lock(&acpi_debugger.lock);
+	if (!acpi_debugger.ops) {
+		ret = -ENODEV;
+		goto err_lock;
+	}
+	if (!try_module_get(acpi_debugger.owner)) {
+		ret = -ENODEV;
+		goto err_lock;
+	}
+	func = acpi_debugger.ops->notify_command_complete;
+	owner = acpi_debugger.owner;
+	mutex_unlock(&acpi_debugger.lock);
+
+	ret = func();
+
+	mutex_lock(&acpi_debugger.lock);
+	module_put(owner);
+err_lock:
+	mutex_unlock(&acpi_debugger.lock);
+	return ret;
+}
+
+int __init acpi_debugger_init(void)
+{
+	mutex_init(&acpi_debugger.lock);
+	acpi_debugger_initialized = true;
+	return 0;
+}
+#endif
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_os_execute
@@ -1127,7 +1321,7 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 			  function, context));
 
 	if (type == OSL_DEBUGGER_MAIN_THREAD) {
-		ret = acpi_aml_create_thread(function, context);
+		ret = acpi_debugger_create_thread(function, context);
 		if (ret) {
 			pr_err("Call to kthread_create() failed.\n");
 			status = AE_ERROR;
@@ -1377,7 +1571,7 @@ acpi_status acpi_os_get_line(char *buffer, u32 buffer_length, u32 *bytes_read)
 #else
 	int ret;
 
-	ret = acpi_aml_read_cmd(buffer, buffer_length);
+	ret = acpi_debugger_read_cmd(buffer, buffer_length);
 	if (ret < 0)
 		return AE_ERROR;
 	if (bytes_read)
@@ -1386,12 +1580,13 @@ acpi_status acpi_os_get_line(char *buffer, u32 buffer_length, u32 *bytes_read)
 
 	return AE_OK;
 }
+EXPORT_SYMBOL(acpi_os_get_line);
 
 acpi_status acpi_os_wait_command_ready(void)
 {
 	int ret;
 
-	ret = acpi_aml_wait_command_ready();
+	ret = acpi_debugger_wait_command_ready();
 	if (ret < 0)
 		return AE_ERROR;
 	return AE_OK;
@@ -1401,7 +1596,7 @@ acpi_status acpi_os_notify_command_complete(void)
 {
 	int ret;
 
-	ret = acpi_aml_notify_command_complete();
+	ret = acpi_debugger_notify_command_complete();
 	if (ret < 0)
 		return AE_ERROR;
 	return AE_OK;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 51a96a8..8f24e03 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -37,6 +37,8 @@
 #include <linux/list.h>
 #include <linux/mod_devicetable.h>
 #include <linux/dynamic_debug.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -119,6 +121,75 @@ typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
 typedef int (*acpi_tbl_entry_handler)(struct acpi_subtable_header *header,
 				      const unsigned long end);
 
+/* Debugger support */
+
+struct acpi_debugger_ops {
+	int (*create_thread)(acpi_osd_exec_callback function, void *context);
+	ssize_t (*write_log)(const char *msg);
+	ssize_t (*read_cmd)(char *buffer, size_t length);
+	int (*wait_command_ready)(bool single_step, char *buffer, size_t length);
+	int (*notify_command_complete)(void);
+};
+
+struct acpi_debugger {
+	const struct acpi_debugger_ops *ops;
+	struct module *owner;
+	struct mutex lock;
+};
+
+#ifdef CONFIG_ACPI_DEBUGGER
+int __init acpi_debugger_init(void);
+int acpi_register_debugger(struct module *owner,
+			   const struct acpi_debugger_ops *ops);
+void acpi_unregister_debugger(const struct acpi_debugger_ops *ops);
+int acpi_debugger_create_thread(acpi_osd_exec_callback function, void *context);
+ssize_t acpi_debugger_write_log(const char *msg);
+ssize_t acpi_debugger_read_cmd(char *buffer, size_t buffer_length);
+int acpi_debugger_wait_command_ready(void);
+int acpi_debugger_notify_command_complete(void);
+#else
+static inline int acpi_debugger_init(void)
+{
+	return -ENODEV;
+}
+
+static inline int acpi_register_debugger(struct module *owner,
+					 const struct acpi_debugger_ops *ops)
+{
+	return -ENODEV;
+}
+
+static inline void acpi_unregister_debugger(const struct acpi_debugger_ops *ops)
+{
+}
+
+static inline int acpi_debugger_create_thread(acpi_osd_exec_callback function,
+					      void *context)
+{
+	return -ENODEV;
+}
+
+static inline int acpi_debugger_write_log(const char *msg)
+{
+	return -ENODEV;
+}
+
+static inline int acpi_debugger_read_cmd(char *buffer, u32 buffer_length)
+{
+	return -ENODEV;
+}
+
+static inline int acpi_debugger_wait_command_ready(void)
+{
+	return -ENODEV;
+}
+
+static inline int acpi_debugger_notify_command_complete(void)
+{
+	return -ENODEV;
+}
+#endif
+
 #ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
 void acpi_initrd_override(void *data, size_t size);
 #else
diff --git a/include/linux/acpi_dbg.h b/include/linux/acpi_dbg.h
deleted file mode 100644
index 60f3887..0000000
--- a/include/linux/acpi_dbg.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * ACPI AML interfacing support
- *
- * Copyright (C) 2015, Intel Corporation
- * Authors: Lv Zheng <lv.zheng@intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _LINUX_ACPI_DBG_H
-#define _LINUX_ACPI_DBG_H
-
-#include <linux/acpi.h>
-
-#ifdef CONFIG_ACPI_DEBUGGER
-int __init acpi_aml_init(void);
-int acpi_aml_create_thread(acpi_osd_exec_callback function, void *context);
-ssize_t acpi_aml_write_log(const char *msg);
-ssize_t acpi_aml_read_cmd(char *buffer, size_t buffer_length);
-int acpi_aml_wait_command_ready(void);
-int acpi_aml_notify_command_complete(void);
-#else
-static int inline acpi_aml_init(void)
-{
-	return 0;
-}
-static inline int acpi_aml_create_thread(acpi_osd_exec_callback function,
-					 void *context)
-{
-	return -ENODEV;
-}
-static inline int acpi_aml_write_log(const char *msg)
-{
-	return -ENODEV;
-}
-static inline int acpi_aml_read_cmd(char *buffer, u32 buffer_length)
-{
-	return -ENODEV;
-}
-static inline int acpi_aml_wait_command_ready(void)
-{
-	return -ENODEV;
-}
-static inline int acpi_aml_notify_command_complete(void)
-{
-	return -ENODEV;
-}
-#endif
-
-#endif /* _LINUX_ACPI_DBG_H */
-- 
1.7.10
