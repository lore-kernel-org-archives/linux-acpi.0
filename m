From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/15] ACPICA: iASL: Update to use internal acpi_ut_strtoul64 function
Date: Fri, 19 Feb 2016 14:16:27 +0800
Message-ID: <a58eb8db7abc944e0a4afca1fdb46998c5860bf2.1455857580.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit e959584d23b520c53700e90282312d17b9603ed5

Was using a local Strtoul64, update to use the common acpi_ut_strtoul64
and remove the local Strtoul64.

Link: https://github.com/acpica/acpica/commit/e959584d
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utnonansi.c |  244 +++++++++++++++++++++++++++++++++------
 1 file changed, 206 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index d1f4a47..d5c3adf 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -140,6 +140,67 @@ int acpi_ut_stricmp(char *string1, char *string2)
 	return (c1 - c2);
 }
 
+#if defined (ACPI_DEBUGGER) || defined (ACPI_APPLICATION)
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_safe_strcpy, acpi_ut_safe_strcat, acpi_ut_safe_strncat
+ *
+ * PARAMETERS:  Adds a "DestSize" parameter to each of the standard string
+ *              functions. This is the size of the Destination buffer.
+ *
+ * RETURN:      TRUE if the operation would overflow the destination buffer.
+ *
+ * DESCRIPTION: Safe versions of standard Clib string functions. Ensure that
+ *              the result of the operation will not overflow the output string
+ *              buffer.
+ *
+ * NOTE:        These functions are typically only helpful for processing
+ *              user input and command lines. For most ACPICA code, the
+ *              required buffer length is precisely calculated before buffer
+ *              allocation, so the use of these functions is unnecessary.
+ *
+ ******************************************************************************/
+
+u8 acpi_ut_safe_strcpy(char *dest, acpi_size dest_size, char *source)
+{
+
+	if (strlen(source) >= dest_size) {
+		return (TRUE);
+	}
+
+	strcpy(dest, source);
+	return (FALSE);
+}
+
+u8 acpi_ut_safe_strcat(char *dest, acpi_size dest_size, char *source)
+{
+
+	if ((strlen(dest) + strlen(source)) >= dest_size) {
+		return (TRUE);
+	}
+
+	strcat(dest, source);
+	return (FALSE);
+}
+
+u8
+acpi_ut_safe_strncat(char *dest,
+		     acpi_size dest_size,
+		     char *source, acpi_size max_transfer_length)
+{
+	acpi_size actual_transfer_length;
+
+	actual_transfer_length = ACPI_MIN(max_transfer_length, strlen(source));
+
+	if ((strlen(dest) + actual_transfer_length) >= dest_size) {
+		return (TRUE);
+	}
+
+	strncat(dest, source, max_transfer_length);
+	return (FALSE);
+}
+#endif
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_strtoul64
@@ -155,7 +216,15 @@ int acpi_ut_stricmp(char *string1, char *string2)
  *              32-bit or 64-bit conversion, depending on the current mode
  *              of the interpreter.
  *
- * NOTE:        Does not support Octal strings, not needed.
+ * NOTES:       acpi_gbl_integer_byte_width should be set to the proper width.
+ *              For the core ACPICA code, this width depends on the DSDT
+ *              version. For iASL, the default byte width is always 8.
+ *
+ *              Does not support Octal strings, not needed at this time.
+ *
+ *              There is an earlier version of the function after this one,
+ *              below. It is slightly different than this one, and the two
+ *              may eventually may need to be merged. (01/2016).
  *
  ******************************************************************************/
 
@@ -318,63 +387,162 @@ error_exit:
 	}
 }
 
-#if defined (ACPI_DEBUGGER) || defined (ACPI_APPLICATION)
+#ifdef _OBSOLETE_FUNCTIONS
+/* TBD: use version in ACPICA main code base? */
+/* DONE: 01/2016 */
+
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ut_safe_strcpy, acpi_ut_safe_strcat, acpi_ut_safe_strncat
+ * FUNCTION:    strtoul64
  *
- * PARAMETERS:  Adds a "DestSize" parameter to each of the standard string
- *              functions. This is the size of the Destination buffer.
+ * PARAMETERS:  string              - Null terminated string
+ *              terminater          - Where a pointer to the terminating byte
+ *                                    is returned
+ *              base                - Radix of the string
  *
- * RETURN:      TRUE if the operation would overflow the destination buffer.
+ * RETURN:      Converted value
  *
