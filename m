From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA Release 20090123 linuxized patches
Date: Wed, 04 Feb 2009 09:42:52 +0800
Message-ID: <1233711772.13659.28.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-NlD8nRx1e7eFTKp0+9CS"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54230 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbZBDBpe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Feb 2009 20:45:34 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>


--=-NlD8nRx1e7eFTKp0+9CS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

mbox file attached which can be applied to Linus tree cleanly.
Build & test on a x86_64 machine.

Lin Ming

---
ACPICA: Add error check to debug object dump routine
ACPICA: Allow OS override of all ACPI tables
ACPICA: Remove extraneous parameter in table manager
ACPICA: Add override for dynamic tables
ACPICA: Update FADT flag definitions
ACPICA: Update version to 20090123


--=-NlD8nRx1e7eFTKp0+9CS
Content-Disposition: attachment; filename="R01_23_09.mbox"
Content-Type: application/mbox; name="R01_23_09.mbox"
Content-Transfer-Encoding: 7bit

>From 8ad60af0cc0841fb55c98229f6c5381379b5179d Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 3 Feb 2009 14:17:29 +0800
Subject: [PATCH 1/6] ACPICA: Add error check to debug object dump routine

Add check for invalid handle in acpi_ns_dump_one_object.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/nsdump.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 0da33c8..e96d37a 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -181,6 +181,12 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 	}
 
 	this_node = acpi_ns_map_handle_to_node(obj_handle);
+	if (!this_node) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Invalid object handle %p\n",
+				  obj_handle));
+		return (AE_OK);
+	}
+
 	type = this_node->type;
 
 	/* Check if the owner matches */

>From d1236021eeedd358d1d7517dc72d7c520a68daab Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 3 Feb 2009 14:35:25 +0800
Subject: [PATCH 2/6] ACPICA: Allow OS override of all ACPI tables

Previously, the table override mechanism was implemented for the
DSDT only. Now, any table in the RSDT/XSDT can be replaced by
the host OS. (including the DSDT).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    1 -
 drivers/acpi/acpica/tbutils.c  |   59 +++++++++++++++++++++++++++++++---------
 drivers/acpi/acpica/tbxface.c  |   31 +--------------------
 include/acpi/actbl.h           |    5 ++-
 4 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index ddb40f5..634fb07 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -371,7 +371,6 @@ ACPI_EXTERN char *acpi_gbl_db_buffer;
 ACPI_EXTERN char *acpi_gbl_db_filename;
 ACPI_EXTERN u32 acpi_gbl_db_debug_level;
 ACPI_EXTERN u32 acpi_gbl_db_console_debug_level;
-ACPI_EXTERN struct acpi_table_header *acpi_gbl_db_table_ptr;
 ACPI_EXTERN struct acpi_namespace_node *acpi_gbl_db_scope_node;
 
 /*
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 9684cc8..af67877 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -287,7 +287,10 @@ u8 acpi_tb_checksum(u8 *buffer, u32 length)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Install an ACPI table into the global data structure.
+ * DESCRIPTION: Install an ACPI table into the global data structure. The
+ *              table override mechanism is implemented here to allow the host
+ *              OS to replace any table before it is installed in the root
+ *              table array.
  *
  ******************************************************************************/
 
