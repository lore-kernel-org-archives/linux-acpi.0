From: Lv Zheng <lv.zheng@intel.com>
Subject: =?y?q?=5BPATCH=2002/14=5D=20ACPICA=3A=20Cleanup=20for=20all=20string-to-integer=20conversions?=
Date: Wed,  7 Sep 2016 14:05:57 +0800
Message-ID: <db717c15c6030129df23d049f857736e4190af92.1473226204.git.lv.zheng@intel.com>
References: <cover.1473226203.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:37280 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751021AbcIGGGI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:06:08 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit e2e72a351201fd58e4694418859ae2c247dafca0

Consolidate multiple versions of strtoul64 to one common version.
limit possible bases to either 10 or 16.
Handles both implicit and explicit conversions.
Added a 2-character ascii-to-hex function for GPEs and buffers.
Adds a new file, utstrtoul64.c

Link: https://github.com/acpica/acpica/commit/e2e72a35
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile             |    1 +
 drivers/acpi/acpica/acutils.h            |   17 +-
 drivers/acpi/acpica/dbconvert.c          |    7 +-
 drivers/acpi/acpica/dswexec.c            |    3 +-
 drivers/acpi/acpica/evgpeinit.c          |    7 +-
 drivers/acpi/acpica/exconcat.c           |    2 +-
 drivers/acpi/acpica/exconvrt.c           |    8 +-
 drivers/acpi/acpica/exmisc.c             |    4 +-
 drivers/acpi/acpica/exoparg1.c           |    5 +-
 drivers/acpi/acpica/exresop.c            |   11 +-
 drivers/acpi/acpica/nsconvert.c          |    1 -
 drivers/acpi/acpica/uthex.c              |   45 +++-
 drivers/acpi/acpica/utnonansi.c          |  357 +-----------------------------
 drivers/acpi/acpica/utstrtoul64.c        |  348 +++++++++++++++++++++++++++++
 tools/power/acpi/tools/acpidump/Makefile |    2 +
 tools/power/acpi/tools/acpidump/apdump.c |    4 +-
 tools/power/acpi/tools/acpidump/apmain.c |    4 +-
 17 files changed, 435 insertions(+), 391 deletions(-)
 create mode 100644 drivers/acpi/acpica/utstrtoul64.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 227bb7b..32d93ed 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -175,6 +175,7 @@ acpi-y +=		\
 	utresrc.o	\
 	utstate.o	\
 	utstring.o	\
+	utstrtoul64.o	\
 	utxface.o	\
 	utxfinit.o	\
 	utxferror.o	\
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index d899296..0a1b53c 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -196,14 +196,15 @@ void acpi_ut_strlwr(char *src_string);
 
 int acpi_ut_stricmp(char *string1, char *string2);
 
-acpi_status
-acpi_ut_strtoul64(char *string,
-		  u32 base, u32 max_integer_byte_width, u64 *ret_integer);
-
-/* Values for max_integer_byte_width above */
+acpi_status acpi_ut_strtoul64(char *string, u32 flags, u64 *ret_integer);
 
-#define ACPI_MAX32_BYTE_WIDTH       4
-#define ACPI_MAX64_BYTE_WIDTH       8
+/*
+ * Values for Flags above
+ * Note: LIMIT values correspond to acpi_gbl_integer_byte_width values (4/8)
+ */
+#define ACPI_STRTOUL_32BIT          0x04	/* 4 bytes */
+#define ACPI_STRTOUL_64BIT          0x08	/* 8 bytes */
+#define ACPI_STRTOUL_BASE16         0x10	/* Default: Base10/16 */
 
 /*
  * utglobal - Global data structures and procedures
@@ -233,6 +234,8 @@ const char *acpi_ut_get_event_name(u32 event_id);
 
 char acpi_ut_hex_to_ascii_char(u64 integer, u32 position);
 
+acpi_status acpi_ut_ascii_to_hex_byte(char *two_ascii_chars, u8 *return_byte);
+
 u8 acpi_ut_ascii_char_to_hex(int hex_char);
 
 u8 acpi_ut_valid_object_type(acpi_object_type type);
diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 7cd07b2..147ce88 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -277,9 +277,10 @@ acpi_db_convert_to_object(acpi_object_type type,
 	default:
 
 		object->type = ACPI_TYPE_INTEGER;
-		status =
-		    acpi_ut_strtoul64(string, 16, acpi_gbl_integer_byte_width,
-				      &object->integer.value);
+		status = acpi_ut_strtoul64(string,
+					   (acpi_gbl_integer_byte_width |
+					    ACPI_STRTOUL_BASE16),
+					   &object->integer.value);
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 402ecc5..438597c 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -133,7 +133,8 @@ acpi_ds_get_predicate_value(struct acpi_walk_state *walk_state,
 	 * Result of predicate evaluation must be an Integer
 	 * object. Implicitly convert the argument if necessary.
 	 */
