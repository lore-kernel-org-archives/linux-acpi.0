From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/25] ACPICA: acpidump: Replace file IOs with new APIs to improve portability.
Date: Tue,  8 Jul 2014 10:07:46 +0800
Message-ID: <248578133a9b24bfe4b4b3474bbb0d99627f82d3.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50588 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbaGHCIJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:08:09 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

The new APIs are enabled to offer a portable layer to access files:
1. acpi_os_XXX_file_XXX: Wrapper of fopen/fclose/fread/fwrite
2. acpi_os_printf: Wrapper of printf
3. acpi_log_error: Wrapper of fprintf(stderr)

This patch deploys such mechanisms to acpidump to improve the portability
of this tool. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 tools/power/acpi/tools/acpidump/acpidump.h |    2 +-
 tools/power/acpi/tools/acpidump/apdump.c   |   65 ++++++++++++++--------------
 tools/power/acpi/tools/acpidump/apfiles.c  |   47 ++++++++++----------
 tools/power/acpi/tools/acpidump/apmain.c   |   27 ++++++------
 4 files changed, 69 insertions(+), 72 deletions(-)

diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
index 8efc848..a2d37d6 100644
--- a/tools/power/acpi/tools/acpidump/acpidump.h
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -68,7 +68,7 @@ EXTERN u8 INIT_GLOBAL(gbl_verbose_mode, FALSE);
 EXTERN u8 INIT_GLOBAL(gbl_binary_mode, FALSE);
 EXTERN u8 INIT_GLOBAL(gbl_dump_customized_tables, FALSE);
 EXTERN u8 INIT_GLOBAL(gbl_do_not_dump_xsdt, FALSE);
-EXTERN FILE INIT_GLOBAL(*gbl_output_file, NULL);
+EXTERN ACPI_FILE INIT_GLOBAL(gbl_output_file, NULL);
 EXTERN char INIT_GLOBAL(*gbl_output_filename, NULL);
 EXTERN u64 INIT_GLOBAL(gbl_rsdp_base, 0);
 
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index ccb6262..34fa5f2 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -69,17 +69,16 @@ u8 ap_is_valid_header(struct acpi_table_header *table)
 		/* Make sure signature is all ASCII and a valid ACPI name */
 
 		if (!acpi_ut_valid_acpi_name(table->signature)) {
-			fprintf(stderr,
-				"Table signature (0x%8.8X) is invalid\n",
-				*(u32 *)table->signature);
+			acpi_log_error("Table signature (0x%8.8X) is invalid\n",
+				       *(u32 *)table->signature);
 			return (FALSE);
 		}
 
 		/* Check for minimum table length */
 
 		if (table->length < sizeof(struct acpi_table_header)) {
-			fprintf(stderr, "Table length (0x%8.8X) is invalid\n",
-				table->length);
+			acpi_log_error("Table length (0x%8.8X) is invalid\n",
+				       table->length);
 			return (FALSE);
 		}
 	}
@@ -116,8 +115,8 @@ u8 ap_is_valid_checksum(struct acpi_table_header *table)
 	}
 
 	if (ACPI_FAILURE(status)) {
-		fprintf(stderr, "%4.4s: Warning: wrong checksum in table\n",
-			table->signature);
+		acpi_log_error("%4.4s: Warning: wrong checksum in table\n",
+			       table->signature);
 	}
 
 	return (AE_OK);
@@ -196,12 +195,12 @@ ap_dump_table_buffer(struct acpi_table_header *table,
 	 * Note: simplest to just always emit a 64-bit address. acpi_xtract
 	 * utility can handle this.
 	 */
-	printf("%4.4s @ 0x%8.8X%8.8X\n", table->signature,
-	       ACPI_FORMAT_UINT64(address));
+	acpi_os_printf("%4.4s @ 0x%8.8X%8.8X\n", table->signature,
+		       ACPI_FORMAT_UINT64(address));
 
 	acpi_ut_dump_buffer(ACPI_CAST_PTR(u8, table), table_length,
 			    DB_BYTE_DISPLAY, 0);
-	printf("\n");
+	acpi_os_printf("\n");
 	return (0);
 }
 
@@ -239,14 +238,14 @@ int ap_dump_all_tables(void)
 			if (status == AE_LIMIT) {
 				return (0);
 			} else if (i == 0) {
-				fprintf(stderr,
-					"Could not get ACPI tables, %s\n",
-					acpi_format_exception(status));
+				acpi_log_error
+				    ("Could not get ACPI tables, %s\n",
+				     acpi_format_exception(status));
 				return (-1);
 			} else {
-				fprintf(stderr,
-					"Could not get ACPI table at index %u, %s\n",
-					i, acpi_format_exception(status));
+				acpi_log_error
+				    ("Could not get ACPI table at index %u, %s\n",
+				     i, acpi_format_exception(status));
 				continue;
 			}
 		}
