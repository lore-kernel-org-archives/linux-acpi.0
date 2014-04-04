From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/28] ACPICA: Remove indent divergences to reduce the difficulties of maintaining the revised ACPICA commits.
Date: Fri,  4 Apr 2014 12:38:18 +0800
Message-ID: <269c72a5a4e7c845d787f08069d16db03075628c.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60599 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbaDDEiW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:38:22 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The divergences in the ACPICA files makes it difficult to maintain linuxize
ACPICA table commits.  This patch reduces such divergences before applying
table manager commits so that human interventions of patch rebasing can be
reduced.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbinstal.c |    6 +++++-
 drivers/acpi/acpica/tbutils.c  |    4 ++--
 drivers/acpi/acpica/tbxface.c  |   10 +++++-----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index e304094..73fffb0 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -75,6 +75,7 @@ acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
 			    acpi_os_map_memory(table_desc->address,
 					       table_desc->length);
 		}
+
 		if (!table_desc->pointer) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
@@ -459,10 +460,13 @@ acpi_tb_store_table(acpi_physical_address address,
 
 void acpi_tb_delete_table(struct acpi_table_desc *table_desc)
 {
+
 	/* Table must be mapped or allocated */
+
 	if (!table_desc->pointer) {
 		return;
 	}
+
 	switch (table_desc->flags & ACPI_TABLE_ORIGIN_MASK) {
 	case ACPI_TABLE_ORIGIN_MAPPED:
 
@@ -657,7 +661,7 @@ acpi_status acpi_tb_release_owner_id(u32 table_index)
  *
  ******************************************************************************/
 
-acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id *owner_id)
+acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id * owner_id)
 {
 	acpi_status status = AE_BAD_PARAMETER;
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index a4702ee..3f1afca 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -582,8 +582,8 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 			if (ACPI_FAILURE(status)) {
 				ACPI_WARNING((AE_INFO,
 					      "Truncating %u table entries!",
-					      (unsigned) (table_count -
-					       (acpi_gbl_root_table_list.
+					      (unsigned)(table_count -
+							 (acpi_gbl_root_table_list.
 							  current_table_count -
 							  2))));
 				break;
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index a159315..4debc12 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -206,8 +206,8 @@ acpi_status
 acpi_get_table_header(char *signature,
 		      u32 instance, struct acpi_table_header *out_table_header)
 {
-       u32 i;
-       u32 j;
+	u32 i;
+	u32 j;
 	struct acpi_table_header *header;
 
 	/* Parameter validation */
@@ -321,8 +321,8 @@ acpi_get_table_with_size(char *signature,
 	       u32 instance, struct acpi_table_header **out_table,
 	       acpi_size *tbl_size)
 {
-       u32 i;
-       u32 j;
+	u32 i;
+	u32 j;
 	acpi_status status;
 
 	/* Parameter validation */
@@ -390,7 +390,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_table)
  *
  ******************************************************************************/
 acpi_status
-acpi_get_table_by_index(u32 table_index, struct acpi_table_header **table)
+acpi_get_table_by_index(u32 table_index, struct acpi_table_header ** table)
 {
 	acpi_status status;
 
-- 
1.7.10