@@ -295,7 +298,10 @@ void
 acpi_tb_install_table(acpi_physical_address address,
 		      u8 flags, char *signature, u32 table_index)
 {
-	struct acpi_table_header *table;
+	acpi_status status;
+	struct acpi_table_header *table_to_install;
+	struct acpi_table_header *mapped_table;
+	struct acpi_table_header *override_table = NULL;
 
 	if (!address) {
 		ACPI_ERROR((AE_INFO,
@@ -306,41 +312,68 @@ acpi_tb_install_table(acpi_physical_address address,
 
 	/* Map just the table header */
 
-	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
-	if (!table) {
+	mapped_table =
+	    acpi_os_map_memory(address, sizeof(struct acpi_table_header));
+	if (!mapped_table) {
 		return;
 	}
 
-	/* If a particular signature is expected, signature must match */
+	/* If a particular signature is expected (DSDT/FACS), it must match */
 
-	if (signature && !ACPI_COMPARE_NAME(table->signature, signature)) {
+	if (signature && !ACPI_COMPARE_NAME(mapped_table->signature, signature)) {
 		ACPI_ERROR((AE_INFO,
-			    "Invalid signature 0x%X for ACPI table [%s]",
-			    *ACPI_CAST_PTR(u32, table->signature), signature));
+			    "Invalid signature 0x%X for ACPI table, expected [%s]",
+			    *ACPI_CAST_PTR(u32, mapped_table->signature),
+			    signature));
 		goto unmap_and_exit;
 	}
 
+	/*
+	 * ACPI Table Override:
+	 *
+	 * Before we install the table, let the host OS override it with a new
+	 * one if desired. Any table within the RSDT/XSDT can be replaced,
+	 * including the DSDT which is pointed to by the FADT.
+	 */
+	status = acpi_os_table_override(mapped_table, &override_table);
+	if (ACPI_SUCCESS(status) && override_table) {
+		ACPI_INFO((AE_INFO,
+			   "%4.4s @ 0x%p Table override, replaced with:",
+			   mapped_table->signature, ACPI_CAST_PTR(void,
+								  address)));
+
+		acpi_gbl_root_table_list.tables[table_index].pointer =
+		    override_table;
+		flags = ACPI_TABLE_ORIGIN_OVERRIDE;
+		address = ACPI_PTR_TO_PHYSADDR(override_table);
+
+		table_to_install = override_table;
+	} else {
+		table_to_install = mapped_table;
+	}
+
 	/* Initialize the table entry */
 
 	acpi_gbl_root_table_list.tables[table_index].address = address;
-	acpi_gbl_root_table_list.tables[table_index].length = table->length;
+	acpi_gbl_root_table_list.tables[table_index].length =
+	    table_to_install->length;
 	acpi_gbl_root_table_list.tables[table_index].flags = flags;
 
 	ACPI_MOVE_32_TO_32(&
 			   (acpi_gbl_root_table_list.tables[table_index].
-			    signature), table->signature);
+			    signature), table_to_install->signature);
 
-	acpi_tb_print_table_header(address, table);
+	acpi_tb_print_table_header(address, table_to_install);
 
 	if (table_index == ACPI_TABLE_INDEX_DSDT) {
 
 		/* Global integer width is based upon revision of the DSDT */
 
-		acpi_ut_set_integer_width(table->revision);
+		acpi_ut_set_integer_width(table_to_install->revision);
 	}
 
       unmap_and_exit:
-	acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
+	acpi_os_unmap_memory(mapped_table, sizeof(struct acpi_table_header));
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index c3e841f..f3f95e3 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -491,7 +491,6 @@ ACPI_EXPORT_SYMBOL(acpi_get_table_by_index)
 static acpi_status acpi_tb_load_namespace(void)
 {
 	acpi_status status;
-	struct acpi_table_header *table;
 	u32 i;
 
 	ACPI_FUNCTION_TRACE(tb_load_namespace);
@@ -515,41 +514,13 @@ static acpi_status acpi_tb_load_namespace(void)
 		goto unlock_and_exit;
 	}
 
-	/*
-	 * Find DSDT table
-	 */
-	status =
-	    acpi_os_table_override(acpi_gbl_root_table_list.
-				   tables[ACPI_TABLE_INDEX_DSDT].pointer,
-				   &table);
-	if (ACPI_SUCCESS(status) && table) {
-		/*
-		 * DSDT table has been found
-		 */
-		acpi_tb_delete_table(&acpi_gbl_root_table_list.
-				     tables[ACPI_TABLE_INDEX_DSDT]);
-		acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT].pointer =
-		    table;
-		acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT].length =
-		    table->length;
-		acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT].flags =
-		    ACPI_TABLE_ORIGIN_UNKNOWN;
-
-		ACPI_INFO((AE_INFO, "Table DSDT replaced by host OS"));
-		acpi_tb_print_table_header(0, table);
-
-		if (no_auto_ssdt == 0) {
-			printk(KERN_WARNING "ACPI: DSDT override uses original SSDTs unless \"acpi_no_auto_ssdt\"\n");
-		}
-	}
+	/* A valid DSDT is required */
 
 	status =
 	    acpi_tb_verify_table(&acpi_gbl_root_table_list.
 				 tables[ACPI_TABLE_INDEX_DSDT]);
 	if (ACPI_FAILURE(status)) {
 
-		/* A valid DSDT is required */
-
 		status = AE_NO_ACPI_TABLES;
 		goto unlock_and_exit;
 	}
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index bf8d4cf..1f3dfdb 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -310,8 +310,9 @@ struct acpi_table_desc {
 #define ACPI_TABLE_ORIGIN_UNKNOWN       (0)
 #define ACPI_TABLE_ORIGIN_MAPPED        (1)
 #define ACPI_TABLE_ORIGIN_ALLOCATED     (2)
-#define ACPI_TABLE_ORIGIN_MASK          (3)
-#define ACPI_TABLE_IS_LOADED            (4)
+#define ACPI_TABLE_ORIGIN_OVERRIDE      (4)
+#define ACPI_TABLE_ORIGIN_MASK          (7)
+#define ACPI_TABLE_IS_LOADED            (8)
 
 /*
  * Get the remaining ACPI tables

>From 159c1947ffd3899a7e7d74e4f85235238f931dca Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 3 Feb 2009 14:41:03 +0800
Subject: [PATCH 3/6] ACPICA: Remove extraneous parameter in table manager

Removed the Flags parameter from several internal functions since
it was not being used.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/actables.h |    7 +++----
 drivers/acpi/acpica/tbfadt.c   |    7 +++----
 drivers/acpi/acpica/tbutils.c  |   14 +++++++-------
 drivers/acpi/acpica/tbxface.c  |    3 +--
 4 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 7ce6e33..d8f8c5d 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -49,7 +49,7 @@ acpi_status acpi_allocate_root_table(u32 initial_table_count);
 /*
  * tbfadt - FADT parse/convert/validate
  */
-void acpi_tb_parse_fadt(u32 table_index, u8 flags);
+void acpi_tb_parse_fadt(u32 table_index);
 
 void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length);
 
