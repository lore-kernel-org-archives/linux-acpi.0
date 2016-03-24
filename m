From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/30] ACPICA: Utilities: Update for strtoul64 merger
Date: Thu, 24 Mar 2016 09:40:33 +0800
Message-ID: <59c0e58f7a1e007f3ea0d1cd2ddf4fb3ba445e76.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 795e136d2ac77c1c8b091fba019b5fe36a44a323

Fixes a problem with the merger of the two internal versions
of this function. Make the maximum integer width (32-bit or
64-bit) a parameter to the function so that it no longer
exclusively uses the integer width specified in the DSDT/SSDT.
ACPICA BZ 1260

Link: https://github.com/acpica/acpica/commit/795e136d
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h            |    9 +++-
 drivers/acpi/acpica/dbconvert.c          |    4 +-
 drivers/acpi/acpica/exconvrt.c           |    4 +-
 drivers/acpi/acpica/nsconvert.c          |    3 +-
 drivers/acpi/acpica/utnonansi.c          |   67 +++++++++++++++++-------------
 tools/power/acpi/tools/acpidump/apdump.c |    3 +-
 tools/power/acpi/tools/acpidump/apmain.c |    3 +-
 7 files changed, 57 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index e43ab6f..7422ff7 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -175,7 +175,14 @@ void acpi_ut_strlwr(char *src_string);
 
 int acpi_ut_stricmp(char *string1, char *string2);
 
-acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer);
+acpi_status
+acpi_ut_strtoul64(char *string,
+		  u32 base, u32 max_integer_byte_width, u64 *ret_integer);
+
+/* Values for max_integer_byte_width above */
+
+#define ACPI_MAX32_BYTE_WIDTH       4
+#define ACPI_MAX64_BYTE_WIDTH       8
 
 /*
  * utglobal - Global data structures and procedures
diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 68f4e0f4..c79c5fb 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -277,7 +277,9 @@ acpi_db_convert_to_object(acpi_object_type type,
 	default:
 
 		object->type = ACPI_TYPE_INTEGER;
-		status = acpi_ut_strtoul64(string, 16, &object->integer.value);
+		status =
+		    acpi_ut_strtoul64(string, 16, acpi_gbl_integer_byte_width,
+				      &object->integer.value);
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 0b9f2c1..d0d16da 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -124,7 +124,9 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 		 * of ACPI 3.0) is that the to_integer() operator allows both decimal
 		 * and hexadecimal strings (hex prefixed with "0x").
 		 */
