From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 12/13] ACPICA: Move all ASCII utilities to a common file
Date: Thu,  5 May 2016 13:00:36 +0800
Message-ID: <b0c18be0f2866c5cc9980ad48c19185075dce43d.1462418912.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com> <cover.1462418912.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462418912.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit ba60e4500053010bf775d58f6f61febbdb94d817

New file is utascii.c

Link: https://github.com/acpica/acpica/commit/ba60e450
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile             |    1 +
 drivers/acpi/acpica/actables.h           |    2 -
 drivers/acpi/acpica/acutils.h            |   13 ++-
 drivers/acpi/acpica/dbnames.c            |    2 +-
 drivers/acpi/acpica/exnames.c            |    2 +-
 drivers/acpi/acpica/tbdata.c             |    6 +-
 drivers/acpi/acpica/tbfind.c             |    2 +-
 drivers/acpi/acpica/tbinstal.c           |    6 +-
 drivers/acpi/acpica/tbutils.c            |   27 ------
 drivers/acpi/acpica/utascii.c            |  140 ++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utstring.c           |   69 +--------------
 tools/power/acpi/tools/acpidump/Makefile |    1 +
 tools/power/acpi/tools/acpidump/apdump.c |    8 +-
 13 files changed, 168 insertions(+), 111 deletions(-)
 create mode 100644 drivers/acpi/acpica/utascii.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 188597f..227bb7b 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -150,6 +150,7 @@ acpi-y +=		\
 acpi-y +=		\
 	utaddress.o	\
 	utalloc.o	\
