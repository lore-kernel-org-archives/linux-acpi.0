From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/18] ACPI: Split out custom_method functionality into an own
 driver
Date: Sun, 29 May 2011 05:44:10 -0400
Message-ID: <526b4af47f44148c9d665e57723ed9f86634c6e3.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:55532 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab1E2J55 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:57:57 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY0094DBOGA0E2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:57:56 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

With /sys/kernel/debug/acpi/custom_method root can write
to arbitrary memory and increase his priveleges, even if
these are restricted.

-> Make this an own debug .config option and warn about the
security issue in the config description.

-> Still keep acpi/debugfs.c which now only creates an empty
   /sys/kernel/debug/acpi directory. There might be other
   users of it later.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: rui.zhang@intel.com
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/acpi/method-customizing.txt   |    5 +
 drivers/acpi/Kconfig                        |   15 ++++
 drivers/acpi/Makefile                       |    1 +
 drivers/acpi/{debugfs.c => custom_method.c} |   20 +++--
 drivers/acpi/debugfs.c                      |  114 ++++----------------------
 5 files changed, 51 insertions(+), 104 deletions(-)
 rename drivers/acpi/{debugfs.c => custom_method.c} (85%)
 rewrite drivers/acpi/debugfs.c (82%)

diff --git a/Documentation/acpi/method-customizing.txt b/Documentation/acpi/method-customizing.txt
index 3e1d25a..5f55373 100644
--- a/Documentation/acpi/method-customizing.txt
+++ b/Documentation/acpi/method-customizing.txt
@@ -66,3 +66,8 @@ Note: We can use a kernel with multiple custom ACPI method running,
       But each individual write to debugfs can implement a SINGLE
       method override. i.e. if we want to insert/override multiple
       ACPI methods, we need to redo step c) ~ g) for multiple times.
+
+Note: Be aware that root can mis-use this driver to modify arbitrary
+      memory and gain additional rights, if root's privileges got
+      restricted (for example if root is not allowed to load additional
+      modules after boot).
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 3a17ca5..d918e13 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -380,6 +380,21 @@ config ACPI_HED
 	  which is used to report some hardware errors notified via
 	  SCI, mainly the corrected errors.
 
+config ACPI_CUSTOM_METHOD
+	tristate "Allow ACPI methods to be inserted/replaced at run time"
+	depends on DEBUG_FS
+	default n
+	help
+	  This debug facility allows ACPI AML methods to me inserted and/or
+	  replaced without rebooting the system. For details refer to:
+	  Documentation/acpi/method-customizing.txt.
+
+	  NOTE: This option is security sensitive, because it allows arbitrary
+	  kernel memory to be written to by root (uid=0) users, allowing them
+	  to bypass certain security measures (e.g. if root is not allowed to
+	  load additional kernel modules after boot, this feature may be used
+	  to override that restriction).
+
 source "drivers/acpi/apei/Kconfig"
 
 endif	# ACPI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d113fa5..cba0b23 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_ACPI_SBS)		+= sbs.o
 obj-$(CONFIG_ACPI_POWER_METER)	+= power_meter.o
 obj-$(CONFIG_ACPI_HED)		+= hed.o
 obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
+obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o processor_throttling.o
diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/custom_method.c
similarity index 85%
rename from drivers/acpi/debugfs.c
rename to drivers/acpi/custom_method.c
index e7abc6e..5d42c24 100644
--- a/drivers/acpi/debugfs.c
+++ b/drivers/acpi/custom_method.c
@@ -9,10 +9,12 @@
 #include <linux/debugfs.h>
 #include <acpi/acpi_drivers.h>
 
+#include "internal.h"
+
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("debugfs");
+ACPI_MODULE_NAME("custom_method");
+MODULE_LICENSE("GPL");
 
-struct dentry *acpi_debugfs_dir;
 static struct dentry *cm_dentry;
 
 /* /sys/kernel/debug/acpi/custom_method */
