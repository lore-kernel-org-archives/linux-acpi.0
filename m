From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/16] ACPICA: Split table print utilities to a new a separate file
Date: Sat,  8 Jun 2013 08:59:02 +0800
Message-ID: <98af6637d808d7c3072853b37f4502e5cf56000e.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19869 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813Ab3FHA73 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 20:59:29 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Improves configurability of ACPICA.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile  |    1 +
 drivers/acpi/acpica/tbprint.c |  237 +++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/tbutils.c |  191 +--------------------------------
 3 files changed, 239 insertions(+), 190 deletions(-)
 create mode 100644 drivers/acpi/acpica/tbprint.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 987bf41..4383040 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -138,6 +138,7 @@ acpi-y +=		\
 	tbfadt.o	\
 	tbfind.o	\
 	tbinstal.o	\
+	tbprint.o	\
 	tbutils.o	\
 	tbxface.o	\
 	tbxfload.o	\
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
new file mode 100644
index 0000000..dc963f8
--- /dev/null
+++ b/drivers/acpi/acpica/tbprint.c
@@ -0,0 +1,237 @@
+/******************************************************************************
+ *
+ * Module Name: tbprint - Table output utilities
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2013, Intel Corp.
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
+#include "actables.h"
+
+#define _COMPONENT          ACPI_TABLES
+ACPI_MODULE_NAME("tbprint")
+
+/* Local prototypes */
+static void acpi_tb_fix_string(char *string, acpi_size length);
+
+static void
+acpi_tb_cleanup_table_header(struct acpi_table_header *out_header,
+			     struct acpi_table_header *header);
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_fix_string
+ *
+ * PARAMETERS:  string              - String to be repaired
+ *              length              - Maximum length
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Replace every non-printable or non-ascii byte in the string
+ *              with a question mark '?'.
+ *
+ ******************************************************************************/
+
+static void acpi_tb_fix_string(char *string, acpi_size length)
+{
+
+	while (length && *string) {
+		if (!ACPI_IS_PRINT(*string)) {
+			*string = '?';
+		}
+		string++;
+		length--;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_cleanup_table_header
+ *
+ * PARAMETERS:  out_header          - Where the cleaned header is returned
+ *              header              - Input ACPI table header
+ *
+ * RETURN:      Returns the cleaned header in out_header
+ *
+ * DESCRIPTION: Copy the table header and ensure that all "string" fields in
+ *              the header consist of printable characters.
+ *
+ ******************************************************************************/
+
+static void
+acpi_tb_cleanup_table_header(struct acpi_table_header *out_header,
+			     struct acpi_table_header *header)
+{
+
+	ACPI_MEMCPY(out_header, header, sizeof(struct acpi_table_header));
+
+	acpi_tb_fix_string(out_header->signature, ACPI_NAME_SIZE);
+	acpi_tb_fix_string(out_header->oem_id, ACPI_OEM_ID_SIZE);
+	acpi_tb_fix_string(out_header->oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	acpi_tb_fix_string(out_header->asl_compiler_id, ACPI_NAME_SIZE);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_print_table_header
+ *
+ * PARAMETERS:  address             - Table physical address
+ *              header              - Table header
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print an ACPI table header. Special cases for FACS and RSDP.
+ *
+ ******************************************************************************/
+
+void
+acpi_tb_print_table_header(acpi_physical_address address,
+			   struct acpi_table_header *header)
+{
+	struct acpi_table_header local_header;
+
+	/*
+	 * The reason that the Address is cast to a void pointer is so that we
+	 * can use %p which will work properly on both 32-bit and 64-bit hosts.
+	 */
+	if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_FACS)) {
+
+		/* FACS only has signature and length fields */
+
+		ACPI_INFO((AE_INFO, "%4.4s %p %05X",
+			   header->signature, ACPI_CAST_PTR(void, address),
+			   header->length));
+	} else if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_RSDP)) {
+
+		/* RSDP has no common fields */
+
+		ACPI_MEMCPY(local_header.oem_id,
+			    ACPI_CAST_PTR(struct acpi_table_rsdp,
+					  header)->oem_id, ACPI_OEM_ID_SIZE);
+		acpi_tb_fix_string(local_header.oem_id, ACPI_OEM_ID_SIZE);
+
+		ACPI_INFO((AE_INFO, "RSDP %p %05X (v%.2d %6.6s)",
+			   ACPI_CAST_PTR(void, address),
+			   (ACPI_CAST_PTR(struct acpi_table_rsdp, header)->
+			    revision >
+			    0) ? ACPI_CAST_PTR(struct acpi_table_rsdp,
+					       header)->length : 20,
+			   ACPI_CAST_PTR(struct acpi_table_rsdp,
+					 header)->revision,
+			   local_header.oem_id));
+	} else {
+		/* Standard ACPI table with full common header */
+
+		acpi_tb_cleanup_table_header(&local_header, header);
+
+		ACPI_INFO((AE_INFO,
+			   "%4.4s %p %05X (v%.2d %6.6s %8.8s %08X %4.4s %08X)",
+			   local_header.signature, ACPI_CAST_PTR(void, address),
+			   local_header.length, local_header.revision,
+			   local_header.oem_id, local_header.oem_table_id,
+			   local_header.oem_revision,
+			   local_header.asl_compiler_id,
+			   local_header.asl_compiler_revision));
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_validate_checksum
+ *
+ * PARAMETERS:  table               - ACPI table to verify
+ *              length              - Length of entire table
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Verifies that the table checksums to zero. Optionally returns
+ *              exception on bad checksum.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length)
+{
+	u8 checksum;
+
+	/* Compute the checksum on the table */
+
+	checksum = acpi_tb_checksum(ACPI_CAST_PTR(u8, table), length);
+
+	/* Checksum ok? (should be zero) */
+
+	if (checksum) {
+		ACPI_BIOS_WARNING((AE_INFO,
+				   "Incorrect checksum in table [%4.4s] - 0x%2.2X, "
+				   "should be 0x%2.2X",
+				   table->signature, table->checksum,
+				   (u8)(table->checksum - checksum)));
+
+#if (ACPI_CHECKSUM_ABORT)
+		return (AE_BAD_CHECKSUM);
+#endif
+	}
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_checksum
+ *
+ * PARAMETERS:  buffer          - Pointer to memory region to be checked
+ *              length          - Length of this memory region
+ *
+ * RETURN:      Checksum (u8)
+ *
+ * DESCRIPTION: Calculates circular checksum of memory region.
+ *
+ ******************************************************************************/
+
+u8 acpi_tb_checksum(u8 *buffer, u32 length)
+{
+	u8 sum = 0;
+	u8 *end = buffer + length;
+
+	while (buffer < end) {
+		sum = (u8)(sum + *(buffer++));
+	}
+
+	return (sum);
+}
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index ce3d5db..bffdfc7 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -1,6 +1,6 @@
 /******************************************************************************
  *
- * Module Name: tbutils   - table utilities
+ * Module Name: tbutils - ACPI Table utilities
  *
  *****************************************************************************/
 
@@ -49,12 +49,6 @@
 ACPI_MODULE_NAME("tbutils")
 
 /* Local prototypes */
-static void acpi_tb_fix_string(char *string, acpi_size length);
-
-static void
-acpi_tb_cleanup_table_header(struct acpi_table_header *out_header,
-			     struct acpi_table_header *header);
-
 static acpi_physical_address
 acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
 
@@ -176,189 +170,6 @@ u8 acpi_tb_tables_loaded(void)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_fix_string
- *
- * PARAMETERS:  string              - String to be repaired
- *              length              - Maximum length
- *
- * RETURN:      None
- *
- * DESCRIPTION: Replace every non-printable or non-ascii byte in the string
- *              with a question mark '?'.
- *
- ******************************************************************************/
-
-static void acpi_tb_fix_string(char *string, acpi_size length)
-{
-
-	while (length && *string) {
-		if (!ACPI_IS_PRINT(*string)) {
-			*string = '?';
-		}
-		string++;
-		length--;
-	}
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_tb_cleanup_table_header
- *
- * PARAMETERS:  out_header          - Where the cleaned header is returned
- *              header              - Input ACPI table header
- *
- * RETURN:      Returns the cleaned header in out_header
- *
- * DESCRIPTION: Copy the table header and ensure that all "string" fields in
- *              the header consist of printable characters.
- *
- ******************************************************************************/
-
-static void
-acpi_tb_cleanup_table_header(struct acpi_table_header *out_header,
-			     struct acpi_table_header *header)
-{
-
-	ACPI_MEMCPY(out_header, header, sizeof(struct acpi_table_header));
-
-	acpi_tb_fix_string(out_header->signature, ACPI_NAME_SIZE);
-	acpi_tb_fix_string(out_header->oem_id, ACPI_OEM_ID_SIZE);
-	acpi_tb_fix_string(out_header->oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
-	acpi_tb_fix_string(out_header->asl_compiler_id, ACPI_NAME_SIZE);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_tb_print_table_header
- *
- * PARAMETERS:  address             - Table physical address
- *              header              - Table header
- *
- * RETURN:      None
- *
- * DESCRIPTION: Print an ACPI table header. Special cases for FACS and RSDP.
- *
- ******************************************************************************/
-
-void
-acpi_tb_print_table_header(acpi_physical_address address,
-			   struct acpi_table_header *header)
-{
-	struct acpi_table_header local_header;
-
-	/*
-	 * The reason that the Address is cast to a void pointer is so that we
-	 * can use %p which will work properly on both 32-bit and 64-bit hosts.
-	 */
-	if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_FACS)) {
-
-		/* FACS only has signature and length fields */
-
-		ACPI_INFO((AE_INFO, "%4.4s %p %05X",
-			   header->signature, ACPI_CAST_PTR(void, address),
-			   header->length));
-	} else if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_RSDP)) {
-
-		/* RSDP has no common fields */
-
-		ACPI_MEMCPY(local_header.oem_id,
-			    ACPI_CAST_PTR(struct acpi_table_rsdp,
-					  header)->oem_id, ACPI_OEM_ID_SIZE);
-		acpi_tb_fix_string(local_header.oem_id, ACPI_OEM_ID_SIZE);
-
-		ACPI_INFO((AE_INFO, "RSDP %p %05X (v%.2d %6.6s)",
-			   ACPI_CAST_PTR (void, address),
-			   (ACPI_CAST_PTR(struct acpi_table_rsdp, header)->
-			    revision >
-			    0) ? ACPI_CAST_PTR(struct acpi_table_rsdp,
-					       header)->length : 20,
-			   ACPI_CAST_PTR(struct acpi_table_rsdp,
-					 header)->revision,
-			   local_header.oem_id));
-	} else {
-		/* Standard ACPI table with full common header */
-
-		acpi_tb_cleanup_table_header(&local_header, header);
-
-		ACPI_INFO((AE_INFO,
-			   "%4.4s %p %05X (v%.2d %6.6s %8.8s %08X %4.4s %08X)",
-			   local_header.signature, ACPI_CAST_PTR(void, address),
-			   local_header.length, local_header.revision,
-			   local_header.oem_id, local_header.oem_table_id,
-			   local_header.oem_revision,
-			   local_header.asl_compiler_id,
-			   local_header.asl_compiler_revision));
-
-	}
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_tb_validate_checksum
- *
- * PARAMETERS:  table               - ACPI table to verify
- *              length              - Length of entire table
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Verifies that the table checksums to zero. Optionally returns
- *              exception on bad checksum.
- *
- ******************************************************************************/
-
-acpi_status acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length)
-{
-	u8 checksum;
-
-	/* Compute the checksum on the table */
-
-	checksum = acpi_tb_checksum(ACPI_CAST_PTR(u8, table), length);
-
-	/* Checksum ok? (should be zero) */
-
-	if (checksum) {
-		ACPI_BIOS_WARNING((AE_INFO,
-				   "Incorrect checksum in table [%4.4s] - 0x%2.2X, "
-				   "should be 0x%2.2X",
-				   table->signature, table->checksum,
-				   (u8)(table->checksum - checksum)));
-
-#if (ACPI_CHECKSUM_ABORT)
-
-		return (AE_BAD_CHECKSUM);
-#endif
-	}
-
-	return (AE_OK);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_tb_checksum
- *
- * PARAMETERS:  buffer          - Pointer to memory region to be checked
- *              length          - Length of this memory region
- *
- * RETURN:      Checksum (u8)
- *
- * DESCRIPTION: Calculates circular checksum of memory region.
- *
- ******************************************************************************/
-
-u8 acpi_tb_checksum(u8 *buffer, u32 length)
-{
-	u8 sum = 0;
-	u8 *end = buffer + length;
-
-	while (buffer < end) {
-		sum = (u8) (sum + *(buffer++));
-	}
-
-	return (sum);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_tb_check_dsdt_header
  *
  * PARAMETERS:  None
-- 
1.7.10

