From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/42] ACPICA: Disassembler/tools: Support for multiple ACPI tables in one file
Date: Tue, 29 Dec 2015 13:54:58 +0800
Message-ID: <9d7f33a5063ba8e10ad34d2f91a19c11db39ed0b.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 5be7dc4d0d69b2953d156f5bc4d3e8a65a390837

Matches the support in iASL and acpi_exec.

Link: https://github.com/acpica/acpica/commit/5be7dc4d
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile   |    1 -
 drivers/acpi/acpica/acapps.h   |   39 ++---
 drivers/acpi/acpica/acdebug.h  |    5 +-
 drivers/acpi/acpica/aclocal.h  |    7 +
 drivers/acpi/acpica/acutils.h  |   12 --
 drivers/acpi/acpica/dbfileio.c |  123 ++------------
 drivers/acpi/acpica/dbinput.c  |   19 ++-
 drivers/acpi/acpica/tbxfload.c |    2 +-
 drivers/acpi/acpica/utfileio.c |  359 ----------------------------------------
 9 files changed, 53 insertions(+), 514 deletions(-)
 delete mode 100644 drivers/acpi/acpica/utfileio.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index e75f401..f682374 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -197,7 +197,6 @@ acpi-$(ACPI_FUTURE_USAGE) +=	\
 	dbfileio.o		\
 	dbtest.o		\
 	utcache.o		\
-	utfileio.o		\
 	utprint.o		\
 	uttrack.o		\
 	utuuid.o
diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index e4cc48f..185c2eb 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -44,6 +44,8 @@
 #ifndef _ACAPPS
 #define _ACAPPS
 
+#include <stdio.h>
+
 /* Common info for tool signons */
 
 #define ACPICA_NAME                 "Intel ACPI Component Architecture"
@@ -90,6 +92,18 @@
 #define FILE_SUFFIX_DISASSEMBLY     "dsl"
 #define FILE_SUFFIX_BINARY_TABLE    ".dat"	/* Needs the dot */
 
+/* acfileio */
+
+acpi_status
+acpi_ac_get_all_tables_from_file(char *filename,
+				 u8 get_only_aml_tables,
+				 struct acpi_new_table_desc **return_list_head);
+
+/* Values for get_only_aml_tables */
+
+#define ACPI_GET_ONLY_AML_TABLES    TRUE
+#define ACPI_GET_ALL_TABLES         FALSE
+
 /*
  * getopt
  */
@@ -107,30 +121,6 @@ extern char *acpi_gbl_optarg;
  */
 u32 cm_get_file_size(ACPI_FILE file);
 
-#ifndef ACPI_DUMP_APP
-/*
- * adisasm
- */
-acpi_status
-ad_aml_disassemble(u8 out_to_file,
-		   char *filename, char *prefix, char **out_filename);
-
-void ad_print_statistics(void);
-
-acpi_status ad_find_dsdt(u8 **dsdt_ptr, u32 *dsdt_length);
-
-void ad_dump_tables(void);
-
-acpi_status ad_get_local_tables(void);
-
-acpi_status
-ad_parse_table(struct acpi_table_header *table,
-	       acpi_owner_id * owner_id, u8 load_table, u8 external);
-
-acpi_status ad_display_tables(char *filename, struct acpi_table_header *table);
-
-acpi_status ad_display_statistics(void);
-
 /*
  * adwalk
  */
@@ -168,6 +158,5 @@ char *ad_generate_filename(char *prefix, char *table_id);
 void
 ad_write_table(struct acpi_table_header *table,
 	       u32 length, char *table_name, char *oem_table_id);
-#endif
 
 #endif				/* _ACAPPS */
diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index dcaa15d..ecb05f1 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -245,10 +245,7 @@ void acpi_db_open_debug_file(char *name);
 
 acpi_status acpi_db_load_acpi_table(char *filename);
 