+	utascii.o	\
 	utbuffer.o	\
 	utcopy.o	\
 	utexcep.o	\
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 848ad3a..cd5a135 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -161,8 +161,6 @@ acpi_tb_install_fixed_table(acpi_physical_address address,
 
 acpi_status acpi_tb_parse_root_table(acpi_physical_address rsdp_address);
 
-u8 acpi_is_valid_signature(char *signature);
-
 /*
  * tbxfload
  */
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 107f9e0..a7dbb2b 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -167,6 +167,15 @@ struct acpi_pkg_info {
 #define DB_QWORD_DISPLAY    8
 
 /*
+ * utascii - ASCII utilities
+ */
+u8 acpi_ut_valid_nameseg(char *signature);
+
+u8 acpi_ut_valid_name_char(char character, u32 position);
+
+void acpi_ut_check_and_repair_ascii(u8 *name, char *repaired_name, u32 count);
+
+/*
  * utnonansi - Non-ANSI C library functions
  */
 void acpi_ut_strupr(char *src_string);
@@ -579,10 +588,6 @@ void acpi_ut_print_string(char *string, u16 max_length);
 void ut_convert_backslashes(char *pathname);
 #endif
 
-u8 acpi_ut_valid_acpi_name(char *name);
-
-u8 acpi_ut_valid_acpi_char(char character, u32 position);
-
 void acpi_ut_repair_name(char *name);
 
 #if defined (ACPI_DEBUGGER) || defined (ACPI_APPLICATION)
diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 4c9e59a..8667f14 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -709,7 +709,7 @@ acpi_db_integrity_walk(acpi_handle obj_handle,
 		return (AE_OK);
 	}
 
-	if (!acpi_ut_valid_acpi_name(node->name.ascii)) {
+	if (!acpi_ut_valid_nameseg(node->name.ascii)) {
 		acpi_os_printf("Invalid AcpiName for Node %p\n", node);
 		return (AE_OK);
 	}
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index 27c11ab..3d6af93 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -178,7 +178,7 @@ static acpi_status acpi_ex_name_segment(u8 ** in_aml_address, char *name_string)
 
 	for (index = 0;
 	     (index < ACPI_NAME_SIZE)
-	     && (acpi_ut_valid_acpi_char(*aml_address, 0)); index++) {
+	     && (acpi_ut_valid_name_char(*aml_address, 0)); index++) {
 		char_buf[index] = *aml_address++;
 		ACPI_DEBUG_PRINT((ACPI_DB_LOAD, "%c\n", char_buf[index]));
 	}
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index d471df3..1388a19 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -401,9 +401,9 @@ acpi_tb_verify_temp_table(struct acpi_table_desc *table_desc, char *signature)
 			ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY,
 					"%4.4s 0x%8.8X%8.8X"
 					" Attempted table install failed",
-					acpi_ut_valid_acpi_name(table_desc->
-								signature.
-								ascii) ?
+					acpi_ut_valid_nameseg(table_desc->
+							      signature.
+							      ascii) ?
 					table_desc->signature.ascii : "????",
 					ACPI_FORMAT_UINT64(table_desc->
 							   address)));
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index f2d0803..e348d61 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -76,7 +76,7 @@ acpi_tb_find_table(char *signature,
 
 	/* Validate the input table signature */
 
-	if (!acpi_is_valid_signature(signature)) {
+	if (!acpi_ut_valid_nameseg(signature)) {
 		return_ACPI_STATUS(AE_BAD_SIGNATURE);
 	}
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 4dc6108..8b13052 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -299,9 +299,9 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 			ACPI_BIOS_ERROR((AE_INFO,
 					 "Table has invalid signature [%4.4s] (0x%8.8X), "
 					 "must be SSDT or OEMx",
-					 acpi_ut_valid_acpi_name(new_table_desc.
-								 signature.
-								 ascii) ?
+					 acpi_ut_valid_nameseg(new_table_desc.
+							       signature.
+							       ascii) ?
 					 new_table_desc.signature.
 					 ascii : "????",
 					 new_table_desc.signature.integer));
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index a962a85..e285539 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -380,30 +380,3 @@ next_table:
 	acpi_os_unmap_memory(table, length);
 	return_ACPI_STATUS(AE_OK);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_is_valid_signature
- *
- * PARAMETERS:  signature           - Sig string to be validated
- *
- * RETURN:      TRUE if signature is has 4 valid ACPI characters
- *
- * DESCRIPTION: Validate an ACPI table signature.
- *
- ******************************************************************************/
-
-u8 acpi_is_valid_signature(char *signature)
-{
-	u32 i;
-
-	/* Validate each character in the signature */
-
-	for (i = 0; i < ACPI_NAME_SIZE; i++) {
-		if (!acpi_ut_valid_acpi_char(signature[i], i)) {
-			return (FALSE);
-		}
-	}
-
-	return (TRUE);
-}
diff --git a/drivers/acpi/acpica/utascii.c b/drivers/acpi/acpica/utascii.c
new file mode 100644
index 0000000..706c1f3
--- /dev/null
+++ b/drivers/acpi/acpica/utascii.c
@@ -0,0 +1,140 @@
+/******************************************************************************
+ *
+ * Module Name: utascii - Utility ascii functions
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2016, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_valid_nameseg
+ *
+ * PARAMETERS:  name            - The name or table signature to be examined.
+ *                                Four characters, does not have to be a
+ *                                NULL terminated string.
+ *
+ * RETURN:      TRUE if signature is has 4 valid ACPI characters
+ *
+ * DESCRIPTION: Validate an ACPI table signature.
+ *
+ ******************************************************************************/
+
+u8 acpi_ut_valid_nameseg(char *name)
+{
+	u32 i;
+
+	/* Validate each character in the signature */
+
+	for (i = 0; i < ACPI_NAME_SIZE; i++) {
+		if (!acpi_ut_valid_name_char(name[i], i)) {
+			return (FALSE);
+		}
+	}
+
+	return (TRUE);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_valid_name_char
+ *
+ * PARAMETERS:  char            - The character to be examined
+ *              position        - Byte position (0-3)
+ *
+ * RETURN:      TRUE if the character is valid, FALSE otherwise
+ *
+ * DESCRIPTION: Check for a valid ACPI character. Must be one of:
+ *              1) Upper case alpha
+ *              2) numeric
+ *              3) underscore
+ *
+ *              We allow a '!' as the last character because of the ASF! table
+ *
+ ******************************************************************************/
+
+u8 acpi_ut_valid_name_char(char character, u32 position)
+{
+
+	if (!((character >= 'A' && character <= 'Z') ||
+	      (character >= '0' && character <= '9') || (character == '_'))) {
+
+		/* Allow a '!' in the last position */
+
+		if (character == '!' && position == 3) {
+			return (TRUE);
+		}
+
+		return (FALSE);
+	}
+
+	return (TRUE);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_check_and_repair_ascii
+ *
+ * PARAMETERS:  name                - Ascii string
+ *              count               - Number of characters to check
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Ensure that the requested number of characters are printable
+ *              Ascii characters. Sets non-printable and null chars to <space>.
+ *
+ ******************************************************************************/
+
+void acpi_ut_check_and_repair_ascii(u8 *name, char *repaired_name, u32 count)
+{
+	u32 i;
+
+	for (i = 0; i < count; i++) {
+		repaired_name[i] = (char)name[i];
+
+		if (!name[i]) {
+			return;
+		}
+		if (!isprint(name[i])) {
+			repaired_name[i] = ' ';
+		}
+	}
+}
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 241259b..288913a 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -145,73 +145,6 @@ void acpi_ut_print_string(char *string, u16 max_length)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ut_valid_acpi_char
- *
- * PARAMETERS:  char            - The character to be examined
- *              position        - Byte position (0-3)
- *
- * RETURN:      TRUE if the character is valid, FALSE otherwise
- *
- * DESCRIPTION: Check for a valid ACPI character. Must be one of:
- *              1) Upper case alpha
- *              2) numeric
- *              3) underscore
- *
- *              We allow a '!' as the last character because of the ASF! table
- *
- ******************************************************************************/
-
-u8 acpi_ut_valid_acpi_char(char character, u32 position)
-{
-
-	if (!((character >= 'A' && character <= 'Z') ||
-	      (character >= '0' && character <= '9') || (character == '_'))) {
-
-		/* Allow a '!' in the last position */
-
-		if (character == '!' && position == 3) {
-			return (TRUE);
-		}
-
-		return (FALSE);
-	}
-
-	return (TRUE);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_valid_acpi_name
- *
- * PARAMETERS:  name            - The name to be examined. Does not have to
- *                                be NULL terminated string.
- *
- * RETURN:      TRUE if the name is valid, FALSE otherwise
- *
- * DESCRIPTION: Check for a valid ACPI name. Each character must be one of:
- *              1) Upper case alpha
- *              2) numeric
- *              3) underscore
- *
- ******************************************************************************/
-
-u8 acpi_ut_valid_acpi_name(char *name)
-{
-	u32 i;
-
-	ACPI_FUNCTION_ENTRY();
-
-	for (i = 0; i < ACPI_NAME_SIZE; i++) {
-		if (!acpi_ut_valid_acpi_char(name[i], i)) {
-			return (FALSE);
-		}
-	}
-
-	return (TRUE);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ut_repair_name
  *
  * PARAMETERS:  name            - The ACPI name to be repaired
@@ -253,7 +186,7 @@ void acpi_ut_repair_name(char *name)
 	/* Check each character in the name */
 
 	for (i = 0; i < ACPI_NAME_SIZE; i++) {
-		if (acpi_ut_valid_acpi_char(name[i], i)) {
+		if (acpi_ut_valid_name_char(name[i], i)) {
 			continue;
 		}
 
diff --git a/tools/power/acpi/tools/acpidump/Makefile b/tools/power/acpi/tools/acpidump/Makefile
index 8d76157..2942cdc 100644
--- a/tools/power/acpi/tools/acpidump/Makefile
+++ b/tools/power/acpi/tools/acpidump/Makefile
@@ -31,6 +31,7 @@ TOOL_OBJS = \
 	osunixxf.o\
 	tbprint.o\
 	tbxfroot.o\
+	utascii.o\
 	utbuffer.o\
 	utdebug.o\
 	utexcep.o\
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index a39e445..fb8f1d9 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -68,7 +68,7 @@ u8 ap_is_valid_header(struct acpi_table_header *table)
 
 		/* Make sure signature is all ASCII and a valid ACPI name */
 
-		if (!acpi_ut_valid_acpi_name(table->signature)) {
+		if (!acpi_ut_valid_nameseg(table->signature)) {
 			acpi_log_error("Table signature (0x%8.8X) is invalid\n",
 				       *(u32 *)table->signature);
 			return (FALSE);
@@ -407,6 +407,12 @@ int ap_dump_table_from_file(char *pathname)
 		return (-1);
 	}
 
+	if (!acpi_ut_valid_nameseg(table->signature)) {
+		acpi_log_error
+		    ("No valid ACPI signature was found in input file %s\n",
+		     pathname);
+	}
+
 	/* File must be at least as long as the table length */
 
 	if (table->length > file_size) {
-- 
1.7.10
