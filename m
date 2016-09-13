From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 3/3] ACPI / sysfs: Update sysfs signature handling code
Date: Tue, 13 Sep 2016 17:48:34 +0800
Message-ID: <04c3b26d3a470a43cfccb1fb09f48e6fb5042925.1473759814.git.lv.zheng@intel.com>
References: <cover.1471337441.git.lv.zheng@intel.com> <cover.1473759814.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:39214 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755407AbcIMJsm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Sep 2016 05:48:42 -0400
In-Reply-To: <cover.1473759814.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch cleans up sysfs table signature handling code:
1. Convert the signature handling code to use the ACPICA APIs in order to
   be benefit from the future improvements of the APIs;
2. Add 'filename' attribute in order to handle both BE/LE name tags;
3. Add instance check in order to avoid the possible buffer overflow
   occurred to the table file name.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sysfs.c |   62 +++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index c88d4bd..703c26e 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -314,10 +314,14 @@ static struct kobject *tables_kobj;
 static struct kobject *dynamic_tables_kobj;
 static struct kobject *hotplug_kobj;
 
+#define ACPI_MAX_TABLE_INSTANCES	999
+#define ACPI_INST_SIZE			4 /* including trailing 0 */
+
 struct acpi_table_attr {
 	struct bin_attribute attr;
-	char name[8];
+	char name[ACPI_NAME_SIZE];
 	int instance;
+	char filename[ACPI_NAME_SIZE+ACPI_INST_SIZE];
 	struct list_head node;
 };
 
@@ -329,14 +333,9 @@ static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
 	    container_of(bin_attr, struct acpi_table_attr, attr);
 	struct acpi_table_header *table_header = NULL;
 	acpi_status status;
-	char name[ACPI_NAME_SIZE];
 
-	if (strncmp(table_attr->name, "NULL", 4))
-		memcpy(name, table_attr->name, ACPI_NAME_SIZE);
-	else
-		memcpy(name, "\0\0\0\0", 4);
-
-	status = acpi_get_table(name, table_attr->instance, &table_header);
+	status = acpi_get_table(table_attr->name, table_attr->instance,
+				&table_header);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -344,38 +343,45 @@ static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
 				       table_header, table_header->length);
 }
 
-static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
-				 struct acpi_table_header *table_header)
+static int acpi_table_attr_init(struct kobject *tables_obj,
+				struct acpi_table_attr *table_attr,
+				struct acpi_table_header *table_header)
 {
 	struct acpi_table_header *header = NULL;
 	struct acpi_table_attr *attr = NULL;
+	char instance_str[ACPI_INST_SIZE];
 
 	sysfs_attr_init(&table_attr->attr.attr);
-	if (table_header->signature[0] != '\0')
-		memcpy(table_attr->name, table_header->signature,
-		       ACPI_NAME_SIZE);
-	else
-		memcpy(table_attr->name, "NULL", 4);
+	ACPI_MOVE_NAME(table_attr->name, table_header->signature);
 
 	list_for_each_entry(attr, &acpi_table_attr_list, node) {
-		if (!memcmp(table_attr->name, attr->name, ACPI_NAME_SIZE))
+		if (ACPI_COMPARE_NAME(table_attr->name, attr->name))
 			if (table_attr->instance < attr->instance)
 				table_attr->instance = attr->instance;
 	}
 	table_attr->instance++;
+	if (table_attr->instance > ACPI_MAX_TABLE_INSTANCES) {
+		pr_warn("%4.4s: too many table instances\n",
+			table_attr->name);
+		return -ERANGE;
+	}
 
+	ACPI_MOVE_NAME(table_attr->filename, table_header->signature);
+	table_attr->filename[ACPI_NAME_SIZE] = '\0';
 	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
 					 !acpi_get_table
-					 (table_header->signature, 2, &header)))
-		sprintf(table_attr->name + ACPI_NAME_SIZE, "%d",
-			table_attr->instance);
+					 (table_header->signature, 2, &header))) {
+		snprintf(instance_str, sizeof(instance_str), "%u",
+			 table_attr->instance);
+		strcat(table_attr->filename, instance_str);
+	}
 
 	table_attr->attr.size = table_header->length;
 	table_attr->attr.read = acpi_table_show;
-	table_attr->attr.attr.name = table_attr->name;
+	table_attr->attr.attr.name = table_attr->filename;
 	table_attr->attr.attr.mode = 0400;
 
-	return;
+	return sysfs_create_bin_file(tables_obj, &table_attr->attr);
 }
 
 acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context)
@@ -389,13 +395,12 @@ acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context)
 		if (!table_attr)
 			return AE_NO_MEMORY;
 
-		acpi_table_attr_init(table_attr, table);
-		if (sysfs_create_bin_file(dynamic_tables_kobj,
-					  &table_attr->attr)) {
+		if (acpi_table_attr_init(dynamic_tables_kobj,
+					 table_attr, table)) {
 			kfree(table_attr);
 			return AE_ERROR;
-		} else
-			list_add_tail(&table_attr->node, &acpi_table_attr_list);
+		}
+		list_add_tail(&table_attr->node, &acpi_table_attr_list);
 		break;
 	case ACPI_TABLE_EVENT_LOAD:
 	case ACPI_TABLE_EVENT_UNLOAD:
@@ -437,13 +442,12 @@ static int acpi_tables_sysfs_init(void)
 		if (ACPI_FAILURE(status))
 			continue;
 
-		table_attr = NULL;
 		table_attr = kzalloc(sizeof(*table_attr), GFP_KERNEL);
 		if (!table_attr)
 			return -ENOMEM;
 
-		acpi_table_attr_init(table_attr, table_header);
-		ret = sysfs_create_bin_file(tables_kobj, &table_attr->attr);
+		ret = acpi_table_attr_init(tables_kobj,
+					   table_attr, table_header);
 		if (ret) {
 			kfree(table_attr);
 			return ret;
-- 
1.7.10

