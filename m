From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/3] [-mm]: ACPI: add ACPICA version in sysfs
Date: Sun, 21 Jan 2007 13:50:04 +0800
Message-ID: <1169358604.5691.7.camel@localhost.localdomain>
References: <1168083333.5619.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19853 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbXAUFtW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jan 2007 00:49:22 -0500
In-Reply-To: <1168083333.5619.40.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

From: Zhang Rui <rui.zhang@intel.com>

Add an ACPI attribute to indicate ACPICA version.
/proc/acpi/version is deprecated by /sys/firmware/acpi/info.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig    |    3 ++-
 drivers/acpi/system.c   |   43 +++++++++++++++++++++++++++++++++++++------
 include/acpi/acpi_bus.h |    7 +++++++
 3 files changed, 46 insertions(+), 7 deletions(-)

Index: linux-2.6.20-rc4-mm1/drivers/acpi/system.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/acpi/system.c	2007-01-21 12:58:31.000000000 +0800
+++ linux-2.6.20-rc4-mm1/drivers/acpi/system.c	2007-01-21 13:03:44.000000000 +0800
@@ -29,6 +29,7 @@
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_drivers.h>
+#include <acpi/acpi_bus.h>
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("acpi_system")
@@ -42,8 +43,24 @@ ACPI_MODULE_NAME("acpi_system")
 extern struct fadt_descriptor acpi_fadt;
 
 /* --------------------------------------------------------------------------
+                              FS Interface (/sys)
+   -------------------------------------------------------------------------- */
+extern struct subsystem acpi_subsys;
+
+static ssize_t version_show(struct subsystem *subsys, char *buf)
+{
+	return 	sprintf(buf, "%x\n", ACPI_CA_VERSION);
+}
+acpi_ro_attr(version);
+
+static int acpi_system_info_add_sysfs(void)
+{
+	return sysfs_create_file(&acpi_subsys.kset.kobj, &version_attr.attr);
+}
+/* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
+#ifdef CONFIG_ACPI_PROCFS
 
 static int acpi_system_read_info(struct seq_file *seq, void *offset)
 {
@@ -63,6 +80,7 @@ static const struct file_operations acpi
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif
 
 static ssize_t acpi_system_read_dsdt(struct file *, char __user *, size_t,
 				     loff_t *);
@@ -118,16 +136,13 @@ acpi_system_read_fadt(struct file *file,
 	return res;
 }
 
-static int __init acpi_system_init(void)
+static int  acpi_system_procfs_init(void)
 {
 	struct proc_dir_entry *entry;
 	int error = 0;
 	char *name;
 
-
-	if (acpi_disabled)
-		return 0;
-
+#ifdef CONFIG_ACPI_PROCFS
 	/* 'info' [R] */
 	name = ACPI_SYSTEM_FILE_INFO;
 	entry = create_proc_entry(name, S_IRUGO, acpi_root_dir);
@@ -136,6 +151,7 @@ static int __init acpi_system_init(void)
 	else {
 		entry->proc_fops = &acpi_system_info_ops;
 	}
+#endif
 
 	/* 'dsdt' [R] */
 	name = ACPI_SYSTEM_FILE_DSDT;
@@ -159,10 +175,25 @@ static int __init acpi_system_init(void)
       Error:
 	remove_proc_entry(ACPI_SYSTEM_FILE_FADT, acpi_root_dir);
 	remove_proc_entry(ACPI_SYSTEM_FILE_DSDT, acpi_root_dir);
+#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_SYSTEM_FILE_INFO, acpi_root_dir);
-
+#endif
 	error = -EFAULT;
 	goto Done;
 }
 
+static int __init acpi_system_init(void) {
+	int result;
+
+	if (acpi_disabled)
+		return 0;
+
+	result = acpi_system_info_add_sysfs();
+	if (result)
+		return result;
+
+	result = acpi_system_procfs_init();
+
+	return result;
+}
 subsys_initcall(acpi_system_init);
Index: linux-2.6.20-rc4-mm1/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/acpi/Kconfig	2007-01-21 12:58:31.000000000 +0800
+++ linux-2.6.20-rc4-mm1/drivers/acpi/Kconfig	2007-01-21 13:02:23.000000000 +0800
@@ -87,7 +87,8 @@ config ACPI_PROCFS
 	  and this proc interface will be removed some time later,
 	  it's marked as deprecated.
 	  ( /proc/acpi/debug_layer && debug_level are deprecated by
-	    /sys/module/acpi/parameters/debug_layer && debug_level. )
+	    /sys/module/acpi/parameters/debug_layer && debug_level.
+	    /proc/acpi/info is deprecated by /sys/firmware/acpi/version )
 
 config ACPI_AC
 	tristate "AC Adapter"
Index: linux-2.6.20-rc4-mm1/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.20-rc4-mm1.orig/include/acpi/acpi_bus.h	2007-01-21 12:58:31.000000000 +0800
+++ linux-2.6.20-rc4-mm1/include/acpi/acpi_bus.h	2007-01-21 13:04:34.000000000 +0800
@@ -320,6 +320,13 @@ struct acpi_bus_event {
 extern struct subsystem acpi_subsys;
 
 /*
+ * This is for ACPI read only data
+ * Like ACPICA version, ACPI tables, etc.
+ */
+#define acpi_ro_attr(_name)	\
+static struct subsys_attribute _name##_attr = __ATTR_RO(_name)
+
+/*
  * External Functions
  */
 
