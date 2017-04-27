From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/2] ACPI: Fix memory mapping leaks in current sysfs dumpable ACPI tables support.
Date: Thu, 27 Apr 2017 16:22:50 +0800
Message-ID: <73632c930a4c3a960ca6a9b935e3a2a8a0222cc5.1493281247.git.lv.zheng@intel.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57585 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935329AbdD0IXD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Apr 2017 04:23:03 -0400
In-Reply-To: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch adds balanced acpi_get_table()/acpi_put_table() support for
sysfs table dumping code so that no need to call
acpi_get_validated_table().

Since ACPICA does not use all of the tables, this can help to reduce some
usless memory mappings by utilizing the new table handling APIs.

The original sysfs dumpable ACPI table implementation forces tables to be
mapped after a read operation and never unmaps them again whatever there
are no users in the kernel interested in these tables.  With new balanced
table handling APIs, tables are unmapped after the read operation.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sysfs.c | 51 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 1b5ee1e..c3bb6ce 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -333,21 +333,34 @@ static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
 	    container_of(bin_attr, struct acpi_table_attr, attr);
 	struct acpi_table_header *table_header = NULL;
 	acpi_status status;
+	ssize_t len;
 
 	status = acpi_get_table(table_attr->name, table_attr->instance,
 				&table_header);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
+	len = memory_read_from_buffer(buf, count, &offset,
+				      table_header, table_header->length);
+	acpi_put_table(table_header);
+	return len;
+}
+
+static bool acpi_table_has_multiple_instances(char *signature)
+{
+	acpi_status status;
+	struct acpi_table_header *header;
 
-	return memory_read_from_buffer(buf, count, &offset,
-				       table_header, table_header->length);
+	status = acpi_get_table(signature, 2, &header);
+	if (ACPI_FAILURE(status))
+		return false;
+	acpi_put_table(header);
+	return true;
 }
 
 static int acpi_table_attr_init(struct kobject *tables_obj,
 				struct acpi_table_attr *table_attr,
 				struct acpi_table_header *table_header)
 {
-	struct acpi_table_header *header = NULL;
 	struct acpi_table_attr *attr = NULL;
 	char instance_str[ACPI_INST_SIZE];
 
@@ -368,9 +381,9 @@ static int acpi_table_attr_init(struct kobject *tables_obj,
 
 	ACPI_MOVE_NAME(table_attr->filename, table_header->signature);
 	table_attr->filename[ACPI_NAME_SIZE] = '\0';
-	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
-					 !acpi_get_table
-					 (table_header->signature, 2, &header))) {
+	if (table_attr->instance > 1 ||
+	    (table_attr->instance == 1 &&
+	     acpi_table_has_multiple_instances(table_header->signature))) {
 		snprintf(instance_str, sizeof(instance_str), "%u",
 			 table_attr->instance);
 		strcat(table_attr->filename, instance_str);
@@ -419,11 +432,11 @@ acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context)
 
 static int acpi_tables_sysfs_init(void)
 {
-	struct acpi_table_attr *table_attr;
+	struct acpi_table_attr *table_attr = NULL;
 	struct acpi_table_header *table_header = NULL;
 	int table_index;
 	acpi_status status;
-	int ret;
+	int ret = 0;
 
 	tables_kobj = kobject_create_and_add("tables", acpi_kobj);
 	if (!tables_kobj)
@@ -435,24 +448,32 @@ static int acpi_tables_sysfs_init(void)
 
 	for (table_index = 0;; table_index++) {
 		status = acpi_get_table_by_index(table_index, &table_header);
-
 		if (status == AE_BAD_PARAMETER)
 			break;
-
 		if (ACPI_FAILURE(status))
-			continue;
+			goto next_table;
 
 		table_attr = kzalloc(sizeof(*table_attr), GFP_KERNEL);
-		if (!table_attr)
-			return -ENOMEM;
+		if (!table_attr) {
+			ret = -ENOMEM;
+			goto next_table;
+		}
 
 		ret = acpi_table_attr_init(tables_kobj,
 					   table_attr, table_header);
+		if (ret)
+			goto next_table;
+		list_add_tail(&table_attr->node, &acpi_table_attr_list);
+
+next_table:
+		acpi_put_table(table_header);
 		if (ret) {
-			kfree(table_attr);
+			if (table_attr) {
+				kfree(table_attr);
+				table_attr = NULL;
+			}
 			return ret;
 		}
-		list_add_tail(&table_attr->node, &acpi_table_attr_list);
 	}
 
 	kobject_uevent(tables_kobj, KOBJ_ADD);
-- 
2.7.4

