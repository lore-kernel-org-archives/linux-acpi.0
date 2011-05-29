From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/18] ACPI: Cleanup custom_method debug stuff
Date: Sun, 29 May 2011 05:44:09 -0400
Message-ID: <aecad432fd68dafa5b3b497c4816fbfce6fd4066.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:55532 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab1E2J5z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:57:55 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY0094DBOGA0E2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:57:55 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

- Move param aml_debug_output to other params into sysfs.c
- Split acpi_debugfs_init to prepare custom_method to be
  an own .config option and driver.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: rui.zhang@intel.com
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/debugfs.c  |   32 +++++++++++++-------------------
 drivers/acpi/internal.h |    3 ++-
 drivers/acpi/sysfs.c    |    8 ++++++++
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
index 384f7ab..e7abc6e 100644
--- a/drivers/acpi/debugfs.c
+++ b/drivers/acpi/debugfs.c
@@ -12,13 +12,8 @@
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("debugfs");
 
-
-/* /sys/modules/acpi/parameters/aml_debug_output */
-
-module_param_named(aml_debug_output, acpi_gbl_enable_aml_debug_object,
-		   bool, 0644);
-MODULE_PARM_DESC(aml_debug_output,
-		 "To enable/disable the ACPI Debug Object output.");
+struct dentry *acpi_debugfs_dir;
+static struct dentry *cm_dentry;
 
 /* /sys/kernel/debug/acpi/custom_method */
 
@@ -80,23 +75,22 @@ static const struct file_operations cm_fops = {
 	.llseek = default_llseek,
 };
 
-int __init acpi_debugfs_init(void)
+static int __init acpi_custom_method_init(void)
 {
-	struct dentry *acpi_dir, *cm_dentry;
-
-	acpi_dir = debugfs_create_dir("acpi", NULL);
-	if (!acpi_dir)
-		goto err;
+	if (!acpi_debugfs_dir)
+		return -ENOENT;
 
 	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
-					acpi_dir, NULL, &cm_fops);
+					acpi_debugfs_dir, NULL, &cm_fops);
 	if (!cm_dentry)
-		goto err;
+		return -ENODEV;
 
 	return 0;
+}
+
+void __init acpi_debugfs_init(void)
+{
+	acpi_debugfs_dir = debugfs_create_dir("acpi", NULL);
 
-err:
-	if (acpi_dir)
-		debugfs_remove(acpi_dir);
-	return -EINVAL;
+	acpi_custom_method_init();
 }
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 4bfb759..ca75b9c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -28,9 +28,10 @@ int acpi_scan_init(void);
 int acpi_sysfs_init(void);
 
 #ifdef CONFIG_DEBUG_FS
+extern struct dentry *acpi_debugfs_dir;
 int acpi_debugfs_init(void);
 #else
-static inline int acpi_debugfs_init(void) { return 0; }
+static inline void acpi_debugfs_init(void) { return; }
 #endif
 
 /* --------------------------------------------------------------------------
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 61891e7..77255f2 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -220,6 +220,14 @@ module_param_call(trace_state, param_set_trace_state, param_get_trace_state,
 		  NULL, 0644);
 #endif /* CONFIG_ACPI_DEBUG */
 
+
+/* /sys/modules/acpi/parameters/aml_debug_output */
+
+module_param_named(aml_debug_output, acpi_gbl_enable_aml_debug_object,
+		   bool, 0644);
+MODULE_PARM_DESC(aml_debug_output,
+		 "To enable/disable the ACPI Debug Object output.");
+
 /* /sys/module/acpi/parameters/acpica_version */
 static int param_get_acpica_version(char *buffer, struct kernel_param *kp)
 {
-- 
1.7.5.3.367.ga9930.dirty

