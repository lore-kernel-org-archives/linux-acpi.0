From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 6/8] ACPICA: Tables: Correct function namings
Date: Thu, 24 Mar 2016 16:31:03 +0800
Message-ID: <3f12481abec0df11dadbcd156dd97b9dfbf30479.1458808078.git.lv.zheng@intel.com>
References: <cover.1458808078.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2949 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754933AbcCXIbG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Mar 2016 04:31:06 -0400
In-Reply-To: <cover.1458808078.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch converts acpi_tb_install_standard_table() to
acpi_tb_verify_and_install_table() to reflect the recent changes. This patch
also converts acpi_tb_init_table_descriptor() to acpi_tb_install_table() to
be fully compliant to the table manager design. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/actables.h |   12 ++++-----
 drivers/acpi/acpica/exconfig.c |    6 ++---
 drivers/acpi/acpica/tbdata.c   |   54 ++++++++++++++++++++++++++++++++--------
 drivers/acpi/acpica/tbfadt.c   |   28 ++++++++++-----------
 drivers/acpi/acpica/tbinstal.c |   54 +++++++---------------------------------
 drivers/acpi/acpica/tbutils.c  |   14 +++++------
 drivers/acpi/acpica/tbxfload.c |   10 ++++----
 7 files changed, 87 insertions(+), 91 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 06d4d3d..5e4d780 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -63,9 +63,9 @@ acpi_tb_get_next_table_descriptor(u32 *table_index,
 				  struct acpi_table_desc **table_desc);
 
 void
-acpi_tb_init_table_descriptor(struct acpi_table_desc *table_desc,
-			      acpi_physical_address address,
-			      u8 flags, struct acpi_table_header *table);
+acpi_tb_install_table(struct acpi_table_desc *table_desc,
+		      acpi_physical_address address,
+		      u8 flags, struct acpi_table_header *table);
 
 acpi_status
 acpi_tb_acquire_temp_table(struct acpi_table_desc *table_desc,
@@ -117,9 +117,9 @@ acpi_tb_release_table(struct acpi_table_header *table,
 		      u32 table_length, u8 table_flags);
 
 acpi_status
-acpi_tb_install_standard_table(acpi_physical_address address,
-			       u8 flags,
-			       u8 reload, u8 override, u32 *table_index);
+acpi_tb_verify_and_install_table(acpi_physical_address address,
+				 u8 flags,
+				 u8 reload, u8 override, u32 *table_index);
 
 void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc);
 
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 3418c90..55039c4 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -477,9 +477,9 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	ACPI_INFO(("Dynamic OEM Table Load:"));
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
-	status = acpi_tb_install_standard_table(ACPI_PTR_TO_PHYSADDR(table),
-						ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL,
-						TRUE, TRUE, &table_index);
+	status = acpi_tb_verify_and_install_table(ACPI_PTR_TO_PHYSADDR(table),
+						  ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL,
+						  TRUE, TRUE, &table_index);
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 7da79ce..87ae305 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -51,7 +51,7 @@ ACPI_MODULE_NAME("tbdata")
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_init_table_descriptor
+ * FUNCTION:    acpi_tb_install_table
  *
  * PARAMETERS:  table_desc              - Table descriptor
  *              address                 - Physical address of the table
@@ -60,13 +60,14 @@ ACPI_MODULE_NAME("tbdata")
  *
  * RETURN:      None
  *
- * DESCRIPTION: Initialize a new table descriptor
+ * DESCRIPTION: This function is called to install the table, the returned
+ *              table descriptor is in "INSTALLED" state.
  *
  ******************************************************************************/
 void
