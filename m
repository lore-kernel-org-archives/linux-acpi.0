From: akpm@linux-foundation.org
Subject: [patch 5/8] acpi: switch /proc/acpi/{debug_layer,debug_level} to seq_file
Date: Fri, 18 Sep 2009 12:41:08 -0700
Message-ID: <200909181941.n8IJf8fT002535@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41276 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757615AbZIRTm3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Sep 2009 15:42:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, adobriyan@gmail.com

From: Alexey Dobriyan <adobriyan@gmail.com>

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/debug.c |   82 +++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 48 deletions(-)

diff -puN drivers/acpi/debug.c~acpi-switch-proc-acpi-debug_layerdebug_level-to-seq_file drivers/acpi/debug.c
--- a/drivers/acpi/debug.c~acpi-switch-proc-acpi-debug_layerdebug_level-to-seq_file
+++ a/drivers/acpi/debug.c
@@ -3,6 +3,7 @@
  */
 
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -201,72 +202,54 @@ module_param_call(trace_state, param_set
 #define ACPI_SYSTEM_FILE_DEBUG_LAYER	"debug_layer"
 #define ACPI_SYSTEM_FILE_DEBUG_LEVEL		"debug_level"
 
-static int
-acpi_system_read_debug(char *page,
-		       char **start, off_t off, int count, int *eof, void *data)
+static int acpi_system_debug_proc_show(struct seq_file *m, void *v)
 {
-	char *p = page;
-	int size = 0;
 	unsigned int i;
 
-	if (off != 0)
-		goto end;
+	seq_printf(m, "%-25s\tHex        SET\n", "Description");
 
-	p += sprintf(p, "%-25s\tHex        SET\n", "Description");
-
-	switch ((unsigned long)data) {
+	switch ((unsigned long)m->private) {
 	case 0:
 		for (i = 0; i < ARRAY_SIZE(acpi_debug_layers); i++) {
-			p += sprintf(p, "%-25s\t0x%08lX [%c]\n",
+			seq_printf(m, "%-25s\t0x%08lX [%c]\n",
 				     acpi_debug_layers[i].name,
 				     acpi_debug_layers[i].value,
 				     (acpi_dbg_layer & acpi_debug_layers[i].
 				      value) ? '*' : ' ');
 		}
-		p += sprintf(p, "%-25s\t0x%08X [%c]\n", "ACPI_ALL_DRIVERS",
+		seq_printf(m, "%-25s\t0x%08X [%c]\n", "ACPI_ALL_DRIVERS",
 			     ACPI_ALL_DRIVERS,
 			     (acpi_dbg_layer & ACPI_ALL_DRIVERS) ==
 			     ACPI_ALL_DRIVERS ? '*' : (acpi_dbg_layer &
 						       ACPI_ALL_DRIVERS) ==
 			     0 ? ' ' : '-');
-		p += sprintf(p,
+		seq_printf(m,
 			     "--\ndebug_layer = 0x%08X (* = enabled, - = partial)\n",
 			     acpi_dbg_layer);
 		break;
 	case 1:
 		for (i = 0; i < ARRAY_SIZE(acpi_debug_levels); i++) {
-			p += sprintf(p, "%-25s\t0x%08lX [%c]\n",
+			seq_printf(m, "%-25s\t0x%08lX [%c]\n",
 				     acpi_debug_levels[i].name,
 				     acpi_debug_levels[i].value,
 				     (acpi_dbg_level & acpi_debug_levels[i].
 				      value) ? '*' : ' ');
 		}
-		p += sprintf(p, "--\ndebug_level = 0x%08X (* = enabled)\n",
+		seq_printf(m, "--\ndebug_level = 0x%08X (* = enabled)\n",
 			     acpi_dbg_level);
 		break;
-	default:
-		p += sprintf(p, "Invalid debug option\n");
-		break;
 	}
+	return 0;
+}
 
-      end:
-	size = (p - page);
-	if (size <= off + count)
-		*eof = 1;
-	*start = page + off;
-	size -= off;
-	if (size > count)
-		size = count;
-	if (size < 0)
-		size = 0;
-
-	return size;
+static int acpi_system_debug_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, acpi_system_debug_proc_show, PDE(inode)->data);
 }
 
-static int
-acpi_system_write_debug(struct file *file,
+static ssize_t acpi_system_debug_proc_write(struct file *file,
 			const char __user * buffer,
-			unsigned long count, void *data)
+			size_t count, loff_t *pos)
 {
 	char debug_string[12] = { '\0' };
 
@@ -279,7 +262,7 @@ acpi_system_write_debug(struct file *fil
 
 	debug_string[count] = '\0';
 
-	switch ((unsigned long)data) {
+	switch ((unsigned long)PDE(file->f_path.dentry->d_inode)->data) {
 	case 0:
 		acpi_dbg_layer = simple_strtoul(debug_string, NULL, 0);
 		break;
@@ -292,6 +275,15 @@ acpi_system_write_debug(struct file *fil
 
 	return count;
 }
+
+static const struct file_operations acpi_system_debug_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= acpi_system_debug_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= acpi_system_debug_proc_write,
+};
 #endif
 
 int __init acpi_debug_init(void)
@@ -303,24 +295,18 @@ int __init acpi_debug_init(void)
 
 	/* 'debug_layer' [R/W] */
 	name = ACPI_SYSTEM_FILE_DEBUG_LAYER;
-	entry =
-	    create_proc_read_entry(name, S_IFREG | S_IRUGO | S_IWUSR,
-				   acpi_root_dir, acpi_system_read_debug,
-				   (void *)0);
-	if (entry)
-		entry->write_proc = acpi_system_write_debug;
-	else
+	entry = proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR,
+				 acpi_root_dir, &acpi_system_debug_proc_fops,
+				 (void *)0);
+	if (!entry)
 		goto Error;
 
 	/* 'debug_level' [R/W] */
 	name = ACPI_SYSTEM_FILE_DEBUG_LEVEL;
-	entry =
-	    create_proc_read_entry(name, S_IFREG | S_IRUGO | S_IWUSR,
-				   acpi_root_dir, acpi_system_read_debug,
-				   (void *)1);
-	if (entry)
-		entry->write_proc = acpi_system_write_debug;
-	else
+	entry = proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR,
+				 acpi_root_dir, &acpi_system_debug_proc_fops,
+				 (void *)1);
+	if (!entry)
 		goto Error;
 
       Done:
_