-acpi_status
-acpi_db_get_table_from_file(char *filename,
-			    struct acpi_table_header **table,
-			    u8 must_be_aml_table);
+acpi_status acpi_db_load_tables(struct acpi_new_table_desc *list_head);
 
 /*
  * dbhistry - debugger HISTORY command
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index e1dd784..4fd5040 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -219,6 +219,13 @@ struct acpi_table_list {
 #define ACPI_ROOT_ORIGIN_ALLOCATED      (1)
 #define ACPI_ROOT_ALLOW_RESIZE          (2)
 
+/* List to manage incoming ACPI tables */
+
+struct acpi_new_table_desc {
+	struct acpi_table_header *table;
+	struct acpi_new_table_desc *next;
+};
+
 /* Predefined table indexes */
 
 #define ACPI_INVALID_TABLE_INDEX        (0xFFFFFFFF)
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 5d3ae91..6776348 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -353,18 +353,6 @@ acpi_ut_execute_power_methods(struct acpi_namespace_node *device_node,
 			      u8 method_count, u8 *out_values);
 
 /*
- * utfileio - file operations
- */
-#ifdef ACPI_APPLICATION
-
-acpi_status
-acpi_ut_read_tables_from_file(FILE * file, struct acpi_table_header **table);
-
-acpi_status
-acpi_ut_read_table_from_file(char *filename, struct acpi_table_header **table);
-#endif
-
-/*
  * utids - device ID support
  */
 acpi_status
diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.c
index d0e6b20..31f54d7 100644
--- a/drivers/acpi/acpica/dbfileio.c
+++ b/drivers/acpi/acpica/dbfileio.c
@@ -46,6 +46,10 @@
 #include "accommon.h"
 #include "acdebug.h"
 #include "actables.h"
+#include <stdio.h>
+#ifdef ACPI_APPLICATION
+#include "acapps.h"
+#endif
 
 #define _COMPONENT          ACPI_CA_DEBUGGER
 ACPI_MODULE_NAME("dbfileio")
@@ -110,122 +114,31 @@ void acpi_db_open_debug_file(char *name)
 }
 #endif
 
-#ifdef ACPI_APPLICATION
-#include "acapps.h"
-
-/*******************************************************************************
- *
- * FUNCTION:    ae_local_load_table
- *
- * PARAMETERS:  table           - pointer to a buffer containing the entire
- *                                table to be loaded
- *
- * RETURN:      Status
- *
- * DESCRIPTION: This function is called to load a table from the caller's
- *              buffer. The buffer must contain an entire ACPI Table including
- *              a valid header. The header fields will be verified, and if it
- *              is determined that the table is invalid, the call will fail.
- *
- ******************************************************************************/
-
-static acpi_status ae_local_load_table(struct acpi_table_header *table)
-{
-	acpi_status status = AE_OK;
-
-	ACPI_FUNCTION_TRACE(ae_local_load_table);
-
-#if 0
-/*    struct acpi_table_desc          table_info; */
-
-	if (!table) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
-	table_info.pointer = table;
-	status = acpi_tb_recognize_table(&table_info, ACPI_TABLE_ALL);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Install the new table into the local data structures */
-
-	status = acpi_tb_init_table_descriptor(&table_info);
-	if (ACPI_FAILURE(status)) {
-		if (status == AE_ALREADY_EXISTS) {
-
-			/* Table already exists, no error */
-
-			status = AE_OK;
-		}
-
-		/* Free table allocated by acpi_tb_get_table */
-
-		acpi_tb_delete_single_table(&table_info);
-		return_ACPI_STATUS(status);
-	}
-#if (!defined (ACPI_NO_METHOD_EXECUTION) && !defined (ACPI_CONSTANT_EVAL_ONLY))
-
-	status =
-	    acpi_ns_load_table(table_info.installed_desc, acpi_gbl_root_node);
-	if (ACPI_FAILURE(status)) {
-
-		/* Uninstall table and free the buffer */
-
-		acpi_tb_delete_tables_by_type(ACPI_TABLE_ID_DSDT);
-		return_ACPI_STATUS(status);
-	}
-#endif
-#endif
-
-	return_ACPI_STATUS(status);
-}
-#endif
-
 /*******************************************************************************
  *
- * FUNCTION:    acpi_db_get_table_from_file
+ * FUNCTION:    acpi_db_load_tables
  *
- * PARAMETERS:  filename        - File where table is located
- *              return_table    - Where a pointer to the table is returned
+ * PARAMETERS:  list_head       - List of ACPI tables to load
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Load an ACPI table from a file
+ * DESCRIPTION: Load ACPI tables from a previously constructed table list.
  *
  ******************************************************************************/
 