@@ -288,17 +287,17 @@ int ap_dump_table_by_address(char *ascii_address)
 
 	status = acpi_ut_strtoul64(ascii_address, 0, &long_address);
 	if (ACPI_FAILURE(status)) {
-		fprintf(stderr, "%s: Could not convert to a physical address\n",
-			ascii_address);
+		acpi_log_error("%s: Could not convert to a physical address\n",
+			       ascii_address);
 		return (-1);
 	}
 
 	address = (acpi_physical_address) long_address;
 	status = acpi_os_get_table_by_address(address, &table);
 	if (ACPI_FAILURE(status)) {
-		fprintf(stderr, "Could not get table at 0x%8.8X%8.8X, %s\n",
-			ACPI_FORMAT_UINT64(address),
-			acpi_format_exception(status));
+		acpi_log_error("Could not get table at 0x%8.8X%8.8X, %s\n",
+			       ACPI_FORMAT_UINT64(address),
+			       acpi_format_exception(status));
 		return (-1);
 	}
 
@@ -330,9 +329,9 @@ int ap_dump_table_by_name(char *signature)
 	int table_status;
 
 	if (ACPI_STRLEN(signature) != ACPI_NAME_SIZE) {
-		fprintf(stderr,
-			"Invalid table signature [%s]: must be exactly 4 characters\n",
-			signature);
+		acpi_log_error
+		    ("Invalid table signature [%s]: must be exactly 4 characters\n",
+		     signature);
 		return (-1);
 	}
 
@@ -362,9 +361,9 @@ int ap_dump_table_by_name(char *signature)
 				return (0);
 			}
 
-			fprintf(stderr,
-				"Could not get ACPI table with signature [%s], %s\n",
-				local_signature, acpi_format_exception(status));
+			acpi_log_error
+			    ("Could not get ACPI table with signature [%s], %s\n",
+			     local_signature, acpi_format_exception(status));
 			return (-1);
 		}
 
