From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/98] ACPICA: Remove extraneous parameter in table manager
Date: Sat, 28 Mar 2009 00:30:51 -0400
Message-ID: <97cbb7d196845ec9a6c0e3cc33ec20503f8c4e73.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:27023 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZC1Ecd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:33 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700APD8M6MKO8@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:31 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Removed the Flags parameter from several internal functions since
it was not being used.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
index e285bed..a0b4243 100644
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
@@ -600,14 +600,14 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags)
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
 
-- 
1.6.0.6