@@ -109,9 +109,8 @@ acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length);
 
 void
 acpi_tb_install_table(acpi_physical_address address,
-		      u8 flags, char *signature, u32 table_index);
+		      char *signature, u32 table_index);
 
-acpi_status
-acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags);
+acpi_status acpi_tb_parse_root_table(acpi_physical_address rsdp_address);
 
 #endif				/* __ACTABLES_H__ */
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 3636e4f..4b683cc 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -172,7 +172,6 @@ acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
  * FUNCTION:    acpi_tb_parse_fadt
  *
  * PARAMETERS:  table_index         - Index for the FADT
- *              Flags               - Flags
  *
  * RETURN:      None
  *
@@ -181,7 +180,7 @@ acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
  *
  ******************************************************************************/
 
-void acpi_tb_parse_fadt(u32 table_index, u8 flags)
+void acpi_tb_parse_fadt(u32 table_index)
 {
 	u32 length;
 	struct acpi_table_header *table;
@@ -219,10 +218,10 @@ void acpi_tb_parse_fadt(u32 table_index, u8 flags)
 	/* Obtain the DSDT and FACS tables via their addresses within the FADT */
 
 	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xdsdt,
-			      flags, ACPI_SIG_DSDT, ACPI_TABLE_INDEX_DSDT);
+			      ACPI_SIG_DSDT, ACPI_TABLE_INDEX_DSDT);
 
 	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xfacs,
