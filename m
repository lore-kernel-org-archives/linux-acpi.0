From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND] [PATCH 3/6] ACPI: create sysfs I/F for inactive tables
Date: Wed, 12 Nov 2008 16:29:05 +0800
Message-ID: <1226478545.15014.173.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:20314 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbYKLIbe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 03:31:34 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Moore, Robert" <robert.moore@intel.com>


Show inactive tables in /sys/firmware/acpi/tables/inactive/.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/system.c |   64 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 17 deletions(-)

Index: linux-acpi-2.6/drivers/acpi/system.c
===================================================================
--- linux-acpi-2.6.orig/drivers/acpi/system.c
+++ linux-acpi-2.6/drivers/acpi/system.c
@@ -63,11 +63,15 @@ module_param_call(acpica_version, NULL, 
 static LIST_HEAD(acpi_table_attr_list);
 static struct kobject *tables_kobj;
 static struct kobject *dynamic_tables_kobj;
+static struct kobject *inactive_tables_kobj;
 
+#define ACPI_TABLE_INACTIVE 0x01
 struct acpi_table_attr {
 	struct bin_attribute attr;
 	char name[8];
 	int instance;
+	int index;
+	int flag;
 	struct list_head node;
 };
 
@@ -81,14 +85,16 @@ static ssize_t acpi_table_show(struct ko
 	acpi_status status;
 	char name[ACPI_NAME_SIZE];
 
-	if (strncmp(table_attr->name, "NULL", 4))
-		memcpy(name, table_attr->name, ACPI_NAME_SIZE);
-	else
-		memcpy(name, "\0\0\0\0", 4);
-
-	status =
-	    acpi_get_table(name, table_attr->instance,
-			   &table_header);
+	if (table_attr->flag != ACPI_TABLE_INACTIVE) {
+		if (strncmp(table_attr->name, "NULL", ACPI_NAME_SIZE))
+			memcpy(name, table_attr->name, ACPI_NAME_SIZE);
+		else
+			memcpy(name, "\0\0\0\0", ACPI_NAME_SIZE);
+		status = acpi_get_table(name,
+					table_attr->instance, &table_header);
+	} else
+		status = acpi_get_inactive_table_by_index
+					(table_attr->index, &table_header);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -110,14 +116,13 @@ static void acpi_table_attr_init(struct 
 
 	list_for_each_entry(attr, &acpi_table_attr_list, node) {
 		if (!memcmp(table_attr->name, attr->name, ACPI_NAME_SIZE))
-			if (table_attr->instance < attr->instance)
+			if ((table_attr->flag == attr->flag) &&
+				(table_attr->instance < attr->instance))
 				table_attr->instance = attr->instance;
 	}
 	table_attr->instance++;
 
-	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
-					!acpi_get_table
-					(table_header->signature, 2, &header)))
+	if (table_attr->instance > 1)
 		sprintf(table_attr->name + ACPI_NAME_SIZE, "%d",
 			table_attr->instance);
 
@@ -163,12 +168,15 @@ acpi_sysfs_table_handler(u32 event, void
 	return AE_OK;
 }
 
+typedef acpi_status (*get_table_func) (u32, struct acpi_table_header **);
+
 static int acpi_system_sysfs_init(void)
 {
 	struct acpi_table_attr *table_attr;
 	struct acpi_table_header *table_header = NULL;
-	int table_index = 0;
-	int result;
+	int table_index, table_flag, result;
+	struct kobject *kobj;
+	get_table_func func;
 
 	tables_kobj = kobject_create_and_add("tables", acpi_kobj);
 	if (!tables_kobj)
@@ -178,8 +186,18 @@ static int acpi_system_sysfs_init(void)
 	if (!dynamic_tables_kobj)
 		goto err_dynamic_tables;
 
+	inactive_tables_kobj = kobject_create_and_add("inactive", tables_kobj);
+	if (!inactive_tables_kobj)
+		goto err_inactive_tables;
+
+	acpi_initialize_inactive_tables();
+
+	func = acpi_get_inactive_table_by_index;
+	kobj = inactive_tables_kobj;
+	table_flag = ACPI_TABLE_INACTIVE;
+	table_index = 0;
 	do {
-		result = acpi_get_table_by_index(table_index, &table_header);
+		result = func(table_index, &table_header);
 		if (!result) {
 			table_index++;
 			table_attr = NULL;
@@ -188,23 +206,35 @@ static int acpi_system_sysfs_init(void)
 			if (!table_attr)
 				return -ENOMEM;
 
+			table_attr->flag = table_flag;
+			if (table_flag == ACPI_TABLE_INACTIVE)
+				table_attr->index = table_index - 1;
 			acpi_table_attr_init(table_attr, table_header);
 			result =
-			    sysfs_create_bin_file(tables_kobj,
-						  &table_attr->attr);
+			    sysfs_create_bin_file(kobj, &table_attr->attr);
 			if (result) {
 				kfree(table_attr);
 				return result;
 			} else
 				list_add_tail(&table_attr->node,
 					      &acpi_table_attr_list);
+		} else if (table_flag == ACPI_TABLE_INACTIVE) {
+			func = acpi_get_table_by_index;
+			kobj = tables_kobj;
+			table_flag = 0;
+			table_index = 0;
+			result = 0;
 		}
 	} while (!result);
 	kobject_uevent(tables_kobj, KOBJ_ADD);
 	kobject_uevent(dynamic_tables_kobj, KOBJ_ADD);
+	kobject_uevent(inactive_tables_kobj, KOBJ_ADD);
 	acpi_gbl_table_handler = acpi_sysfs_table_handler;
 
 	return 0;
+
+err_inactive_tables:
+	kobject_put(dynamic_tables_kobj);
 err_dynamic_tables:
 	kobject_put(tables_kobj);
 err:


