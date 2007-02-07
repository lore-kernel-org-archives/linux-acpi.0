From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/140] ACPI: add ACPICA version in sysfs
Date: Wed,  7 Feb 2007 13:50:43 -0500
Message-ID: <11708744142658-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:45778 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422749AbXBGSxi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:38 -0500
In-Reply-To: <1170874412494-git-send-email-lenb@kernel.org>
Message-Id: <5bb730fda8aa4e3f7e94b259c468ecd095f60770.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Add an ACPI attribute to indicate ACPICA version.
/proc/acpi/version is deprecated by /sys/module/acpi/parameters/acpica_version.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig  |    4 +++-
 drivers/acpi/system.c |   24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a3a1073..df45144 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
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
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index d86dcb3..407b0e0 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
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
@@ -63,6 +82,7 @@ static const struct file_operations acpi_system_info_ops = {
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
-- 
1.5.0.rc3.39.gec804
