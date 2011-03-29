From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/3] acpi: Cleanup custom_method debug stuff
Date: Tue, 29 Mar 2011 14:33:09 +0200
Message-ID: <1301401990-35469-3-git-send-email-trenn@suse.de>
References: <1301401990-35469-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:46608 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413Ab1C2Mal (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Mar 2011 08:30:41 -0400
In-Reply-To: <1301401990-35469-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Thomas Renninger <trenn@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, rui.zhang@intel.com, linux-acpi@vger.kernel.org

- Revert param aml_debug_output, it's not used.
- Split acpi_debugfs_init to prepare custom_method to be
  an own .config option and driver.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Rafael J. Wysocki <rjw@sisk.pl>
CC: lenb@kernel.org
CC: rui.zhang@intel.com
CC: linux-acpi@vger.kernel.org
---
 drivers/acpi/debugfs.c  |   36 +++++++++++++++---------------------
 drivers/acpi/internal.h |    3 ++-
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
index 384f7ab..32945c7 100644
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
+	if (acpi_debugfs_dir == NULL)
+		return -ENOENT;
 
-	acpi_dir = debugfs_create_dir("acpi", NULL);
-	if (!acpi_dir)
-		goto err;
+ 	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
+					acpi_debugfs_dir, NULL, &cm_fops);
+	if (cm_dentry == NULL)
+		return -ENODEV;
 
-	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
-					acpi_dir, NULL, &cm_fops);
-	if (!cm_dentry)
-		goto err;
+ 	return 0;
+}
 
-	return 0;
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
index b1cc81a..afc1a1c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -30,9 +30,10 @@ int acpi_scan_init(void);
 int acpi_sysfs_init(void);
 
 #ifdef CONFIG_DEBUG_FS
+extern struct dentry *acpi_debugfs_dir;
 int acpi_debugfs_init(void);
 #else
-static inline int acpi_debugfs_init(void) { return 0; }
+static inline void acpi_debugfs_init(void) { return; }
 #endif
 
 /* --------------------------------------------------------------------------
-- 
1.7.3.4

