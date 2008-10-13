From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/6] ACPI: show inactive tables in sysfs
Date: Mon, 13 Oct 2008 16:10:11 +0800
Message-ID: <1223885412.2735.186.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51407 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755600AbYJMIX2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 04:23:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Show inactive tables in /sys/firmware/acpi/tables/.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/system.c |   49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

Index: linux-acpi-2.6/drivers/acpi/system.c
===================================================================
--- linux-acpi-2.6.orig/drivers/acpi/system.c
+++ linux-acpi-2.6/drivers/acpi/system.c
@@ -63,9 +63,13 @@ module_param_call(acpica_version, NULL, 
 static LIST_HEAD(acpi_table_attr_list);
 static struct kobject *tables_kobj;
 
+#define ACPI_TABLE_INACTIVE 1
+#define ACPI_TABLE_NAME_MAX 16
 struct acpi_table_attr {
 	struct bin_attribute attr;
-	char name[8];
+	char name[ACPI_TABLE_NAME_MAX];
+	char flag;
+	char table_index;
 	int instance;
 	struct list_head node;
 };
@@ -79,9 +83,13 @@ static ssize_t acpi_table_show(struct ko
 	struct acpi_table_header *table_header = NULL;
 	acpi_status status;
 
-	status =
-	    acpi_get_table(table_attr->name, table_attr->instance,
-			   &table_header);
+	if (table_attr->flag)
+		status = acpi_get_inactive_table_by_index(
+						table_attr->table_index,
+						&table_header);
+	else
+		status = acpi_get_table(table_attr->name, table_attr->instance,
+						&table_header);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -99,7 +107,7 @@ static void acpi_table_attr_init(struct 
 
 	list_for_each_entry(attr, &acpi_table_attr_list, node) {
 		if (!memcmp(table_header->signature, attr->name,
-			    ACPI_NAME_SIZE))
+			    ACPI_NAME_SIZE) && (attr->flag == table_attr->flag))
 			if (table_attr->instance < attr->instance)
 				table_attr->instance = attr->instance;
 	}
@@ -111,6 +119,9 @@ static void acpi_table_attr_init(struct 
 							 &header)))
 		sprintf(table_attr->name + 4, "%d", table_attr->instance);
 
+	if (table_attr->flag)
+		strncat(table_attr->name, "_inactive",
+				ACPI_TABLE_NAME_MAX - strlen(table_attr->name));
 	table_attr->attr.size = 0;
 	table_attr->attr.read = acpi_table_show;
 	table_attr->attr.attr.name = table_attr->name;
@@ -126,22 +137,38 @@ static int acpi_system_sysfs_init(void)
 	struct acpi_table_header *table_header = NULL;
 	int table_index = 0;
 	int result;
+	int active_tables = 0;
+
+	result = acpi_initialize_inactive_tables();
+	if (result)
+		active_tables = 1;
 
 	tables_kobj = kobject_create_and_add("tables", acpi_kobj);
 	if (!tables_kobj)
 		return -ENOMEM;
 
 	do {
-		result = acpi_get_table_by_index(table_index, &table_header);
+		if (active_tables)
+			result = acpi_get_table_by_index(table_index,
+							&table_header);
+		else
+			result = acpi_get_inactive_table_by_index(table_index,
+							&table_header);
+
 		if (!result) {
-			table_index++;
 			table_attr = NULL;
 			table_attr =
 			    kzalloc(sizeof(struct acpi_table_attr), GFP_KERNEL);
 			if (!table_attr)
 				return -ENOMEM;
 
+			if (!active_tables) {
+				table_attr->flag = ACPI_TABLE_INACTIVE;
+				table_attr->table_index = table_index;
+			}
+			table_index++;
 			acpi_table_attr_init(table_attr, table_header);
+
 			result =
 			    sysfs_create_bin_file(tables_kobj,
 						  &table_attr->attr);
@@ -151,6 +178,14 @@ static int acpi_system_sysfs_init(void)
 			} else
 				list_add_tail(&table_attr->node,
 					      &acpi_table_attr_list);
+		} else if (result == AE_TABLE_NOT_SUPPORTED) {
+			/* ignore the invalid table entry in RSDT/XSDT */
+			table_index++;
+			result = 0;
+		} else if (!active_tables) {
+			active_tables = 1;
+			table_index = 0;
+			result = 0;
 		}
 	} while (!result);
 	kobject_uevent(tables_kobj, KOBJ_ADD);


