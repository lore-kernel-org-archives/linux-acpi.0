From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: introduce sysfs I/F for dynamic tables
Date: Thu, 26 Feb 2009 11:27:23 +0800
Message-ID: <1235618843.32297.140.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39312 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914AbZBZD1O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Feb 2009 22:27:14 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


SSDT tables may be loaded at runtime.
create sysfs I/F for these dynamic tables in /sys/firmware/acpi/tables/dynamic/.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/system.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/system.c
===================================================================
--- linux-2.6.orig/drivers/acpi/system.c
+++ linux-2.6/drivers/acpi/system.c
@@ -62,6 +62,7 @@ module_param_call(acpica_version, NULL, 
    -------------------------------------------------------------------------- */
 static LIST_HEAD(acpi_table_attr_list);
 static struct kobject *tables_kobj;
+static struct kobject *dynamic_tables_kobj;
 
 struct acpi_table_attr {
 	struct bin_attribute attr;
@@ -128,6 +129,40 @@ static void acpi_table_attr_init(struct 
 	return;
 }
 
+static acpi_status
+acpi_sysfs_table_handler(u32 event, void *table, void *context)
+{
+	struct acpi_table_attr *table_attr;
+
+	switch (event) {
+	case ACPI_TABLE_EVENT_LOAD:
+		table_attr =
+			kzalloc(sizeof(struct acpi_table_attr), GFP_KERNEL);
+		if (!table_attr)
+			return AE_NO_MEMORY;
+
+		acpi_table_attr_init(table_attr, table);
+		if (sysfs_create_bin_file(dynamic_tables_kobj,
+					&table_attr->attr)) {
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
@@ -137,7 +172,11 @@ static int acpi_system_sysfs_init(void)
 
 	tables_kobj = kobject_create_and_add("tables", acpi_kobj);
 	if (!tables_kobj)
-		return -ENOMEM;
+		goto err;
+
+	dynamic_tables_kobj = kobject_create_and_add("dynamic", tables_kobj);
+	if (!dynamic_tables_kobj)
+		goto err_dynamic_tables;
 
 	do {
 		result = acpi_get_table_by_index(table_index, &table_header);
@@ -162,8 +201,14 @@ static int acpi_system_sysfs_init(void)
 		}
 	} while (!result);
 	kobject_uevent(tables_kobj, KOBJ_ADD);
+	kobject_uevent(dynamic_tables_kobj, KOBJ_ADD);
+	result = acpi_install_table_handler(acpi_sysfs_table_handler, NULL);
 
-	return 0;
+	return result == AE_OK ? 0 : -EINVAL;
+err_dynamic_tables:
+	kobject_put(tables_kobj);
+err:
+	return -ENOMEM;
 }
 
 /*


