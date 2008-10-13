From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4/6] ACPI: show dynamic ACPI tables
Date: Mon, 13 Oct 2008 16:10:14 +0800
Message-ID: <1223885414.2735.187.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56777 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755881AbYJMIPx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 04:15:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Some ACPI tables are loaded at runtime.
create sysfs I/F for these dynamic tables in /sys/firmware/acpi/tables/.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/system.c |   56 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 11 deletions(-)

Index: linux-acpi-2.6/drivers/acpi/system.c
===================================================================
--- linux-acpi-2.6.orig/drivers/acpi/system.c
+++ linux-acpi-2.6/drivers/acpi/system.c
@@ -100,7 +100,6 @@ static ssize_t acpi_table_show(struct ko
 static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
 				 struct acpi_table_header *table_header)
 {
-	struct acpi_table_header *header = NULL;
 	struct acpi_table_attr *attr = NULL;
 
 	memcpy(table_attr->name, table_header->signature, ACPI_NAME_SIZE);
@@ -113,15 +112,9 @@ static void acpi_table_attr_init(struct 
 	}
 	table_attr->instance++;
 
-	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
-					 !acpi_get_table(table_header->
-							 signature, 2,
-							 &header)))
+	if (table_attr->instance > 1)
 		sprintf(table_attr->name + 4, "%d", table_attr->instance);
 
-	if (table_attr->flag)
-		strncat(table_attr->name, "_inactive",
-				ACPI_TABLE_NAME_MAX - strlen(table_attr->name));
 	table_attr->attr.size = 0;
 	table_attr->attr.read = acpi_table_show;
 	table_attr->attr.attr.name = table_attr->name;
@@ -131,6 +124,42 @@ static void acpi_table_attr_init(struct 
 	return;
 }
 
+static acpi_status
+acpi_sysfs_table_handler(u32 event, void *table, void *context)
+{
+	struct acpi_table_attr *table_attr = NULL;
+
+	switch (event) {
+	case ACPI_TABLE_EVENT_LOAD:
+		table_attr =
+			kzalloc(sizeof(struct acpi_table_attr), GFP_KERNEL);
+		if (!table_attr)
+			return AE_NO_MEMORY;
+
+		acpi_table_attr_init(table_attr, table);
+		strncat(table_attr->name, "_dynamic",
+			ACPI_TABLE_NAME_MAX - strlen(table_attr->name));
+
+		if (sysfs_create_bin_file(tables_kobj, &table_attr->attr)) {
+			kfree(table_attr);
+			return AE_ERROR;
+		} else
+			list_add_tail(&table_attr->node,
+					&acpi_table_attr_list);
+		break;
+	case ACPI_TABLE_EVENT_UNLOAD:
+		/*
+		 * we do not need to do anything right now
+		 * because the table is not deleted from the
+		 * global table list when unloading it.
+		 */
+		break;
+	default:
+		return AE_BAD_PARAMETER;
+	}
+	return AE_OK;
+}
+
 static int acpi_system_sysfs_init(void)
 {
 	struct acpi_table_attr *table_attr;
@@ -162,12 +191,16 @@ static int acpi_system_sysfs_init(void)
 			if (!table_attr)
 				return -ENOMEM;
 
-			if (!active_tables) {
+			if (!active_tables)
 				table_attr->flag = ACPI_TABLE_INACTIVE;
-				table_attr->table_index = table_index;
-			}
+
+			table_attr->table_index = table_index;
 			table_index++;
 			acpi_table_attr_init(table_attr, table_header);
+			if (!active_tables)
+				strncat(table_attr->name, "_inactive",
+						ACPI_TABLE_NAME_MAX -
+						strlen(table_attr->name));
 
 			result =
 			    sysfs_create_bin_file(tables_kobj,
@@ -189,6 +222,7 @@ static int acpi_system_sysfs_init(void)
 		}
 	} while (!result);
 	kobject_uevent(tables_kobj, KOBJ_ADD);
+	acpi_gbl_table_handler = acpi_sysfs_table_handler;
 
 	return 0;
 }


