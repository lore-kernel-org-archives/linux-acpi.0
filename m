From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/28] ACPICA: Tables: Fix the issues in handling virtual addressed tables.
Date: Fri,  4 Apr 2014 12:38:26 +0800
Message-ID: <cd9962fe775357646153d2cdba0ed13b523f66a7.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36705 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbaDDEib (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:38:31 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

When table is overridden or reloaded, acpi_tb_delete_table() is called where
struct acpi_table_desc.Pointer will be NULL.  It thus is impossible for virtual
addressed tables to obtain the .Pointer again in acpi_tb_verify_table().

This patch stores virtual table addresses  (ACPI_TABLE_ORIGIN_ALLOCATED,
ACPI_TABLE_ORIGIN_UNKNOWN, ACPI_TABLE_ORIGIN_OVERRIDE) in the
struct acpi_table_desc.Address field and refills the struct acpi_table_desc.Pointer
using these addresses in acpi_tb_verify_table(). Note that if a table with
ACPI_TABLE_ORIGIN_ALLOCATED set is actually freed, the .Address field
should be invalidated and thus must be replaced with NULL to avoid wrong
future validations occuring in acpi_tb_verify_table().

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exconfig.c |    4 ++--
 drivers/acpi/acpica/tbinstal.c |   20 ++++++++++++++++++--
 drivers/acpi/acpica/tbutils.c  |    1 +
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 1b734eb..649a8ef 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -435,7 +435,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 			return_ACPI_STATUS(status);
 		}
 
-		table_desc.address = obj_desc->region.address;
+		table_desc.address = ACPI_PTR_TO_PHYSADDR(table_desc.pointer);
 		break;
 
 	case ACPI_TYPE_BUFFER:	/* Buffer or resolved region_field */
@@ -476,7 +476,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		}
 
 		ACPI_MEMCPY(table_desc.pointer, table, length);
-		table_desc.address = ACPI_TO_INTEGER(table_desc.pointer);
+		table_desc.address = ACPI_PTR_TO_PHYSADDR(table_desc.pointer);
 		break;
 
 	default:
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 73fffb0..144076a 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -69,11 +69,26 @@ acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
 	/* Map the table if necessary */
 
 	if (!table_desc->pointer) {
-		if ((table_desc->flags & ACPI_TABLE_ORIGIN_MASK) ==
-		    ACPI_TABLE_ORIGIN_MAPPED) {
+		switch (table_desc->flags & ACPI_TABLE_ORIGIN_MASK) {
+		case ACPI_TABLE_ORIGIN_MAPPED:
+
 			table_desc->pointer =
 			    acpi_os_map_memory(table_desc->address,
 					       table_desc->length);
+			break;
+
+		case ACPI_TABLE_ORIGIN_ALLOCATED:
+		case ACPI_TABLE_ORIGIN_UNKNOWN:
+		case ACPI_TABLE_ORIGIN_OVERRIDE:
+
+			table_desc->pointer =
+			    ACPI_CAST_PTR(struct acpi_table_header,
+					  table_desc->address);
+			break;
+
+		default:
+
+			break;
 		}
 
 		if (!table_desc->pointer) {
@@ -476,6 +491,7 @@ void acpi_tb_delete_table(struct acpi_table_desc *table_desc)
 	case ACPI_TABLE_ORIGIN_ALLOCATED:
 
 		ACPI_FREE(table_desc->pointer);
+		table_desc->address = ACPI_PTR_TO_PHYSADDR(NULL);
 		break;
 
 		/* Not mapped or allocated, there is nothing we can do */
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 3f1afca..9b6992d 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -179,6 +179,7 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
 
 	ACPI_MEMCPY(new_table, table_desc->pointer, table_desc->length);
 	acpi_tb_delete_table(table_desc);
+	table_desc->address = ACPI_PTR_TO_PHYSADDR(new_table);
 	table_desc->pointer = new_table;
 	table_desc->flags = ACPI_TABLE_ORIGIN_ALLOCATED;
 
-- 
1.7.10

