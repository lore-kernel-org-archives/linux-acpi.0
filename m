From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 4/4] ACPI: Fix memory mapping leaks in current sysfs dumpable ACPI tables support
Date: Tue,  9 May 2017 13:57:54 +0800
Message-ID: <f0ecac8fbdfbd7f23db77e523a7a16704134671f.1494309338.git.lv.zheng@intel.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59442 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755203AbdEIF6F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 May 2017 01:58:05 -0400
In-Reply-To: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch adds acpi_put_table() to make all acpi_get_table() clone
invocations balanced for sysfs ACPI table dump code.

Since Linux does not use all of the tables, this can help to reduce some
usless memory mappings.

While originally, all tables will be remained to be mapped after a
userspace acpidump execution, potentially causing problem on server
platforms. With the new APIs, it is possible to release such useless table
mappings.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sysfs.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 2bbf722..14425dc 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -346,11 +346,22 @@ static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
 	return len;
 }
 
+static bool acpi_table_has_multiple_instances(char *signature)
+{
+	acpi_status status;
+	struct acpi_table_header *header;
+
+	status = acpi_get_table(signature, 2, &header);
+	if (ACPI_FAILURE(status))
+		return false;
+	acpi_put_table(header);
+	return true;
+}
+
 static int acpi_table_attr_init(struct kobject *tables_obj,
 				struct acpi_table_attr *table_attr,
 				struct acpi_table_header *table_header)
 {
-	struct acpi_table_header *header = NULL;
 	struct acpi_table_attr *attr = NULL;
 	char instance_str[ACPI_INST_SIZE];
 
@@ -371,9 +382,9 @@ static int acpi_table_attr_init(struct kobject *tables_obj,
 
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
@@ -422,11 +433,11 @@ acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context)
 
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
@@ -446,16 +457,26 @@ static int acpi_tables_sysfs_init(void)
 			continue;
 
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