-			      flags, ACPI_SIG_FACS, ACPI_TABLE_INDEX_FACS);
+			      ACPI_SIG_FACS, ACPI_TABLE_INDEX_FACS);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index af67877..0bd6dba 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -280,7 +280,6 @@ u8 acpi_tb_checksum(u8 *buffer, u32 length)
  * FUNCTION:    acpi_tb_install_table
  *
  * PARAMETERS:  Address                 - Physical address of DSDT or FACS
- *              Flags                   - Flags
  *              Signature               - Table signature, NULL if no need to
  *                                        match
  *              table_index             - Index into root table array
@@ -296,8 +295,9 @@ u8 acpi_tb_checksum(u8 *buffer, u32 length)
 
 void
 acpi_tb_install_table(acpi_physical_address address,
-		      u8 flags, char *signature, u32 table_index)
+		      char *signature, u32 table_index)
 {
+	u8 flags;
 	acpi_status status;
 	struct acpi_table_header *table_to_install;
 	struct acpi_table_header *mapped_table;
@@ -344,12 +344,13 @@ acpi_tb_install_table(acpi_physical_address address,
 
 		acpi_gbl_root_table_list.tables[table_index].pointer =
 		    override_table;
-		flags = ACPI_TABLE_ORIGIN_OVERRIDE;
 		address = ACPI_PTR_TO_PHYSADDR(override_table);
 
 		table_to_install = override_table;
+		flags = ACPI_TABLE_ORIGIN_OVERRIDE;
 	} else {
 		table_to_install = mapped_table;
+		flags = ACPI_TABLE_ORIGIN_MAPPED;
 	}
 
 	/* Initialize the table entry */
@@ -435,7 +436,6 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
  * FUNCTION:    acpi_tb_parse_root_table
  *
  * PARAMETERS:  Rsdp                    - Pointer to the RSDP
- *              Flags                   - Flags
  *
  * RETURN:      Status
  *
@@ -449,7 +449,7 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
  ******************************************************************************/
 
 acpi_status __init
-acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags)
+acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 {
 	struct acpi_table_rsdp *rsdp;
 	u32 table_entry_size;
@@ -601,14 +601,14 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags)
 	 */
 	for (i = 2; i < acpi_gbl_root_table_list.count; i++) {
 		acpi_tb_install_table(acpi_gbl_root_table_list.tables[i].
-				      address, flags, NULL, i);
+				      address, NULL, i);
 
 		/* Special case for FADT - get the DSDT and FACS */
 
 		if (ACPI_COMPARE_NAME
 		    (&acpi_gbl_root_table_list.tables[i].signature,
 		     ACPI_SIG_FADT)) {
-			acpi_tb_parse_fadt(i, flags);
+			acpi_tb_parse_fadt(i);
 		}
 	}
 
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index f3f95e3..416d01d 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -150,8 +150,7 @@ acpi_initialize_tables(struct acpi_table_desc * initial_table_array,
 	 * Root Table Array. This array contains the information of the RSDT/XSDT
 	 * in a common, more useable format.
 	 */
-	status =
-	    acpi_tb_parse_root_table(rsdp_address, ACPI_TABLE_ORIGIN_MAPPED);
+	status = acpi_tb_parse_root_table(rsdp_address);
 	return_ACPI_STATUS(status);
 }
 

>From 6760f729987c478b9163eabdc99d5e59335015a4 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 3 Feb 2009 14:43:04 +0800
Subject: [PATCH 4/6] ACPICA: Add override for dynamic tables

Add a call to acpi_os_table_override during the installation of a
dynamic table (loaded via the Load or LoadTable AML operators).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/tbinstal.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 37374b2..ef269a2 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -103,7 +103,9 @@ acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: This function is called to add the ACPI table
+ * DESCRIPTION: This function is called to add an ACPI table. It is used to
+ *              dynamically load tables via the Load and load_table AML
+ *              operators.
  *
  ******************************************************************************/
 
