From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/42] ACPICA: iasl/acpiexec: Update input file handling and verification
Date: Tue, 29 Dec 2015 13:55:05 +0800
Message-ID: <62324643737a67f675ca47678c5db1e1f2e1e65c.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 3a6f2a516dd35a4daacbc5b5144d1db763ff2cb0

Improve and cleanup verification of ACPI tables within input files.
Share more code between the disassembler and acpiexec.

This patch only affects application debugger commands, thus it is a
no-op chage for Linux kernel.

Link: https://github.com/acpica/acpica/commit/3a6f2a51
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acapps.h  |   10 +++++++---
 drivers/acpi/acpica/dbinput.c |    7 +++----
 drivers/acpi/acpica/exmisc.c  |    4 ++--
 drivers/acpi/acpica/tbutils.c |    8 +-------
 4 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index 185c2eb..340350f 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -95,9 +95,13 @@
 /* acfileio */
 
 acpi_status
-acpi_ac_get_all_tables_from_file(char *filename,
-				 u8 get_only_aml_tables,
-				 struct acpi_new_table_desc **return_list_head);
+ac_get_all_tables_from_file(char *filename,
+			    u8 get_only_aml_tables,
+			    struct acpi_new_table_desc **return_list_head);
+
+u8 ac_is_file_binary(FILE * file);
+
+acpi_status ac_validate_table_header(FILE * file, long table_offset);
 
 /* Values for get_only_aml_tables */
 
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 71357fe..802779a 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -1056,10 +1056,9 @@ acpi_db_command_dispatch(char *input_buffer,
 			struct acpi_new_table_desc *list_head = NULL;
 
 			status =
-			    acpi_ac_get_all_tables_from_file(acpi_gbl_db_args
-							     [1],
-							     ACPI_GET_ALL_TABLES,
-							     &list_head);
+			    ac_get_all_tables_from_file(acpi_gbl_db_args[1],
+							ACPI_GET_ALL_TABLES,
+							&list_head);
 			if (ACPI_SUCCESS(status)) {
 				acpi_db_load_tables(list_head);
 			}
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index b5413bb..a8ce8a8 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -98,9 +98,9 @@ acpi_ex_get_object_reference(union acpi_operand_object *obj_desc,
 
 		default:
 
-			ACPI_ERROR((AE_INFO, "Unknown Reference Class 0x%2.2X",
+			ACPI_ERROR((AE_INFO, "Invalid Reference Class 0x%2.2X",
 				    obj_desc->reference.class));
-			return_ACPI_STATUS(AE_AML_INTERNAL);
+			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 		}
 		break;
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 72bcccf..7c1b5f8 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -389,7 +389,7 @@ next_table:
  *
  * PARAMETERS:  signature           - Sig string to be validated
  *
- * RETURN:      TRUE if signature is correct length and has valid characters
+ * RETURN:      TRUE if signature is has 4 valid ACPI characters
  *
  * DESCRIPTION: Validate an ACPI table signature.
  *
@@ -399,12 +399,6 @@ u8 acpi_is_valid_signature(char *signature)
 {
 	u32 i;
 
-	/* Validate the signature length */
-
-	if (strlen(signature) != ACPI_NAME_SIZE) {
-		return (FALSE);
-	}
-
 	/* Validate each character in the signature */
 
 	for (i = 0; i < ACPI_NAME_SIZE; i++) {
-- 
1.7.10
