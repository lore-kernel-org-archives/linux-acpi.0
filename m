From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 4/7] ACPI / debugger: Add IO interface to access debugger functionalities
Date: Tue, 10 Nov 2015 16:22:03 +0800
Message-ID: <5932425346b4568127fb928403f5793270db372f.1447143067.git.lv.zheng@intel.com>
References: <cover.1446790780.git.lv.zheng@intel.com> <cover.1447143067.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447143067.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch adds /sys/kernel/debug/acpi/acpidbg, which can be used by
userspace programs to access ACPICA debugger functionalities.

Known issue:
1. IO flush support
   acpi_os_notify_command_complete() and acpi_os_wait_command_ready() can
   be used by acpi_dbg module to implement .flush() filesystem operation.
   While this patch doesn't go that far. It then becomes userspace tool's
   duty now to flush old commands before executing new batch mode commands.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/Kconfig              |    3 +-
 drivers/acpi/Makefile             |    1 +
 drivers/acpi/acpi_dbg.c           |  792 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c                |    2 +
 drivers/acpi/osl.c                |   55 ++-
 include/acpi/platform/aclinux.h   |    2 -
 include/acpi/platform/aclinuxex.h |   10 -
 include/linux/acpi_dbg.h          |   52 +++
 8 files changed, 900 insertions(+), 17 deletions(-)
 create mode 100644 drivers/acpi/acpi_dbg.c
 create mode 100644 include/linux/acpi_dbg.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 25dbb76..4de3517 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -58,8 +58,9 @@ config ACPI_CCA_REQUIRED
 	bool
 
 config ACPI_DEBUGGER
-	bool "In-kernel debugger (EXPERIMENTAL)"
+	bool "In-kernel debugger"
 	select ACPI_DEBUG
+	depends on DEBUG_FS
 	help
 	  Enable in-kernel debugging facilities: statistics, internal
 	  object dump, single step control method execution.
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 675eaf3..102b5e6 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -50,6 +50,7 @@ acpi-y				+= sysfs.o
 acpi-y				+= property.o
 acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
