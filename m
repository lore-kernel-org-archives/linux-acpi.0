From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 27/32] ACPICA: Finish C library name transition.
Date: Fri, 19 Jun 2015 11:41:14 +0800
Message-ID: <edfb28643780789a104bae297fca39775db0c074.1434684720.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54944 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754412AbbFSDlU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jun 2015 23:41:20 -0400
In-Reply-To: <cover.1434684719.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 47d22a738d0e19fd241ffe4e3e9d4e198e4afc69

Cast various invocations as necessary.

Link: https://github.com/acpica/acpica/commit/47d22a73
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h             |   18 ------------------
 drivers/acpi/acpica/nsdump.c              |    2 +-
 drivers/acpi/acpica/nsrepair2.c           |    2 +-
 drivers/acpi/acpica/tbprint.c             |    2 +-
 drivers/acpi/acpica/utprint.c             |    6 +++---
 drivers/acpi/acpica/utstring.c            |   18 +++++++++---------
 tools/power/acpi/tools/acpidump/apfiles.c |    8 ++++----
 7 files changed, 19 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 6372a6b..ef1e51d 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -261,24 +261,6 @@ extern const u8 _acpi_ctype[];
 #define isprint(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_LO | _ACPI_UP | _ACPI_DI | _ACPI_XS | _ACPI_PU))
 #define isalpha(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_LO | _ACPI_UP))
 
