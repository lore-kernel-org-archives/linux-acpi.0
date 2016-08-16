From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/5] ACPICA: Tables: Remove acpi_tb_install_fixed_table()
Date: Tue, 16 Aug 2016 16:52:46 +0800
Message-ID: <1483f243acd8ba3a4af9dae5271fe4246bbbf7d8.1471337441.git.lv.zheng@intel.com>
References: <cover.1471337441.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1471337441.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

acpi_tb_install_fixed_table() is now redundant as we've removed the fixed
table indexing mechanism. This patch cleans up the code accordingly.
No functional change. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/actables.h |    7 +----
 drivers/acpi/acpica/tbfadt.c   |   24 ++++++++-------
 drivers/acpi/acpica/tbinstal.c |   65 +---------------------------------------
 3 files changed, 16 insertions(+), 80 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 86d4d62..9469cd4 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -155,12 +155,7 @@ void
 acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 				    u8 override, u32 *table_index);
 
-acpi_status
-acpi_tb_install_fixed_table(acpi_physical_address address,
-			    char *signature, u32 *table_index);
-
-acpi_status ACPI_INIT_FUNCTION
-acpi_tb_parse_root_table(acpi_physical_address rsdp_address);
+acpi_status acpi_tb_parse_root_table(acpi_physical_address rsdp_address);
 
 /*
  * tbxfload
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 016bcdc..e678d6f 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -344,23 +344,27 @@ void acpi_tb_parse_fadt(void)
 
 	/* Obtain the DSDT and FACS tables via their addresses within the FADT */
 
-	acpi_tb_install_fixed_table((acpi_physical_address)acpi_gbl_FADT.Xdsdt,
-				    ACPI_SIG_DSDT, &acpi_gbl_dsdt_index);
+	acpi_tb_install_standard_table((acpi_physical_address)acpi_gbl_FADT.
+				       Xdsdt,
+				       ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
+				       FALSE, TRUE, &acpi_gbl_dsdt_index);
 
 	/* If Hardware Reduced flag is set, there is no FACS */
 
 	if (!acpi_gbl_reduced_hardware) {
 		if (acpi_gbl_FADT.facs) {
-			acpi_tb_install_fixed_table((acpi_physical_address)
-						    acpi_gbl_FADT.facs,
-						    ACPI_SIG_FACS,
-						    &acpi_gbl_facs_index);
+			acpi_tb_install_standard_table((acpi_physical_address)
+						       acpi_gbl_FADT.facs,
+						       ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
+						       FALSE, TRUE,
+						       &acpi_gbl_facs_index);
 		}
 		if (acpi_gbl_FADT.Xfacs) {
-			acpi_tb_install_fixed_table((acpi_physical_address)
-						    acpi_gbl_FADT.Xfacs,
-						    ACPI_SIG_FACS,
-						    &acpi_gbl_xfacs_index);
+			acpi_tb_install_standard_table((acpi_physical_address)
+						       acpi_gbl_FADT.Xfacs,
+						       ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
+						       FALSE, TRUE,
+						       &acpi_gbl_xfacs_index);
 		}
 	}
 }
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 8b13052..d461864 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -157,68 +157,6 @@ acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_install_fixed_table
- *
- * PARAMETERS:  address                 - Physical address of DSDT or FACS
- *              signature               - Table signature, NULL if no need to
- *                                        match
- *              table_index             - Where the table index is returned
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Install a fixed ACPI table (DSDT/FACS) into the global data
- *              structure.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_tb_install_fixed_table(acpi_physical_address address,
-			    char *signature, u32 *table_index)
-{
-	struct acpi_table_desc new_table_desc;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(tb_install_fixed_table);
-
-	if (!address) {
-		ACPI_ERROR((AE_INFO,
-			    "Null physical address for ACPI table [%s]",
-			    signature));
-		return (AE_NO_MEMORY);
-	}
-
-	/* Fill a table descriptor for validation */
-
-	status = acpi_tb_acquire_temp_table(&new_table_desc, address,
-					    ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL);
-	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO,
-			    "Could not acquire table length at %8.8X%8.8X",
-			    ACPI_FORMAT_UINT64(address)));
-		return_ACPI_STATUS(status);
-	}
-
-	/* Validate and verify a table before installation */
-
-	status = acpi_tb_verify_temp_table(&new_table_desc, signature);
-	if (ACPI_FAILURE(status)) {
-		goto release_and_exit;
-	}
-
-	/* Add the table to the global root table list */
-
-	acpi_tb_install_table_with_override(&new_table_desc, TRUE, table_index);
-
-release_and_exit:
-
-	/* Release the temporary table descriptor */
-
-	acpi_tb_release_temp_table(&new_table_desc);
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_tb_install_standard_table
  *
  * PARAMETERS:  address             - Address of the table (might be a virtual
@@ -230,8 +168,7 @@ release_and_exit:
  *
  * RETURN:      Status
  *
- * DESCRIPTION: This function is called to install an ACPI table that is
- *              neither DSDT nor FACS (a "standard" table.)
+ * DESCRIPTION: This function is called to verify and install an ACPI table.
  *              When this function is called by "Load" or "LoadTable" opcodes,
  *              or by acpi_load_table() API, the "Reload" parameter is set.
  *              After sucessfully returning from this function, table is
-- 
1.7.10