-acpi_tb_init_table_descriptor(struct acpi_table_desc *table_desc,
-			      acpi_physical_address address,
-			      u8 flags, struct acpi_table_header *table)
+acpi_tb_install_table(struct acpi_table_desc *table_desc,
+		      acpi_physical_address address,
+		      u8 flags, struct acpi_table_header *table)
 {
 
 	/*
@@ -82,6 +83,41 @@ acpi_tb_init_table_descriptor(struct acpi_table_desc *table_desc,
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_uninstall_table
+ *
+ * PARAMETERS:  table_desc          - Table descriptor
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Uninstall one internal ACPI table, this is the inverse of
+ *              acpi_tb_install_table().
+ *
+ ******************************************************************************/
+
+void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc)
+{
+
+	ACPI_FUNCTION_TRACE(tb_uninstall_table);
+
+	/* Table must be installed */
+
+	if (!table_desc->address) {
+		return_VOID;
+	}
+
+	acpi_tb_invalidate_table(table_desc);
+
+	if ((table_desc->flags & ACPI_TABLE_ORIGIN_MASK) ==
+	    ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL) {
+		ACPI_FREE(ACPI_PHYSADDR_TO_PTR(table_desc->address));
+	}
+
+	table_desc->address = ACPI_PTR_TO_PHYSADDR(NULL);
+	return_VOID;
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_acquire_table
  *
  * PARAMETERS:  table_desc          - Table descriptor
@@ -205,8 +241,7 @@ acpi_tb_acquire_temp_table(struct acpi_table_desc *table_desc,
 			return (AE_NO_MEMORY);
 		}
 
-		acpi_tb_init_table_descriptor(table_desc, address, flags,
-					      table_header);
+		acpi_tb_install_table(table_desc, address, flags, table_header);
 		acpi_os_unmap_memory(table_header,
 				     sizeof(struct acpi_table_header));
 		return (AE_OK);
@@ -220,8 +255,7 @@ acpi_tb_acquire_temp_table(struct acpi_table_desc *table_desc,
 			return (AE_NO_MEMORY);
 		}
 
-		acpi_tb_init_table_descriptor(table_desc, address, flags,
-					      table_header);
+		acpi_tb_install_table(table_desc, address, flags, table_header);
 		return (AE_OK);
 
 	default:
@@ -343,7 +377,7 @@ acpi_status acpi_tb_validate_temp_table(struct acpi_table_desc *table_desc)
 		 * Note that Length contains the size of the mapping after invoking
 		 * this work around, this value is required by
 		 * acpi_tb_release_temp_table().
-		 * We can do this because in acpi_init_table_descriptor(), the Length
+		 * We can do this because in acpi_tb_install_table(), the Length
 		 * field of the installed descriptor is filled with the actual
 		 * table length obtaining from the table header.
 		 */
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 2d24c4b..cc2b774 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -344,27 +344,27 @@ void acpi_tb_parse_fadt(void)
 
 	/* Obtain the DSDT and FACS tables via their addresses within the FADT */
 
-	acpi_tb_install_standard_table((acpi_physical_address) acpi_gbl_FADT.
-				       Xdsdt,
-				       ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
-				       FALSE, TRUE, &acpi_gbl_dsdt_index);
+	acpi_tb_verify_and_install_table((acpi_physical_address) acpi_gbl_FADT.
+					 Xdsdt,
+					 ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
+					 FALSE, TRUE, &acpi_gbl_dsdt_index);
 
 	/* If Hardware Reduced flag is set, there is no FACS */
 
 	if (!acpi_gbl_reduced_hardware) {
 		if (acpi_gbl_FADT.facs) {
-			acpi_tb_install_standard_table((acpi_physical_address)
-						       acpi_gbl_FADT.facs,
-						       ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
-						       FALSE, TRUE,
-						       &acpi_gbl_facs_index);
+			acpi_tb_verify_and_install_table((acpi_physical_address)
+							 acpi_gbl_FADT.facs,
+							 ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
+							 FALSE, TRUE,
+							 &acpi_gbl_facs_index);
 		}
 		if (acpi_gbl_FADT.Xfacs) {
-			acpi_tb_install_standard_table((acpi_physical_address)
-						       acpi_gbl_FADT.Xfacs,
-						       ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
-						       FALSE, TRUE,
-						       &acpi_gbl_xfacs_index);
+			acpi_tb_verify_and_install_table((acpi_physical_address)
+							 acpi_gbl_FADT.Xfacs,
+							 ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
+							 FALSE, TRUE,
+							 &acpi_gbl_xfacs_index);
 		}
 	}
 }
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index f9f9b41..2f6a5fb 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -136,10 +136,9 @@ acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 		acpi_tb_override_table(new_table_desc);
 	}
 
-	acpi_tb_init_table_descriptor(&acpi_gbl_root_table_list.tables[i],
-				      new_table_desc->address,
-				      new_table_desc->flags,
-				      new_table_desc->pointer);
+	acpi_tb_install_table(&acpi_gbl_root_table_list.tables[i],
+			      new_table_desc->address, new_table_desc->flags,
+			      new_table_desc->pointer);
 
 	acpi_tb_print_table_header(new_table_desc->address,
 				   new_table_desc->pointer);
