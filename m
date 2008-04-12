From: Len Brown <lenb@kernel.org>
Subject: [PATCH 51/73] ACPICA: Fix for LoadTable operator, input strings
Date: Sat, 12 Apr 2008 00:25:34 -0400
Message-ID: <f1a7174c5440a95f932b31ca992454e76193caf1.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:49384 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753450AbYDLE2L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:11 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem with the LoadTable operator where the OemId
and OemTableId input strings could cause unexpected failures if
they were shorter than the maximum lengths allowed. (Lin Ming,
Bob Moore) BZ 576

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconfig.c |    5 +----
 drivers/acpi/tables/tbfind.c     |   32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index 52b1e95..ed92fb5 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -236,7 +236,7 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 	status = acpi_get_table_by_index(table_index, &table);
 	if (ACPI_SUCCESS(status)) {
 		ACPI_INFO((AE_INFO,
-			   "Dynamic OEM Table Load - [%4.4s] OemId [%6.6s] OemTableId [%8.8s]",
+			   "Dynamic OEM Table Load - [%.4s] OemId [%.6s] OemTableId [%.8s]",
 			   table->signature, table->oem_id,
 			   table->oem_table_id));
 	}
@@ -472,8 +472,5 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 
 	acpi_tb_set_table_loaded_flag(table_index, FALSE);
 
-	/* Delete the table descriptor (ddb_handle) */
-
-	acpi_ut_remove_reference(table_desc);
 	return_ACPI_STATUS(AE_OK);
 }
diff --git a/drivers/acpi/tables/tbfind.c b/drivers/acpi/tables/tbfind.c
index 058c064..772ca41 100644
--- a/drivers/acpi/tables/tbfind.c
+++ b/drivers/acpi/tables/tbfind.c
@@ -70,12 +70,22 @@ acpi_tb_find_table(char *signature,
 {
 	acpi_native_uint i;
 	acpi_status status;
+	struct acpi_table_header header;
 
 	ACPI_FUNCTION_TRACE(tb_find_table);
 
+	/* Normalize the input strings */
+
+	ACPI_MEMSET(&header, 0, sizeof(struct acpi_table_header));
+	ACPI_STRNCPY(header.signature, signature, ACPI_NAME_SIZE);
+	ACPI_STRNCPY(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
+	ACPI_STRNCPY(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+
+	/* Search for the table */
+
 	for (i = 0; i < acpi_gbl_root_table_list.count; ++i) {
 		if (ACPI_MEMCMP(&(acpi_gbl_root_table_list.tables[i].signature),
-				signature, ACPI_NAME_SIZE)) {
+				header.signature, ACPI_NAME_SIZE)) {
 
 			/* Not the requested table */
 
@@ -104,20 +114,24 @@ acpi_tb_find_table(char *signature,
 
 		if (!ACPI_MEMCMP
 		    (acpi_gbl_root_table_list.tables[i].pointer->signature,
-		     signature, ACPI_NAME_SIZE) && (!oem_id[0]
-						    ||
-						    !ACPI_MEMCMP
-						    (acpi_gbl_root_table_list.
-						     tables[i].pointer->oem_id,
-						     oem_id, ACPI_OEM_ID_SIZE))
+		     header.signature, ACPI_NAME_SIZE) && (!oem_id[0]
+							   ||
+							   !ACPI_MEMCMP
+							   (acpi_gbl_root_table_list.
+							    tables[i].pointer->
+							    oem_id,
+							    header.oem_id,
+							    ACPI_OEM_ID_SIZE))
 		    && (!oem_table_id[0]
 			|| !ACPI_MEMCMP(acpi_gbl_root_table_list.tables[i].
-					pointer->oem_table_id, oem_table_id,
+					pointer->oem_table_id,
+					header.oem_table_id,
 					ACPI_OEM_TABLE_ID_SIZE))) {
 			*table_index = i;
 
 			ACPI_DEBUG_PRINT((ACPI_DB_TABLES,
-					  "Found table [%4.4s]\n", signature));
+					  "Found table [%4.4s]\n",
+					  header.signature));
 			return_ACPI_STATUS(AE_OK);
 		}
 	}
-- 
1.5.5.29.g7134

