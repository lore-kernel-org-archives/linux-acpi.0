From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/5] ACPI / sysfs: Update sysfs signature handling code
Date: Tue, 16 Aug 2016 16:53:15 +0800
Message-ID: <a1bcc19e4a62a078cd070551905641eae70f21b1.1471337441.git.lv.zheng@intel.com>
References: <cover.1471337441.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1471337441.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is a cleanup to covert sysfs signature handling code using ACPICA
APIs, so that sysfs code can automatically be benefit from any future
implementation in the name tag handling macros.
Additional filename attribute is added in order to handle both BE/LE name
tag cases.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sysfs.c |   35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index f2fa363..974eb64 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -314,10 +314,13 @@ static struct kobject *tables_kobj;
 static struct kobject *dynamic_tables_kobj;
 static struct kobject *hotplug_kobj;
 
+#define ACPI_INST_SIZE		4	/* including trailing 0 */
+
 struct acpi_table_attr {
 	struct bin_attribute attr;
-	char name[8];
+	char name[ACPI_NAME_SIZE];
 	int instance;
+	char filename[ACPI_NAME_SIZE+ACPI_INST_SIZE];
 	struct list_head node;
 };
 
@@ -329,14 +332,9 @@ static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
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
 
@@ -349,30 +347,31 @@ static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
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
 
 	return;
-- 
1.7.10
