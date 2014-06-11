From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 4/7 v2] RAS, debugfs: Add debugfs interface for RAS subsystem
Date: Wed, 11 Jun 2014 04:34:48 -0400
Message-ID: <1402475691-30045-5-git-send-email-gong.chen@linux.intel.com>
References: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28831 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933AbaFKJDm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jun 2014 05:03:42 -0400
In-Reply-To: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, rostedt@goodmis.org
Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

Implement a new debugfs interface for RAS susbsystem.
A file named daemon_active is added there accordingly.
This file is used to track if user space daemon enables
perf/trace interface or not. One can track which daemon
opens it via "lsof /path/to/debugfs/ras/daemon_active".

v2 -> v1: Change file access mode from 0444 to 0400.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/ras/Makefile  |  2 +-
 drivers/ras/debugfs.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ras/ras.c     | 14 +++++++++++++
 include/linux/ras.h   | 15 ++++++++++++++
 4 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ras/debugfs.c
 create mode 100644 include/linux/ras.h

diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 223e806..d7f7334 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_RAS) += ras.o
+obj-$(CONFIG_RAS) += ras.o debugfs.o
diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
new file mode 100644
index 0000000..d0bc389
--- /dev/null
+++ b/drivers/ras/debugfs.c
@@ -0,0 +1,57 @@
+#include <linux/debugfs.h>
+
+struct dentry *ras_debugfs_dir;
+EXPORT_SYMBOL_GPL(ras_debugfs_dir);
+
+static atomic_t trace_count = ATOMIC_INIT(0);
+
+int ras_userspace_consumers(void)
+{
+	return atomic_read(&trace_count);
+}
+EXPORT_SYMBOL_GPL(ras_userspace_consumers);
+
+static int trace_show(struct seq_file *m, void *v)
+{
+	return atomic_read(&trace_count);
+}
+
+static int trace_open(struct inode *inode, struct file *file)
+{
+	atomic_inc(&trace_count);
+	return single_open(file, trace_show, NULL);
+}
+
+static int trace_release(struct inode *inode, struct file *file)
+{
+	atomic_dec(&trace_count);
+	return single_release(inode, file);
+}
+
+static const struct file_operations trace_fops = {
+	.open    = trace_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = trace_release,
+};
+
+int __init ras_add_daemon_trace(void)
+{
+	struct dentry *fentry;
+
+	if (!ras_debugfs_dir)
+		return -ENOENT;
+
+	fentry = debugfs_create_file("daemon_active", S_IRUSR, ras_debugfs_dir,
+				     NULL, &trace_fops);
+	if (!fentry)
+		return -ENODEV;
+
+	return 0;
+
+}
+
+void __init ras_debugfs_init(void)
+{
+	ras_debugfs_dir = debugfs_create_dir("ras", NULL);
+}
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index b0c6ed1..4cac43a 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -5,8 +5,22 @@
  *	Chen, Gong <gong.chen@linux.intel.com>
  */
 
+#include <linux/init.h>
+#include <linux/ras.h>
+
 #define CREATE_TRACE_POINTS
 #define TRACE_INCLUDE_PATH ../../include/ras
 #include <ras/ras_event.h>
 
+static int __init ras_init(void)
+{
+	int rc = 0;
+
+	ras_debugfs_init();
+	rc = ras_add_daemon_trace();
+
+	return rc;
+}
+subsys_initcall(ras_init);
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
diff --git a/include/linux/ras.h b/include/linux/ras.h
new file mode 100644
index 0000000..af53248
--- /dev/null
+++ b/include/linux/ras.h
@@ -0,0 +1,15 @@
+#ifndef __RAS_H__
+#define __RAS_H__
+
+#ifdef CONFIG_DEBUG_FS
+extern struct dentry *ras_debugfs_dir;
+int ras_userspace_consumers(void);
+void ras_debugfs_init(void);
+int ras_add_daemon_trace(void);
+#else
+static inline int ras_userspace_consumers(void) { return 0; }
+static inline void ras_debugfs_init(void) { return; }
+static inline int ras_add_daemon_trace(void) { return 0; }
+#endif
+
+#endif
-- 
2.0.0.rc2