- * DESCRIPTION: Safe versions of standard Clib string functions. Ensure that
- *              the result of the operation will not overflow the output string
- *              buffer.
- *
- * NOTE:        These functions are typically only helpful for processing
- *              user input and command lines. For most ACPICA code, the
- *              required buffer length is precisely calculated before buffer
- *              allocation, so the use of these functions is unnecessary.
+ * DESCRIPTION: Convert a string into an unsigned value.
  *
  ******************************************************************************/
 
-u8 acpi_ut_safe_strcpy(char *dest, acpi_size dest_size, char *source)
+acpi_status strtoul64(char *string, u32 base, u64 *ret_integer)
 {
+	u32 index;
+	u32 sign;
+	u64 return_value = 0;
+	acpi_status status = AE_OK;
 
-	if (strlen(source) >= dest_size) {
-		return (TRUE);
+	*ret_integer = 0;
+
+	switch (base) {
+	case 0:
+	case 8:
+	case 10:
+	case 16:
+
+		break;
+
+	default:
+		/*
+		 * The specified Base parameter is not in the domain of
+		 * this function:
+		 */
+		return (AE_BAD_PARAMETER);
 	}
 
-	strcpy(dest, source);
-	return (FALSE);
-}
+	/* Skip over any white space in the buffer: */
 
-u8 acpi_ut_safe_strcat(char *dest, acpi_size dest_size, char *source)
-{
+	while (isspace((int)*string) || *string == '\t') {
+		++string;
+	}
 
-	if ((strlen(dest) + strlen(source)) >= dest_size) {
-		return (TRUE);
+	/*
+	 * The buffer may contain an optional plus or minus sign.
+	 * If it does, then skip over it but remember what is was:
+	 */
+	if (*string == '-') {
+		sign = ACPI_SIGN_NEGATIVE;
+		++string;
+	} else if (*string == '+') {
+		++string;
+		sign = ACPI_SIGN_POSITIVE;
+	} else {
+		sign = ACPI_SIGN_POSITIVE;
 	}
 
-	strcat(dest, source);
-	return (FALSE);
-}
+	/*
+	 * If the input parameter Base is zero, then we need to
+	 * determine if it is octal, decimal, or hexadecimal:
+	 */
+	if (base == 0) {
+		if (*string == '0') {
+			if (tolower((int)*(++string)) == 'x') {
+				base = 16;
+				++string;
+			} else {
+				base = 8;
+			}
+		} else {
+			base = 10;
+		}
+	}
 
-u8
-acpi_ut_safe_strncat(char *dest,
-		     acpi_size dest_size,
-		     char *source, acpi_size max_transfer_length)
-{
-	acpi_size actual_transfer_length;
+	/*
+	 * For octal and hexadecimal bases, skip over the leading
+	 * 0 or 0x, if they are present.
+	 */
+	if (base == 8 && *string == '0') {
+		string++;
+	}
 
-	actual_transfer_length = ACPI_MIN(max_transfer_length, strlen(source));
+	if (base == 16 && *string == '0' && tolower((int)*(++string)) == 'x') {
+		string++;
+	}
 
-	if ((strlen(dest) + actual_transfer_length) >= dest_size) {
-		return (TRUE);
+	/* Main loop: convert the string to an unsigned long */
+
+	while (*string) {
+		if (isdigit((int)*string)) {
+			index = ((u8)*string) - '0';
+		} else {
+			index = (u8)toupper((int)*string);
+			if (isupper((int)index)) {
+				index = index - 'A' + 10;
+			} else {
+				goto error_exit;
+			}
+		}
+
+		if (index >= base) {
+			goto error_exit;
+		}
+
+		/* Check to see if value is out of range: */
+
+		if (return_value > ((ACPI_UINT64_MAX - (u64)index) / (u64)base)) {
+			goto error_exit;
+		} else {
+			return_value *= base;
+			return_value += index;
+		}
+
+		++string;
 	}
 
-	strncat(dest, source, max_transfer_length);
-	return (FALSE);
+	/* If a minus sign was present, then "the conversion is negated": */
+
+	if (sign == ACPI_SIGN_NEGATIVE) {
+		return_value = (ACPI_UINT32_MAX - return_value) + 1;
+	}
+
+	*ret_integer = return_value;
+	return (status);
+
+error_exit:
+	switch (base) {
+	case 8:
+
+		status = AE_BAD_OCTAL_CONSTANT;
+		break;
+
+	case 10:
+
+		status = AE_BAD_DECIMAL_CONSTANT;
+		break;
+
+	case 16:
+
+		status = AE_BAD_HEX_CONSTANT;
+		break;
+
+	default:
+
+		/* Base validated above */
+
+		break;
+	}
+
+	return (status);
 }
 #endif
-- 
1.7.10
