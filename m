From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 22/25] ACPICA: utprint/oslibcfs: cleanup - no functional change.
Date: Tue,  8 Jul 2014 10:08:13 +0800
Message-ID: <9de16d6826d14a70be597b3eb2611ddb83ab04a2.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50643 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbaGHCIR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:08:17 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Some cleanup and comment update.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utprint.c                      |   44 +++++++++++++-------
 .../acpi/os_specific/service_layers/oslibcfs.c     |   30 ++++++-------
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 9d5293f..1031164 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -67,6 +67,11 @@ static char *acpi_ut_format_number(char *string,
 
 static char *acpi_ut_put_number(char *string, u64 number, u8 base, u8 upper);
 
+/* Module globals */
+
+static const char acpi_gbl_lower_hex_digits[] = "0123456789abcdef";
+static const char acpi_gbl_upper_hex_digits[] = "0123456789ABCDEF";
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_bound_string_length
@@ -74,7 +79,7 @@ static char *acpi_ut_put_number(char *string, u64 number, u8 base, u8 upper);
  * PARAMETERS:  string              - String with boundary
  *              count               - Boundary of the string
  *
- * RETURN:      Length of the string.
+ * RETURN:      Length of the string. Less than or equal to Count.
  *
  * DESCRIPTION: Calculate the length of a string with boundary.
  *
@@ -114,8 +119,8 @@ static char *acpi_ut_bound_string_output(char *string, const char *end, char c)
 	if (string < end) {
 		*string = c;
 	}
-	++string;
 
+	++string;
 	return (string);
 }
 
@@ -137,14 +142,12 @@ static char *acpi_ut_bound_string_output(char *string, const char *end, char c)
 
 static char *acpi_ut_put_number(char *string, u64 number, u8 base, u8 upper)
 {
-	const char lower_digits[] = "0123456789abcdef";
-	const char upper_digits[] = "0123456789ABCDEF";
 	const char *digits;
 	u64 digit_index;
 	char *pos;
 
 	pos = string;
-	digits = upper ? upper_digits : lower_digits;
+	digits = upper ? acpi_gbl_upper_hex_digits : acpi_gbl_lower_hex_digits;
 
 	if (number == 0) {
 		*(pos++) = '0';
@@ -155,8 +158,8 @@ static char *acpi_ut_put_number(char *string, u64 number, u8 base, u8 upper)
 			*(pos++) = digits[digit_index];
 		}
 	}
-	/* *(Pos++) = '0'; */
 
+	/* *(Pos++) = '0'; */
 	return (pos);
 }
 
@@ -181,8 +184,8 @@ const char *acpi_ut_scan_number(const char *string, u64 *number_ptr)
 		number *= 10;
 		number += *(string++) - '0';
 	}
-	*number_ptr = number;
 
+	*number_ptr = number;
 	return (string);
 }
 
@@ -211,8 +214,8 @@ const char *acpi_ut_print_number(char *string, u64 number)
 	while (pos1 != ascii_string) {
 		*(pos2++) = *(--pos1);
 	}
-	*pos2 = 0;
 
+	*pos2 = 0;
 	return (string);
 }
 