@@ -157,7 +156,7 @@ acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_install_standard_table
+ * FUNCTION:    acpi_tb_verify_and_install_table
  *
  * PARAMETERS:  address             - Address of the table (might be a virtual
  *                                    address depending on the table_flags)
@@ -177,9 +176,9 @@ acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
  ******************************************************************************/
 
 acpi_status
-acpi_tb_install_standard_table(acpi_physical_address address,
-			       u8 flags,
-			       u8 reload, u8 override, u32 *table_index)
+acpi_tb_verify_and_install_table(acpi_physical_address address,
+				 u8 flags,
+				 u8 reload, u8 override, u32 *table_index)
 {
 	u32 i;
 	acpi_status status = AE_OK;
@@ -382,46 +381,11 @@ finish_override:
 	 * Replace the original table descriptor and keep its state as
 	 * "VALIDATED".
 	 */
-	acpi_tb_init_table_descriptor(old_table_desc, new_table_desc.address,
-				      new_table_desc.flags,
-				      new_table_desc.pointer);
+	acpi_tb_install_table(old_table_desc, new_table_desc.address,
+			      new_table_desc.flags, new_table_desc.pointer);
 	acpi_tb_validate_temp_table(old_table_desc);
 
 	/* Release the temporary table descriptor */
 
 	acpi_tb_release_temp_table(&new_table_desc);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_tb_uninstall_table
- *
- * PARAMETERS:  table_desc          - Table descriptor
- *
- * RETURN:      None
- *
- * DESCRIPTION: Delete one internal ACPI table
- *
- ******************************************************************************/
-
-void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc)
-{
-
-	ACPI_FUNCTION_TRACE(tb_uninstall_table);
-
-	/* Table must be installed */
-
-	if (!table_desc->address) {
-		return_VOID;
-	}
-
-	acpi_tb_invalidate_table(table_desc);
-
-	if ((table_desc->flags & ACPI_TABLE_ORIGIN_MASK) ==
-	    ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL) {
-		ACPI_FREE(ACPI_PHYSADDR_TO_PTR(table_desc->address));
-	}
-
-	table_desc->address = ACPI_PTR_TO_PHYSADDR(NULL);
-	return_VOID;
-}
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index ec6ce69..5956c4a 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -168,10 +168,8 @@ struct acpi_table_header *acpi_tb_copy_dsdt(void)
 	memcpy(new_table, table_desc->pointer, table_desc->length);
 	acpi_tb_uninstall_table(table_desc);
 
-	acpi_tb_init_table_descriptor(table_desc,
-				      ACPI_PTR_TO_PHYSADDR(new_table),
-				      ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL,
-				      new_table);
+	acpi_tb_install_table(table_desc, ACPI_PTR_TO_PHYSADDR(new_table),
+			      ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL, new_table);
 
 	ACPI_INFO(("Forced DSDT copy: length 0x%05X copied locally, original unmapped", new_table->length));
 
@@ -358,10 +356,10 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 			goto next_table;
 		}
 
-		status = acpi_tb_install_standard_table(address,
-							ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
-							FALSE, TRUE,
-							&table_index);
+		status = acpi_tb_verify_and_install_table(address,
+							  ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
+							  FALSE, TRUE,
+							  &table_index);
 
 		if (ACPI_SUCCESS(status) &&
 		    ACPI_COMPARE_NAME(&acpi_gbl_root_table_list.
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 9d3cf30..47b8b82 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -287,8 +287,8 @@ acpi_install_table(acpi_physical_address address, u8 physical)
 		flags = ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL;
 	}
 
-	status = acpi_tb_install_standard_table(address, flags,
-						FALSE, FALSE, &table_index);
+	status = acpi_tb_verify_and_install_table(address, flags,
+						  FALSE, FALSE, &table_index);
 
 	return_ACPI_STATUS(status);
 }
@@ -336,9 +336,9 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 	ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
-	status = acpi_tb_install_standard_table(ACPI_PTR_TO_PHYSADDR(table),
-						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
-						TRUE, FALSE, &table_index);
+	status = acpi_tb_verify_and_install_table(ACPI_PTR_TO_PHYSADDR(table),
+						  ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
+						  TRUE, FALSE, &table_index);
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	if (ACPI_FAILURE(status)) {
-- 
1.7.10