-acpi_status
-acpi_db_get_table_from_file(char *filename,
-			    struct acpi_table_header **return_table,
-			    u8 must_be_aml_file)
+acpi_status acpi_db_load_tables(struct acpi_new_table_desc *list_head)
 {
-#ifdef ACPI_APPLICATION
 	acpi_status status;
+	struct acpi_new_table_desc *table_list_head;
 	struct acpi_table_header *table;
-	u8 is_aml_table = TRUE;
-
-	status = acpi_ut_read_table_from_file(filename, &table);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
-
-	if (must_be_aml_file) {
-		is_aml_table = acpi_ut_is_aml_table(table);
-		if (!is_aml_table) {
-			ACPI_EXCEPTION((AE_INFO, AE_OK,
-					"Input for -e is not an AML table: "
-					"\"%4.4s\" (must be DSDT/SSDT)",
-					table->signature));
-			return (AE_TYPE);
-		}
-	}
 
-	if (is_aml_table) {
+	/* Load all ACPI tables in the list */
 
-		/* Attempt to recognize and install the table */
+	table_list_head = list_head;
+	while (table_list_head) {
+		table = table_list_head->table;
 
-		status = ae_local_load_table(table);
+		status = acpi_load_table(table);
 		if (ACPI_FAILURE(status)) {
 			if (status == AE_ALREADY_EXISTS) {
 				acpi_os_printf
@@ -239,18 +152,12 @@ acpi_db_get_table_from_file(char *filename,
 			return (status);
 		}
 
-		acpi_tb_print_table_header(0, table);
-
 		fprintf(stderr,
 			"Acpi table [%4.4s] successfully installed and loaded\n",
 			table->signature);
-	}
 
-	acpi_gbl_acpi_hardware_present = FALSE;
-	if (return_table) {
-		*return_table = table;
+		table_list_head = table_list_head->next;
 	}
 
-#endif				/* ACPI_APPLICATION */
 	return (AE_OK);
 }
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 2bf8e6b..71357fe 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -45,6 +45,10 @@
 #include "accommon.h"
 #include "acdebug.h"
 
+#ifdef ACPI_APPLICATION
+#include "acapps.h"
+#endif
+
 #define _COMPONENT          ACPI_CA_DEBUGGER
 ACPI_MODULE_NAME("dbinput")
 
@@ -1048,11 +1052,18 @@ acpi_db_command_dispatch(char *input_buffer,
 		acpi_db_close_debug_file();
 		break;
 
-	case CMD_LOAD:
+	case CMD_LOAD:{
+			struct acpi_new_table_desc *list_head = NULL;
 
-		status =
-		    acpi_db_get_table_from_file(acpi_gbl_db_args[1], NULL,
-						FALSE);
+			status =
+			    acpi_ac_get_all_tables_from_file(acpi_gbl_db_args
+							     [1],
+							     ACPI_GET_ALL_TABLES,
+							     &list_head);
+			if (ACPI_SUCCESS(status)) {
+				acpi_db_load_tables(list_head);
+			}
+		}
 		break;
 
 	case CMD_OPEN:
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 9a7d72b..ca2f136 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -207,7 +207,7 @@ acpi_status acpi_tb_load_namespace(void)
 
 	if (!tables_failed) {
 		ACPI_INFO((AE_INFO,
-			   "%u ACPI AML tables successfully acquired and loaded",
+			   "%u ACPI AML tables successfully acquired and loaded\n",
 			   tables_loaded));
 	} else {
 		ACPI_ERROR((AE_INFO,
diff --git a/drivers/acpi/acpica/utfileio.c b/drivers/acpi/acpica/utfileio.c
deleted file mode 100644
index e729486..0000000
--- a/drivers/acpi/acpica/utfileio.c
+++ /dev/null
@@ -1,359 +0,0 @@
-/*******************************************************************************
- *
- * Module Name: utfileio - simple file I/O routines
- *
- ******************************************************************************/
-
-/*
- * Copyright (C) 2000 - 2015, Intel Corp.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce at minimum a disclaimer
- *    substantially similar to the "NO WARRANTY" disclaimer below
- *    ("Disclaimer") and any redistribution must be conditioned upon
- *    including a substantially similar Disclaimer requirement for further
- *    binary redistribution.
- * 3. Neither the names of the above-listed copyright holders nor the names
- *    of any contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * Alternatively, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2 as published by the Free
- * Software Foundation.
- *
- * NO WARRANTY
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
- * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGES.
- */
-
-#include <acpi/acpi.h>
-#include "accommon.h"
-#include "actables.h"
-#include "acapps.h"
-#include "errno.h"
-
-#ifdef ACPI_ASL_COMPILER
-#include "aslcompiler.h"
-#endif
-
-#define _COMPONENT          ACPI_CA_DEBUGGER
-ACPI_MODULE_NAME("utfileio")
-
-#ifdef ACPI_APPLICATION
-/* Local prototypes */
-static acpi_status
-acpi_ut_check_text_mode_corruption(u8 *table,
-				   u32 table_length, u32 file_length);
-
-static acpi_status
-acpi_ut_read_table(FILE * fp,
-		   struct acpi_table_header **table, u32 *table_length);
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_check_text_mode_corruption
- *
- * PARAMETERS:  table           - Table buffer
- *              table_length    - Length of table from the table header
- *              file_length     - Length of the file that contains the table
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Check table for text mode file corruption where all linefeed
- *              characters (LF) have been replaced by carriage return linefeed
- *              pairs (CR/LF).
- *
- ******************************************************************************/
-
-static acpi_status
-acpi_ut_check_text_mode_corruption(u8 *table, u32 table_length, u32 file_length)
-{
-	u32 i;
-	u32 pairs = 0;
-
-	if (table_length != file_length) {
-		ACPI_WARNING((AE_INFO,
-			      "File length (0x%X) is not the same as the table length (0x%X)",
-			      file_length, table_length));
-	}
-
-	/* Scan entire table to determine if each LF has been prefixed with a CR */
-
-	for (i = 1; i < file_length; i++) {
-		if (table[i] == 0x0A) {
-			if (table[i - 1] != 0x0D) {
-
-				/* The LF does not have a preceding CR, table not corrupted */
-
-				return (AE_OK);
-			} else {
-				/* Found a CR/LF pair */
-
-				pairs++;
-			}
-
-			i++;
-		}
-	}
-
-	if (!pairs) {
-		return (AE_OK);
-	}
-
-	/*
-	 * Entire table scanned, each CR is part of a CR/LF pair --
-	 * meaning that the table was treated as a text file somewhere.
-	 *
-	 * NOTE: We can't "fix" the table, because any existing CR/LF pairs in the
-	 * original table are left untouched by the text conversion process --
-	 * meaning that we cannot simply replace CR/LF pairs with LFs.
-	 */
-	acpi_os_printf("Table has been corrupted by text mode conversion\n");
-	acpi_os_printf("All LFs (%u) were changed to CR/LF pairs\n", pairs);
-	acpi_os_printf("Table cannot be repaired!\n");
-
-	return (AE_BAD_VALUE);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_read_table
- *
- * PARAMETERS:  fp              - File that contains table
- *              table           - Return value, buffer with table
- *              table_length    - Return value, length of table
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Load the DSDT from the file pointer
- *
- ******************************************************************************/
-
-static acpi_status
-acpi_ut_read_table(FILE * fp,
-		   struct acpi_table_header **table, u32 *table_length)
-{
-	struct acpi_table_header table_header;
-	u32 actual;
-	acpi_status status;
-	u32 file_size;
-	u8 standard_header = TRUE;
-	s32 count;
-
-	/* Get the file size */
-
-	file_size = cm_get_file_size(fp);
-	if (file_size == ACPI_UINT32_MAX) {
-		return (AE_ERROR);
-	}
-
-	if (file_size < 4) {
-		return (AE_BAD_HEADER);
-	}
-
-	/* Read the signature */
-
-	fseek(fp, 0, SEEK_SET);
-
-	count = fread(&table_header, 1, sizeof(struct acpi_table_header), fp);
-	if (count != sizeof(struct acpi_table_header)) {
-		acpi_os_printf("Could not read the table header\n");
-		return (AE_BAD_HEADER);
-	}
-
-	/* The RSDP table does not have standard ACPI header */
-
-	if (ACPI_VALIDATE_RSDP_SIG(table_header.signature)) {
-		*table_length = file_size;
-		standard_header = FALSE;
-	} else {
-
-#if 0
-		/* Validate the table header/length */
-
-		status = acpi_tb_validate_table_header(&table_header);
-		if (ACPI_FAILURE(status)) {
-			acpi_os_printf("Table header is invalid!\n");
-			return (status);
-		}
-#endif
-
-		/* File size must be at least as long as the Header-specified length */
-
-		if (table_header.length > file_size) {
-			acpi_os_printf
-			    ("TableHeader length [0x%X] greater than the input file size [0x%X]\n",
-			     table_header.length, file_size);
-
-#ifdef ACPI_ASL_COMPILER
-			acpi_os_printf("File is corrupt or is ASCII text -- "
-				       "it must be a binary file\n");
-#endif
-			return (AE_BAD_HEADER);
-		}
-#ifdef ACPI_OBSOLETE_CODE
-		/* We only support a limited number of table types */
-
-		if (!ACPI_COMPARE_NAME
-		    ((char *)table_header.signature, ACPI_SIG_DSDT)
-		    && !ACPI_COMPARE_NAME((char *)table_header.signature,
-					  ACPI_SIG_PSDT)
-		    && !ACPI_COMPARE_NAME((char *)table_header.signature,
-					  ACPI_SIG_SSDT)) {
-			acpi_os_printf
-			    ("Table signature [%4.4s] is invalid or not supported\n",
-			     (char *)table_header.signature);
-			ACPI_DUMP_BUFFER(&table_header,
-					 sizeof(struct acpi_table_header));
-			return (AE_ERROR);
-		}
-#endif
-
-		*table_length = table_header.length;
-	}
-
-	/* Allocate a buffer for the table */
-
-	*table = acpi_os_allocate((size_t) file_size);
-	if (!*table) {
-		acpi_os_printf
-		    ("Could not allocate memory for ACPI table %4.4s (size=0x%X)\n",
-		     table_header.signature, *table_length);
-		return (AE_NO_MEMORY);
-	}
-
-	/* Get the rest of the table */
-
-	fseek(fp, 0, SEEK_SET);
-	actual = fread(*table, 1, (size_t) file_size, fp);
-	if (actual == file_size) {
-		if (standard_header) {
-
-			/* Now validate the checksum */
-
-			status = acpi_tb_verify_checksum((void *)*table,
-							 ACPI_CAST_PTR(struct
-								       acpi_table_header,
-								       *table)->
-							 length);
-
-			if (status == AE_BAD_CHECKSUM) {
-				status =
-				    acpi_ut_check_text_mode_corruption((u8 *)
-								       *table,
-								       file_size,
-								       (*table)->
-								       length);
-				return (status);
-			}
-		}
-		return (AE_OK);
-	}
-
-	if (actual > 0) {
-		acpi_os_printf("Warning - reading table, asked for %X got %X\n",
-			       file_size, actual);
-		return (AE_OK);
-	}
-
-	acpi_os_printf("Error - could not read the table file\n");
-	acpi_os_free(*table);
-	*table = NULL;
-	*table_length = 0;
-	return (AE_ERROR);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_read_table_from_file
- *
- * PARAMETERS:  filename         - File where table is located
- *              table            - Where a pointer to the table is returned
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Get an ACPI table from a file
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ut_read_tables_from_file(FILE * file, struct acpi_table_header ** table)
-{
-	struct acpi_table_header table_header;
-	s32 count;
-	long position;
-
-	position = ftell(file);
-	count = fread(&table_header, 1, sizeof(struct acpi_table_header), file);
-	if (count < sizeof(struct acpi_table_header)) {
-		return (AE_CTRL_TERMINATE);
-	}
-
-	/* Allocate a buffer for the table */
-
-	*table = acpi_os_allocate((size_t) table_header.length);
-	fseek(file, position, SEEK_SET);
-
-	count = fread(*table, 1, table_header.length, file);
-
-	return (AE_OK);
-}
-
-acpi_status
-acpi_ut_read_table_from_file(char *filename, struct acpi_table_header ** table)
-{
-	FILE *file;
-	u32 file_size;
-	u32 table_length;
-	acpi_status status = AE_ERROR;
-
-	/* Open the file, get current size */
-
-	file = fopen(filename, "rb");
-	if (!file) {
-		perror("Could not open input file");
-
-		if (errno == ENOENT) {
-			return (AE_NOT_EXIST);
-		}
-
-		return (status);
-	}
-
-	file_size = cm_get_file_size(file);
-	if (file_size == ACPI_UINT32_MAX) {
-		goto exit;
-	}
-
-	/* Get the entire file */
-
-	fprintf(stderr,
-		"Reading ACPI table from file %12s - Length %.8u (0x%06X)\n",
-		filename, file_size, file_size);
-
-	status = acpi_ut_read_table(file, table, &table_length);
-	if (ACPI_FAILURE(status)) {
-		acpi_os_printf("Could not get table from the file\n");
-	}
-
-exit:
-	fclose(file);
-	return (status);
-}
-
-#endif
-- 
1.7.10
