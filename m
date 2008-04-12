From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/73] ACPICA: Fix for Load/LoadTable to specify load location
Date: Sat, 12 Apr 2008 00:25:11 -0400
Message-ID: <efddf08cfff8abc30482e5774c1f897091606d97.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:20142 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752861AbYDLE2F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:05 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem with the Load and LoadTable operators where
the table location within the namespace was ignored. Instead,
the table was always loaded into the root or current scope.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconfig.c |    3 ++-
 drivers/acpi/namespace/nsload.c  |    2 +-
 drivers/acpi/namespace/nsparse.c |   18 +++++++++++++++---
 include/acpi/acnamesp.h          |    3 ++-
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index dbf1e6f..b9543a7 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -368,7 +368,8 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	}
 
 	status =
-	    acpi_ex_add_table(table_index, acpi_gbl_root_node, &ddb_handle);
+	    acpi_ex_add_table(table_index, walk_state->scope_info->scope.node,
+			      &ddb_handle);
 	if (ACPI_FAILURE(status)) {
 
 		/* On error, table_ptr was deallocated above */
diff --git a/drivers/acpi/namespace/nsload.c b/drivers/acpi/namespace/nsload.c
index d4f9654..545010d 100644
--- a/drivers/acpi/namespace/nsload.c
+++ b/drivers/acpi/namespace/nsload.c
@@ -107,7 +107,7 @@ acpi_ns_load_table(acpi_native_uint table_index,
 		goto unlock;
 	}
 
-	status = acpi_ns_parse_table(table_index, node->child);
+	status = acpi_ns_parse_table(table_index, node);
 	if (ACPI_SUCCESS(status)) {
 		acpi_tb_set_table_loaded_flag(table_index, TRUE);
 	} else {
diff --git a/drivers/acpi/namespace/nsparse.c b/drivers/acpi/namespace/nsparse.c
index e696aa8..86bd6e5 100644
--- a/drivers/acpi/namespace/nsparse.c
+++ b/drivers/acpi/namespace/nsparse.c
@@ -64,7 +64,8 @@ ACPI_MODULE_NAME("nsparse")
  ******************************************************************************/
 acpi_status
 acpi_ns_one_complete_parse(acpi_native_uint pass_number,
-			   acpi_native_uint table_index)
+			   acpi_native_uint table_index,
+			   struct acpi_namespace_node * start_node)
 {
 	union acpi_parse_object *parse_root;
 	acpi_status status;
@@ -121,6 +122,13 @@ acpi_ns_one_complete_parse(acpi_native_uint pass_number,
 		return_ACPI_STATUS(status);
 	}
 
+	/* start_node is the default location to load the table */
+
+	if (start_node && start_node != acpi_gbl_root_node) {
+		acpi_ds_scope_stack_push(start_node, ACPI_TYPE_METHOD,
+					 walk_state);
+	}
+
 	/* Parse the AML */
 
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "*PARSE* pass %d parse\n",
@@ -163,7 +171,9 @@ acpi_ns_parse_table(acpi_native_uint table_index,
 	 * performs another complete parse of the AML.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 1\n"));
-	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS1, table_index);
+	status =
+	    acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS1, table_index,
+				       start_node);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -178,7 +188,9 @@ acpi_ns_parse_table(acpi_native_uint table_index,
 	 * parse objects are all cached.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 2\n"));
-	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS2, table_index);
+	status =
+	    acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS2, table_index,
+				       start_node);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/include/acpi/acnamesp.h b/include/acpi/acnamesp.h
index 5ef38a6..1cad10b 100644
--- a/include/acpi/acnamesp.h
+++ b/include/acpi/acnamesp.h
@@ -113,7 +113,8 @@ acpi_ns_parse_table(acpi_native_uint table_index,
 
 acpi_status
 acpi_ns_one_complete_parse(acpi_native_uint pass_number,
-			   acpi_native_uint table_index);
+			   acpi_native_uint table_index,
+			   struct acpi_namespace_node *start_node);
 
 /*
  * nsaccess - Top-level namespace access
-- 
1.5.5.29.g7134

