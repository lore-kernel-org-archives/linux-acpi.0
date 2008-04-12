From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/73] ACPICA: Fix for fault if Load() fails
Date: Sat, 12 Apr 2008 00:25:06 -0400
Message-ID: <f64b14ad08040573e5613a0f067832ecb8f4b2fa.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:15947 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752369AbYDLE2B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:01 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem with the Load operator when loading a table from
a buffer object. The input buffer was prematurely zeroed and/or
deleted. (BZ 577)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconfig.c |   35 ++++++++++++++++++++++++-----------
 drivers/acpi/tables/tbinstal.c   |   21 ++++++++++++++-------
 drivers/acpi/utilities/utdebug.c |    5 +++++
 3 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index 009aef5..8cc410c 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -285,16 +285,16 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
 	case ACPI_TYPE_REGION:
 
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Load from Region %p %s\n",
+				  obj_desc,
+				  acpi_ut_get_object_type_name(obj_desc)));
+
 		/* Region must be system_memory (from ACPI spec) */
 
 		if (obj_desc->region.space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 		}
 
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Load from Region %p %s\n",
-				  obj_desc,
-				  acpi_ut_get_object_type_name(obj_desc)));
-
 		/*
 		 * If the Region Address and Length have not been previously evaluated,
 		 * evaluate them now and save the results.
@@ -306,6 +306,11 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 			}
 		}
 
+		/*
+		 * We will simply map the memory region for the table. However, the
+		 * memory region is technically not guaranteed to remain stable and
+		 * we may eventually have to copy the table to a local buffer.
+		 */
 		table_desc.address = obj_desc->region.address;
 		table_desc.length = obj_desc->region.length;
 		table_desc.flags = ACPI_TABLE_ORIGIN_MAPPED;
@@ -313,18 +318,23 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
 	case ACPI_TYPE_BUFFER:	/* Buffer or resolved region_field */
 
-		/* Simply extract the buffer from the buffer object */
-
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 				  "Load from Buffer or Field %p %s\n", obj_desc,
 				  acpi_ut_get_object_type_name(obj_desc)));
 
-		table_desc.pointer = ACPI_CAST_PTR(struct acpi_table_header,
-						   obj_desc->buffer.pointer);
-		table_desc.length = table_desc.pointer->length;
-		table_desc.flags = ACPI_TABLE_ORIGIN_ALLOCATED;
+		/*
+		 * We need to copy the buffer since the original buffer could be
+		 * changed or deleted in the future
+		 */
+		table_desc.pointer = ACPI_ALLOCATE(obj_desc->buffer.length);
+		if (!table_desc.pointer) {
+			return_ACPI_STATUS(AE_NO_MEMORY);
+		}
 
-		obj_desc->buffer.pointer = NULL;
+		ACPI_MEMCPY(table_desc.pointer, obj_desc->buffer.pointer,
+			    obj_desc->buffer.length);
+		table_desc.length = obj_desc->buffer.length;
+		table_desc.flags = ACPI_TABLE_ORIGIN_ALLOCATED;
 		break;
 
 	default:
@@ -369,6 +379,9 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
       cleanup:
 	if (ACPI_FAILURE(status)) {
+
+		/* Delete allocated buffer or mapping */
+
 		acpi_tb_delete_table(&table_desc);
 	}
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/tables/tbinstal.c b/drivers/acpi/tables/tbinstal.c
index 3bc0c67..6a6ee1f 100644
--- a/drivers/acpi/tables/tbinstal.c
+++ b/drivers/acpi/tables/tbinstal.c
@@ -125,13 +125,20 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc,
 
 	/* The table must be either an SSDT or a PSDT or an OEMx */
 
-	if ((!ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_PSDT))
-	    &&
-	    (!ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_SSDT))
-	    && (strncmp(table_desc->pointer->signature, "OEM", 3))) {
-		ACPI_ERROR((AE_INFO,
-			    "Table has invalid signature [%4.4s], must be SSDT, PSDT or OEMx",
-			    table_desc->pointer->signature));
+	if (!ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_PSDT)&&
+	    !ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_SSDT)&&
+	    strncmp(table_desc->pointer->signature, "OEM", 3)) {
+		/* Check for a printable name */
+		if (acpi_ut_valid_acpi_name(
+			*(u32 *) table_desc->pointer->signature)) {
+			ACPI_ERROR((AE_INFO, "Table has invalid signature "
+					"[%4.4s], must be SSDT or PSDT",
+				    table_desc->pointer->signature));
+		} else {
+			ACPI_ERROR((AE_INFO, "Table has invalid signature "
+					"(0x%8.8X), must be SSDT or PSDT",
+				    *(u32 *) table_desc->pointer->signature));
+		}
 		return_ACPI_STATUS(AE_BAD_SIGNATURE);
 	}
 
diff --git a/drivers/acpi/utilities/utdebug.c b/drivers/acpi/utilities/utdebug.c
index 7361204..a914867 100644
--- a/drivers/acpi/utilities/utdebug.c
+++ b/drivers/acpi/utilities/utdebug.c
@@ -524,6 +524,11 @@ void acpi_ut_dump_buffer2(u8 * buffer, u32 count, u32 display)
 	u32 temp32;
 	u8 buf_char;
 
+	if (!buffer) {
+		acpi_os_printf("Null Buffer Pointer in DumpBuffer!\n");
+		return;
+	}
+
 	if ((count < 4) || (count & 0x01)) {
 		display = DB_BYTE_DISPLAY;
 	}
-- 
1.5.5.29.g7134

