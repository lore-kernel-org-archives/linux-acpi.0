From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/20] ACPI: introduce drivers/acpi/debugfs.c
Date: Sun, 15 Aug 2010 01:23:16 -0400
Message-ID: <a25ee9200eef07377e1703697afbb5d81f89e500.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:57561 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab0HOFaI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:30:08 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600HN2HY5RHB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:30:08 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Introduce drivers/acpi/debugfs.c.

Code for ACPI debugfs I/F,
i.e. /sys/kernel/debug/acpi/custom_method,
is moved to this file.

And make ACPI debugfs always built in,
even if CONFIG_ACPI_DEBUG is cleared.

BTW:this adds about 400bytes code to ACPI, when
CONFIG_ACPI_DEBUG is cleared.

[uaccess.h build fix from Andrew Morton <akpm@linux-foundation.org>]

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Makefile   |    1 +
 drivers/acpi/bus.c      |    1 +
 drivers/acpi/debug.c    |   75 -----------------------------------------
 drivers/acpi/debugfs.c  |   85 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h |    6 +++
 5 files changed, 93 insertions(+), 75 deletions(-)
 create mode 100644 drivers/acpi/debugfs.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 6ee3316..7891904 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -39,6 +39,7 @@ acpi-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
 acpi-y				+= power.o
 acpi-y				+= system.o event.o
 acpi-$(CONFIG_ACPI_DEBUG)	+= debug.o
+acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 ifdef CONFIG_ACPI_VIDEO
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c1d23cd..7136f24 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1036,6 +1036,7 @@ static int __init acpi_init(void)
 	acpi_power_init();
 	acpi_system_init();
 	acpi_debug_init();
+	acpi_debugfs_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
 	return result;
diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
index 146135e..22476ea 100644
--- a/drivers/acpi/debug.c
+++ b/drivers/acpi/debug.c
@@ -198,80 +198,6 @@ module_param_call(trace_state, param_set_trace_state, param_get_trace_state,
 		  NULL, 0644);
 
 /* --------------------------------------------------------------------------
-				DebugFS Interface
-   -------------------------------------------------------------------------- */
-
-static ssize_t cm_write(struct file *file, const char __user *user_buf,
-			size_t count, loff_t *ppos)
-{
-	static char *buf;
-	static int uncopied_bytes;
-	struct acpi_table_header table;
-	acpi_status status;
-
-	if (!(*ppos)) {
-		/* parse the table header to get the table length */
-		if (count <= sizeof(struct acpi_table_header))
-			return -EINVAL;
-		if (copy_from_user(&table, user_buf,
-			sizeof(struct acpi_table_header)))
-			return -EFAULT;
-		uncopied_bytes = table.length;
-		buf = kzalloc(uncopied_bytes, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-	}
-
-	if (uncopied_bytes < count) {
-		kfree(buf);
-		return -EINVAL;
-	}
-
-	if (copy_from_user(buf + (*ppos), user_buf, count)) {
-		kfree(buf);
-		return -EFAULT;
-	}
-
-	uncopied_bytes -= count;
-	*ppos += count;
-
-	if (!uncopied_bytes) {
-		status = acpi_install_method(buf);
-		kfree(buf);
-		if (ACPI_FAILURE(status))
-			return -EINVAL;
-		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);
-	}
-
-	return count;
-}
-
-static const struct file_operations cm_fops = {
-	.write = cm_write,
-};
-
-static int acpi_debugfs_init(void)
-{
-	struct dentry *acpi_dir, *cm_dentry;
-
-	acpi_dir = debugfs_create_dir("acpi", NULL);
-	if (!acpi_dir)
-		goto err;
-
-	cm_dentry = debugfs_create_file("custom_method", S_IWUGO,
-					acpi_dir, NULL, &cm_fops);
-	if (!cm_dentry)
-		goto err;
-
-	return 0;
-
-err:
-	if (acpi_dir)
-		debugfs_remove(acpi_dir);
-	return -EINVAL;
-}
-
-/* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_PROCFS
@@ -400,7 +326,6 @@ int __init acpi_procfs_init(void)
 
 int __init acpi_debug_init(void)
 {
-	acpi_debugfs_init();
 	acpi_procfs_init();
 	return 0;
 }
diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
new file mode 100644
index 0000000..abfcf9f
--- /dev/null
+++ b/drivers/acpi/debugfs.c
@@ -0,0 +1,85 @@
+/*
+ * debugfs.c - ACPI debugfs interface to userspace.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/debugfs.h>
+#include <acpi/acpi_drivers.h>
+
+#define _COMPONENT		ACPI_SYSTEM_COMPONENT
+ACPI_MODULE_NAME("debugfs");
+
+/* /sys/kernel/debug/acpi/custom_method */
+
+static ssize_t cm_write(struct file *file, const char __user * user_buf,
+			size_t count, loff_t *ppos)
+{
+	static char *buf;
+	static int uncopied_bytes;
+	struct acpi_table_header table;
+	acpi_status status;
+
+	if (!(*ppos)) {
+		/* parse the table header to get the table length */
+		if (count <= sizeof(struct acpi_table_header))
+			return -EINVAL;
+		if (copy_from_user(&table, user_buf,
+				   sizeof(struct acpi_table_header)))
+			return -EFAULT;
+		uncopied_bytes = table.length;
+		buf = kzalloc(uncopied_bytes, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+	}
+
+	if (uncopied_bytes < count) {
+		kfree(buf);
+		return -EINVAL;
+	}
+
+	if (copy_from_user(buf + (*ppos), user_buf, count)) {
+		kfree(buf);
+		return -EFAULT;
+	}
+
+	uncopied_bytes -= count;
+	*ppos += count;
+
+	if (!uncopied_bytes) {
+		status = acpi_install_method(buf);
+		kfree(buf);
+		if (ACPI_FAILURE(status))
+			return -EINVAL;
+		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);
+	}
+
+	return count;
+}
+
+static const struct file_operations cm_fops = {
+	.write = cm_write,
+};
+
+int __init acpi_debugfs_init(void)
+{
+	struct dentry *acpi_dir, *cm_dentry;
+
+	acpi_dir = debugfs_create_dir("acpi", NULL);
+	if (!acpi_dir)
+		goto err;
+
+	cm_dentry = debugfs_create_file("custom_method", S_IWUGO,
+					acpi_dir, NULL, &cm_fops);
+	if (!cm_dentry)
+		goto err;
+
+	return 0;
+
+err:
+	if (acpi_dir)
+		debugfs_remove(acpi_dir);
+	return -EINVAL;
+}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index f8f190e..0650e34 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -30,6 +30,12 @@ int acpi_debug_init(void);
 static inline int acpi_debug_init(void) { return 0; }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+int acpi_debugfs_init(void);
+#else
+static inline int acpi_debugfs_init(void) { return 0; }
+#endif
+
 /* --------------------------------------------------------------------------
                                   Power Resource
    -------------------------------------------------------------------------- */
-- 
1.7.2.1.95.g3d045

