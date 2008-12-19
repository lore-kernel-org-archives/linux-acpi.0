From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/8] ACPI: add sysfs I/F for dynamic ACPI tables
Date: Fri, 19 Dec 2008 15:57:40 +0800
Message-ID: <1229673460.562.133.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:46685 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916AbYLSH7H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 02:59:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>


SSDT tables may be loaded at runtime.
create sysfs I/F for these dynamic tables
in /sys/firmware/acpi/tables/dynamic/.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/system.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

Index: linux-acpi-2.6/drivers/acpi/system.c
===================================================================
--- linux-acpi-2.6.orig/drivers/acpi/system.c	2008-11-10 10:55:48.000000000 +0800
+++ linux-acpi-2.6/drivers/acpi/system.c	2008-11-10 10:56:32.000000000 +0800
@@ -62,6 +62,7 @@
    -------------------------------------------------------------------------- */
 static LIST_HEAD(acpi_table_attr_list);
 static struct kobject *tables_kobj;
+static struct kobject *dynamic_tables_kobj;
 
 struct acpi_table_attr {
 	struct bin_attribute attr;
@@ -128,6 +128,40 @@
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
@@ -137,7 +171,11 @@
 
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
@@ -162,8 +200,14 @@
 		}
 	} while (!result);
 	kobject_uevent(tables_kobj, KOBJ_ADD);
+	kobject_uevent(dynamic_tables_kobj, KOBJ_ADD);
+	acpi_gbl_table_handler = acpi_sysfs_table_handler;
 
 	return 0;
+err_dynamic_tables:
+	kobject_put(tables_kobj);
+err:
+	return -ENOMEM;
 }
 
 /*


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