@@ -246,11 +249,12 @@ static char *acpi_ut_format_number(char *string,
 	s32 i;
 	char reversed_string[66];
 
-	/* Perform sanity checks */
+	/* Parameter validation */
 
 	if (base < 2 || base > 16) {
-		return NULL;
+		return (NULL);
 	}
+
 	if (type & ACPI_FORMAT_LEFT) {
 		type &= ~ACPI_FORMAT_ZERO;
 	}
@@ -294,6 +298,7 @@ static char *acpi_ut_format_number(char *string,
 	if (i > precision) {
 		precision = i;
 	}
+
 	width -= precision;
 
 	/* Output the string */
@@ -318,6 +323,7 @@ static char *acpi_ut_format_number(char *string,
 			string = acpi_ut_bound_string_output(string, end, zero);
 		}
 	}
+
 	while (i <= --precision) {
 		string = acpi_ut_bound_string_output(string, end, '0');
 	}
@@ -341,7 +347,7 @@ static char *acpi_ut_format_number(char *string,
  *              format              - Standard printf format
  *              args                - Argument list
  *
- * RETURN:      Size of successfully output bytes
+ * RETURN:      Number of bytes actually written.
  *
  * DESCRIPTION: Formatted output to a string using argument list pointer.
  *
@@ -428,6 +434,7 @@ acpi_ut_vsnprintf(char *string,
 		if (*format == 'h' || *format == 'l' || *format == 'L') {
 			qualifier = *format;
 			++format;
+
 			if (qualifier == 'l' && *format == 'l') {
 				qualifier = 'L';
 				++format;
@@ -450,8 +457,10 @@ acpi_ut_vsnprintf(char *string,
 									' ');
 				}
 			}
+
 			c = (char)va_arg(args, int);
 			pos = acpi_ut_bound_string_output(pos, end, c);
+
 			while (--width > 0) {
 				pos =
 				    acpi_ut_bound_string_output(pos, end, ' ');
@@ -512,10 +521,11 @@ acpi_ut_vsnprintf(char *string,
 				width = 2 * sizeof(void *);
 				type |= ACPI_FORMAT_ZERO;
 			}
+
 			p = va_arg(args, void *);
 			pos = acpi_ut_format_number(pos, end,
-						    ACPI_TO_INTEGER(p),
-						    16, width, precision, type);
+						    ACPI_TO_INTEGER(p), 16,
+						    width, precision, type);
 			continue;
 
 		default:
@@ -552,6 +562,7 @@ acpi_ut_vsnprintf(char *string,
 				number = (signed int)number;
 			}
 		}
+
 		pos = acpi_ut_format_number(pos, end, number, base,
 					    width, precision, type);
 	}
@@ -575,7 +586,7 @@ acpi_ut_vsnprintf(char *string,
  *              size                - Boundary of the string
  *              Format, ...         - Standard printf format
  *
- * RETURN:      Size of successfully output bytes
+ * RETURN:      Number of bytes actually written.
  *
  * DESCRIPTION: Formatted output to a string.
  *
@@ -602,7 +613,7 @@ int acpi_ut_snprintf(char *string, acpi_size size, const char *format, ...)
  *              format              - Standard printf format
  *              args                - Argument list
  *
- * RETURN:      Size of successfully output bytes
+ * RETURN:      Number of bytes actually written.
  *
  * DESCRIPTION: Formatted output to a file using argument list pointer.
  *
@@ -616,6 +627,7 @@ int acpi_ut_file_vprintf(ACPI_FILE file, const char *format, va_list args)
 	flags = acpi_os_acquire_lock(acpi_gbl_print_lock);
 	length = acpi_ut_vsnprintf(acpi_gbl_print_buffer,
 				   sizeof(acpi_gbl_print_buffer), format, args);
+
 	(void)acpi_os_write_file(file, acpi_gbl_print_buffer, length, 1);
 	acpi_os_release_lock(acpi_gbl_print_lock, flags);
 
@@ -629,7 +641,7 @@ int acpi_ut_file_vprintf(ACPI_FILE file, const char *format, va_list args)
  * PARAMETERS:  file                - File descriptor
  *              Format, ...         - Standard printf format
  *
- * RETURN:      Size of successfully output bytes
+ * RETURN:      Number of bytes actually written.
  *
  * DESCRIPTION: Formatted output to a file.
  *
diff --git a/tools/power/acpi/os_specific/service_layers/oslibcfs.c b/tools/power/acpi/os_specific/service_layers/oslibcfs.c
index 2da0ce8..c13ff9c 100644
--- a/tools/power/acpi/os_specific/service_layers/oslibcfs.c
+++ b/tools/power/acpi/os_specific/service_layers/oslibcfs.c
@@ -1,6 +1,6 @@
 /******************************************************************************
  *
- * Module Name: oslibcfs - C library OSL for file IO
+ * Module Name: oslibcfs - C library OSL for file I/O
  *
  *****************************************************************************/
 
@@ -64,8 +64,8 @@ ACPI_MODULE_NAME("oslibcfs")
 ACPI_FILE acpi_os_open_file(const char *path, u8 modes)
 {
 	ACPI_FILE file;
-	char modes_str[4];
 	u32 i = 0;
+	char modes_str[4];
 
 	if (modes & ACPI_FILE_READING) {
 		modes_str[i++] = 'r';
@@ -76,6 +76,7 @@ ACPI_FILE acpi_os_open_file(const char *path, u8 modes)
 	if (modes & ACPI_FILE_BINARY) {
 		modes_str[i++] = 'b';
 	}
+
 	modes_str[i++] = '\0';
 
 	file = fopen(path, modes_str);
@@ -90,11 +91,11 @@ ACPI_FILE acpi_os_open_file(const char *path, u8 modes)
  *
  * FUNCTION:    acpi_os_close_file
  *
- * PARAMETERS:  file                - File descriptor
+ * PARAMETERS:  file                - An open file descriptor
  *
  * RETURN:      None.
  *
- * DESCRIPTION: Close a file.
+ * DESCRIPTION: Close a file opened via acpi_os_open_file.
  *
  ******************************************************************************/
 
@@ -107,14 +108,14 @@ void acpi_os_close_file(ACPI_FILE file)
  *
  * FUNCTION:    acpi_os_read_file
  *
- * PARAMETERS:  file                - File descriptor
+ * PARAMETERS:  file                - An open file descriptor
  *              buffer              - Data buffer
  *              size                - Data block size
  *              count               - Number of data blocks
  *
- * RETURN:      Size of successfully read buffer.
+ * RETURN:      Number of bytes actually read.
  *
- * DESCRIPTION: Read a file.
+ * DESCRIPTION: Read from a file.
  *
  ******************************************************************************/
 
@@ -135,14 +136,14 @@ acpi_os_read_file(ACPI_FILE file, void *buffer, acpi_size size, acpi_size count)
  *
  * FUNCTION:    acpi_os_write_file
  *
- * PARAMETERS:  file                - File descriptor
+ * PARAMETERS:  file                - An open file descriptor
  *              buffer              - Data buffer
  *              size                - Data block size
  *              count               - Number of data blocks
  *
- * RETURN:      Size of successfully written buffer.
+ * RETURN:      Number of bytes actually written.
  *
- * DESCRIPTION: Write a file.
+ * DESCRIPTION: Write to a file.
  *
  ******************************************************************************/
 
@@ -164,9 +165,9 @@ acpi_os_write_file(ACPI_FILE file,
  *
  * FUNCTION:    acpi_os_get_file_offset
  *
- * PARAMETERS:  file                - File descriptor
+ * PARAMETERS:  file                - An open file descriptor
  *
- * RETURN:      Size of current position.
+ * RETURN:      Current file pointer position.
  *
  * DESCRIPTION: Get current file offset.
  *
@@ -177,7 +178,6 @@ long acpi_os_get_file_offset(ACPI_FILE file)
 	long offset;
 
 	offset = ftell(file);
-
 	return (offset);
 }
 
@@ -185,8 +185,8 @@ long acpi_os_get_file_offset(ACPI_FILE file)
  *
  * FUNCTION:    acpi_os_set_file_offset
  *
- * PARAMETERS:  file                - File descriptor
- *              offset              - File offset
+ * PARAMETERS:  file                - An open file descriptor
+ *              offset              - New file offset
  *              from                - From begin/end of file
  *
  * RETURN:      Status
-- 
1.7.10

