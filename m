From: Len Brown <len.brown@intel.com>
Subject: [PATCH 77/77] ACPI: Populate /sys/firmware/acpi/tables/
Date: Sun, 22 Jul 2007 05:15:02 -0400
Message-ID: <11850957822419-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
 <11850957552824-git-send-email-len.brown@intel.com>
 <11850957561003-git-send-email-len.brown@intel.com>
 <11850957571080-git-send-email-len.brown@intel.com>
 <11850957591101-git-send-email-len.brown@intel.com>
 <11850957601664-git-send-email-len.brown@intel.com>
 <1185095761326-git-send-email-len.brown@intel.com>
 <11850957621605-git-send-email-len.brown@intel.com>
 <11850957633613-git-send-email-len.brown@intel.com>
 <11850957641697-git-send-email-len.brown@intel.com>
 <11850957651127-git-send-email-len.brown@intel.com>
 <1185095766274-git-send-email-len.brown@intel.com>
 <1185095767879-git-send-email-len.brown@intel.com>
 <1185095768376-git-send-email-len.brown@intel.com>
 <11850957691561-git-send-email-len.brown@intel.com>
 <11850957703097-git-send-email-len.brown@intel.com>
 <11850957712166-git-send-email-len.brown@intel.com>
 <11850957721285-git-send-email-len.brown@intel.com>
 <11850957721315-git-send-email-len.brown@intel.com>
 <11850957741937-git-send-email-len.brown@intel.com>
 <1185095775978-git-send-email-len.brown@intel.com>
 <1185095776538-git-send-email-len.brown@intel.com>
 <1185095777144-git-send-email-len.brown@intel.com>
 <11850957781461-git-send-email-len.brown@intel.com>
 <11850957791127-git-send-email-len.brown@intel.com>
 <11850957801755-git-send-email-len.brown@intel.com>
 <11850957811573-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6024 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764608AbXGVJQ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:26 -0400
In-Reply-To: <11850957811573-git-send-email-len.brown@intel.com>
Message-Id: <d4c5f047ae2a33296774e41abc2ac5c89283f736.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

The file name is the signature, such as DSDT,
and the contents are the binary table image.

Some tables, such as the SSDT, can have multiple instances.
If just one, the file is SSDT, but if 3 instances,
for example, it will be SSDT1, SSDT2, SSDT3

