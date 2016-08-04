From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 24/30] ACPICA: Clib: Add -nostdinc support for EFI layer
Date: Thu,  4 Aug 2016 16:45:06 +0800
Message-ID: <2fb6b29f82d77ce0938c19ec21c922a3717051d9.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15630 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757476AbcHDIpQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:45:16 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit d261d40ea168f8e4c4e3986de720b8651c4aba1c

This patch adds sprintf()/snprintf()/vsnprintf()/printf()/vfprintf()
support for OSPMs that have ACPI_USE_SYSTEM_CLIBRARY defined but do not
have ACPI_USE_STANDARD_HEADERS defined.

-iwithprefix include is required to include <stdarg.h> which contains
compiler specific implementation of vargs when -nostdinc is specified.
-fno-builtin is required for GCC to avoid optimization performed printf().
This optimization cannot be automatically disabled by specifying -nostdlib.
Please refer to the Link 1 for the details. However, the build option
changes do not affect Linux kernel builds and are not included. Lv Zheng.

Link 1: http://www.ciselant.de/projects/gcc_printf/gcc_printf.html
Link: https://github.com/acpica/acpica/commit/d261d40e
Link: https://bugs.acpica.org/show_bug.cgi?id=1302
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acutils.h             |   19 ------
 drivers/acpi/acpica/utbuffer.c            |   30 ++++-----
 drivers/acpi/acpica/utdebug.c             |    2 +-
 drivers/acpi/acpica/utprint.c             |  104 +++++++++++++++++++++++++----
 tools/power/acpi/tools/acpidump/apdump.c  |    6 +-
 tools/power/acpi/tools/acpidump/apfiles.c |    3 +-
 6 files changed, 109 insertions(+), 55 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 91269a6..d899296 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -724,25 +724,6 @@ const struct ah_device_id *acpi_ah_match_hardware_id(char *hid);
 const char *acpi_ah_match_uuid(u8 *data);
 
 /*
- * utprint - printf/vprintf output functions
- */
-const char *acpi_ut_scan_number(const char *string, u64 *number_ptr);
-
-const char *acpi_ut_print_number(char *string, u64 number);
-
-int
-acpi_ut_vsnprintf(char *string,
-		  acpi_size size, const char *format, va_list args);
-
-int acpi_ut_snprintf(char *string, acpi_size size, const char *format, ...);
-
-#ifdef ACPI_APPLICATION
-int acpi_ut_file_vprintf(ACPI_FILE file, const char *format, va_list args);
-
-int acpi_ut_file_printf(ACPI_FILE file, const char *format, ...);
-#endif
-
-/*
  * utuuid -- UUID support functions
  */
 #if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP || defined ACPI_HELP_APP)
diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
index bd31faf..ff29812 100644
--- a/drivers/acpi/acpica/utbuffer.c
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -239,8 +239,7 @@ acpi_ut_dump_buffer_to_file(ACPI_FILE file,
 	u8 buf_char;
 
 	if (!buffer) {
-		acpi_ut_file_printf(file,
-				    "Null Buffer Pointer in DumpBuffer!\n");
+		fprintf(file, "Null Buffer Pointer in DumpBuffer!\n");
 		return;
 	}
 
@@ -254,7 +253,7 @@ acpi_ut_dump_buffer_to_file(ACPI_FILE file,
 
 		/* Print current offset */
 
-		acpi_ut_file_printf(file, "%6.4X: ", (base_offset + i));
+		fprintf(file, "%6.4X: ", (base_offset + i));
 
 		/* Print 16 hex chars */
 
@@ -263,8 +262,7 @@ acpi_ut_dump_buffer_to_file(ACPI_FILE file,
 
 				/* Dump fill spaces */
 
-				acpi_ut_file_printf(file, "%*s",
-						    ((display * 2) + 1), " ");
+				fprintf(file, "%*s", ((display * 2) + 1), " ");
 				j += display;
 				continue;
 			}
@@ -273,34 +271,34 @@ acpi_ut_dump_buffer_to_file(ACPI_FILE file,
 			case DB_BYTE_DISPLAY:
 			default:	/* Default is BYTE display */
 
-				acpi_ut_file_printf(file, "%02X ",
-						    buffer[(acpi_size)i + j]);
+				fprintf(file, "%02X ",
+					buffer[(acpi_size)i + j]);
 				break;
 
 			case DB_WORD_DISPLAY:
 
 				ACPI_MOVE_16_TO_32(&temp32,
 						   &buffer[(acpi_size)i + j]);
-				acpi_ut_file_printf(file, "%04X ", temp32);
+				fprintf(file, "%04X ", temp32);
 				break;
 
 			case DB_DWORD_DISPLAY:
 
 				ACPI_MOVE_32_TO_32(&temp32,
 						   &buffer[(acpi_size)i + j]);
-				acpi_ut_file_printf(file, "%08X ", temp32);
+				fprintf(file, "%08X ", temp32);
 				break;
 
 			case DB_QWORD_DISPLAY:
 
 				ACPI_MOVE_32_TO_32(&temp32,
 						   &buffer[(acpi_size)i + j]);
-				acpi_ut_file_printf(file, "%08X", temp32);
+				fprintf(file, "%08X", temp32);
 
 				ACPI_MOVE_32_TO_32(&temp32,
 						   &buffer[(acpi_size)i + j +
 							   4]);
-				acpi_ut_file_printf(file, "%08X ", temp32);
+				fprintf(file, "%08X ", temp32);
 				break;
 			}
 
@@ -311,24 +309,24 @@ acpi_ut_dump_buffer_to_file(ACPI_FILE file,
 		 * Print the ASCII equivalent characters but watch out for the bad
 		 * unprintable ones (printable chars are 0x20 through 0x7E)
 		 */
-		acpi_ut_file_printf(file, " ");
+		fprintf(file, " ");
 		for (j = 0; j < 16; j++) {
 			if (i + j >= count) {
-				acpi_ut_file_printf(file, "\n");
+				fprintf(file, "\n");
 				return;
 			}
 
 			buf_char = buffer[(acpi_size)i + j];
 			if (isprint(buf_char)) {
-				acpi_ut_file_printf(file, "%c", buf_char);
+				fprintf(file, "%c", buf_char);
 			} else {
-				acpi_ut_file_printf(file, ".");
+				fprintf(file, ".");
 			}
 		}
 
 		/* Done with that line. */
 
-		acpi_ut_file_printf(file, "\n");
+		fprintf(file, "\n");
 		i += 16;
 	}
 
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 84c0853..005a4a2 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -646,7 +646,7 @@ void ACPI_INTERNAL_VAR_XFACE acpi_log_error(const char *format, ...)
 	va_list args;
 
 	va_start(args, format);
-	(void)acpi_ut_file_vprintf(ACPI_FILE_ERR, format, args);
+	(void)vfprintf(ACPI_FILE_ERR, format, args);
 	va_end(args);
 }
 
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index dd084cf..13b8617 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -336,7 +336,7 @@ static char *acpi_ut_format_number(char *string,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ut_vsnprintf
+ * FUNCTION:    vsnprintf
  *
  * PARAMETERS:  string              - String with boundary
  *              size                - Boundary of the string
@@ -349,9 +349,7 @@ static char *acpi_ut_format_number(char *string,
  *
  ******************************************************************************/
 
-int
-acpi_ut_vsnprintf(char *string,
-		  acpi_size size, const char *format, va_list args)
+int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
 {
 	u8 base;
 	u8 type;
@@ -586,7 +584,7 @@ acpi_ut_vsnprintf(char *string,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ut_snprintf
+ * FUNCTION:    snprintf
  *
  * PARAMETERS:  string              - String with boundary
  *              size                - Boundary of the string
@@ -598,13 +596,38 @@ acpi_ut_vsnprintf(char *string,
  *
  ******************************************************************************/
 
-int acpi_ut_snprintf(char *string, acpi_size size, const char *format, ...)
+int snprintf(char *string, acpi_size size, const char *format, ...)
 {
 	va_list args;
 	int length;
 
 	va_start(args, format);
-	length = acpi_ut_vsnprintf(string, size, format, args);
+	length = vsnprintf(string, size, format, args);
+	va_end(args);
+
+	return (length);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    sprintf
+ *
+ * PARAMETERS:  string              - String with boundary
+ *              Format, ...         - Standard printf format
+ *
+ * RETURN:      Number of bytes actually written.
+ *
+ * DESCRIPTION: Formatted output to a string.
+ *
+ ******************************************************************************/
+
+int sprintf(char *string, const char *format, ...)
+{
+	va_list args;
+	int length;
+
+	va_start(args, format);
+	length = vsnprintf(string, ACPI_UINT32_MAX, format, args);
 	va_end(args);
 
 	return (length);
@@ -613,7 +636,60 @@ int acpi_ut_snprintf(char *string, acpi_size size, const char *format, ...)
 #ifdef ACPI_APPLICATION
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ut_file_vprintf
+ * FUNCTION:    vprintf
+ *
+ * PARAMETERS:  format              - Standard printf format
+ *              args                - Argument list
+ *
+ * RETURN:      Number of bytes actually written.
+ *
+ * DESCRIPTION: Formatted output to stdout using argument list pointer.
+ *
+ ******************************************************************************/
+
+int vprintf(const char *format, va_list args)
+{
+	acpi_cpu_flags flags;
+	int length;
+
+	flags = acpi_os_acquire_lock(acpi_gbl_print_lock);
+	length = vsnprintf(acpi_gbl_print_buffer,
+			   sizeof(acpi_gbl_print_buffer), format, args);
+
+	(void)acpi_os_write_file(ACPI_FILE_OUT, acpi_gbl_print_buffer, length,
+				 1);
+	acpi_os_release_lock(acpi_gbl_print_lock, flags);
+
+	return (length);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    printf
+ *
+ * PARAMETERS:  Format, ...         - Standard printf format
+ *
+ * RETURN:      Number of bytes actually written.
+ *
+ * DESCRIPTION: Formatted output to stdout.
+ *
+ ******************************************************************************/
+
+int printf(const char *format, ...)
+{
+	va_list args;
+	int length;
+
+	va_start(args, format);
+	length = vprintf(format, args);
+	va_end(args);
+
+	return (length);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    vfprintf
  *
  * PARAMETERS:  file                - File descriptor
  *              format              - Standard printf format
@@ -625,14 +701,14 @@ int acpi_ut_snprintf(char *string, acpi_size size, const char *format, ...)
  *
  ******************************************************************************/
 
-int acpi_ut_file_vprintf(ACPI_FILE file, const char *format, va_list args)
+int vfprintf(FILE * file, const char *format, va_list args)
 {
 	acpi_cpu_flags flags;
 	int length;
 
 	flags = acpi_os_acquire_lock(acpi_gbl_print_lock);
-	length = acpi_ut_vsnprintf(acpi_gbl_print_buffer,
-				   sizeof(acpi_gbl_print_buffer), format, args);
+	length = vsnprintf(acpi_gbl_print_buffer,
+			   sizeof(acpi_gbl_print_buffer), format, args);
 
 	(void)acpi_os_write_file(file, acpi_gbl_print_buffer, length, 1);
 	acpi_os_release_lock(acpi_gbl_print_lock, flags);
@@ -642,7 +718,7 @@ int acpi_ut_file_vprintf(ACPI_FILE file, const char *format, va_list args)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ut_file_printf
+ * FUNCTION:    fprintf
  *
  * PARAMETERS:  file                - File descriptor
  *              Format, ...         - Standard printf format
@@ -653,13 +729,13 @@ int acpi_ut_file_vprintf(ACPI_FILE file, const char *format, va_list args)
  *
  ******************************************************************************/
 
-int acpi_ut_file_printf(ACPI_FILE file, const char *format, ...)
+int fprintf(FILE * file, const char *format, ...)
 {
 	va_list args;
 	int length;
 
 	va_start(args, format);
-	length = acpi_ut_file_vprintf(file, format, args);
+	length = vfprintf(file, format, args);
 	va_end(args);
 
 	return (length);
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index fb8f1d9..2a1507c 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -195,13 +195,13 @@ ap_dump_table_buffer(struct acpi_table_header *table,
 	 * Note: simplest to just always emit a 64-bit address. acpi_xtract
 	 * utility can handle this.
 	 */
-	acpi_ut_file_printf(gbl_output_file, "%4.4s @ 0x%8.8X%8.8X\n",
-			    table->signature, ACPI_FORMAT_UINT64(address));
+	fprintf(gbl_output_file, "%4.4s @ 0x%8.8X%8.8X\n",
+		table->signature, ACPI_FORMAT_UINT64(address));
 
 	acpi_ut_dump_buffer_to_file(gbl_output_file,
 				    ACPI_CAST_PTR(u8, table), table_length,
 				    DB_BYTE_DISPLAY, 0);
-	acpi_ut_file_printf(gbl_output_file, "\n");
+	fprintf(gbl_output_file, "\n");
 	return (0);
 }
 
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 44a0010..71edeb4 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -157,8 +157,7 @@ int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 	/* Handle multiple SSDts - create different filenames for each */
 
 	if (instance > 0) {
-		acpi_ut_snprintf(instance_str, sizeof(instance_str), "%u",
-				 instance);
+		snprintf(instance_str, sizeof(instance_str), "%u", instance);
 		strcat(filename, instance_str);
 	}
 
-- 
1.7.10

