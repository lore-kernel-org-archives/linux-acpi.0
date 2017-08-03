From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/15] ACPICA: CLib: Add short multiply/shift support
Date: Thu,  3 Aug 2017 14:26:50 +0800
Message-ID: <d15d8607474e80dda35309d7486e820027c5c182.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51695 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbdHCG0y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:26:54 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

ACPICA commit 01b8f5a2350b9cc329cd8402ac8faec36fc501f5

In order to build ACPICA EFI tools with EDK-II on Windows, 64-bit
multiply/shift supports are also required to be implemented. Otherwise,
MSVC complains:
 acpidump.lib(utstrtoul64.obj) : error LNK2001: unresolved external symbol __allmul
 acpidump.lib(uthex.obj) : error LNK2001: unresolved external symbol __aullshr

Note:
1. This patch also splits _EDK2_EFI from _GNU_EFI as they might have
   different math64 supports.
2. Support of gcc math64 is not included in this patch.
3. Support of EDK2 arch independent math64 is done via linking to base_lib.

This patch fixes this issue. Reported by Shao Ming, fixed by Lv Zheng.

For Linux kernel, this patch is a functional no-op.

Link: https://github.com/acpica/acpica/commit/01b8f5a2
Tested-by: "Shao, Ming" <smbest163@163.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acutils.h             |   7 +
 drivers/acpi/acpica/uthex.c               |   4 +-
 drivers/acpi/acpica/utmath.c              | 222 ++++++++++++++++++++++++++++--
 drivers/acpi/acpica/utprint.c             |   2 +-
 drivers/acpi/acpica/utstrtoul64.c         |   9 +-
 include/acpi/actypes.h                    |   1 +
 include/acpi/platform/acgcc.h             |   4 +
 include/acpi/platform/aclinux.h           |   2 +
 tools/power/acpi/tools/acpidump/apfiles.c |   2 +-
 tools/power/acpi/tools/acpidump/apmain.c  |   2 +-
 10 files changed, 237 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 2a3cc429..0a56014 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -538,6 +538,13 @@ acpi_status
 acpi_ut_short_divide(u64 in_dividend,
 		     u32 divisor, u64 *out_quotient, u32 *out_remainder);
 
+acpi_status
+acpi_ut_short_multiply(u64 in_multiplicand, u32 multiplier, u64 *outproduct);
+
+acpi_status acpi_ut_short_shift_left(u64 operand, u32 count, u64 *out_result);
+
+acpi_status acpi_ut_short_shift_right(u64 operand, u32 count, u64 *out_result);
+
 /*
  * utmisc
  */