+acpi-$(CONFIG_ACPI_DEBUGGER)	+= acpi_dbg.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 acpi-y				+= acpi_lpat.o
diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
new file mode 100644
index 0000000..7be0851
--- /dev/null
+++ b/drivers/acpi/acpi_dbg.c
@@ -0,0 +1,792 @@
+/*
+ * ACPI AML interfacing support
+ *
+ * Copyright (C) 2015, Intel Corporation
+ * Authors: Lv Zheng <lv.zheng@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* #define DEBUG */
+#define pr_fmt(fmt) "ACPI : AML: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/sched.h>
+#include <linux/kthread.h>
+#include <linux/proc_fs.h>
+#include <linux/debugfs.h>
+#include <linux/circ_buf.h>
+#include <linux/acpi_dbg.h>
+#include "internal.h"
+
+#define ACPI_AML_BUF_ALIGN	(sizeof (acpi_size))
+#define ACPI_AML_BUF_SIZE	PAGE_SIZE
+
+#define circ_count(circ) \
+	(CIRC_CNT((circ)->head, (circ)->tail, ACPI_AML_BUF_SIZE))
+#define circ_count_to_end(circ) \
+	(CIRC_CNT_TO_END((circ)->head, (circ)->tail, ACPI_AML_BUF_SIZE))
+#define circ_space(circ) \
+	(CIRC_SPACE((circ)->head, (circ)->tail, ACPI_AML_BUF_SIZE))
+#define circ_space_to_end(circ) \
+	(CIRC_SPACE_TO_END((circ)->head, (circ)->tail, ACPI_AML_BUF_SIZE))
+
+#define ACPI_AML_OPENED		0x0001
+#define ACPI_AML_CLOSED		0x0002
+#define ACPI_AML_IN_USER	0x0004 /* user space is writing cmd */
+#define ACPI_AML_IN_KERN	0x0008 /* kernel space is reading cmd */
+#define ACPI_AML_OUT_USER	0x0010 /* user space is reading log */
+#define ACPI_AML_OUT_KERN	0x0020 /* kernel space is writing log */
+#define ACPI_AML_USER		(ACPI_AML_IN_USER | ACPI_AML_OUT_USER)
+#define ACPI_AML_KERN		(ACPI_AML_IN_KERN | ACPI_AML_OUT_KERN)
+#define ACPI_AML_BUSY		(ACPI_AML_USER | ACPI_AML_KERN)
+#define ACPI_AML_OPEN		(ACPI_AML_OPENED | ACPI_AML_CLOSED)
+
+struct acpi_aml_io {
+	wait_queue_head_t wait;
+	unsigned long flags;
+	unsigned long users;
+	struct mutex lock;
+	struct task_struct *thread;
+	char out_buf[ACPI_AML_BUF_SIZE] __aligned(ACPI_AML_BUF_ALIGN);
+	struct circ_buf out_crc;
+	char in_buf[ACPI_AML_BUF_SIZE] __aligned(ACPI_AML_BUF_ALIGN);
+	struct circ_buf in_crc;
+	acpi_osd_exec_callback function;
+	void *context;
+	unsigned long usages;
+};
+
+static struct acpi_aml_io acpi_aml_io;
+static bool acpi_aml_initialized;
+static struct file *acpi_aml_active_reader;
+static struct dentry *acpi_aml_dentry;
+
+static inline bool __acpi_aml_running(void)
+{
+	return acpi_aml_io.thread ? true : false;
+}
+
+static inline bool __acpi_aml_access_ok(unsigned long flag)
+{
+	/*
+	 * The debugger interface is in opened state (OPENED && !CLOSED),
+	 * then it is allowed to access the debugger buffers from either
+	 * user space or the kernel space.
+	 * In addition, for the kernel space, only the debugger thread
+	 * (thread ID matched) is allowed to access.
+	 */
+	if (!(acpi_aml_io.flags & ACPI_AML_OPENED) ||
+	    (acpi_aml_io.flags & ACPI_AML_CLOSED) ||
+	    !__acpi_aml_running())
+		return false;
+	if ((flag & ACPI_AML_KERN) &&
+	    current != acpi_aml_io.thread)
+		return false;
+	return true;
+}
+
+static inline bool __acpi_aml_readable(struct circ_buf *circ, unsigned long flag)
+{
+	/*
+	 * Another read is not in progress and there is data in buffer
+	 * available for read.
+	 */
+	if (!(acpi_aml_io.flags & flag) && circ_count(circ))
+		return true;
+	return false;
+}
+
+static inline bool __acpi_aml_writable(struct circ_buf *circ, unsigned long flag)
+{
+	/*
+	 * Another write is not in progress and there is buffer space
+	 * available for write.
+	 */
+	if (!(acpi_aml_io.flags & flag) && circ_space(circ))
+		return true;
+	return false;
+}
+
+static inline bool __acpi_aml_busy(void)
+{
+	if (acpi_aml_io.flags & ACPI_AML_BUSY)
+		return true;
+	return false;
+}
+
+static inline bool __acpi_aml_opened(void)
+{
+	if (acpi_aml_io.flags & ACPI_AML_OPEN)
+		return true;
+	return false;
+}
+
+static inline bool __acpi_aml_used(void)
+{
+	return acpi_aml_io.usages ? true : false;
+}
+
+static inline bool acpi_aml_running(void)
+{
+	bool ret;
+
+	mutex_lock(&acpi_aml_io.lock);
+	ret = __acpi_aml_running();
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static bool acpi_aml_busy(void)
+{
+	bool ret;
+
+	mutex_lock(&acpi_aml_io.lock);
+	ret = __acpi_aml_busy();
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static bool acpi_aml_used(void)
+{
+	bool ret;
+
+	/*
+	 * The usage count is prepared to avoid race conditions between the
+	 * starts and the stops of the debugger thread.
+	 */
+	mutex_lock(&acpi_aml_io.lock);
+	ret = __acpi_aml_used();
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static bool acpi_aml_kern_readable(void)
+{
+	bool ret;
+
+	mutex_lock(&acpi_aml_io.lock);
+	ret = !__acpi_aml_access_ok(ACPI_AML_IN_KERN) ||
+	      __acpi_aml_readable(&acpi_aml_io.in_crc, ACPI_AML_IN_KERN);
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static bool acpi_aml_kern_writable(void)
+{
+	bool ret;
+
+	mutex_lock(&acpi_aml_io.lock);
+	ret = !__acpi_aml_access_ok(ACPI_AML_OUT_KERN) ||
+	      __acpi_aml_writable(&acpi_aml_io.out_crc, ACPI_AML_OUT_KERN);
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static bool acpi_aml_user_readable(void)
+{
+	bool ret;
+
+	mutex_lock(&acpi_aml_io.lock);
+	ret = !__acpi_aml_access_ok(ACPI_AML_OUT_USER) ||
+	      __acpi_aml_readable(&acpi_aml_io.out_crc, ACPI_AML_OUT_USER);
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static bool acpi_aml_user_writable(void)
+{
+	bool ret;
+
+	mutex_lock(&acpi_aml_io.lock);
+	ret = !__acpi_aml_access_ok(ACPI_AML_IN_USER) ||
+	      __acpi_aml_writable(&acpi_aml_io.in_crc, ACPI_AML_IN_USER);
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static int acpi_aml_lock_write(struct circ_buf *circ, unsigned long flag)
+{
+	int ret = 0;
+
+	mutex_lock(&acpi_aml_io.lock);
+	if (!__acpi_aml_access_ok(flag)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	if (!__acpi_aml_writable(circ, flag)) {
+		ret = -EAGAIN;
+		goto out;
+	}
+	acpi_aml_io.flags |= flag;
+out:
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static int acpi_aml_lock_read(struct circ_buf *circ, unsigned long flag)
+{
+	int ret = 0;
+
+	mutex_lock(&acpi_aml_io.lock);
+	if (!__acpi_aml_access_ok(flag)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	if (!__acpi_aml_readable(circ, flag)) {
+		ret = -EAGAIN;
+		goto out;
+	}
+	acpi_aml_io.flags |= flag;
+out:
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static void acpi_aml_unlock_fifo(unsigned long flag, bool wakeup)
+{
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.flags &= ~flag;
+	if (wakeup)
+		wake_up_interruptible(&acpi_aml_io.wait);
+	mutex_unlock(&acpi_aml_io.lock);
+}
+
+static int acpi_aml_write_kern(const char *buf, int len)
+{
+	int ret;
+	struct circ_buf *crc = &acpi_aml_io.out_crc;
+	int n;
+	char *p;
+
+	ret = acpi_aml_lock_write(crc, ACPI_AML_OUT_KERN);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+	/* sync tail before inserting logs */
+	smp_mb();
+	p = &crc->buf[crc->head];
+	n = min(len, circ_space_to_end(crc));
+	memcpy(p, buf, n);
+	/* sync head after inserting logs */
+	smp_wmb();
+	crc->head = (crc->head + n) & (ACPI_AML_BUF_SIZE - 1);
+	acpi_aml_unlock_fifo(ACPI_AML_OUT_KERN, true);
+	return n;
+}
+
+static int acpi_aml_readb_kern(void)
+{
+	int ret;
+	struct circ_buf *crc = &acpi_aml_io.in_crc;
+	char *p;
+
+	ret = acpi_aml_lock_read(crc, ACPI_AML_IN_KERN);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+	/* sync head before removing cmds */
+	smp_rmb();
+	p = &crc->buf[crc->tail];
+	ret = (int)*p;
+	/* sync tail before inserting cmds */
+	smp_mb();
+	crc->tail = (crc->tail + 1) & (ACPI_AML_BUF_SIZE - 1);
+	acpi_aml_unlock_fifo(ACPI_AML_IN_KERN, true);
+	return ret;
+}
+
+/*
+ * acpi_aml_write_log() - Capture debugger output
+ * @msg: the debugger output
+ *
+ * This function should be used to implement acpi_os_printf() to filter out
+ * the debugger output and store the output into the debugger interface
+ * buffer. Return the size of stored logs or errno.
+ */
+ssize_t acpi_aml_write_log(const char *msg)
+{
+	int ret = 0;
+	int count = 0, size = 0;
+
+	if (!acpi_aml_initialized)
+		return -ENODEV;
+	if (msg)
+		count = strlen(msg);
+	while (count > 0) {
+again:
+		ret = acpi_aml_write_kern(msg + size, count);
+		/*
+		 * A control method execution may be blocked if we wait
+		 * user space here and some kernel functionalities may be
+		 * executing another control method that need to be
+		 * synchronized with the one executed by the debugger
+		 * thread. Thus we do not wait when the user space isn't
+		 * fast enough to drain the logs, so that the logs are
+		 * dropped when the buffer is overflow and the normal
+		 * kernel functionalities won't get blocked.
+		 *
+		 * A module parameter may be used to tune this if the
+		 * integrity of the debugger output is required.
+		 */
+		if (ret == -EAGAIN) {
+			ret = wait_event_interruptible(acpi_aml_io.wait,
+				acpi_aml_kern_writable());
+			/*
+			 * We need to retry when the condition
+			 * becomes true.
+			 */
+			if (ret == 0)
+				goto again;
+			break;
+		}
+		if (IS_ERR_VALUE(ret))
+			break;
+		size += ret;
+		count -= ret;
+	}
+	return size > 0 ? size : ret;
+}
+EXPORT_SYMBOL(acpi_aml_write_log);
+
+/*
+ * acpi_aml_read_cmd() - Capture debugger input
+ * @msg: the debugger input
+ * @size: the size of the debugger input
+ *
+ * This function should be used to implement acpi_os_get_line() to capture
+ * the debugger input commands and store the input commands into the
+ * debugger interface buffer. Return the size of stored commands or errno.
+ */
+ssize_t acpi_aml_read_cmd(char *msg, size_t count)
+{
+	int ret = 0;
+	int size = 0;
+
+	/*
+	 * This is ensured by the running fact of the debugger thread
+	 * unless a bug is introduced.
+	 */
+	BUG_ON(!acpi_aml_initialized);
+	while (count > 0) {
+again:
+		/*
+		 * Check each input byte to find the end of the command.
+		 */
+		ret = acpi_aml_readb_kern();
+		if (ret == -EAGAIN) {
+			ret = wait_event_interruptible(acpi_aml_io.wait,
+				acpi_aml_kern_readable());
+			/*
+			 * We need to retry when the condition becomes
+			 * true.
+			 */
+			if (ret == 0)
+				goto again;
+		}
+		if (IS_ERR_VALUE(ret))
+			break;
+		*(msg + size) = (char)ret;
+		size++;
+		count--;
+		if (ret == '\n') {
+			/*
+			 * acpi_os_get_line() requires a zero terminated command
+			 * string.
+			 */
+			*(msg + size - 1) = '\0';
+			break;
+		}
+	}
+	return size > 0 ? size : ret;
+}
+EXPORT_SYMBOL(acpi_aml_read_cmd);
+
+static int acpi_aml_thread(void *unsed)
+{
+	acpi_osd_exec_callback function = NULL;
+	void *context;
+
+	mutex_lock(&acpi_aml_io.lock);
+	if (acpi_aml_io.function) {
+		acpi_aml_io.usages++;
+		function = acpi_aml_io.function;
+		context = acpi_aml_io.context;
+	}
+	mutex_unlock(&acpi_aml_io.lock);
+
+	if (function)
+		function(context);
+
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.usages--;
+	if (!__acpi_aml_used()) {
+		acpi_aml_io.thread = NULL;
+		wake_up(&acpi_aml_io.wait);
+	}
+	mutex_unlock(&acpi_aml_io.lock);
+
+	return 0;
+}
+
+/*
+ * acpi_aml_create_thread() - Create AML debugger thread
+ * @function: the debugger thread callback
+ * @context: the context to be passed to the debugger thread
+ *
+ * This function should be used to implement acpi_os_execute() which is
+ * used by the ACPICA debugger to create the debugger thread.
+ */
+int acpi_aml_create_thread(acpi_osd_exec_callback function, void *context)
+{
+	struct task_struct *t;
+
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.function = function;
+	acpi_aml_io.context = context;
+	mutex_unlock(&acpi_aml_io.lock);
+
+	t = kthread_create(acpi_aml_thread, NULL, "aml");
+	if (IS_ERR(t)) {
+		pr_err("Failed to create AML debugger thread.\n");
+		return PTR_ERR(t);
+	}
+
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.thread = t;
+	acpi_set_debugger_thread_id((acpi_thread_id)(unsigned long)t);
+	wake_up_process(t);
+	mutex_unlock(&acpi_aml_io.lock);
+	return 0;
+}
+EXPORT_SYMBOL(acpi_aml_create_thread);
+
+int acpi_aml_wait_command_ready(void)
+{
+	acpi_status status;
+
+	if (!acpi_gbl_method_executing)
+		acpi_os_printf("\n%1c ", ACPI_DEBUGGER_COMMAND_PROMPT);
+	else
+		acpi_os_printf("\n%1c ", ACPI_DEBUGGER_EXECUTE_PROMPT);
+
+	status = acpi_os_get_line(acpi_gbl_db_line_buf,
+				  ACPI_DB_LINE_BUFFER_SIZE, NULL);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(acpi_aml_wait_command_ready);
+
+int acpi_aml_notify_command_complete(void)
+{
+	return 0;
+}
+EXPORT_SYMBOL(acpi_aml_notify_command_complete);
+
+static int acpi_aml_open(struct inode *inode, struct file *file)
+{
+	int ret = 0;
+	acpi_status status;
+
+	mutex_lock(&acpi_aml_io.lock);
+	/*
+	 * The debugger interface is being closed, no new user is allowed
+	 * during this period.
+	 */
+	if (acpi_aml_io.flags & ACPI_AML_CLOSED) {
+		ret = -EBUSY;
+		goto err_lock;
+	}
+	if ((file->f_flags & O_ACCMODE) != O_WRONLY) {
+		/*
+		 * Only one reader is allowed to initiate the debugger
+		 * thread.
+		 */
+		if (acpi_aml_active_reader) {
+			ret = -EBUSY;
+			goto err_lock;
+		} else {
+			pr_debug("Opening debugger reader.\n");
+			acpi_aml_active_reader = file;
+		}
+	} else {
+		/*
+		 * No writer is allowed unless the debugger thread is
+		 * ready.
+		 */
+		if (!(acpi_aml_io.flags & ACPI_AML_OPENED)) {
+			ret = -ENODEV;
+			goto err_lock;
+		}
+	}
+	if (acpi_aml_active_reader == file) {
+		pr_debug("Opening debugger interface.\n");
+		mutex_unlock(&acpi_aml_io.lock);
+
+		pr_debug("Initializing debugger thread.\n");
+		status = acpi_initialize_debugger();
+		if (ACPI_FAILURE(status)) {
+			pr_err("Failed to initialize debugger.\n");
+			ret = -EINVAL;
+			goto err_lock;
+		}
+		acpi_aml_io.flags |= ACPI_AML_OPENED;
+		pr_debug("Debugger thread initialized.\n");
+
+		mutex_lock(&acpi_aml_io.lock);
+		acpi_aml_io.out_crc.head = acpi_aml_io.out_crc.tail = 0;
+		acpi_aml_io.in_crc.head = acpi_aml_io.in_crc.tail = 0;
+		pr_debug("Debugger interface opened.\n");
+	}
+	acpi_aml_io.users++;
+err_lock:
+	if (IS_ERR_VALUE(ret)) {
+		if (acpi_aml_active_reader == file)
+			acpi_aml_active_reader = NULL;
+	}
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static int acpi_aml_release(struct inode *inode, struct file *file)
+{
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.users--;
+	if (file == acpi_aml_active_reader) {
+		pr_debug("Closing debugger reader.\n");
+		acpi_aml_active_reader = NULL;
+
+		pr_debug("Closing debugger interface.\n");
+		acpi_aml_io.flags |= ACPI_AML_CLOSED;
+
+		/*
+		 * Wake up all user space/kernel space blocked
+		 * readers/writers.
+		 */
+		wake_up_interruptible(&acpi_aml_io.wait);
+		mutex_unlock(&acpi_aml_io.lock);
+		/*
+		 * Wait all user space/kernel space readers/writers to
+		 * stop so that ACPICA command loop of the debugger thread
+		 * should fail all its command line reads after this point.
+		 */
+		wait_event(acpi_aml_io.wait, !acpi_aml_busy());
+
+		/*
+		 * Then we try to terminate the debugger thread if it is
+		 * not terminated.
+		 */
+		pr_debug("Terminating debugger thread.\n");
+		acpi_terminate_debugger();
+		wait_event(acpi_aml_io.wait, !acpi_aml_used());
+		pr_debug("Debugger thread terminated.\n");
+
+		mutex_lock(&acpi_aml_io.lock);
+		acpi_aml_io.flags &= ~ACPI_AML_OPENED;
+	}
+	if (acpi_aml_io.users == 0) {
+		pr_debug("Debugger interface closed.\n");
+		acpi_aml_io.flags &= ~ACPI_AML_CLOSED;
+	}
+	mutex_unlock(&acpi_aml_io.lock);
+	return 0;
+}
+
+static int acpi_aml_read_user(char __user *buf, int len)
+{
+	int ret;
+	struct circ_buf *crc = &acpi_aml_io.out_crc;
+	int n;
+	char *p;
+
+	ret = acpi_aml_lock_read(crc, ACPI_AML_OUT_USER);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+	/* sync head before removing logs */
+	smp_rmb();
+	p = &crc->buf[crc->tail];
+	n = min(len, circ_count_to_end(crc));
+	ret = copy_to_user(buf, p, n);
+	if (IS_ERR_VALUE(ret))
+		goto out;
+	/* sync tail after removing logs */
+	smp_mb();
+	crc->tail = (crc->tail + n) & (ACPI_AML_BUF_SIZE - 1);
+	ret = n;
+out:
+	acpi_aml_unlock_fifo(ACPI_AML_OUT_USER, !IS_ERR_VALUE(ret));
+	return ret;
+}
+
+static ssize_t acpi_aml_read(struct file *file, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	int ret = 0;
+	int size = 0;
+
+	if (!buf || count < 0)
+		return -EINVAL;
+	if (!count)
+		return 0;
+	if (!access_ok(VERIFY_WRITE, buf, count))
+		return -EFAULT;
+
+	while (count > 0) {
+again:
+		ret = acpi_aml_read_user(buf + size, count);
+		if (ret == -EAGAIN) {
+			if (file->f_flags & O_NONBLOCK)
+				break;
+			else {
+				ret = wait_event_interruptible(acpi_aml_io.wait,
+					acpi_aml_user_readable());
+				/*
+				 * We need to retry when the condition
+				 * becomes true.
+				 */
+				if (ret == 0)
+					goto again;
+			}
+		}
+		if (IS_ERR_VALUE(ret)) {
+			if (!acpi_aml_running())
+				ret = 0;
+			break;
+		}
+		if (ret) {
+			size += ret;
+			count -= ret;
+			*ppos += ret;
+			break;
+		}
+	}
+	return size > 0 ? size : ret;
+}
+
+static int acpi_aml_write_user(const char __user *buf, int len)
+{
+	int ret;
+	struct circ_buf *crc = &acpi_aml_io.in_crc;
+	int n;
+	char *p;
+
+	ret = acpi_aml_lock_write(crc, ACPI_AML_IN_USER);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+	/* sync tail before inserting cmds */
+	smp_mb();
+	p = &crc->buf[crc->head];
+	n = min(len, circ_space_to_end(crc));
+	ret = copy_from_user(p, buf, n);
+	if (IS_ERR_VALUE(ret))
+		goto out;
+	/* sync head after inserting cmds */
+	smp_wmb();
+	crc->head = (crc->head + n) & (ACPI_AML_BUF_SIZE - 1);
+	ret = n;
+out:
+	acpi_aml_unlock_fifo(ACPI_AML_IN_USER, !IS_ERR_VALUE(ret));
+	return n;
+}
+
+static ssize_t acpi_aml_write(struct file *file, const char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	int ret = 0;
+	int size = 0;
+
+	if (!buf || count < 0)
+		return -EINVAL;
+	if (!count)
+		return 0;
+	if (!access_ok(VERIFY_READ, buf, count))
+		return -EFAULT;
+
+	while (count > 0) {
+again:
+		ret = acpi_aml_write_user(buf + size, count);
+		if (ret == -EAGAIN) {
+			if (file->f_flags & O_NONBLOCK)
+				break;
+			else {
+				ret = wait_event_interruptible(acpi_aml_io.wait,
+					acpi_aml_user_writable());
+				/*
+				 * We need to retry when the condition
+				 * becomes true.
+				 */
+				if (ret == 0)
+					goto again;
+			}
+		}
+		if (IS_ERR_VALUE(ret)) {
+			if (!acpi_aml_running())
+				ret = 0;
+			break;
+		}
+		if (ret) {
+			size += ret;
+			count -= ret;
+			*ppos += ret;
+		}
+	}
+	return size > 0 ? size : ret;
+}
+
+static unsigned int acpi_aml_poll(struct file *file, poll_table *wait)
+{
+	int masks = 0;
+
+	poll_wait(file, &acpi_aml_io.wait, wait);
+	if (acpi_aml_user_readable())
+		masks |= POLLIN | POLLRDNORM;
+	if (acpi_aml_user_writable())
+		masks |= POLLOUT | POLLWRNORM;
+
+	return masks;
+}
+
+static const struct file_operations acpi_aml_operations = {
+	.read		= acpi_aml_read,
+	.write		= acpi_aml_write,
+	.poll		= acpi_aml_poll,
+	.open		= acpi_aml_open,
+	.release	= acpi_aml_release,
+	.llseek		= generic_file_llseek,
+};
+
+int __init acpi_aml_init(void)
+{
+	if (!acpi_debugfs_dir)
+		return -ENOENT;
+	/* Initialize AML IO interface */
+	mutex_init(&acpi_aml_io.lock);
+	init_waitqueue_head(&acpi_aml_io.wait);
+	acpi_aml_io.out_crc.buf = acpi_aml_io.out_buf;
+	acpi_aml_io.in_crc.buf = acpi_aml_io.in_buf;
+	acpi_aml_dentry = debugfs_create_file("acpidbg",
+					      S_IFREG | S_IRUGO | S_IWUSR,
+					      acpi_debugfs_dir, NULL,
+					      &acpi_aml_operations);
+	if (acpi_aml_dentry == NULL)
+		return -ENODEV;
+	acpi_aml_initialized = true;
+	return 0;
+}
+
+#if 0
+void __exit acpi_aml_exit(void)
+{
+	/* TODO: Stop the in kernel debugger */
+	if (acpi_aml_dentry)
+		debugfs_remove(acpi_aml_dentry);
+	acpi_aml_initialized = false;
+}
+
+module_init(acpi_aml_init);
+module_exit(acpi_aml_exit);
+#endif
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a212cef..06fbba9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -37,6 +37,7 @@
 #include <acpi/apei.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
+#include <linux/acpi_dbg.h>
 
 #include "internal.h"
 
@@ -1094,6 +1095,7 @@ static int __init acpi_init(void)
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
+	acpi_aml_init();
 	return 0;
 }
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3272915..2de8f66 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -40,6 +40,7 @@
 #include <linux/list.h>
 #include <linux/jiffies.h>
 #include <linux/semaphore.h>
+#include <linux/acpi_dbg.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -233,7 +234,8 @@ void acpi_os_vprintf(const char *fmt, va_list args)
 		printk(KERN_CONT "%s", buffer);
 	}
 #else
-	printk(KERN_CONT "%s", buffer);
+	if (acpi_aml_write_log(buffer) < 0)
+		printk(KERN_CONT "%s", buffer);
 #endif
 }
 
@@ -1124,6 +1126,15 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
 			  function, context));
 
+	if (type == OSL_DEBUGGER_MAIN_THREAD) {
+		ret = acpi_aml_create_thread(function, context);
+		if (ret) {
+			pr_err("Call to kthread_create() failed.\n");
+			status = AE_ERROR;
+		}
+		goto out_thread;
+	}
+
 	/*
 	 * Allocate/initialize DPC structure.  Note that this memory will be
 	 * freed by the callee.  The kernel handles the work_struct list  in a
@@ -1148,11 +1159,17 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	if (type == OSL_NOTIFY_HANDLER) {
 		queue = kacpi_notify_wq;
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
-	} else {
+	} else if (type == OSL_GPE_HANDLER) {
 		queue = kacpid_wq;
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+	} else {
+		pr_err("Unsupported os_execute type %d.\n", type);
+		status = AE_ERROR;
 	}
 
+	if (ACPI_FAILURE(status))
+		goto err_workqueue;
+
 	/*
 	 * On some machines, a software-initiated SMI causes corruption unless
 	 * the SMI runs on CPU 0.  An SMI can be initiated by any AML, but
@@ -1161,13 +1178,15 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	 * queueing on CPU 0.
 	 */
 	ret = queue_work_on(0, queue, &dpc->work);
-
 	if (!ret) {
 		printk(KERN_ERR PREFIX
 			  "Call to queue_work() failed.\n");
 		status = AE_ERROR;
-		kfree(dpc);
 	}
+err_workqueue:
+	if (ACPI_FAILURE(status))
+		kfree(dpc);
+out_thread:
 	return status;
 }
 EXPORT_SYMBOL(acpi_os_execute);
@@ -1355,11 +1374,39 @@ acpi_status acpi_os_get_line(char *buffer, u32 buffer_length, u32 *bytes_read)
 		chars = strlen(buffer) - 1;
 		buffer[chars] = '\0';
 	}
+#else
+	int ret;
+
+	ret = acpi_aml_read_cmd(buffer, buffer_length);
+	if (ret < 0)
+		return AE_ERROR;
+	if (bytes_read)
+		*bytes_read = ret;
 #endif
 
 	return AE_OK;
 }
 
+acpi_status acpi_os_wait_command_ready(void)
+{
+	int ret;
+
+	ret = acpi_aml_wait_command_ready();
+	if (ret < 0)
+		return AE_ERROR;
+	return AE_OK;
+}
+
+acpi_status acpi_os_notify_command_complete(void)
+{
+	int ret;
+
+	ret = acpi_aml_notify_command_complete();
+	if (ret < 0)
+		return AE_ERROR;
+	return AE_OK;
+}
+
 acpi_status acpi_os_signal(u32 function, void *info)
 {
 	switch (function) {
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 69dbae6..e21857d 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -152,8 +152,6 @@
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_writable
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_initialize_command_signals
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_terminate_command_signals
-#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_wait_command_ready
-#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_notify_command_complete
 
 /*
  * OSL interfaces used by utilities
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index 673fdf4..ceea026 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -138,16 +138,6 @@ static inline void acpi_os_terminate_command_signals(void)
 {
 }
 
-static inline acpi_status acpi_os_wait_command_ready(void)
-{
-	return AE_ERROR;
-}
-
-static inline acpi_status acpi_os_notify_command_complete(void)
-{
-	return AE_ERROR;
-}
-
 /*
  * OSL interfaces added by Linux
  */
diff --git a/include/linux/acpi_dbg.h b/include/linux/acpi_dbg.h
new file mode 100644
index 0000000..60f3887
--- /dev/null
+++ b/include/linux/acpi_dbg.h
@@ -0,0 +1,52 @@
+/*
+ * ACPI AML interfacing support
+ *
+ * Copyright (C) 2015, Intel Corporation
+ * Authors: Lv Zheng <lv.zheng@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_ACPI_DBG_H
+#define _LINUX_ACPI_DBG_H
+
+#include <linux/acpi.h>
+
+#ifdef CONFIG_ACPI_DEBUGGER
+int __init acpi_aml_init(void);
+int acpi_aml_create_thread(acpi_osd_exec_callback function, void *context);
+ssize_t acpi_aml_write_log(const char *msg);
+ssize_t acpi_aml_read_cmd(char *buffer, size_t buffer_length);
+int acpi_aml_wait_command_ready(void);
+int acpi_aml_notify_command_complete(void);
+#else
+static int inline acpi_aml_init(void)
+{
+	return 0;
+}
+static inline int acpi_aml_create_thread(acpi_osd_exec_callback function,
+					 void *context)
+{
+	return -ENODEV;
+}
+static inline int acpi_aml_write_log(const char *msg)
+{
+	return -ENODEV;
+}
+static inline int acpi_aml_read_cmd(char *buffer, u32 buffer_length)
+{
+	return -ENODEV;
+}
+static inline int acpi_aml_wait_command_ready(void)
+{
+	return -ENODEV;
+}
+static inline int acpi_aml_notify_command_complete(void)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* _LINUX_ACPI_DBG_H */
-- 
1.7.10