All static tables (besides teh RSDP and RSDT themselves
are exported.  Dynamic tables, such as SSDT op-regions that
are not declared in the RSDT, will be added in a subsequent patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/system.c |  165 ++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 144 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 83a8d30..edee280 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -39,15 +39,12 @@ ACPI_MODULE_NAME("system");
 
 #define ACPI_SYSTEM_CLASS		"system"
 #define ACPI_SYSTEM_DEVICE_NAME		"System"
-#define ACPI_SYSTEM_FILE_INFO		"info"
-#define ACPI_SYSTEM_FILE_EVENT		"event"
-#define ACPI_SYSTEM_FILE_DSDT		"dsdt"
-#define ACPI_SYSTEM_FILE_FADT		"fadt"
 
 /*
  * Make ACPICA version work as module param
  */
-static int param_get_acpica_version(char *buffer, struct kernel_param *kp) {
+static int param_get_acpica_version(char *buffer, struct kernel_param *kp)
+{
 	int result;
 
 	result = sprintf(buffer, "%x", ACPI_CA_VERSION);
@@ -58,9 +55,126 @@ static int param_get_acpica_version(char *buffer, struct kernel_param *kp) {
 module_param_call(acpica_version, NULL, param_get_acpica_version, NULL, 0444);
 
 /* --------------------------------------------------------------------------
+                              FS Interface (/sys)
+   -------------------------------------------------------------------------- */
+static LIST_HEAD(acpi_table_attr_list);
+static struct kobject tables_kobj;
+
+struct acpi_table_attr {
+	struct bin_attribute attr;
+	char name[8];
+	int instance;
+	struct list_head node;
+};
+
+static ssize_t acpi_table_show(struct kobject *kobj,
+			       struct bin_attribute *bin_attr, char *buf,
+			       loff_t offset, size_t count)
+{
+	struct acpi_table_attr *table_attr =
+	    container_of(bin_attr, struct acpi_table_attr, attr);
+	struct acpi_table_header *table_header = NULL;
+	acpi_status status;
+	ssize_t ret_count = count;
+
+	status =
+	    acpi_get_table(table_attr->name, table_attr->instance,
+			   &table_header);
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
+	memcpy(buf, ((char *)table_header) + offset, ret_count);
+
+      end:
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
+			    ACPI_NAME_SIZE))
+			if (table_attr->instance < attr->instance)
+				table_attr->instance = attr->instance;
+	}
+	table_attr->instance++;
+
+	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
+					 !acpi_get_table(table_header->
+							 signature, 2,
+							 &header)))
+		sprintf(table_attr->name + 4, "%d", table_attr->instance);
+
+	table_attr->attr.size = 0;
+	table_attr->attr.read = acpi_table_show;
+	table_attr->attr.attr.name = table_attr->name;
+	table_attr->attr.attr.mode = 0444;
+	table_attr->attr.attr.owner = THIS_MODULE;
+
+	return;
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
+			table_attr =
+			    kzalloc(sizeof(struct acpi_table_attr), GFP_KERNEL);
+			if (!table_attr)
+				return -ENOMEM;
+
+			acpi_table_attr_init(table_attr, table_header);
+			result =
+			    sysfs_create_bin_file(&tables_kobj,
+						  &table_attr->attr);
+			if (result) {
+				kfree(table_attr);
+				return result;
+			} else
+				list_add_tail(&table_attr->node,
+					      &acpi_table_attr_list);
+		}
+	} while (!result);
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
@@ -80,7 +194,6 @@ static const struct file_operations acpi_system_info_ops = {
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-#endif
 
 static ssize_t acpi_system_read_dsdt(struct file *, char __user *, size_t,
 				     loff_t *);
@@ -97,13 +210,11 @@ acpi_system_read_dsdt(struct file *file,
 	struct acpi_table_header *dsdt = NULL;
 	ssize_t res;
 
-
 	status = acpi_get_table(ACPI_SIG_DSDT, 1, &dsdt);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	res = simple_read_from_buffer(buffer, count, ppos,
-				      dsdt, dsdt->length);
+	res = simple_read_from_buffer(buffer, count, ppos, dsdt, dsdt->length);
 
 	return res;
 }
@@ -123,28 +234,21 @@ acpi_system_read_fadt(struct file *file,
 	struct acpi_table_header *fadt = NULL;
 	ssize_t res;
 
-
 	status = acpi_get_table(ACPI_SIG_FADT, 1, &fadt);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	res = simple_read_from_buffer(buffer, count, ppos,
-				      fadt, fadt->length);
+	res = simple_read_from_buffer(buffer, count, ppos, fadt, fadt->length);
 
 	return res;
 }
 
-static int __init acpi_system_init(void)
+static int acpi_system_procfs_init(void)
 {
 	struct proc_dir_entry *entry;
 	int error = 0;
 	char *name;
 
-
-	if (acpi_disabled)
-		return 0;
-
-#ifdef CONFIG_ACPI_PROCFS
 	/* 'info' [R] */
 	name = ACPI_SYSTEM_FILE_INFO;
 	entry = create_proc_entry(name, S_IRUGO, acpi_root_dir);
@@ -153,7 +257,6 @@ static int __init acpi_system_init(void)
 	else {
 		entry->proc_fops = &acpi_system_info_ops;
 	}
-#endif
 
 	/* 'dsdt' [R] */
 	name = ACPI_SYSTEM_FILE_DSDT;
@@ -177,12 +280,32 @@ static int __init acpi_system_init(void)
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
+static int acpi_system_procfs_init(void)
+{
+	return 0;
+}
+#endif
+
+static int __init acpi_system_init(void)
+{
+	int result = 0;
+
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
-- 
1.5.3.rc2.22.g69a9b
