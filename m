From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/2] ACPI / debugger: Add kernel flushing support
Date: Tue, 19 Jul 2016 18:00:39 +0800
Message-ID: <97e2430e92d486c7ca46aa8e0e602600317d5e7b.1468922310.git.lv.zheng@intel.com>
References: <cover.1468464391.git.lv.zheng@intel.com> <cover.1468922310.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1468922310.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch adds debugger log flushing support in kernel via .ioctl()
callback. The in-kernel flushing is more efficient, because it reduces
useless log IOs by bypassing log user_read/kern_write during the flush
period.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpi_dbg.c     |   98 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/acpi-ioctls.h |   21 ++++++++++
 2 files changed, 115 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/acpi-ioctls.h

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index dee8692..6ac1388 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -22,6 +22,7 @@
 #include <linux/debugfs.h>
 #include <linux/circ_buf.h>
 #include <linux/acpi.h>
+#include <linux/acpi-ioctls.h>
 #include "internal.h"
 
 #define ACPI_AML_BUF_ALIGN	(sizeof (acpi_size))
@@ -46,6 +47,8 @@
 #define ACPI_AML_KERN		(ACPI_AML_IN_KERN | ACPI_AML_OUT_KERN)
 #define ACPI_AML_BUSY		(ACPI_AML_USER | ACPI_AML_KERN)
 #define ACPI_AML_OPEN		(ACPI_AML_OPENED | ACPI_AML_CLOSED)
+#define ACPI_AML_FLUSHING_LOG	0x0040 /* flushing log output */
+#define ACPI_AML_WAITING_CMD	0x0080 /* waiting for cmd input */
 
 struct acpi_aml_io {
 	wait_queue_head_t wait;
@@ -120,6 +123,20 @@ static inline bool __acpi_aml_busy(void)
 	return false;
 }
 
+static inline bool __acpi_aml_waiting_cmd(void)
+{
+	if (acpi_aml_io.flags & ACPI_AML_WAITING_CMD)
+		return true;
+	return false;
+}
+
+static inline bool __acpi_aml_flushing_log(void)
+{
+	if (acpi_aml_io.flags & ACPI_AML_FLUSHING_LOG)
+		return true;
+	return false;
+}
+
 static inline bool __acpi_aml_opened(void)
 {
 	if (acpi_aml_io.flags & ACPI_AML_OPEN)
@@ -152,6 +169,26 @@ static bool acpi_aml_busy(void)
 	return ret;
 }
 
+static inline bool acpi_aml_waiting_cmd(void)
+{
+	bool ret;
+
+	mutex_lock(&acpi_aml_io.lock);
+	ret = __acpi_aml_waiting_cmd();
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static inline bool acpi_aml_flushing_log(void)
+{
+	bool ret;
+
+	mutex_lock(&acpi_aml_io.lock);
+	ret = __acpi_aml_flushing_log();
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
 static bool acpi_aml_used(void)
 {
 	bool ret;
@@ -183,7 +220,8 @@ static bool acpi_aml_kern_writable(void)
 
 	mutex_lock(&acpi_aml_io.lock);
 	ret = !__acpi_aml_access_ok(ACPI_AML_OUT_KERN) ||
-	      __acpi_aml_writable(&acpi_aml_io.out_crc, ACPI_AML_OUT_KERN);
+	      __acpi_aml_writable(&acpi_aml_io.out_crc, ACPI_AML_OUT_KERN) ||
+	      __acpi_aml_flushing_log();
 	mutex_unlock(&acpi_aml_io.lock);
 	return ret;
 }
@@ -264,6 +302,9 @@ static int acpi_aml_write_kern(const char *buf, int len)
 	int n;
 	char *p;
 
+	if (acpi_aml_flushing_log())
+		return len;
+
 	ret = acpi_aml_lock_write(crc, ACPI_AML_OUT_KERN);
 	if (ret < 0)
 		return ret;
@@ -458,9 +499,18 @@ static int acpi_aml_wait_command_ready(bool single_step,
 	else
 		acpi_os_printf("\n%1c ", ACPI_DEBUGGER_COMMAND_PROMPT);
 
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.flags |= ACPI_AML_WAITING_CMD;
+	wake_up_interruptible(&acpi_aml_io.wait);
+	mutex_unlock(&acpi_aml_io.lock);
+
 	status = acpi_os_get_line(buffer, length, NULL);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
+
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.flags &= ~ACPI_AML_WAITING_CMD;
+	mutex_unlock(&acpi_aml_io.lock);
 	return 0;
 }
 
@@ -593,9 +643,11 @@ static int acpi_aml_read_user(char __user *buf, int len)
 	smp_rmb();
 	p = &crc->buf[crc->tail];
 	n = min(len, circ_count_to_end(crc));
-	if (copy_to_user(buf, p, n)) {
-		ret = -EFAULT;
-		goto out;
+	if (!acpi_aml_flushing_log()) {
+		if (copy_to_user(buf, p, n)) {
+			ret = -EFAULT;
+			goto out;
+		}
 	}
 	/* sync tail after removing logs */
 	smp_mb();
@@ -731,10 +783,48 @@ static unsigned int acpi_aml_poll(struct file *file, poll_table *wait)
 	return masks;
 }
 
+static int acpi_aml_flush(void)
+{
+	int ret;
+
+	/*
+	 * Discard output buffer and put the driver into a state waiting
+	 * for the new user input.
+	 */
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.flags |= ACPI_AML_FLUSHING_LOG;
+	mutex_unlock(&acpi_aml_io.lock);
+
+	ret = wait_event_interruptible(acpi_aml_io.wait,
+		acpi_aml_waiting_cmd());
+	(void)acpi_aml_read_user(NULL, ACPI_AML_BUF_SIZE);
+
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.flags &= ~ACPI_AML_FLUSHING_LOG;
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static long acpi_aml_ioctl(struct file *file,
+			   unsigned int cmd, unsigned long arg)
+{
+	long ret = -EINVAL;
+
+	switch (cmd) {
+	case ACPI_IOCTL_DEBUGGER_FLUSH:
+		ret = acpi_aml_flush();
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
 static const struct file_operations acpi_aml_operations = {
 	.read		= acpi_aml_read,
 	.write		= acpi_aml_write,
 	.poll		= acpi_aml_poll,
+	.unlocked_ioctl	= acpi_aml_ioctl,
 	.open		= acpi_aml_open,
 	.release	= acpi_aml_release,
 	.llseek		= generic_file_llseek,
diff --git a/include/linux/acpi-ioctls.h b/include/linux/acpi-ioctls.h
new file mode 100644
index 0000000..56b8170
--- /dev/null
+++ b/include/linux/acpi-ioctls.h
@@ -0,0 +1,21 @@
+/*
+ * ACPI IOCTL collections
+ *
+ * Copyright (C) 2016, Intel Corporation
+ * Authors: Lv Zheng <lv.zheng@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_ACPI_IOCTLS_H
+#define _LINUX_ACPI_IOCTLS_H
+
+#include <linux/ioctl.h>
+
+#define ACPI_IOCTL_IDENT		'a'
+
+#define ACPI_IOCTL_DEBUGGER_FLUSH	_IO(ACPI_IOCTL_IDENT, 0x80)
+
+#endif /* _LINUX_ACPI_IOCTLS_H */
-- 
1.7.10
