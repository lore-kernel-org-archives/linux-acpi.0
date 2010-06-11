From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/5] ACPI: remove ACPI debugfs out of drivers/acpi/debug.c
Date: Fri, 11 Jun 2010 13:47:52 +0800
Message-ID: <1276235272.19052.15871.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:54017 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab0FKFr3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jun 2010 01:47:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


ACPI debugfs I/F should not depend on CONFIG_ACPI_DEBUG.
Introduce driver/acpi/debugfs.c for ACPI debugfs I/F.

No function change in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Makefile   |    1 
 drivers/acpi/bus.c      |    1 
 drivers/acpi/debug.c    |   75 ---------------------------------------------
 drivers/acpi/debugfs.c  |   80 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h |    1 
 5 files changed, 83 insertions(+), 75 deletions(-)

Index: linux-2.6/drivers/acpi/debugfs.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/acpi/debugfs.c
@@ -0,0 +1,80 @@
+/*
+ * debugfs.c - ACPI debugfs interface to userspace.
+ */
+
+#include <linux/module.h>
+#include <linux/debugfs.h>
+#include <acpi/acpi_drivers.h>
+
+#define _COMPONENT		ACPI_SYSTEM_COMPONENT
+ACPI_MODULE_NAME("debugfs");
+
+static ssize_t cm_write(struct file *file, const char __user *user_buf,
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
+			sizeof(struct acpi_table_header)))
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
Index: linux-2.6/drivers/acpi/Makefile
===================================================================
--- linux-2.6.orig/drivers/acpi/Makefile
+++ linux-2.6/drivers/acpi/Makefile
@@ -38,6 +38,7 @@ acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
 acpi-y				+= power.o
 acpi-y				+= system.o event.o
+acpi-y				+= debugfs.o
 acpi-$(CONFIG_ACPI_DEBUG)	+= debug.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -1035,6 +1035,7 @@ static int __init acpi_init(void)
 	acpi_ec_init();
 	acpi_power_init();
 	acpi_system_init();
+	acpi_debugfs_init();
 	acpi_debug_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
Index: linux-2.6/drivers/acpi/internal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/internal.h
+++ linux-2.6/drivers/acpi/internal.h
@@ -23,6 +23,7 @@
 int init_acpi_device_notify(void);
 int acpi_scan_init(void);
 int acpi_system_init(void);
+int acpi_debugfs_init(void);
 
 #ifdef CONFIG_ACPI_DEBUG
 int acpi_debug_init(void);
Index: linux-2.6/drivers/acpi/debug.c
===================================================================
--- linux-2.6.orig/drivers/acpi/debug.c
+++ linux-2.6/drivers/acpi/debug.c
@@ -198,80 +198,6 @@ module_param_call(trace_state, param_set
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