-	status = acpi_ex_convert_to_integer(obj_desc, &local_obj_desc, 16);
+	status = acpi_ex_convert_to_integer(obj_desc, &local_obj_desc,
+					    ACPI_STRTOUL_BASE16);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
 	}
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 7dc7547..16ce483 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -323,7 +323,9 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 	struct acpi_gpe_walk_info *walk_info =
 	    ACPI_CAST_PTR(struct acpi_gpe_walk_info, context);
 	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_status status;
 	u32 gpe_number;
+	u8 temp_gpe_number;
 	char name[ACPI_NAME_SIZE + 1];
 	u8 type;
 
@@ -377,8 +379,8 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 
 	/* 4) The last two characters of the name are the hex GPE Number */
 
-	gpe_number = strtoul(&name[2], NULL, 16);
-	if (gpe_number == ACPI_UINT32_MAX) {
+	status = acpi_ut_ascii_to_hex_byte(&name[2], &temp_gpe_number);
+	if (ACPI_FAILURE(status)) {
 
 		/* Conversion failed; invalid method, just ignore it */
 
@@ -390,6 +392,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 
 	/* Ensure that we have a valid GPE number for this GPE block */
 
+	gpe_number = (u32)temp_gpe_number;
 	gpe_event_info =
 	    acpi_ev_low_get_gpe_info(gpe_number, walk_info->gpe_block);
 	if (!gpe_event_info) {
diff --git a/drivers/acpi/acpica/exconcat.c b/drivers/acpi/acpica/exconcat.c
index 2423fe0..5429c2a 100644
--- a/drivers/acpi/acpica/exconcat.c
+++ b/drivers/acpi/acpica/exconcat.c
@@ -156,7 +156,7 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 
 		status =
 		    acpi_ex_convert_to_integer(local_operand1, &temp_operand1,
-					       16);
+					       ACPI_STRTOUL_BASE16);
 		break;
 
 	case ACPI_TYPE_BUFFER:
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index b7e9b3d..588ad14 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -124,9 +124,9 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 		 * of ACPI 3.0) is that the to_integer() operator allows both decimal
 		 * and hexadecimal strings (hex prefixed with "0x").
 		 */
-		status = acpi_ut_strtoul64((char *)pointer, flags,
-					   acpi_gbl_integer_byte_width,
-					   &result);
+		status = acpi_ut_strtoul64(ACPI_CAST_PTR(char, pointer),
+					   (acpi_gbl_integer_byte_width |
+					    flags), &result);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
@@ -632,7 +632,7 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 			 */
 			status =
 			    acpi_ex_convert_to_integer(source_desc, result_desc,
-						       16);
+						       ACPI_STRTOUL_BASE16);
 			break;
 
 		case ACPI_TYPE_STRING:
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 4f7e667..37c88b4 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -327,8 +327,8 @@ acpi_ex_do_logical_op(u16 opcode,
 	switch (operand0->common.type) {
 	case ACPI_TYPE_INTEGER:
 
-		status =
-		    acpi_ex_convert_to_integer(operand1, &local_operand1, 16);
+		status = acpi_ex_convert_to_integer(operand1, &local_operand1,
+						    ACPI_STRTOUL_BASE16);
 		break;
 
 	case ACPI_TYPE_STRING:
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 4e17506..6ae19cb 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -521,9 +521,10 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 
 	case AML_TO_INTEGER_OP:	/* to_integer (Data, Result) */
 
+		/* Perform "explicit" conversion */
+
 		status =
-		    acpi_ex_convert_to_integer(operand[0], &return_desc,
-					       ACPI_ANY_BASE);
+		    acpi_ex_convert_to_integer(operand[0], &return_desc, 0);
 		if (return_desc == operand[0]) {
 
 			/* No conversion performed, add ref to handle return value */
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 27b41fd..f29eba1 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -410,12 +410,13 @@ acpi_ex_resolve_operands(u16 opcode,
 		case ARGI_INTEGER:
 
 			/*
-			 * Need an operand of type ACPI_TYPE_INTEGER,
-			 * But we can implicitly convert from a STRING or BUFFER
-			 * aka - "Implicit Source Operand Conversion"
+			 * Need an operand of type ACPI_TYPE_INTEGER, but we can
+			 * implicitly convert from a STRING or BUFFER.
+			 *
+			 * Known as "Implicit Source Operand Conversion"
 			 */
-			status =
-			    acpi_ex_convert_to_integer(obj_desc, stack_ptr, 16);
+			status = acpi_ex_convert_to_integer(obj_desc, stack_ptr,
+							    ACPI_STRTOUL_BASE16);
 			if (ACPI_FAILURE(status)) {
 				if (status == AE_TYPE) {
 					ACPI_ERROR((AE_INFO,
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index c803bda..2b85dee 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -79,7 +79,6 @@ acpi_ns_convert_to_integer(union acpi_operand_object *original_object,
 		/* String-to-Integer conversion */
 
 		status = acpi_ut_strtoul64(original_object->string.pointer,
-					   ACPI_ANY_BASE,
 					   acpi_gbl_integer_byte_width, &value);
 		if (ACPI_FAILURE(status)) {
 			return (status);
diff --git a/drivers/acpi/acpica/uthex.c b/drivers/acpi/acpica/uthex.c
index 4354fb8..3a4ca95 100644
--- a/drivers/acpi/acpica/uthex.c
+++ b/drivers/acpi/acpica/uthex.c
@@ -75,9 +75,40 @@ char acpi_ut_hex_to_ascii_char(u64 integer, u32 position)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ut_ascii_to_hex_byte
+ *
+ * PARAMETERS:  two_ascii_chars             - Pointer to two ASCII characters
+ *              return_byte                 - Where converted byte is returned
+ *
+ * RETURN:      Status and converted hex byte
+ *
+ * DESCRIPTION: Perform ascii-to-hex translation, exactly two ASCII characters
+ *              to a single converted byte value.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_ascii_to_hex_byte(char *two_ascii_chars, u8 *return_byte)
+{
+
+	/* Both ASCII characters must be valid hex digits */
+
+	if (!isxdigit(two_ascii_chars[0]) || !isxdigit(two_ascii_chars[1])) {
+		return (AE_BAD_HEX_CONSTANT);
+	}
+
+	*return_byte =
+	    acpi_ut_ascii_char_to_hex(two_ascii_chars[1]) |
+	    (acpi_ut_ascii_char_to_hex(two_ascii_chars[0]) << 4);
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ut_ascii_char_to_hex
  *
- * PARAMETERS:  hex_char                - Hex character in Ascii
+ * PARAMETERS:  hex_char                - Hex character in Ascii. Must be:
+ *                                        0-9 or A-F or a-f
  *
  * RETURN:      The binary value of the ascii/hex character
  *
@@ -88,13 +119,19 @@ char acpi_ut_hex_to_ascii_char(u64 integer, u32 position)
 u8 acpi_ut_ascii_char_to_hex(int hex_char)
 {
 
-	if (hex_char <= 0x39) {
-		return ((u8)(hex_char - 0x30));
+	/* Values 0-9 */
+
+	if (hex_char <= '9') {
+		return ((u8)(hex_char - '0'));
 	}
 
-	if (hex_char <= 0x46) {
+	/* Upper case A-F */
+
+	if (hex_char <= 'F') {
 		return ((u8)(hex_char - 0x37));
 	}
 
+	/* Lower case a-f */
+
 	return ((u8)(hex_char - 0x57));
 }
diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index 3465fe2..2514239 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -48,8 +48,8 @@
 ACPI_MODULE_NAME("utnonansi")
 
 /*
- * Non-ANSI C library functions - strlwr, strupr, stricmp, and a 64-bit
- * version of strtoul.
+ * Non-ANSI C library functions - strlwr, strupr, stricmp, and "safe"
+ * string functions.
  */
 /*******************************************************************************
  *
@@ -200,356 +200,3 @@ acpi_ut_safe_strncat(char *dest,
 	return (FALSE);
 }
 #endif
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_strtoul64
- *
- * PARAMETERS:  string                  - Null terminated string
- *              base                    - Radix of the string: 16 or 10 or
- *                                        ACPI_ANY_BASE
- *              max_integer_byte_width  - Maximum allowable integer,in bytes:
- *                                        4 or 8 (32 or 64 bits)
- *              ret_integer             - Where the converted integer is
- *                                        returned
- *
- * RETURN:      Status and Converted value
- *
- * DESCRIPTION: Convert a string into an unsigned value. Performs either a
- *              32-bit or 64-bit conversion, depending on the input integer
- *              size (often the current mode of the interpreter).
- *
- * NOTES:       Negative numbers are not supported, as they are not supported
- *              by ACPI.
- *
- *              acpi_gbl_integer_byte_width should be set to the proper width.
- *              For the core ACPICA code, this width depends on the DSDT
- *              version. For iASL, the default byte width is always 8 for the
- *              parser, but error checking is performed later to flag cases
- *              where a 64-bit constant is defined in a 32-bit DSDT/SSDT.
- *
- *              Does not support Octal strings, not needed at this time.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ut_strtoul64(char *string,
-		  u32 base, u32 max_integer_byte_width, u64 *ret_integer)
-{
-	u32 this_digit = 0;
-	u64 return_value = 0;
-	u64 quotient;
-	u64 dividend;
-	u8 valid_digits = 0;
-	u8 sign_of0x = 0;
-	u8 term = 0;
-
-	ACPI_FUNCTION_TRACE_STR(ut_strtoul64, string);
-
-	switch (base) {
-	case ACPI_ANY_BASE:
-	case 10:
-	case 16:
-
-		break;
-
-	default:
-
-		/* Invalid Base */
-
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
-	if (!string) {
-		goto error_exit;
-	}
-
-	/* Skip over any white space in the buffer */
-
-	while ((*string) && (isspace((int)*string) || *string == '\t')) {
-		string++;
-	}
-
-	if (base == ACPI_ANY_BASE) {
-		/*
-		 * Base equal to ACPI_ANY_BASE means 'Either decimal or hex'.
-		 * We need to determine if it is decimal or hexadecimal.
-		 */
-		if ((*string == '0') && (tolower((int)*(string + 1)) == 'x')) {
-			sign_of0x = 1;
-			base = 16;
-
-			/* Skip over the leading '0x' */
-			string += 2;
-		} else {
-			base = 10;
-		}
-	}
-
-	/* Any string left? Check that '0x' is not followed by white space. */
-
-	if (!(*string) || isspace((int)*string) || *string == '\t') {
-		if (base == ACPI_ANY_BASE) {
-			goto error_exit;
-		} else {
-			goto all_done;
-		}
-	}
-
-	/*
-	 * Perform a 32-bit or 64-bit conversion, depending upon the input
-	 * byte width
-	 */
-	dividend = (max_integer_byte_width <= ACPI_MAX32_BYTE_WIDTH) ?
-	    ACPI_UINT32_MAX : ACPI_UINT64_MAX;
-
-	/* Main loop: convert the string to a 32- or 64-bit integer */
-
-	while (*string) {
-		if (isdigit((int)*string)) {
-
-			/* Convert ASCII 0-9 to Decimal value */
-
-			this_digit = ((u8)*string) - '0';
-		} else if (base == 10) {
-
-			/* Digit is out of range; possible in to_integer case only */
-
-			term = 1;
-		} else {
-			this_digit = (u8)toupper((int)*string);
-			if (isxdigit((int)this_digit)) {
-
-				/* Convert ASCII Hex char to value */
-
-				this_digit = this_digit - 'A' + 10;
-			} else {
-				term = 1;
-			}
-		}
-
-		if (term) {
-			if (base == ACPI_ANY_BASE) {
-				goto error_exit;
-			} else {
-				break;
-			}
-		} else if ((valid_digits == 0) && (this_digit == 0)
-			   && !sign_of0x) {
-
-			/* Skip zeros */
-			string++;
-			continue;
-		}
-
-		valid_digits++;
-
-		if (sign_of0x && ((valid_digits > 16) ||
-				  ((valid_digits > 8)
-				   && (max_integer_byte_width <=
-				       ACPI_MAX32_BYTE_WIDTH)))) {
-			/*
-			 * This is to_integer operation case.
-			 * No restrictions for string-to-integer conversion,
-			 * see ACPI spec.
-			 */
-			goto error_exit;
-		}
-
-		/* Divide the digit into the correct position */
-
-		(void)acpi_ut_short_divide((dividend - (u64)this_digit), base,
-					   &quotient, NULL);
-
-		if (return_value > quotient) {
-			if (base == ACPI_ANY_BASE) {
-				goto error_exit;
-			} else {
-				break;
-			}
-		}
-
-		return_value *= base;
-		return_value += this_digit;
-		string++;
-	}
-
-	/* All done, normal exit */
-
-all_done:
-
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Converted value: %8.8X%8.8X\n",
-			  ACPI_FORMAT_UINT64(return_value)));
-
-	*ret_integer = return_value;
-	return_ACPI_STATUS(AE_OK);
-
-error_exit:
-
-	/* Base was set/validated above (10 or 16) */
-
-	if (base == 10) {
-		return_ACPI_STATUS(AE_BAD_DECIMAL_CONSTANT);
-	} else {
-		return_ACPI_STATUS(AE_BAD_HEX_CONSTANT);
-	}
-}
-
-#ifdef _OBSOLETE_FUNCTIONS
-/* Removed: 01/2016 */
-
-/*******************************************************************************
- *
- * FUNCTION:    strtoul64
- *
- * PARAMETERS:  string              - Null terminated string
- *              terminater          - Where a pointer to the terminating byte
- *                                    is returned
- *              base                - Radix of the string
- *
- * RETURN:      Converted value
- *
- * DESCRIPTION: Convert a string into an unsigned value.
- *
- ******************************************************************************/
-
-acpi_status strtoul64(char *string, u32 base, u64 *ret_integer)
-{
-	u32 index;
-	u32 sign;
-	u64 return_value = 0;
-	acpi_status status = AE_OK;
-
-	*ret_integer = 0;
-
-	switch (base) {
-	case 0:
-	case 8:
-	case 10:
-	case 16:
-
-		break;
-
-	default:
-		/*
-		 * The specified Base parameter is not in the domain of
-		 * this function:
-		 */
-		return (AE_BAD_PARAMETER);
-	}
-
-	/* Skip over any white space in the buffer: */
-
-	while (isspace((int)*string) || *string == '\t') {
-		++string;
-	}
-
-	/*
-	 * The buffer may contain an optional plus or minus sign.
-	 * If it does, then skip over it but remember what is was:
-	 */
-	if (*string == '-') {
-		sign = ACPI_SIGN_NEGATIVE;
-		++string;
-	} else if (*string == '+') {
-		++string;
-		sign = ACPI_SIGN_POSITIVE;
-	} else {
-		sign = ACPI_SIGN_POSITIVE;
-	}
-
-	/*
-	 * If the input parameter Base is zero, then we need to
-	 * determine if it is octal, decimal, or hexadecimal:
-	 */
-	if (base == 0) {
-		if (*string == '0') {
-			if (tolower((int)*(++string)) == 'x') {
-				base = 16;
-				++string;
-			} else {
-				base = 8;
-			}
-		} else {
-			base = 10;
-		}
-	}
-
-	/*
-	 * For octal and hexadecimal bases, skip over the leading
-	 * 0 or 0x, if they are present.
-	 */
-	if (base == 8 && *string == '0') {
-		string++;
-	}
-
-	if (base == 16 && *string == '0' && tolower((int)*(++string)) == 'x') {
-		string++;
-	}
-
-	/* Main loop: convert the string to an unsigned long */
-
-	while (*string) {
-		if (isdigit((int)*string)) {
-			index = ((u8)*string) - '0';
-		} else {
-			index = (u8)toupper((int)*string);
-			if (isupper((int)index)) {
-				index = index - 'A' + 10;
-			} else {
-				goto error_exit;
-			}
-		}
-
-		if (index >= base) {
-			goto error_exit;
-		}
-
-		/* Check to see if value is out of range: */
-
-		if (return_value > ((ACPI_UINT64_MAX - (u64)index) / (u64)base)) {
-			goto error_exit;
-		} else {
-			return_value *= base;
-			return_value += index;
-		}
-
-		++string;
-	}
-
-	/* If a minus sign was present, then "the conversion is negated": */
-
-	if (sign == ACPI_SIGN_NEGATIVE) {
-		return_value = (ACPI_UINT32_MAX - return_value) + 1;
-	}
-
-	*ret_integer = return_value;
-	return (status);
-
-error_exit:
-	switch (base) {
-	case 8:
-
-		status = AE_BAD_OCTAL_CONSTANT;
-		break;
-
-	case 10:
-
-		status = AE_BAD_DECIMAL_CONSTANT;
-		break;
-
-	case 16:
-
-		status = AE_BAD_HEX_CONSTANT;
-		break;
-
-	default:
-
-		/* Base validated above */
-
-		break;
-	}
-
-	return (status);
-}
-#endif
diff --git a/drivers/acpi/acpica/utstrtoul64.c b/drivers/acpi/acpica/utstrtoul64.c
new file mode 100644
index 0000000..5946811
--- /dev/null
+++ b/drivers/acpi/acpica/utstrtoul64.c
@@ -0,0 +1,348 @@
+/*******************************************************************************
+ *
+ * Module Name: utstrtoul64 - string to 64-bit integer support
+ *
+ ******************************************************************************/
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
+ * The functions in this module satisfy the need for 64-bit string-to-integer
+ * conversions on both 32-bit and 64-bit platforms.
+ *
+ ******************************************************************************/
+
+#define _COMPONENT          ACPI_UTILITIES
+ACPI_MODULE_NAME("utstrtoul64")
+
+/* Local prototypes */
+static u64 acpi_ut_strtoul_base10(char *string, u32 flags);
+
+static u64 acpi_ut_strtoul_base16(char *string, u32 flags);
+
+/*******************************************************************************
+ *
+ * String conversion rules as written in the ACPI specification. The error
+ * conditions and behavior are different depending on the type of conversion.
+ *
+ *
+ * Implicit data type conversion: string-to-integer
+ * --------------------------------------------------
+ *
+ * Base is always 16. This is the ACPI_STRTOUL_BASE16 case.
+ *
+ * Example:
+ *      Add ("BA98", Arg0, Local0)
+ *
+ * The integer is initialized to the value zero.
+ * The ASCII string is interpreted as a hexadecimal constant.
+ *
+ *  1)  A “0x” prefix is not allowed. However, ACPICA allows this for
+ *      compatibility with previous ACPICA. (NO ERROR)
+ *
+ *  2)  Terminates when the size of an integer is reached (32 or 64 bits).
+ *      (NO ERROR)
+ *
+ *  3)  The first non-hex character terminates the conversion without error.
+ *      (NO ERROR)
+ *
+ *  4)  Conversion of a null (zero-length) string to an integer is not
+ *      allowed. However, ACPICA allows this for compatibility with previous
+ *      ACPICA. This conversion returns the value 0. (NO ERROR)
+ *
+ *
+ * Explicit data type conversion:  to_integer() with string operand
+ * ---------------------------------------------------------------
+ *
+ * Base is either 10 (default) or 16 (with 0x prefix)
+ *
+ * Examples:
+ *      to_integer ("1000")
+ *      to_integer ("0xABCD")
+ *
+ *  1)  Can be (must be) either a decimal or hexadecimal numeric string.
+ *      A hex value must be prefixed by "0x" or it is interpreted as a decimal.
+ *
+ *  2)  The value must not exceed the maximum of an integer value. ACPI spec
+ *      states the behavior is "unpredictable", so ACPICA matches the behavior
+ *      of the implicit conversion case.(NO ERROR)
+ *
+ *  3)  Behavior on the first non-hex character is not specified by the ACPI
+ *      spec, so ACPICA matches the behavior of the implicit conversion case
+ *      and terminates. (NO ERROR)
+ *
+ *  4)  A null (zero-length) string is illegal.
+ *      However, ACPICA allows this for compatibility with previous ACPICA.
+ *      This conversion returns the value 0. (NO ERROR)
+ *
+ ******************************************************************************/
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strtoul64
+ *
+ * PARAMETERS:  string                  - Null terminated input string
+ *              flags                   - Conversion info, see below
+ *              return_value            - Where the converted integer is
+ *                                        returned
+ *
+ * RETURN:      Status and Converted value
+ *
+ * DESCRIPTION: Convert a string into an unsigned value. Performs either a
+ *              32-bit or 64-bit conversion, depending on the input integer
+ *              size in Flags (often the current mode of the interpreter).
+ *
+ * Values for Flags:
+ *      ACPI_STRTOUL_32BIT      - Max integer value is 32 bits
+ *      ACPI_STRTOUL_64BIT      - Max integer value is 64 bits
+ *      ACPI_STRTOUL_BASE16     - Input string is hexadecimal. Default
+ *                                is 10/16 based on string prefix (0x).
+ *
+ * NOTES:
+ *   Negative numbers are not supported, as they are not supported by ACPI.
+ *
+ *   Supports only base 16 or base 10 strings/values. Does not
+ *   support Octal strings, as these are not supported by ACPI.
+ *
+ * Current users of this support:
+ *
+ *  interpreter - Implicit and explicit conversions, GPE method names
+ *  debugger    - Command line input string conversion
+ *  iASL        - Main parser, conversion of constants to integers
+ *  iASL        - Data Table Compiler parser (constant math expressions)
+ *  iASL        - Preprocessor (constant math expressions)
+ *  acpi_dump   - Input table addresses
+ *  acpi_exec   - Testing of the acpi_ut_strtoul64 function
+ *
+ * Note concerning callers:
+ *   acpi_gbl_integer_byte_width can be used to set the 32/64 limit. If used,
+ *   this global should be set to the proper width. For the core ACPICA code,
+ *   this width depends on the DSDT version. For iASL, the default byte
+ *   width is always 8 for the parser, but error checking is performed later
+ *   to flag cases where a 64-bit constant is defined in a 32-bit DSDT/SSDT.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_strtoul64(char *string, u32 flags, u64 *return_value)
+{
+	acpi_status status = AE_OK;
+	u32 base;
+
+	ACPI_FUNCTION_TRACE_STR(ut_strtoul64, string);
+
+	/* Parameter validation */
+
+	if (!string || !return_value) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	*return_value = 0;
+
+	/* Check for zero-length string, returns 0 */
+
+	if (*string == 0) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/* Skip over any white space at start of string */
+
+	while (isspace((int)*string)) {
+		string++;
+	}
+
+	/* End of string? return 0 */
+
+	if (*string == 0) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/*
+	 * 1) The "0x" prefix indicates base 16. Per the ACPI specification,
+	 * the "0x" prefix is only allowed for implicit (non-strict) conversions.
+	 * However, we always allow it for compatibility with older ACPICA.
+	 */
+	if ((*string == ACPI_ASCII_ZERO) &&
+	    (tolower((int)*(string + 1)) == 'x')) {
+		string += 2;	/* Go past the 0x */
+		if (*string == 0) {
+			return_ACPI_STATUS(AE_OK);	/* Return value 0 */
+		}
+
+		base = 16;
+	}
+
+	/* 2) Force to base 16 (implicit conversion case) */
+
+	else if (flags & ACPI_STRTOUL_BASE16) {
+		base = 16;
+	}
+
+	/* 3) Default fallback is to Base 10 */
+
+	else {
+		base = 10;
+	}
+
+	/* Skip all leading zeros */
+
+	while (*string == ACPI_ASCII_ZERO) {
+		string++;
+		if (*string == 0) {
+			return_ACPI_STATUS(AE_OK);	/* Return value 0 */
+		}
+	}
+
+	/* Perform the base 16 or 10 conversion */
+
+	if (base == 16) {
+		*return_value = acpi_ut_strtoul_base16(string, flags);
+	} else {
+		*return_value = acpi_ut_strtoul_base10(string, flags);
+	}
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strtoul_base10
+ *
+ * PARAMETERS:  string                  - Null terminated input string
+ *              flags                   - Conversion info
+ *
+ * RETURN:      64-bit converted integer
+ *
+ * DESCRIPTION: Performs a base 10 conversion of the input string to an
+ *              integer value, either 32 or 64 bits.
+ *              Note: String must be valid and non-null.
+ *
+ ******************************************************************************/
+
+static u64 acpi_ut_strtoul_base10(char *string, u32 flags)
+{
+	int ascii_digit;
+	u64 next_value;
+	u64 return_value = 0;
+
+	/* Main loop: convert each ASCII byte in the input string */
+
+	while (*string) {
+		ascii_digit = *string;
+		if (!isdigit(ascii_digit)) {
+
+			/* Not ASCII 0-9, terminate */
+
+			goto exit;
+		}
+
+		/* Convert and insert (add) the decimal digit */
+
+		next_value =
+		    (return_value * 10) + (ascii_digit - ACPI_ASCII_ZERO);
+
+		/* Check for overflow (32 or 64 bit) - return current converted value */
+
+		if (((flags & ACPI_STRTOUL_32BIT) && (next_value > ACPI_UINT32_MAX)) || (next_value < return_value)) {	/* 64-bit overflow case */
+			goto exit;
+		}
+
+		return_value = next_value;
+		string++;
+	}
+
+exit:
+	return (return_value);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strtoul_base16
+ *
+ * PARAMETERS:  string                  - Null terminated input string
+ *              flags                   - conversion info
+ *
+ * RETURN:      64-bit converted integer
+ *
+ * DESCRIPTION: Performs a base 16 conversion of the input string to an
+ *              integer value, either 32 or 64 bits.
+ *              Note: String must be valid and non-null.
+ *
+ ******************************************************************************/
+
+static u64 acpi_ut_strtoul_base16(char *string, u32 flags)
+{
+	int ascii_digit;
+	u32 valid_digits = 1;
+	u64 return_value = 0;
+
+	/* Main loop: convert each ASCII byte in the input string */
+
+	while (*string) {
+
+		/* Check for overflow (32 or 64 bit) - return current converted value */
+
+		if ((valid_digits > 16) ||
+		    ((valid_digits > 8) && (flags & ACPI_STRTOUL_32BIT))) {
+			goto exit;
+		}
+
+		ascii_digit = *string;
+		if (!isxdigit(ascii_digit)) {
+
+			/* Not Hex ASCII A-F, a-f, or 0-9, terminate */
+
+			goto exit;
+		}
+
+		/* Convert and insert the hex digit */
+
+		return_value =
+		    (return_value << 4) |
+		    acpi_ut_ascii_char_to_hex(ascii_digit);
+
+		string++;
+		valid_digits++;
+	}
+
+exit:
+	return (return_value);
+}
diff --git a/tools/power/acpi/tools/acpidump/Makefile b/tools/power/acpi/tools/acpidump/Makefile
index a710f60..04b5db7 100644
--- a/tools/power/acpi/tools/acpidump/Makefile
+++ b/tools/power/acpi/tools/acpidump/Makefile
@@ -36,10 +36,12 @@ TOOL_OBJS = \
 	utdebug.o\
 	utexcep.o\
 	utglobal.o\
+	uthex.o\
 	utmath.o\
 	utnonansi.o\
 	utprint.o\
 	utstring.o\
+	utstrtoul64.o\
 	utxferror.o\
 	oslinuxtbl.o\
 	cmfsize.o\
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index 1c4e00b..9031be1 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -287,8 +287,8 @@ int ap_dump_table_by_address(char *ascii_address)
 
 	/* Convert argument to an integer physical address */
 
-	status = acpi_ut_strtoul64(ascii_address, ACPI_ANY_BASE,
-				   ACPI_MAX64_BYTE_WIDTH, &long_address);
+	status = acpi_ut_strtoul64(ascii_address, ACPI_STRTOUL_64BIT,
+				   &long_address);
 	if (ACPI_FAILURE(status)) {
 		fprintf(stderr, "%s: Could not convert to a physical address\n",
 			ascii_address);
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index f32968e..7ff46be 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -208,8 +208,8 @@ static int ap_do_options(int argc, char **argv)
 		case 'r':	/* Dump tables from specified RSDP */
 
 			status =
-			    acpi_ut_strtoul64(acpi_gbl_optarg, ACPI_ANY_BASE,
-					      ACPI_MAX64_BYTE_WIDTH,
+			    acpi_ut_strtoul64(acpi_gbl_optarg,
+					      ACPI_STRTOUL_64BIT,
 					      &gbl_rsdp_base);
 			if (ACPI_FAILURE(status)) {
 				fprintf(stderr,
-- 
1.7.10

