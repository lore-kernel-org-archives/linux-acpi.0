From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/98] ACPI: introduce sysfs I/F for dynamic tables
Date: Sat, 28 Mar 2009 00:30:38 -0400
Message-ID: <4658e4ef9d252c26630268b20ceab78b3952db41.1238214617.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64533 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbZC1Ecj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:39 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7005858LXES13@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:22 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

SSDT tables may be loaded at runtime.
create sysfs I/F for these dynamic tables in
/sys/firmware/acpi/tables/dynamic/.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/system.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 391d035..c885904 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -62,6 +62,7 @@ module_param_call(acpica_version, NULL, param_get_acpica_version, NULL, 0444);
    -------------------------------------------------------------------------- */
 static LIST_HEAD(acpi_table_attr_list);
 static struct kobject *tables_kobj;
+static struct kobject *dynamic_tables_kobj;
 
 struct acpi_table_attr {
 	struct bin_attribute attr;
@@ -128,6 +129,40 @@ static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
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
-
-	return 0;
+	kobject_uevent(dynamic_tables_kobj, KOBJ_ADD);
+	result = acpi_install_table_handler(acpi_sysfs_table_handler, NULL);
+
+	return result == AE_OK ? 0 : -EINVAL;
+err_dynamic_tables:
+	kobject_put(tables_kobj);
+err:
+	return -ENOMEM;
 }
 
 /*
-- 
1.6.0.6