-#ifndef ACPI_CLIBRARY
-#define strstr(s1,s2)       strstr ((s1), (s2))
-#define strchr(s1,c)        strchr ((s1), (c))
-#define strlen(s)           (acpi_size) strlen ((s))
-#define strcpy(d,s)         (void) strcpy ((d), (s))
-#define strncpy(d,s,n)      (void) strncpy ((d), (s), (acpi_size)(n))
-#define strncmp(d,s,n)      strncmp ((d), (s), (acpi_size)(n))
-#define strcmp(d,s)         strcmp ((d), (s))
-#define strcat(d,s)         (void) strcat ((d), (s))
-#define strncat(d,s,n)      strncat ((d), (s), (acpi_size)(n))
-#define strtoul(d,s,n)      strtoul ((d), (s), (acpi_size)(n))
-#define memcmp(s1,s2,n)     memcmp((void *)(s1), (void *)(s2), (acpi_size)(n))
-#define memcpy(d,s,n)       (void) memcpy ((d), (s), (acpi_size)(n))
-#define memset(d,v,n)       (void) memset ((d), (v), (acpi_size)(n))
-#define toupper(c)          toupper ((int) (c))
-#define tolower(c)          tolower ((int) (c))
-#endif				/* ACPI_CLIBRARY */
-
 #endif				/* !ACPI_USE_SYSTEM_CLIBRARY */
 
 #define ACPI_IS_ASCII(c)  ((c) < 0x80)
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index b5fcf65..0f1daba 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -101,7 +101,7 @@ void acpi_ns_print_pathname(u32 num_segments, char *pathname)
 
 	while (num_segments) {
 		for (i = 0; i < 4; i++) {
-			isprint(pathname[i]) ?
+			isprint((int)pathname[i]) ?
 			    acpi_os_printf("%c", pathname[i]) :
 			    acpi_os_printf("?");
 		}
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index abf8dff..0515a70 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -580,7 +580,7 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 	 * # is a hex digit.
 	 */
 	for (dest = new_string->string.pointer; *source; dest++, source++) {
-		*dest = (char)toupper(*source);
+		*dest = (char)toupper((int)*source);
 	}
 
 	acpi_ut_remove_reference(return_object);
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index c8ed532..709d511 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -73,7 +73,7 @@ static void acpi_tb_fix_string(char *string, acpi_size length)
 {
 
 	while (length && *string) {
-		if (!isprint(*string)) {
+		if (!isprint((int)*string)) {
 			*string = '?';
 		}
 		string++;
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 342b02e..b26297c 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -180,7 +180,7 @@ const char *acpi_ut_scan_number(const char *string, u64 *number_ptr)
 {
 	u64 number = 0;
 
-	while (isdigit(*string)) {
+	while (isdigit((int)*string)) {
 		number *= 10;
 		number += *(string++) - '0';
 	}
@@ -405,7 +405,7 @@ acpi_ut_vsnprintf(char *string,
 		/* Process width */
 
 		width = -1;
-		if (isdigit(*format)) {
+		if (isdigit((int)*format)) {
 			format = acpi_ut_scan_number(format, &number);
 			width = (s32) number;
 		} else if (*format == '*') {
@@ -422,7 +422,7 @@ acpi_ut_vsnprintf(char *string,
 		precision = -1;
 		if (*format == '.') {
 			++format;
-			if (isdigit(*format)) {
+			if (isdigit((int)*format)) {
 				format = acpi_ut_scan_number(format, &number);
 				precision = (s32) number;
 			} else if (*format == '*') {
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index e9dfafc..8f3c883 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -79,7 +79,7 @@ void acpi_ut_strlwr(char *src_string)
 	/* Walk entire string, lowercasing the letters */
 
 	for (string = src_string; *string; string++) {
-		*string = (char)tolower(*string);
+		*string = (char)tolower((int)*string);
 	}
 
 	return;
@@ -145,7 +145,7 @@ void acpi_ut_strupr(char *src_string)
 	/* Walk entire string, uppercasing the letters */
 
 	for (string = src_string; *string; string++) {
-		*string = (char)toupper(*string);
+		*string = (char)toupper((int)*string);
 	}
 
 	return;
@@ -202,7 +202,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 
 	/* Skip over any white space in the buffer */
 
-	while ((*string) && (isspace(*string) || *string == '\t')) {
+	while ((*string) && (isspace((int)*string) || *string == '\t')) {
 		string++;
 	}
 
@@ -211,7 +211,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 		 * Base equal to ACPI_ANY_BASE means 'ToInteger operation case'.
 		 * We need to determine if it is decimal or hexadecimal.
 		 */
-		if ((*string == '0') && (tolower(*(string + 1)) == 'x')) {
+		if ((*string == '0') && (tolower((int)*(string + 1)) == 'x')) {
 			sign_of0x = 1;
 			base = 16;
 
@@ -224,7 +224,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 
 	/* Any string left? Check that '0x' is not followed by white space. */
 
-	if (!(*string) || isspace(*string) || *string == '\t') {
+	if (!(*string) || isspace((int)*string) || *string == '\t') {
 		if (to_integer_op) {
 			goto error_exit;
 		} else {
@@ -241,7 +241,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 	/* Main loop: convert the string to a 32- or 64-bit integer */
 
 	while (*string) {
-		if (isdigit(*string)) {
+		if (isdigit((int)*string)) {
 
 			/* Convert ASCII 0-9 to Decimal value */
 
@@ -252,8 +252,8 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 
 			term = 1;
 		} else {
-			this_digit = (u8)toupper(*string);
-			if (isxdigit((char)this_digit)) {
+			this_digit = (u8)toupper((int)*string);
+			if (isxdigit((int)this_digit)) {
 
 				/* Convert ASCII Hex char to value */
 
@@ -404,7 +404,7 @@ void acpi_ut_print_string(char *string, u16 max_length)
 
 			/* Check for printable character or hex escape */
 
-			if (isprint(string[i])) {
+			if (isprint((int)string[i])) {
 				/* This is a normal character */
 
 				acpi_os_printf("%c", (int)string[i]);
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 9a26fb5..a37f970 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -136,10 +136,10 @@ int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 	} else {
 		ACPI_MOVE_NAME(filename, table->signature);
 	}
-	filename[0] = (char)tolower(filename[0]);
-	filename[1] = (char)tolower(filename[1]);
-	filename[2] = (char)tolower(filename[2]);
-	filename[3] = (char)tolower(filename[3]);
+	filename[0] = (char)tolower((int)filename[0]);
+	filename[1] = (char)tolower((int)filename[1]);
+	filename[2] = (char)tolower((int)filename[2]);
+	filename[3] = (char)tolower((int)filename[3]);
 	filename[ACPI_NAME_SIZE] = 0;
 
 	/* Handle multiple SSDts - create different filenames for each */
-- 
1.7.10

