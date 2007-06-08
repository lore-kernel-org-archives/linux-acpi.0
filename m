From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: expose ACPI tables in sysfs
Date: Fri, 08 Jun 2007 17:43:27 +0800
Message-ID: <1181295807.5317.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4724 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbXFGJod (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Jun 2007 05:44:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

From: Zhang Rui <rui.zhang@intel.com>

This is the basic functionality of exposing ACPI tables in sysfs.
Only static tables are exposed to user space in this patch.
Every static table has a file under /sys/firmware/acpi/tables/.
The file name is constituted of the table signature and instance number.

With this patch, we can get all the static ACPI tables except for RSDP and RSDT.
For example, "#cat /sys/firmware/acpi/tables/dsdt > /tmp/dsdt.bin"
can help you get the content of dsdt table.
But iasl is still needed to disassemble the acpi tables.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/system.c |  144 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 131 insertions(+), 13 deletions(-)

Index: linux-2.6.22-rc4/drivers/acpi/system.c
===================================================================
--- linux-2.6.22-rc4.orig/drivers/acpi/system.c	2007-06-08 00:16:53.000000000 +0800
+++ linux-2.6.22-rc4/drivers/acpi/system.c	2007-06-08 00:24:40.000000000 +0800
@@ -39,10 +39,7 @@ ACPI_MODULE_NAME("system");
 
 #define ACPI_SYSTEM_CLASS		"system"
 #define ACPI_SYSTEM_DEVICE_NAME		"System"
-#define ACPI_SYSTEM_FILE_INFO		"info"
-#define ACPI_SYSTEM_FILE_EVENT		"event"
-#define ACPI_SYSTEM_FILE_DSDT		"dsdt"
-#define ACPI_SYSTEM_FILE_FADT		"fadt"
+
 
 /*
  * Make ACPICA version work as module param
@@ -58,9 +55,117 @@ static int param_get_acpica_version(char
 module_param_call(acpica_version, NULL, param_get_acpica_version, NULL, 0444);
 
 /* --------------------------------------------------------------------------
+                              FS Interface (/sys)
+   -------------------------------------------------------------------------- */
+static LIST_HEAD(acpi_table_attr_list);
+static struct kobject tables_kobj;
+
+struct acpi_table_attr {
+	struct bin_attribute	attr;
+	char			name[8];
+	int			instance;
+	struct list_head	node;
+};
+
+static ssize_t acpi_table_show(struct kobject *kobj, struct bin_attribute *bin_attr,
+					char *buf, loff_t offset, size_t count)
+{
+	struct acpi_table_attr *table_attr = container_of(bin_attr, struct acpi_table_attr, attr);
+	struct acpi_table_header *table_header = NULL;
+	acpi_status status;
+	ssize_t ret_count = count;
+
+	status = acpi_get_table(table_attr->name, table_attr->instance, &table_header);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	if (offset >= table_header->length) {
+		ret_count = 0;
+		goto end;
+	}
+
+	if (offset + ret_count > table_header->length)
+		ret_count = table_header->length - offset;
+
+	memcpy(buf, ((char *)table_header)+offset, ret_count);
+
+     end:
+	return ret_count;
+}
+
+static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
+				 struct acpi_table_header *table_header)
+{
+	struct acpi_table_header *header = NULL;
+	struct acpi_table_attr *attr = NULL;
+
+	memcpy(table_attr->name, table_header->signature, ACPI_NAME_SIZE);
+
+	list_for_each_entry(attr, &acpi_table_attr_list, node) {
+		if (!memcmp(table_header->signature, attr->name,
+			ACPI_NAME_SIZE))
+			if (table_attr->instance < attr->instance)
+				table_attr->instance = attr->instance;
+	}
+	table_attr->instance ++;
+
+	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
+		!acpi_get_table(table_header->signature, 2, &header)))
+		sprintf(table_attr->name+4, "%d", table_attr->instance);
+
+	table_attr->attr.size = 0;
+	table_attr->attr.read = acpi_table_show;
+	table_attr->attr.attr.name = table_attr->name;
+	table_attr->attr.attr.mode = 0444;
+	table_attr->attr.attr.owner = THIS_MODULE;
+
+	return ;
+}
+
+static int acpi_system_sysfs_init(void)
+{
+	struct acpi_table_attr *table_attr;
+	struct acpi_table_header *table_header = NULL;
+	int table_index = 0;
+	int result;
+
+	tables_kobj.parent = &acpi_subsys.kobj;
+	kobject_set_name(&tables_kobj, "tables");
+	result = kobject_register(&tables_kobj);
+	if (result)
+		return result;
+
+	do {
+		result = acpi_get_table_by_index(table_index, &table_header);
+		if (!result) {
+			table_index++;
+			table_attr = NULL;
+			table_attr = kzalloc(sizeof(struct acpi_table_attr), GFP_KERNEL);
+			if (!table_attr)
+				return -ENOMEM;
+
+			acpi_table_attr_init(table_attr, table_header);
+			result = sysfs_create_bin_file(&tables_kobj, &table_attr->attr);
+			if (result) {
+				kfree(table_attr);
+				return result;
+			}
+			else
+				list_add_tail(&table_attr->node, &acpi_table_attr_list);
+		}
+	} while(!result);
+
+	return 0;
+}
+
+/* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_PROCFS
+#define ACPI_SYSTEM_FILE_INFO		"info"
+#define ACPI_SYSTEM_FILE_EVENT		"event"
+#define ACPI_SYSTEM_FILE_DSDT		"dsdt"
+#define ACPI_SYSTEM_FILE_FADT		"fadt"
 
 static int acpi_system_read_info(struct seq_file *seq, void *offset)
 {
@@ -80,7 +185,7 @@ static const struct file_operations acpi
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-#endif
+
 
 static ssize_t acpi_system_read_dsdt(struct file *, char __user *, size_t,
 				     loff_t *);
@@ -134,17 +239,13 @@ acpi_system_read_fadt(struct file *file,
 	return res;
 }
 
-static int __init acpi_system_init(void)
+static int acpi_system_procfs_init(void)
 {
 	struct proc_dir_entry *entry;
 	int error = 0;
 	char *name;
 
 
-	if (acpi_disabled)
-		return 0;
-
-#ifdef CONFIG_ACPI_PROCFS
 	/* 'info' [R] */
 	name = ACPI_SYSTEM_FILE_INFO;
 	entry = create_proc_entry(name, S_IRUGO, acpi_root_dir);
@@ -153,7 +254,6 @@ static int __init acpi_system_init(void)
 	else {
 		entry->proc_fops = &acpi_system_info_ops;
 	}
-#endif
 
 	/* 'dsdt' [R] */
 	name = ACPI_SYSTEM_FILE_DSDT;
@@ -177,12 +277,30 @@ static int __init acpi_system_init(void)
       Error:
 	remove_proc_entry(ACPI_SYSTEM_FILE_FADT, acpi_root_dir);
 	remove_proc_entry(ACPI_SYSTEM_FILE_DSDT, acpi_root_dir);
-#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_SYSTEM_FILE_INFO, acpi_root_dir);
-#endif
 
 	error = -EFAULT;
 	goto Done;
 }
+#else
+static int acpi_system_procfs_init(void) {
+	return 0;
+}
+#endif
+
+static int __init acpi_system_init(void)
+{
+	int result = 0;
 
+	if (acpi_disabled)
+		return 0;
+
+	result = acpi_system_procfs_init();
+	if (result)
+		return result;
+
+	result = acpi_system_sysfs_init();
+
+	return result;
+}
 subsys_initcall(acpi_system_init);