diff --git a/drivers/acpi/acpica/uthex.c b/drivers/acpi/acpica/uthex.c
index 6600bc2..fb406da 100644
--- a/drivers/acpi/acpica/uthex.c
+++ b/drivers/acpi/acpica/uthex.c
@@ -69,8 +69,10 @@ static const char acpi_gbl_hex_to_ascii[] = {
 
 char acpi_ut_hex_to_ascii_char(u64 integer, u32 position)
 {
+	u64 index;
 
-	return (acpi_gbl_hex_to_ascii[(integer >> position) & 0xF]);
+	acpi_ut_short_shift_right(integer, position, &index);
+	return (acpi_gbl_hex_to_ascii[index & 0xF]);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index aa0502d..5f9c680 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -47,15 +47,6 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utmath")
 
-/*
- * Optional support for 64-bit double-precision integer divide. This code
- * is configurable and is implemented in order to support 32-bit kernel
- * environments where a 64-bit double-precision math library is not available.
- *
- * Support for a more normal 64-bit divide/modulo (with check for a divide-
- * by-zero) appears after this optional section of code.
- */
-#ifndef ACPI_USE_NATIVE_DIVIDE
 /* Structures used only for 64-bit divide */
 typedef struct uint64_struct {
 	u32 lo;
@@ -69,6 +60,217 @@ typedef union uint64_overlay {
 
 } uint64_overlay;
 
+/*
+ * Optional support for 64-bit double-precision integer multiply and shift.
+ * This code is configurable and is implemented in order to support 32-bit
+ * kernel environments where a 64-bit double-precision math library is not
+ * available.
+ */
+#ifndef ACPI_USE_NATIVE_MATH64
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_short_multiply
+ *
+ * PARAMETERS:  multiplicand        - 64-bit multiplicand
+ *              multiplier          - 32-bit multiplier
+ *              out_product         - Pointer to where the product is returned
+ *
+ * DESCRIPTION: Perform a short multiply.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ut_short_multiply(u64 multiplicand, u32 multiplier, u64 *out_product)
+{
+	union uint64_overlay multiplicand_ovl;
+	union uint64_overlay product;
+	u32 carry32;
+
+	ACPI_FUNCTION_TRACE(ut_short_multiply);
+
+	multiplicand_ovl.full = multiplicand;
+
+	/*
+	 * The Product is 64 bits, the carry is always 32 bits,
+	 * and is generated by the second multiply.
+	 */
+	ACPI_MUL_64_BY_32(0, multiplicand_ovl.part.hi, multiplier,
+			  product.part.hi, carry32);
+
+	ACPI_MUL_64_BY_32(0, multiplicand_ovl.part.lo, multiplier,
+			  product.part.lo, carry32);
+
+	product.part.hi += carry32;
+
+	/* Return only what was requested */
+
+	if (out_product) {
+		*out_product = product.full;
+	}
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_short_shift_left
+ *
+ * PARAMETERS:  operand             - 64-bit shift operand
+ *              count               - 32-bit shift count
+ *              out_result          - Pointer to where the result is returned
+ *
+ * DESCRIPTION: Perform a short left shift.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_short_shift_left(u64 operand, u32 count, u64 *out_result)
+{
+	union uint64_overlay operand_ovl;
+
+	ACPI_FUNCTION_TRACE(ut_short_shift_left);
+
+	operand_ovl.full = operand;
+
+	if ((count & 63) >= 32) {
+		operand_ovl.part.hi = operand_ovl.part.lo;
+		operand_ovl.part.lo ^= operand_ovl.part.lo;
+		count = (count & 63) - 32;
+	}
+	ACPI_SHIFT_LEFT_64_BY_32(operand_ovl.part.hi,
+				 operand_ovl.part.lo, count);
+
+	/* Return only what was requested */
+
+	if (out_result) {
+		*out_result = operand_ovl.full;
+	}
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_short_shift_right
+ *
+ * PARAMETERS:  operand             - 64-bit shift operand
+ *              count               - 32-bit shift count
+ *              out_result          - Pointer to where the result is returned
+ *
+ * DESCRIPTION: Perform a short right shift.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_short_shift_right(u64 operand, u32 count, u64 *out_result)
+{
+	union uint64_overlay operand_ovl;
+
+	ACPI_FUNCTION_TRACE(ut_short_shift_right);
+
+	operand_ovl.full = operand;
+
+	if ((count & 63) >= 32) {
+		operand_ovl.part.lo = operand_ovl.part.hi;
+		operand_ovl.part.hi ^= operand_ovl.part.hi;
+		count = (count & 63) - 32;
+	}
+	ACPI_SHIFT_RIGHT_64_BY_32(operand_ovl.part.hi,
+				  operand_ovl.part.lo, count);
+
+	/* Return only what was requested */
+
+	if (out_result) {
+		*out_result = operand_ovl.full;
+	}
+
+	return_ACPI_STATUS(AE_OK);
+}
+#else
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_short_multiply
+ *
+ * PARAMETERS:  See function headers above
+ *
+ * DESCRIPTION: Native version of the ut_short_multiply function.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ut_short_multiply(u64 multiplicand, u32 multiplier, u64 *out_product)
+{
+
+	ACPI_FUNCTION_TRACE(ut_short_multiply);
+
+	/* Return only what was requested */
+
+	if (out_product) {
+		*out_product = multiplicand * multiplier;
+	}
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_short_shift_left
+ *
+ * PARAMETERS:  See function headers above
+ *
+ * DESCRIPTION: Native version of the ut_short_shift_left function.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_short_shift_left(u64 operand, u32 count, u64 *out_result)
+{
+
+	ACPI_FUNCTION_TRACE(ut_short_shift_left);
+
+	/* Return only what was requested */
+
+	if (out_result) {
+		*out_result = operand << count;
+	}
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_short_shift_right
+ *
+ * PARAMETERS:  See function headers above
+ *
+ * DESCRIPTION: Native version of the ut_short_shift_right function.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_short_shift_right(u64 operand, u32 count, u64 *out_result)
+{
+
+	ACPI_FUNCTION_TRACE(ut_short_shift_right);
+
+	/* Return only what was requested */
+
+	if (out_result) {
+		*out_result = operand >> count;
+	}
+
+	return_ACPI_STATUS(AE_OK);
+}
+#endif
+
+/*
+ * Optional support for 64-bit double-precision integer divide. This code
+ * is configurable and is implemented in order to support 32-bit kernel
+ * environments where a 64-bit double-precision math library is not available.
+ *
+ * Support for a more normal 64-bit divide/modulo (with check for a divide-
+ * by-zero) appears after this optional section of code.
+ */
+#ifndef ACPI_USE_NATIVE_DIVIDE
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_short_divide
@@ -258,6 +460,7 @@ acpi_ut_divide(u64 in_dividend,
 }
 
 #else
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_short_divide, acpi_ut_divide
@@ -272,6 +475,7 @@ acpi_ut_divide(u64 in_dividend,
  *                 perform the divide.
  *
  ******************************************************************************/
+
 acpi_status
 acpi_ut_short_divide(u64 in_dividend,
 		     u32 divisor, u64 *out_quotient, u32 *out_remainder)
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 7e6e1ae..23cb472 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -176,7 +176,7 @@ const char *acpi_ut_scan_number(const char *string, u64 *number_ptr)
 	u64 number = 0;
 
 	while (isdigit((int)*string)) {
-		number *= 10;
+		acpi_ut_short_multiply(number, 10, &number);
 		number += *(string++) - '0';
 	}
 
diff --git a/drivers/acpi/acpica/utstrtoul64.c b/drivers/acpi/acpica/utstrtoul64.c
index f42be01..9633ee1 100644
--- a/drivers/acpi/acpica/utstrtoul64.c
+++ b/drivers/acpi/acpica/utstrtoul64.c
@@ -276,8 +276,8 @@ static u64 acpi_ut_strtoul_base10(char *string, u32 flags)
 
 		/* Convert and insert (add) the decimal digit */
 
-		next_value =
-		    (return_value * 10) + (ascii_digit - ACPI_ASCII_ZERO);
+		acpi_ut_short_multiply(return_value, 10, &next_value);
+		next_value += (ascii_digit - ACPI_ASCII_ZERO);
 
 		/* Check for overflow (32 or 64 bit) - return current converted value */
 
@@ -335,9 +335,8 @@ static u64 acpi_ut_strtoul_base16(char *string, u32 flags)
 
 		/* Convert and insert the hex digit */
 
-		return_value =
-		    (return_value << 4) |
-		    acpi_ut_ascii_char_to_hex(ascii_digit);
+		acpi_ut_short_shift_left(return_value, 4, &return_value);
+		return_value |= acpi_ut_ascii_char_to_hex(ascii_digit);
 
 		string++;
 		valid_digits++;
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 0260be5..dc3bb15 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -166,6 +166,7 @@ typedef u64 acpi_physical_address;
 #define ACPI_SIZE_MAX                   ACPI_UINT64_MAX
 
 #define ACPI_USE_NATIVE_DIVIDE	/* Has native 64-bit integer support */
+#define ACPI_USE_NATIVE_MATH64	/* Has native 64-bit integer support */
 
 /*
  * In the case of the Itanium Processor Family (IPF), the hardware does not
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 97a7e21..9c8f8b7 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -84,4 +84,8 @@ typedef __builtin_va_list va_list;
 
 #define COMPILER_VA_MACRO               1
 
+/* GCC supports native multiply/shift on 32-bit platforms */
+
+#define ACPI_USE_NATIVE_MATH64
+
 #endif				/* __ACGCC_H__ */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index afd95f2..1b473ef 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -128,6 +128,7 @@
 /* Host-dependent types and defines for in-kernel ACPICA */
 
 #define ACPI_MACHINE_WIDTH          BITS_PER_LONG
+#define ACPI_USE_NATIVE_MATH64
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
 #define strtoul                     simple_strtoul
 
@@ -216,6 +217,7 @@
 #define COMPILER_DEPENDENT_INT64    long long
 #define COMPILER_DEPENDENT_UINT64   unsigned long long
 #define ACPI_USE_NATIVE_DIVIDE
+#define ACPI_USE_NATIVE_MATH64
 #endif
 
 #ifndef __cdecl
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 31b5a7f..d686e11 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -61,7 +61,7 @@ static int ap_is_existing_file(char *pathname);
 
 static int ap_is_existing_file(char *pathname)
 {
-#ifndef _GNU_EFI
+#if !defined(_GNU_EFI) && !defined(_EDK2_EFI)
 	struct stat stat_info;
 
 	if (!stat(pathname, &stat_info)) {
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index dd82afa..943b6b6 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -300,7 +300,7 @@ static int ap_do_options(int argc, char **argv)
  *
  ******************************************************************************/
 
-#ifndef _GNU_EFI
+#if !defined(_GNU_EFI) && !defined(_EDK2_EFI)
 int ACPI_SYSTEM_XFACE main(int argc, char *argv[])
 #else
 int ACPI_SYSTEM_XFACE acpi_main(int argc, char *argv[])
-- 
2.7.4

