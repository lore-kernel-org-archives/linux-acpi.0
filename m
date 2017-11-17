From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 01/15] ACPICA: Use local 64-bit divide support for string conversions
Date: Fri, 17 Nov 2017 15:42:16 -0800
Message-ID: <20171117234230.913-2-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39431 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759898AbdKQXqe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:34 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit f230f4df26d07b97ef00be39156ecee64250447d

On 32-bit platforms, 64-bit divide often requires a library
function which may not be present in the build.

Link: https://github.com/acpica/acpica/commit/f230f4df
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/utstrsuppt.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/utstrsuppt.c b/drivers/acpi/acpica/utstrsuppt.c
index bec2b8e1693e..97f48d71f9e6 100644
--- a/drivers/acpi/acpica/utstrsuppt.c
+++ b/drivers/acpi/acpica/utstrsuppt.c
@@ -52,10 +52,9 @@ static acpi_status
 acpi_ut_insert_digit(u64 *accumulated_value, u32 base, int ascii_digit);
 
 static acpi_status
-acpi_ut_strtoul_multiply64(u64 multiplicand, u64 multiplier, u64 *out_product);
+acpi_ut_strtoul_multiply64(u64 multiplicand, u32 base, u64 *out_product);
 
-static acpi_status
-acpi_ut_strtoul_add64(u64 addend1, u64 addend2, u64 *out_sum);
+static acpi_status acpi_ut_strtoul_add64(u64 addend1, u32 digit, u64 *out_sum);
 
 /*******************************************************************************
  *
@@ -357,7 +356,7 @@ acpi_ut_insert_digit(u64 *accumulated_value, u32 base, int ascii_digit)
  * FUNCTION:    acpi_ut_strtoul_multiply64
  *
  * PARAMETERS:  multiplicand            - Current accumulated converted integer
- *              multiplier              - Base/Radix
+ *              base                    - Base/Radix
  *              out_product             - Where the product is returned
  *
  * RETURN:      Status and 64-bit product
@@ -369,24 +368,32 @@ acpi_ut_insert_digit(u64 *accumulated_value, u32 base, int ascii_digit)
  ******************************************************************************/
 
 static acpi_status
-acpi_ut_strtoul_multiply64(u64 multiplicand, u64 multiplier, u64 *out_product)
+acpi_ut_strtoul_multiply64(u64 multiplicand, u32 base, u64 *out_product)
 {
 	u64 product;
+	u64 quotient;
 
 	/* Exit if either operand is zero */
 
 	*out_product = 0;
-	if (!multiplicand || !multiplier) {
+	if (!multiplicand || !base) {
 		return (AE_OK);
 	}
 
-	/* Check for 64-bit overflow before the actual multiplication */
-
-	if (multiplicand > (ACPI_UINT64_MAX / multiplier)) {
+	/*
+	 * Check for 64-bit overflow before the actual multiplication.
+	 *
+	 * Notes: 64-bit division is often not supported on 32-bit platforms
+	 * (it requires a library function), Therefore ACPICA has a local
+	 * 64-bit divide function. Also, Multiplier is currently only used
+	 * as the radix (8/10/16), to the 64/32 divide will always work.
+	 */
+	acpi_ut_short_divide(ACPI_UINT64_MAX, base, &quotient, NULL);
+	if (multiplicand > quotient) {
 		return (AE_NUMERIC_OVERFLOW);
 	}
 
-	product = multiplicand * multiplier;
+	product = multiplicand * base;
 
 	/* Check for 32-bit overflow if necessary */
 
@@ -403,7 +410,7 @@ acpi_ut_strtoul_multiply64(u64 multiplicand, u64 multiplier, u64 *out_product)
  * FUNCTION:    acpi_ut_strtoul_add64
  *
  * PARAMETERS:  addend1                 - Current accumulated converted integer
- *              addend2                 - New hex value/char
+ *              digit                   - New hex value/char
  *              out_sum                 - Where sum is returned (Accumulator)
  *
  * RETURN:      Status and 64-bit sum
@@ -414,17 +421,17 @@ acpi_ut_strtoul_multiply64(u64 multiplicand, u64 multiplier, u64 *out_product)
  *
  ******************************************************************************/
 
-static acpi_status acpi_ut_strtoul_add64(u64 addend1, u64 addend2, u64 *out_sum)
+static acpi_status acpi_ut_strtoul_add64(u64 addend1, u32 digit, u64 *out_sum)
 {
 	u64 sum;
 
 	/* Check for 64-bit overflow before the actual addition */
 
-	if ((addend1 > 0) && (addend2 > (ACPI_UINT64_MAX - addend1))) {
+	if ((addend1 > 0) && (digit > (ACPI_UINT64_MAX - addend1))) {
 		return (AE_NUMERIC_OVERFLOW);
 	}
 
-	sum = addend1 + addend2;
+	sum = addend1 + digit;
 
 	/* Check for 32-bit overflow if necessary */
 
-- 
2.13.6