-		status = acpi_ut_strtoul64((char *)pointer, flags, &result);
+		status = acpi_ut_strtoul64((char *)pointer, flags,
+					   acpi_gbl_integer_byte_width,
+					   &result);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index 878e8fb..256f56c 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -79,7 +79,8 @@ acpi_ns_convert_to_integer(union acpi_operand_object *original_object,
 		/* String-to-Integer conversion */
 
 		status = acpi_ut_strtoul64(original_object->string.pointer,
-					   ACPI_ANY_BASE, &value);
+					   ACPI_ANY_BASE,
+					   acpi_gbl_integer_byte_width, &value);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index d5c3adf..3465fe2 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -205,37 +205,41 @@ acpi_ut_safe_strncat(char *dest,
  *
  * FUNCTION:    acpi_ut_strtoul64
  *
- * PARAMETERS:  string          - Null terminated string
- *              base            - Radix of the string: 16 or ACPI_ANY_BASE;
- *                                ACPI_ANY_BASE means 'in behalf of to_integer'
- *              ret_integer     - Where the converted integer is returned
+ * PARAMETERS:  string                  - Null terminated string
+ *              base                    - Radix of the string: 16 or 10 or
+ *                                        ACPI_ANY_BASE
+ *              max_integer_byte_width  - Maximum allowable integer,in bytes:
+ *                                        4 or 8 (32 or 64 bits)
+ *              ret_integer             - Where the converted integer is
+ *                                        returned
  *
  * RETURN:      Status and Converted value
  *
  * DESCRIPTION: Convert a string into an unsigned value. Performs either a
- *              32-bit or 64-bit conversion, depending on the current mode
- *              of the interpreter.
+ *              32-bit or 64-bit conversion, depending on the input integer
+ *              size (often the current mode of the interpreter).
  *
- * NOTES:       acpi_gbl_integer_byte_width should be set to the proper width.
+ * NOTES:       Negative numbers are not supported, as they are not supported
+ *              by ACPI.
+ *
+ *              acpi_gbl_integer_byte_width should be set to the proper width.
  *              For the core ACPICA code, this width depends on the DSDT
- *              version. For iASL, the default byte width is always 8.
+ *              version. For iASL, the default byte width is always 8 for the
+ *              parser, but error checking is performed later to flag cases
+ *              where a 64-bit constant is defined in a 32-bit DSDT/SSDT.
  *
  *              Does not support Octal strings, not needed at this time.
  *
- *              There is an earlier version of the function after this one,
- *              below. It is slightly different than this one, and the two
- *              may eventually may need to be merged. (01/2016).
- *
  ******************************************************************************/
 
-acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
+acpi_status
+acpi_ut_strtoul64(char *string,
+		  u32 base, u32 max_integer_byte_width, u64 *ret_integer)
 {
 	u32 this_digit = 0;
 	u64 return_value = 0;
 	u64 quotient;
 	u64 dividend;
-	u32 to_integer_op = (base == ACPI_ANY_BASE);
-	u32 mode32 = (acpi_gbl_integer_byte_width == 4);
 	u8 valid_digits = 0;
 	u8 sign_of0x = 0;
 	u8 term = 0;
@@ -244,6 +248,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 
 	switch (base) {
 	case ACPI_ANY_BASE:
+	case 10:
 	case 16:
 
 		break;
@@ -265,9 +270,9 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 		string++;
 	}
 
-	if (to_integer_op) {
+	if (base == ACPI_ANY_BASE) {
 		/*
-		 * Base equal to ACPI_ANY_BASE means 'ToInteger operation case'.
+		 * Base equal to ACPI_ANY_BASE means 'Either decimal or hex'.
 		 * We need to determine if it is decimal or hexadecimal.
 		 */
 		if ((*string == '0') && (tolower((int)*(string + 1)) == 'x')) {
@@ -284,7 +289,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 	/* Any string left? Check that '0x' is not followed by white space. */
 
 	if (!(*string) || isspace((int)*string) || *string == '\t') {
-		if (to_integer_op) {
+		if (base == ACPI_ANY_BASE) {
 			goto error_exit;
 		} else {
 			goto all_done;
@@ -292,10 +297,11 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 	}
 
 	/*
-	 * Perform a 32-bit or 64-bit conversion, depending upon the current
-	 * execution mode of the interpreter
+	 * Perform a 32-bit or 64-bit conversion, depending upon the input
+	 * byte width
 	 */
-	dividend = (mode32) ? ACPI_UINT32_MAX : ACPI_UINT64_MAX;
+	dividend = (max_integer_byte_width <= ACPI_MAX32_BYTE_WIDTH) ?
+	    ACPI_UINT32_MAX : ACPI_UINT64_MAX;
 
 	/* Main loop: convert the string to a 32- or 64-bit integer */
 
@@ -323,7 +329,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 		}
 
 		if (term) {
-			if (to_integer_op) {
+			if (base == ACPI_ANY_BASE) {
 				goto error_exit;
 			} else {
 				break;
@@ -338,12 +344,13 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 
 		valid_digits++;
 
-		if (sign_of0x
-		    && ((valid_digits > 16)
-			|| ((valid_digits > 8) && mode32))) {
+		if (sign_of0x && ((valid_digits > 16) ||
+				  ((valid_digits > 8)
+				   && (max_integer_byte_width <=
+				       ACPI_MAX32_BYTE_WIDTH)))) {
 			/*
 			 * This is to_integer operation case.
-			 * No any restrictions for string-to-integer conversion,
+			 * No restrictions for string-to-integer conversion,
 			 * see ACPI spec.
 			 */
 			goto error_exit;
@@ -355,7 +362,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 					   &quotient, NULL);
 
 		if (return_value > quotient) {
-			if (to_integer_op) {
+			if (base == ACPI_ANY_BASE) {
 				goto error_exit;
 			} else {
 				break;
@@ -378,7 +385,8 @@ all_done:
 	return_ACPI_STATUS(AE_OK);
 
 error_exit:
-	/* Base was set/validated above */
+
+	/* Base was set/validated above (10 or 16) */
 
 	if (base == 10) {
 		return_ACPI_STATUS(AE_BAD_DECIMAL_CONSTANT);
@@ -388,8 +396,7 @@ error_exit:
 }
 
 #ifdef _OBSOLETE_FUNCTIONS
-/* TBD: use version in ACPICA main code base? */
-/* DONE: 01/2016 */
+/* Removed: 01/2016 */
 
 /*******************************************************************************
  *
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index da44458..9c2db0e 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -286,7 +286,8 @@ int ap_dump_table_by_address(char *ascii_address)
 
 	/* Convert argument to an integer physical address */
 
-	status = acpi_ut_strtoul64(ascii_address, 0, &long_address);
+	status = acpi_ut_strtoul64(ascii_address, ACPI_ANY_BASE,
+				   ACPI_MAX64_BYTE_WIDTH, &long_address);
 	if (ACPI_FAILURE(status)) {
 		acpi_log_error("%s: Could not convert to a physical address\n",
 			       ascii_address);
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index c3c0915..7692e6b 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -209,7 +209,8 @@ static int ap_do_options(int argc, char **argv)
 		case 'r':	/* Dump tables from specified RSDP */
 
 			status =
-			    acpi_ut_strtoul64(acpi_gbl_optarg, 0,
+			    acpi_ut_strtoul64(acpi_gbl_optarg, ACPI_ANY_BASE,
+					      ACPI_MAX64_BYTE_WIDTH,
 					      &gbl_rsdp_base);
 			if (ACPI_FAILURE(status)) {
 				acpi_log_error
-- 
1.7.10
