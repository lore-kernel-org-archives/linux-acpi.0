From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/3] [-mm]: ACPI: add ACPICA version in sysfs
Date: Mon, 29 Jan 2007 11:02:42 +0800
Message-ID: <1170039762.6907.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32360 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933117AbXA2DCI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Jan 2007 22:02:08 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

From: Zhang Rui <rui.zhang@intel.com>

Add an ACPI attribute to indicate ACPICA version.
/proc/acpi/version is deprecated by /sys/module/acpi/parameters/acpica_version.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig  |    4 +++-
 drivers/acpi/system.c |   24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

Index: linux-2.6.20-rc4-mm1/drivers/acpi/system.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/acpi/system.c	2007-01-29 09:24:06.000000000 +0800
+++ linux-2.6.20-rc4-mm1/drivers/acpi/system.c	2007-01-29 11:00:21.000000000 +0800
@@ -32,6 +32,11 @@
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("acpi_system")
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "acpi."
+
 #define ACPI_SYSTEM_CLASS		"system"
 #define ACPI_SYSTEM_DRIVER_NAME		"ACPI System Driver"
 #define ACPI_SYSTEM_DEVICE_NAME		"System"
@@ -41,9 +46,23 @@ ACPI_MODULE_NAME("acpi_system")
 #define ACPI_SYSTEM_FILE_FADT		"fadt"
 extern struct fadt_descriptor acpi_fadt;
 
+/*
+ * Make ACPICA version work as module param
+ */
+static int param_get_acpica_version(char *buffer, struct kernel_param *kp) {
+	int result;
+
+	result = sprintf(buffer, "%x", ACPI_CA_VERSION);
+
+	return result;
+}
+
+module_param_call(acpica_version, NULL, param_get_acpica_version, NULL, 0444);
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
+#ifdef CONFIG_ACPI_PROCFS
 
 static int acpi_system_read_info(struct seq_file *seq, void *offset)
 {
@@ -63,6 +82,7 @@ static const struct file_operations acpi
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif
 
 static ssize_t acpi_system_read_dsdt(struct file *, char __user *, size_t,
 				     loff_t *);
@@ -128,6 +148,7 @@ static int __init acpi_system_init(void)
 	if (acpi_disabled)
 		return 0;
 
+#ifdef CONFIG_ACPI_PROCFS
 	/* 'info' [R] */
 	name = ACPI_SYSTEM_FILE_INFO;
 	entry = create_proc_entry(name, S_IRUGO, acpi_root_dir);
@@ -136,6 +157,7 @@ static int __init acpi_system_init(void)
 	else {
 		entry->proc_fops = &acpi_system_info_ops;
 	}
+#endif
 
 	/* 'dsdt' [R] */
 	name = ACPI_SYSTEM_FILE_DSDT;
@@ -159,7 +181,9 @@ static int __init acpi_system_init(void)
       Error:
 	remove_proc_entry(ACPI_SYSTEM_FILE_FADT, acpi_root_dir);
 	remove_proc_entry(ACPI_SYSTEM_FILE_DSDT, acpi_root_dir);
+#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_SYSTEM_FILE_INFO, acpi_root_dir);
+#endif
 
 	error = -EFAULT;
 	goto Done;
Index: linux-2.6.20-rc4-mm1/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/acpi/Kconfig	2007-01-29 09:27:11.000000000 +0800
+++ linux-2.6.20-rc4-mm1/drivers/acpi/Kconfig	2007-01-29 09:27:13.000000000 +0800
@@ -87,7 +87,9 @@ config ACPI_PROCFS
 	  and this proc interface will be removed some time later,
 	  it's marked as deprecated.
 	  ( /proc/acpi/debug_layer && debug_level are deprecated by
-	    /sys/module/acpi/parameters/debug_layer && debug_level. )
+	    /sys/module/acpi/parameters/debug_layer && debug_level.
+	    /proc/acpi/info is deprecated by
+	    /sys/module/acpi/parameters/acpica_version )
 
 config ACPI_AC
 	tristate "AC Adapter"
