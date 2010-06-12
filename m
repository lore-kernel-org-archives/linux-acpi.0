From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/4 V2] ACPI: remove deprecated procfs I/F
Date: Sat, 12 Jun 2010 15:45:27 +0800
Message-ID: <1276328727.19052.17838.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3933 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024Ab0FLHpF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jun 2010 03:45:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Rmove deprecated ACPI procfs I/F, including
/proc/acpi/debug_layer
/proc/acpi/debug_level
/proc/acpi/info
/proc/acpi/dsdt
/proc/acpi/fadt
because the sysfs I/F is already available
and has been working well for years.

No function change in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig  |    5 -
 drivers/acpi/debug.c  |  128 --------------------------------------------------
 drivers/acpi/system.c |  124 ------------------------------------------------
 3 files changed, 257 deletions(-)

Index: linux-2.6/drivers/acpi/debug.c
===================================================================
--- linux-2.6.orig/drivers/acpi/debug.c
+++ linux-2.6/drivers/acpi/debug.c
@@ -271,136 +271,8 @@ err:
 	return -EINVAL;
 }
 
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
 int __init acpi_debug_init(void)
 {
 	acpi_debugfs_init();
-	acpi_procfs_init();
 	return 0;
 }
Index: linux-2.6/drivers/acpi/system.c
===================================================================
--- linux-2.6.orig/drivers/acpi/system.c
+++ linux-2.6/drivers/acpi/system.c
@@ -503,134 +503,10 @@ static void __exit interrupt_stats_exit(
 	return;
 }
 
-/* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-#ifdef CONFIG_ACPI_PROCFS
-#define ACPI_SYSTEM_FILE_INFO		"info"
-#define ACPI_SYSTEM_FILE_EVENT		"event"
-#define ACPI_SYSTEM_FILE_DSDT		"dsdt"
-#define ACPI_SYSTEM_FILE_FADT		"fadt"
-
-static int acpi_system_read_info(struct seq_file *seq, void *offset)
-{
-
-	seq_printf(seq, "version:                 %x\n", ACPI_CA_VERSION);
-	return 0;
-}
-
-static int acpi_system_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_system_read_info, PDE(inode)->data);
-}
-
-static const struct file_operations acpi_system_info_ops = {
-	.owner = THIS_MODULE,
-	.open = acpi_system_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static ssize_t acpi_system_read_dsdt(struct file *, char __user *, size_t,
-				     loff_t *);
-
-static const struct file_operations acpi_system_dsdt_ops = {
-	.owner = THIS_MODULE,
-	.read = acpi_system_read_dsdt,
-};
-
-static ssize_t
-acpi_system_read_dsdt(struct file *file,
-		      char __user * buffer, size_t count, loff_t * ppos)
-{
-	acpi_status status = AE_OK;
-	struct acpi_table_header *dsdt = NULL;
-	ssize_t res;
-
-	status = acpi_get_table(ACPI_SIG_DSDT, 1, &dsdt);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	res = simple_read_from_buffer(buffer, count, ppos, dsdt, dsdt->length);
-
-	return res;
-}
-
-static ssize_t acpi_system_read_fadt(struct file *, char __user *, size_t,
-				     loff_t *);
-
-static const struct file_operations acpi_system_fadt_ops = {
-	.owner = THIS_MODULE,
-	.read = acpi_system_read_fadt,
-};
-
-static ssize_t
-acpi_system_read_fadt(struct file *file,
-		      char __user * buffer, size_t count, loff_t * ppos)
-{
-	acpi_status status = AE_OK;
-	struct acpi_table_header *fadt = NULL;
-	ssize_t res;
-
-	status = acpi_get_table(ACPI_SIG_FADT, 1, &fadt);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	res = simple_read_from_buffer(buffer, count, ppos, fadt, fadt->length);
-
-	return res;
-}
-
-static int acpi_system_procfs_init(void)
-{
-	struct proc_dir_entry *entry;
-	int error = 0;
-
-	/* 'info' [R] */
-	entry = proc_create(ACPI_SYSTEM_FILE_INFO, S_IRUGO, acpi_root_dir,
-			    &acpi_system_info_ops);
-	if (!entry)
-		goto Error;
-
-	/* 'dsdt' [R] */
-	entry = proc_create(ACPI_SYSTEM_FILE_DSDT, S_IRUSR, acpi_root_dir,
-			    &acpi_system_dsdt_ops);
-	if (!entry)
-		goto Error;
-
-	/* 'fadt' [R] */
-	entry = proc_create(ACPI_SYSTEM_FILE_FADT, S_IRUSR, acpi_root_dir,
-			    &acpi_system_fadt_ops);
-	if (!entry)
-		goto Error;
-
-      Done:
-	return error;
-
-      Error:
-	remove_proc_entry(ACPI_SYSTEM_FILE_FADT, acpi_root_dir);
-	remove_proc_entry(ACPI_SYSTEM_FILE_DSDT, acpi_root_dir);
-	remove_proc_entry(ACPI_SYSTEM_FILE_INFO, acpi_root_dir);
-
-	error = -EFAULT;
-	goto Done;
-}
-#else
-static int acpi_system_procfs_init(void)
-{
-	return 0;
-}
-#endif
-
 int __init acpi_system_init(void)
 {
 	int result;
 
-	result = acpi_system_procfs_init();
-	if (result)
-		return result;
-
 	result = acpi_system_sysfs_init();
 
 	return result;
Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -55,11 +55,6 @@ config ACPI_PROCFS
 	  The deprecated files (and their replacements) include:
 
 	  /proc/acpi/sleep (/sys/power/state)
-	  /proc/acpi/info (/sys/module/acpi/parameters/acpica_version)
-	  /proc/acpi/dsdt (/sys/firmware/acpi/tables/DSDT)
-	  /proc/acpi/fadt (/sys/firmware/acpi/tables/FACP)
-	  /proc/acpi/debug_layer (/sys/module/acpi/parameters/debug_layer)
-	  /proc/acpi/debug_level (/sys/module/acpi/parameters/debug_level)
 	  /proc/acpi/processor/*/power (/sys/devices/system/cpu/*/cpuidle/*)
 	  /proc/acpi/processor/*/performance (/sys/devices/system/cpu/*/
 		cpufreq/*)