@@ -409,16 +408,16 @@ int ap_dump_table_from_file(char *pathname)
 	/* File must be at least as long as the table length */
 
 	if (table->length > file_size) {
-		fprintf(stderr,
-			"Table length (0x%X) is too large for input file (0x%X) %s\n",
-			table->length, file_size, pathname);
+		acpi_log_error
+		    ("Table length (0x%X) is too large for input file (0x%X) %s\n",
+		     table->length, file_size, pathname);
 		goto exit;
 	}
 
 	if (gbl_verbose_mode) {
-		fprintf(stderr,
-			"Input file:  %s contains table [%4.4s], 0x%X (%u) bytes\n",
-			pathname, table->signature, file_size, file_size);
+		acpi_log_error
+		    ("Input file:  %s contains table [%4.4s], 0x%X (%u) bytes\n",
+		     pathname, table->signature, file_size, file_size);
 	}
 
 	table_status = ap_dump_table_buffer(table, 0, 0);
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 1d12b9d..5699ca1 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -65,8 +65,7 @@ int ap_open_output_file(char *pathname)
 	/* If file exists, prompt for overwrite */
 
 	if (!stat(pathname, &stat_info)) {
-		fprintf(stderr,
-			"Target path already exists, overwrite? [y|n] ");
+		acpi_log_error("Target path already exists, overwrite? [y|n] ");
 
 		if (getchar() != 'y') {
 			return (-1);
@@ -106,7 +105,7 @@ int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 {
 	char filename[ACPI_NAME_SIZE + 16];
 	char instance_str[16];
-	FILE *file;
+	ACPI_FILE file;
 	size_t actual;
 	u32 table_length;
 
@@ -138,28 +137,29 @@ int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 	ACPI_STRCAT(filename, ACPI_TABLE_FILE_SUFFIX);
 
 	if (gbl_verbose_mode) {
-		fprintf(stderr,
-			"Writing [%4.4s] to binary file: %s 0x%X (%u) bytes\n",
-			table->signature, filename, table->length,
-			table->length);
+		acpi_log_error
+		    ("Writing [%4.4s] to binary file: %s 0x%X (%u) bytes\n",
+		     table->signature, filename, table->length, table->length);
 	}
 
 	/* Open the file and dump the entire table in binary mode */
 
-	file = fopen(filename, "wb");
+	file = acpi_os_open_file(filename,
+				 ACPI_FILE_WRITING | ACPI_FILE_BINARY);
 	if (!file) {
-		perror("Could not open output file");
+		acpi_log_error("Could not open output file: %s\n", filename);
 		return (-1);
 	}
 
-	actual = fwrite(table, 1, table_length, file);
+	actual = acpi_os_write_file(file, table, 1, table_length);
 	if (actual != table_length) {
-		perror("Error writing binary output file");
-		fclose(file);
+		acpi_log_error("Error writing binary output file: %s\n",
+			       filename);
+		acpi_os_close_file(file);
 		return (-1);
 	}
 
-	fclose(file);
+	acpi_os_close_file(file);
 	return (0);
 }
 
@@ -180,15 +180,16 @@ struct acpi_table_header *ap_get_table_from_file(char *pathname,
 						 u32 *out_file_size)
 {
 	struct acpi_table_header *buffer = NULL;
-	FILE *file;
+	ACPI_FILE file;
 	u32 file_size;
 	size_t actual;
 
 	/* Must use binary mode */
 
-	file = fopen(pathname, "rb");
+	file =
+	    acpi_os_open_file(pathname, ACPI_FILE_READING | ACPI_FILE_BINARY);
 	if (!file) {
-		perror("Could not open input file");
+		acpi_log_error("Could not open input file: %s\n", pathname);
 		return (NULL);
 	}
 
@@ -196,8 +197,7 @@ struct acpi_table_header *ap_get_table_from_file(char *pathname,
 
 	file_size = cm_get_file_size(file);
 	if (file_size == ACPI_UINT32_MAX) {
-		fprintf(stderr,
-			"Could not get input file size: %s\n", pathname);
+		acpi_log_error("Could not get input file size: %s\n", pathname);
 		goto cleanup;
 	}
 
@@ -205,17 +205,16 @@ struct acpi_table_header *ap_get_table_from_file(char *pathname,
 
 	buffer = ACPI_ALLOCATE_ZEROED(file_size);
 	if (!buffer) {
-		fprintf(stderr,
-			"Could not allocate file buffer of size: %u\n",
-			file_size);
+		acpi_log_error("Could not allocate file buffer of size: %u\n",
+			       file_size);
 		goto cleanup;
 	}
 
 	/* Read the entire file */
 
-	actual = fread(buffer, 1, file_size, file);
+	actual = acpi_os_read_file(file, buffer, 1, file_size);
 	if (actual != file_size) {
-		fprintf(stderr, "Could not read input file: %s\n", pathname);
+		acpi_log_error("Could not read input file: %s\n", pathname);
 		ACPI_FREE(buffer);
 		buffer = NULL;
 		goto cleanup;
@@ -224,6 +223,6 @@ struct acpi_table_header *ap_get_table_from_file(char *pathname,
 	*out_file_size = file_size;
 
 cleanup:
-	fclose(file);
+	acpi_os_close_file(file);
 	return (buffer);
 }
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 55fd44d..63f7bc9 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -140,8 +140,8 @@ static int ap_insert_action(char *argument, u32 to_be_done)
 
 	current_action++;
 	if (current_action > AP_MAX_ACTIONS) {
-		fprintf(stderr, "Too many table options (max %u)\n",
-			AP_MAX_ACTIONS);
+		acpi_log_error("Too many table options (max %u)\n",
+			       AP_MAX_ACTIONS);
 		return (-1);
 	}
 
@@ -203,9 +203,9 @@ static int ap_do_options(int argc, char **argv)
 			    acpi_ut_strtoul64(acpi_gbl_optarg, 0,
 					      &gbl_rsdp_base);
 			if (ACPI_FAILURE(status)) {
-				fprintf(stderr,
-					"%s: Could not convert to a physical address\n",
-					acpi_gbl_optarg);
+				acpi_log_error
+				    ("%s: Could not convert to a physical address\n",
+				     acpi_gbl_optarg);
 				return (-1);
 			}
 			continue;
@@ -226,13 +226,13 @@ static int ap_do_options(int argc, char **argv)
 
 		case 'v':	/* Revision/version */
 
-			printf(ACPI_COMMON_SIGNON(AP_UTILITY_NAME));
+			acpi_os_printf(ACPI_COMMON_SIGNON(AP_UTILITY_NAME));
 			return (1);
 
 		case 'z':	/* Verbose mode */
 
 			gbl_verbose_mode = TRUE;
-			fprintf(stderr, ACPI_COMMON_SIGNON(AP_UTILITY_NAME));
+			acpi_log_error(ACPI_COMMON_SIGNON(AP_UTILITY_NAME));
 			continue;
 
 			/*
@@ -338,9 +338,8 @@ int ACPI_SYSTEM_XFACE main(int argc, char *argv[])
 
 		default:
 
-			fprintf(stderr,
-				"Internal error, invalid action: 0x%X\n",
-				action->to_be_done);
+			acpi_log_error("Internal error, invalid action: 0x%X\n",
+				       action->to_be_done);
 			return (-1);
 		}
 
@@ -355,12 +354,12 @@ int ACPI_SYSTEM_XFACE main(int argc, char *argv[])
 			/* Summary for the output file */
 
 			file_size = cm_get_file_size(gbl_output_file);
-			fprintf(stderr,
-				"Output file %s contains 0x%X (%u) bytes\n\n",
-				gbl_output_filename, file_size, file_size);
+			acpi_log_error
+			    ("Output file %s contains 0x%X (%u) bytes\n\n",
+			     gbl_output_filename, file_size, file_size);
 		}
 
-		fclose(gbl_output_file);
+		acpi_os_close_file(gbl_output_file);
 	}
 
 	return (status);
-- 
1.7.10

