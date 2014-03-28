From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 4/5] trace, eMCA: Add a knob to adjust where to save event log
Date: Fri, 28 Mar 2014 01:53:00 -0400
Message-ID: <1395985981-20476-5-git-send-email-gong.chen@linux.intel.com>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20301 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbaC1GRC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Mar 2014 02:17:02 -0400
In-Reply-To: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com, "Chen, Gong" <gong.chen@linux.intel.com>

To avoid saving two copies for one H/W event, add a new
file under debugfs to control how to save event log.
Once this file is opened, the perf/trace will be used,
in the meanwhile, kernel will stop to print event log
to the console. On the other hand, if this file is closed,
kernel will print event log to the console again.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 74 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 0ee2c38..f9a63dd 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -12,6 +12,7 @@
 #include <linux/cper.h>
 #include <linux/ratelimit.h>
 #include <linux/edac.h>
+#include <linux/debugfs.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
 
@@ -62,6 +63,9 @@ static void *elog_buf;
 static u64 *l1_entry_base;
 static u32 l1_percpu_entry;
 
+static struct dentry *extlog_debug_dir;
+static atomic_t trace_on;
+
 #define ELOG_IDX(cpu, bank) \
 	(cpu_physical_id(cpu) * l1_percpu_entry + (bank))
 
@@ -183,21 +187,24 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	estatus->block_status = 0;
 
 	tmp = (struct acpi_generic_status *)elog_buf;
-	print_extlog_rcd(NULL, tmp, cpu);
-
-	/* log event via trace */
-	err_count++;
-	gdata = (struct acpi_generic_data *)(tmp + 1);
-	if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
-		fru_id = (uuid_le *)gdata->fru_id;
-	if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
-		fru_text = gdata->fru_text;
-	sec_type = (uuid_le *)gdata->section_type;
-	if (!uuid_le_cmp(*sec_type, CPER_SEC_PLATFORM_MEM)) {
-		struct cper_sec_mem_err *mem_err = (void *)(gdata + 1);
-		if (gdata->error_data_length >= sizeof(*mem_err))
-			__trace_mem_error(fru_id, fru_text, err_count,
-					  gdata->error_severity, mem_err);
+	if (!atomic_read(&trace_on))
+		print_extlog_rcd(NULL, tmp, cpu);
+	else {
+		/* log event via trace */
+		err_count++;
+		gdata = (struct acpi_generic_data *)(tmp + 1);
+		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
+			fru_id = (uuid_le *)gdata->fru_id;
+		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
+			fru_text = gdata->fru_text;
+		sec_type = (uuid_le *)gdata->section_type;
+		if (!uuid_le_cmp(*sec_type, CPER_SEC_PLATFORM_MEM)) {
+			struct cper_sec_mem_err *mem_err = (void *)(gdata + 1);
+			if (gdata->error_data_length >= sizeof(*mem_err))
+				__trace_mem_error(fru_id, fru_text, err_count,
+						  gdata->error_severity,
+						  mem_err);
+		}
 	}
 
 	return NOTIFY_STOP;
@@ -233,6 +240,31 @@ static bool __init extlog_get_l1addr(void)
 
 	return true;
 }
+
+static int extlog_trace_show(struct seq_file *m, void *v)
+{
+	atomic_inc(&trace_on);
+	return 0;
+}
+
+static int trace_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, extlog_trace_show, NULL);
+}
+
+static int trace_release(struct inode *inode, struct file *file)
+{
+	atomic_dec(&trace_on);
+	return single_release(inode, file);
+}
+
+static const struct file_operations trace_fops = {
+	.open    = trace_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = trace_release,
+};
+
 static struct notifier_block extlog_mce_dec = {
 	.notifier_call	= extlog_print,
 };
@@ -243,6 +275,7 @@ static int __init extlog_init(void)
 	void __iomem *extlog_l1_hdr;
 	size_t l1_hdr_size;
 	struct resource *r;
+	struct dentry *fentry;
 	u64 cap;
 	int rc;
 
@@ -306,6 +339,14 @@ static int __init extlog_init(void)
 	if (elog_buf == NULL)
 		goto err_release_elog;
 
+	extlog_debug_dir = debugfs_create_dir("extlog", NULL);
+	if (!extlog_debug_dir)
+		goto err_cleanup;
+	fentry = debugfs_create_file("suppress_console", S_IRUSR,
+				     extlog_debug_dir, NULL, &trace_fops);
+	if (!fentry)
+		goto err_cleanup;
+
 	/*
 	 * eMCA event report method has higher priority than EDAC method,
 	 * unless EDAC event report method is mandatory.
@@ -318,6 +359,8 @@ static int __init extlog_init(void)
 
 	return 0;
 
+err_cleanup:
+	debugfs_remove_recursive(extlog_debug_dir);
 err_release_elog:
 	if (elog_addr)
 		acpi_os_unmap_memory(elog_addr, elog_size);
@@ -343,6 +386,7 @@ static void __exit extlog_exit(void)
 	release_mem_region(elog_base, elog_size);
 	release_mem_region(l1_dirbase, l1_size);
 	kfree(elog_buf);
+	debugfs_remove_recursive(extlog_debug_dir);
 }
 
 module_init(extlog_init);
-- 
1.9.0

