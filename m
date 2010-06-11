From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/5] ACPI: remove ACPI debug procfs I/F
Date: Fri, 11 Jun 2010 13:47:55 +0800
Message-ID: <1276235275.19052.15872.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6869 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab0FKFrc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jun 2010 01:47:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Remove the deprecated ACPI debug procfs I/F, including
/proc/acpi/debug_layer and /proc/acpi/debug_level.

Because /sys/module/acpi/parameters/debug_layer and
/sys/module/acpi/parameters/debug_level has been working
for years without any problem.

No function change in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/bus.c      |    1 
 drivers/acpi/debug.c    |  133 ------------------------------------------------
 drivers/acpi/internal.h |    6 --
 3 files changed, 140 deletions(-)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -1036,7 +1036,6 @@ static int __init acpi_init(void)
 	acpi_power_init();
 	acpi_system_init();
 	acpi_debugfs_init();
-	acpi_debug_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
 	return result;
Index: linux-2.6/drivers/acpi/debug.c
===================================================================
--- linux-2.6.orig/drivers/acpi/debug.c
+++ linux-2.6/drivers/acpi/debug.c
@@ -196,136 +196,3 @@ static int param_get_trace_state(char *b
 
 module_param_call(trace_state, param_set_trace_state, param_get_trace_state,
 		  NULL, 0644);
-
-/* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-#ifdef CONFIG_ACPI_PROCFS
-#define ACPI_SYSTEM_FILE_DEBUG_LAYER	"debug_layer"
-#define ACPI_SYSTEM_FILE_DEBUG_LEVEL		"debug_level"
-
-static int acpi_system_debug_proc_show(struct seq_file *m, void *v)
-{
-	unsigned int i;
-
-	seq_printf(m, "%-25s\tHex        SET\n", "Description");
-
-	switch ((unsigned long)m->private) {
-	case 0:
-		for (i = 0; i < ARRAY_SIZE(acpi_debug_layers); i++) {
-			seq_printf(m, "%-25s\t0x%08lX [%c]\n",
-				     acpi_debug_layers[i].name,
-				     acpi_debug_layers[i].value,
-				     (acpi_dbg_layer & acpi_debug_layers[i].
-				      value) ? '*' : ' ');
-		}
-		seq_printf(m, "%-25s\t0x%08X [%c]\n", "ACPI_ALL_DRIVERS",
-			     ACPI_ALL_DRIVERS,
-			     (acpi_dbg_layer & ACPI_ALL_DRIVERS) ==
-			     ACPI_ALL_DRIVERS ? '*' : (acpi_dbg_layer &
-						       ACPI_ALL_DRIVERS) ==
-			     0 ? ' ' : '-');
-		seq_printf(m,
-			     "--\ndebug_layer = 0x%08X (* = enabled, - = partial)\n",
-			     acpi_dbg_layer);
-		break;
-	case 1:
-		for (i = 0; i < ARRAY_SIZE(acpi_debug_levels); i++) {
-			seq_printf(m, "%-25s\t0x%08lX [%c]\n",
-				     acpi_debug_levels[i].name,
-				     acpi_debug_levels[i].value,
-				     (acpi_dbg_level & acpi_debug_levels[i].
-				      value) ? '*' : ' ');
-		}
-		seq_printf(m, "--\ndebug_level = 0x%08X (* = enabled)\n",
-			     acpi_dbg_level);
-		break;
-	}
-	return 0;
-}
-
-static int acpi_system_debug_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_system_debug_proc_show, PDE(inode)->data);
-}
-
-static ssize_t acpi_system_debug_proc_write(struct file *file,
-			const char __user * buffer,
-			size_t count, loff_t *pos)
-{
-	char debug_string[12] = { '\0' };
-
-
-	if (count > sizeof(debug_string) - 1)
-		return -EINVAL;
-
-	if (copy_from_user(debug_string, buffer, count))
-		return -EFAULT;
-
-	debug_string[count] = '\0';
-
-	switch ((unsigned long)PDE(file->f_path.dentry->d_inode)->data) {
-	case 0:
-		acpi_dbg_layer = simple_strtoul(debug_string, NULL, 0);
-		break;
-	case 1:
-		acpi_dbg_level = simple_strtoul(debug_string, NULL, 0);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return count;
-}
-
-static const struct file_operations acpi_system_debug_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= acpi_system_debug_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.write		= acpi_system_debug_proc_write,
-};
-#endif
-
-int __init acpi_procfs_init(void)
-{
-#ifdef CONFIG_ACPI_PROCFS
-	struct proc_dir_entry *entry;
-	int error = 0;
-	char *name;
-
-	/* 'debug_layer' [R/W] */
-	name = ACPI_SYSTEM_FILE_DEBUG_LAYER;
-	entry = proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR,
-				 acpi_root_dir, &acpi_system_debug_proc_fops,
-				 (void *)0);
-	if (!entry)
-		goto Error;
-
-	/* 'debug_level' [R/W] */
-	name = ACPI_SYSTEM_FILE_DEBUG_LEVEL;
-	entry = proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR,
-				 acpi_root_dir, &acpi_system_debug_proc_fops,
-				 (void *)1);
-	if (!entry)
-		goto Error;
-
-      Done:
-	return error;
-
-      Error:
-	remove_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LEVEL, acpi_root_dir);
-	remove_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LAYER, acpi_root_dir);
-	error = -ENODEV;
-	goto Done;
-#else
-	return 0;
-#endif
-}
-
-int __init acpi_debug_init(void)
-{
-	acpi_procfs_init();
-	return 0;
-}
Index: linux-2.6/drivers/acpi/internal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/internal.h
+++ linux-2.6/drivers/acpi/internal.h
@@ -25,12 +25,6 @@ int acpi_scan_init(void);
 int acpi_system_init(void);
 int acpi_debugfs_init(void);
 
-#ifdef CONFIG_ACPI_DEBUG
-int acpi_debug_init(void);
-#else
-static inline int acpi_debug_init(void) { return 0; }
-#endif
-
 /* --------------------------------------------------------------------------
                                   Power Resource
    -------------------------------------------------------------------------- */