@@ -112,6 +114,7 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 {
 	u32 i;
 	acpi_status status = AE_OK;
+	struct acpi_table_header *override_table = NULL;
 
 	ACPI_FUNCTION_TRACE(tb_add_table);
 
@@ -201,6 +204,29 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 		}
 	}
 
+	/*
+	 * ACPI Table Override:
+	 * Allow the host to override dynamically loaded tables.
+	 */
+	status = acpi_os_table_override(table_desc->pointer, &override_table);
+	if (ACPI_SUCCESS(status) && override_table) {
+		ACPI_INFO((AE_INFO,
+			   "%4.4s @ 0x%p Table override, replaced with:",
+			   table_desc->pointer->signature,
+			   ACPI_CAST_PTR(void, table_desc->address)));
+
+		/* We can delete the table that was passed as a parameter */
+
+		acpi_tb_delete_table(table_desc);
+
+		/* Setup descriptor for the new table */
+
+		table_desc->address = ACPI_PTR_TO_PHYSADDR(override_table);
+		table_desc->pointer = override_table;
+		table_desc->length = override_table->length;
+		table_desc->flags = ACPI_TABLE_ORIGIN_OVERRIDE;
+	}
+
 	/* Add the table to the global root table list */
 
 	status = acpi_tb_store_table(table_desc->address, table_desc->pointer,

>From bc559b42ee89282372ced353b126c89402445b6a Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 3 Feb 2009 15:14:33 +0800
Subject: [PATCH 5/6] ACPICA: Update FADT flag definitions

Add new flags in the Boot Architecture flags field. Update comments
for all FADT flags. Add FADT version when each flag was defined.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/pci/pci-acpi.c |    4 +-
 include/acpi/actbl.h   |   69 +++++++++++++++++++++++------------------------
 2 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index deea8a1..368ca72 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -386,12 +386,12 @@ static int __init acpi_pci_init(void)
 {
 	int ret;
 
-	if (acpi_gbl_FADT.boot_flags & BAF_MSI_NOT_SUPPORTED) {
+	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_MSI) {
 		printk(KERN_INFO"ACPI FADT declares the system doesn't support MSI, so disable it\n");
 		pci_no_msi();
 	}
 
-	if (acpi_gbl_FADT.boot_flags & BAF_PCIE_ASPM_CONTROL) {
+	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 		printk(KERN_INFO"ACPI FADT declares the system doesn't support PCIe ASPM, so disable it\n");
 		pcie_no_aspm();
 	}
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 1f3dfdb..222733d 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -214,11 +214,11 @@ struct acpi_table_fadt {
 	u16 flush_size;		/* Processor's memory cache line width, in bytes */
 	u16 flush_stride;	/* Number of flush strides that need to be read */
 	u8 duty_offset;		/* Processor duty cycle index in processor's P_CNT reg */
-	u8 duty_width;		/* Processor duty cycle value bit width in P_CNT register. */
+	u8 duty_width;		/* Processor duty cycle value bit width in P_CNT register */
 	u8 day_alarm;		/* Index to day-of-month alarm in RTC CMOS RAM */
 	u8 month_alarm;		/* Index to month-of-year alarm in RTC CMOS RAM */
 	u8 century;		/* Index to century in RTC CMOS RAM */
-	u16 boot_flags;		/* IA-PC Boot Architecture Flags. See Table 5-10 for description */
+	u16 boot_flags;		/* IA-PC Boot Architecture Flags (see below for individual flags) */
 	u8 reserved;		/* Reserved, must be zero */
 	u32 flags;		/* Miscellaneous flag bits (see below for individual flags) */
 	struct acpi_generic_address reset_register;	/* 64-bit address of the Reset register */
@@ -236,32 +236,41 @@ struct acpi_table_fadt {
 	struct acpi_generic_address xgpe1_block;	/* 64-bit Extended General Purpose Event 1 Reg Blk address */
 };
 
+/* FADT Boot Architecture Flags (boot_flags) */
+
+#define ACPI_FADT_LEGACY_DEVICES    (1)  	/* 00: [V2] System has LPC or ISA bus devices */
+#define ACPI_FADT_8042              (1<<1)	/* 01: [V3] System has an 8042 controller on port 60/64 */
+#define ACPI_FADT_NO_VGA            (1<<2)	/* 02: [V4] It is not safe to probe for VGA hardware */
+#define ACPI_FADT_NO_MSI            (1<<3)	/* 03: [V4] Message Signaled Interrupts (MSI) must not be enabled */
+#define ACPI_FADT_NO_ASPM           (1<<4)	/* 04: [V4] PCIe ASPM control must not be enabled */
+
+#define FADT2_REVISION_ID               3
+
 /* FADT flags */
 
-#define ACPI_FADT_WBINVD            (1)	/* 00: The wbinvd instruction works properly */
-#define ACPI_FADT_WBINVD_FLUSH      (1<<1)	/* 01: The wbinvd flushes but does not invalidate */
-#define ACPI_FADT_C1_SUPPORTED      (1<<2)	/* 02: All processors support C1 state */
-#define ACPI_FADT_C2_MP_SUPPORTED   (1<<3)	/* 03: C2 state works on MP system */
-#define ACPI_FADT_POWER_BUTTON      (1<<4)	/* 04: Power button is handled as a generic feature */
-#define ACPI_FADT_SLEEP_BUTTON      (1<<5)	/* 05: Sleep button is handled as a generic feature, or  not present */
-#define ACPI_FADT_FIXED_RTC         (1<<6)	/* 06: RTC wakeup stat not in fixed register space */
-#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: RTC wakeup possible from S4 */
-#define ACPI_FADT_32BIT_TIMER       (1<<8)	/* 08: tmr_val is 32 bits 0=24-bits */
-#define ACPI_FADT_DOCKING_SUPPORTED (1<<9)	/* 09: Docking supported */
-#define ACPI_FADT_RESET_REGISTER    (1<<10)	/* 10: System reset via the FADT RESET_REG supported */
-#define ACPI_FADT_SEALED_CASE       (1<<11)	/* 11: No internal expansion capabilities and case is sealed */
-#define ACPI_FADT_HEADLESS          (1<<12)	/* 12: No local video capabilities or local input devices */
-#define ACPI_FADT_SLEEP_TYPE        (1<<13)	/* 13: Must execute native instruction after writing  SLP_TYPx register */
-#define ACPI_FADT_PCI_EXPRESS_WAKE  (1<<14)	/* 14: System supports PCIEXP_WAKE (STS/EN) bits (ACPI 3.0) */
-#define ACPI_FADT_PLATFORM_CLOCK    (1<<15)	/* 15: OSPM should use platform-provided timer (ACPI 3.0) */
-#define ACPI_FADT_S4_RTC_VALID      (1<<16)	/* 16: Contents of RTC_STS valid after S4 wake (ACPI 3.0) */
-#define ACPI_FADT_REMOTE_POWER_ON   (1<<17)	/* 17: System is compatible with remote power on (ACPI 3.0) */
-#define ACPI_FADT_APIC_CLUSTER      (1<<18)	/* 18: All local APICs must use cluster model (ACPI 3.0) */
-#define ACPI_FADT_APIC_PHYSICAL     (1<<19)	/* 19: All local x_aPICs must use physical dest mode (ACPI 3.0) */
+#define ACPI_FADT_WBINVD            (1)	/* 00: [V1] The wbinvd instruction works properly */
+#define ACPI_FADT_WBINVD_FLUSH      (1<<1)	/* 01: [V1] wbinvd flushes but does not invalidate caches */
+#define ACPI_FADT_C1_SUPPORTED      (1<<2)	/* 02: [V1] All processors support C1 state */
+#define ACPI_FADT_C2_MP_SUPPORTED   (1<<3)	/* 03: [V1] C2 state works on MP system */
+#define ACPI_FADT_POWER_BUTTON      (1<<4)	/* 04: [V1] Power button is handled as a control method device */
+#define ACPI_FADT_SLEEP_BUTTON      (1<<5)	/* 05: [V1] Sleep button is handled as a control method device */
+#define ACPI_FADT_FIXED_RTC         (1<<6)	/* 06: [V1] RTC wakeup status not in fixed register space */
+#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: [V1] RTC alarm can wake system from S4 */
+#define ACPI_FADT_32BIT_TIMER       (1<<8)	/* 08: [V1] ACPI timer width is 32-bit (0=24-bit) */
+#define ACPI_FADT_DOCKING_SUPPORTED (1<<9)	/* 09: [V1] Docking supported */
+#define ACPI_FADT_RESET_REGISTER    (1<<10)	/* 10: [V2] System reset via the FADT RESET_REG supported */
+#define ACPI_FADT_SEALED_CASE       (1<<11)	/* 11: [V3] No internal expansion capabilities and case is sealed */
+#define ACPI_FADT_HEADLESS          (1<<12)	/* 12: [V3] No local video capabilities or local input devices */
+#define ACPI_FADT_SLEEP_TYPE        (1<<13)	/* 13: [V3] Must execute native instruction after writing  SLP_TYPx register */
+#define ACPI_FADT_PCI_EXPRESS_WAKE  (1<<14)	/* 14: [V4] System supports PCIEXP_WAKE (STS/EN) bits (ACPI 3.0) */
+#define ACPI_FADT_PLATFORM_CLOCK    (1<<15)	/* 15: [V4] OSPM should use platform-provided timer (ACPI 3.0) */
+#define ACPI_FADT_S4_RTC_VALID      (1<<16)	/* 16: [V4] Contents of RTC_STS valid after S4 wake (ACPI 3.0) */
+#define ACPI_FADT_REMOTE_POWER_ON   (1<<17)	/* 17: [V4] System is compatible with remote power on (ACPI 3.0) */
+#define ACPI_FADT_APIC_CLUSTER      (1<<18)	/* 18: [V4] All local APICs must use cluster model (ACPI 3.0) */
+#define ACPI_FADT_APIC_PHYSICAL     (1<<19)	/* 19: [V4] All local x_aPICs must use physical dest mode (ACPI 3.0) */
+
+/* FADT Prefered Power Management Profiles */
 
-/*
- * FADT Prefered Power Management Profiles
- */
 enum acpi_prefered_pm_profiles {
 	PM_UNSPECIFIED = 0,
 	PM_DESKTOP = 1,
@@ -272,16 +281,6 @@ enum acpi_prefered_pm_profiles {
 	PM_APPLIANCE_PC = 6
 };
 
-/* FADT Boot Arch Flags */
-
-#define BAF_LEGACY_DEVICES              0x0001
-#define BAF_8042_KEYBOARD_CONTROLLER    0x0002
-#define BAF_MSI_NOT_SUPPORTED           0x0008
-#define BAF_PCIE_ASPM_CONTROL           0x0010
-
-#define FADT2_REVISION_ID               3
-#define FADT2_MINUS_REVISION_ID         2
-
 /* Reset to default packing */
 
 #pragma pack()

>From f209113694abd6098f65b269f42f8d93b48e143f Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 3 Feb 2009 15:16:51 +0800
Subject: [PATCH 6/6] ACPICA: Update version to 20090123

Update version to 20090123.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c8e8cf4..8f9df62 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20081204
+#define ACPI_CA_VERSION                 0x20090123
 
 #include "actypes.h"
 #include "actbl.h"


--=-NlD8nRx1e7eFTKp0+9CS--

