From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/73] ACPICA: Add a table checksum verify for Load operator
Date: Sat, 12 Apr 2008 00:25:09 -0400
Message-ID: <44fd3509251fe52f6ed74eb4914e25304a20c639.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:7534 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752829AbYDLE2E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:04 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Added a table checksum verification for the Load operator, in
the case where the load is from a buffer. (BZ 578).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconfig.c |   24 +++++++++++++++++++++---
 drivers/acpi/tables/tbutils.c    |    2 +-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index a0f34b4..dbf1e6f 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -275,6 +275,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	struct acpi_table_desc table_desc;
 	acpi_native_uint table_index;
 	acpi_status status;
+	u32 length;
 
 	ACPI_FUNCTION_TRACE(ex_load_op);
 
@@ -322,18 +323,35 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 				  "Load from Buffer or Field %p %s\n", obj_desc,
 				  acpi_ut_get_object_type_name(obj_desc)));
 
+		length = obj_desc->buffer.length;
+
+		/* Must have at least an ACPI table header */
+
+		if (length < sizeof(struct acpi_table_header)) {
+			return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
+		}
+
+		/* Validate checksum here. It won't get validated in tb_add_table */
+
+		status = acpi_tb_verify_checksum((struct acpi_table_header *)
+						 obj_desc->buffer.pointer,
+						 length);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+
 		/*
 		 * We need to copy the buffer since the original buffer could be
 		 * changed or deleted in the future
 		 */
-		table_desc.pointer = ACPI_ALLOCATE(obj_desc->buffer.length);
+		table_desc.pointer = ACPI_ALLOCATE(length);
 		if (!table_desc.pointer) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
 		ACPI_MEMCPY(table_desc.pointer, obj_desc->buffer.pointer,
-			    obj_desc->buffer.length);
-		table_desc.length = obj_desc->buffer.length;
+			    length);
+		table_desc.length = length;
 		table_desc.flags = ACPI_TABLE_ORIGIN_ALLOCATED;
 		break;
 
diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index 010f196..d04442f 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -212,7 +212,7 @@ acpi_status acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length)
 
 	if (checksum) {
 		ACPI_WARNING((AE_INFO,
-			      "Incorrect checksum in table [%4.4s] -  %2.2X, should be %2.2X",
+			      "Incorrect checksum in table [%4.4s] - %2.2X, should be %2.2X",
 			      table->signature, table->checksum,
 			      (u8) (table->checksum - checksum)));
 
-- 
1.5.5.29.g7134