@@ -77,20 +79,22 @@ static const struct file_operations cm_fops = {
 
 static int __init acpi_custom_method_init(void)
 {
-	if (!acpi_debugfs_dir)
+	if (acpi_debugfs_dir == NULL)
 		return -ENOENT;
 
 	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
 					acpi_debugfs_dir, NULL, &cm_fops);
-	if (!cm_dentry)
+	if (cm_dentry == NULL)
 		return -ENODEV;
 
 	return 0;
 }
 
-void __init acpi_debugfs_init(void)
+static void __exit acpi_custom_method_exit(void)
 {
-	acpi_debugfs_dir = debugfs_create_dir("acpi", NULL);
+	if (cm_dentry)
+		debugfs_remove(cm_dentry);
+ }
 
-	acpi_custom_method_init();
-}
+module_init(acpi_custom_method_init);
+module_exit(acpi_custom_method_exit);
diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
dissimilarity index 82%
index e7abc6e..182a9fc 100644
--- a/drivers/acpi/debugfs.c
+++ b/drivers/acpi/debugfs.c
@@ -1,96 +1,18 @@
-/*
- * debugfs.c - ACPI debugfs interface to userspace.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/uaccess.h>
-#include <linux/debugfs.h>
-#include <acpi/acpi_drivers.h>
-
-#define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("debugfs");
-
-struct dentry *acpi_debugfs_dir;
-static struct dentry *cm_dentry;
-
-/* /sys/kernel/debug/acpi/custom_method */
-
-static ssize_t cm_write(struct file *file, const char __user * user_buf,
-			size_t count, loff_t *ppos)
-{
-	static char *buf;
-	static u32 max_size;
-	static u32 uncopied_bytes;
-
-	struct acpi_table_header table;
-	acpi_status status;
-
-	if (!(*ppos)) {
-		/* parse the table header to get the table length */
-		if (count <= sizeof(struct acpi_table_header))
-			return -EINVAL;
-		if (copy_from_user(&table, user_buf,
-				   sizeof(struct acpi_table_header)))
-			return -EFAULT;
-		uncopied_bytes = max_size = table.length;
-		buf = kzalloc(max_size, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-	}
-
-	if (buf == NULL)
-		return -EINVAL;
-
-	if ((*ppos > max_size) ||
-	    (*ppos + count > max_size) ||
-	    (*ppos + count < count) ||
-	    (count > uncopied_bytes))
-		return -EINVAL;
-
-	if (copy_from_user(buf + (*ppos), user_buf, count)) {
-		kfree(buf);
-		buf = NULL;
-		return -EFAULT;
-	}
-
-	uncopied_bytes -= count;
-	*ppos += count;
-
-	if (!uncopied_bytes) {
-		status = acpi_install_method(buf);
-		kfree(buf);
-		buf = NULL;
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
-	.llseek = default_llseek,
-};
-
-static int __init acpi_custom_method_init(void)
-{
-	if (!acpi_debugfs_dir)
-		return -ENOENT;
-
-	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
-					acpi_debugfs_dir, NULL, &cm_fops);
-	if (!cm_dentry)
-		return -ENODEV;
-
-	return 0;
-}
-
-void __init acpi_debugfs_init(void)
-{
-	acpi_debugfs_dir = debugfs_create_dir("acpi", NULL);
-
-	acpi_custom_method_init();
-}
+/*
+ * debugfs.c - ACPI debugfs interface to userspace.
+ */
+
+#include <linux/init.h>
+#include <linux/debugfs.h>
+#include <acpi/acpi_drivers.h>
+
+#define _COMPONENT		ACPI_SYSTEM_COMPONENT
+ACPI_MODULE_NAME("debugfs");
+
+struct dentry *acpi_debugfs_dir;
+EXPORT_SYMBOL_GPL(acpi_debugfs_dir);
+
+void __init acpi_debugfs_init(void)
+{
+	acpi_debugfs_dir = debugfs_create_dir("acpi", NULL);
+}
-- 
1.7.5.3.367.ga9930.dirty

