From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/14] ACPICA: Tables: Override all 64-bit GAS fields when acpi_gbl_use32_bit_fadt_addresses is TRUE
Date: Wed,  7 Sep 2016 14:06:39 +0800
Message-ID: <52286b5744f719786f73146f1fb85936a53e2492.1473226204.git.lv.zheng@intel.com>
References: <cover.1473226203.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34624 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751080AbcIGGGp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:06:45 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit aaace77db4c3b267a65b75c33f84ace6f65bbcf7

Originally, when acpi_gbl_use32_bit_fadt_addresses is TRUE, GAS override can
only happen when the Address field mismatches.
According to the investigation result, Windows may favor 32-bit FADT
addresses in some cases. So we need this quirk working after enabling full
GAS support. This requires us to override GAS access_size/bit_width/bit_offset
fields as long as acpi_gbl_use32_bit_fadt_addresses is TRUE.
This patch enhances this quirk mechanism to make it working with full GAS
support. Lv Zheng.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=151501
Link: https://github.com/acpica/acpica/commit/aaace77d
Reported-and-tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |  102 ++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 53 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index e678d6f..046c4d0 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -558,78 +558,74 @@ static void acpi_tb_convert_fadt(void)
 		 *
 		 * Address32 zero, Address64 [don't care]   - Use Address64
 		 *
+		 * No override: if acpi_gbl_use32_bit_fadt_addresses is FALSE, and:
 		 * Address32 non-zero, Address64 zero       - Copy/use Address32
 		 * Address32 non-zero == Address64 non-zero - Use Address64
 		 * Address32 non-zero != Address64 non-zero - Warning, use Address64
 		 *
 		 * Override: if acpi_gbl_use32_bit_fadt_addresses is TRUE, and:
+		 * Address32 non-zero, Address64 zero       - Copy/use Address32
+		 * Address32 non-zero == Address64 non-zero - Copy/use Address32
 		 * Address32 non-zero != Address64 non-zero - Warning, copy/use Address32
 		 *
 		 * Note: space_id is always I/O for 32-bit legacy address fields
 		 */
 		if (address32) {
-			if (!address64->address) {
+			if (address64->address) {
+				if (address64->address != (u64)address32) {
+
+					/* Address mismatch */
+
+					ACPI_BIOS_WARNING((AE_INFO,
+							   "32/64X address mismatch in FADT/%s: "
+							   "0x%8.8X/0x%8.8X%8.8X, using %u-bit address",
+							   name, address32,
+							   ACPI_FORMAT_UINT64
+							   (address64->address),
+							   acpi_gbl_use32_bit_fadt_addresses
+							   ? 32 : 64));
+				}
 
-				/* 64-bit address is zero, use 32-bit address */
+				/*
+				 * For each extended field, check for length mismatch
+				 * between the legacy length field and the corresponding
+				 * 64-bit X length field.
+				 * Note: If the legacy length field is > 0xFF bits, ignore
+				 * this check. (GPE registers can be larger than the
+				 * 64-bit GAS structure can accomodate, 0xFF bits).
+				 */
+				if ((ACPI_MUL_8(length) <= ACPI_UINT8_MAX) &&
+				    (address64->bit_width !=
+				     ACPI_MUL_8(length))) {
+					ACPI_BIOS_WARNING((AE_INFO,
+							   "32/64X length mismatch in FADT/%s: %u/%u",
+							   name,
+							   ACPI_MUL_8(length),
+							   address64->
+							   bit_width));
+				}
+			}
 
+			/*
+			 * Hardware register access code always uses the 64-bit fields.
+			 * So if the 64-bit field is zero or is to be overridden,
+			 * initialize it with the 32-bit fields.
+			 * Note that when the 32-bit address favor is specified, the
+			 * 64-bit fields are always re-initialized so that
+			 * access_size/bit_width/bit_offset fields can be correctly
+			 * configured to the values to trigger a 32-bit compatible
+			 * access mode in the hardware register access code.
+			 */
+			if (!address64->address
+			    || acpi_gbl_use32_bit_fadt_addresses) {
 				acpi_tb_init_generic_address(address64,
 							     ACPI_ADR_SPACE_SYSTEM_IO,
-							     *ACPI_ADD_PTR(u8,
-									   &acpi_gbl_FADT,
-									   fadt_info_table
-									   [i].
-									   length),
+							     length,
 							     (u64)address32,
 							     name, flags);
-			} else if (address64->address != (u64)address32) {
-
-				/* Address mismatch */
-
-				ACPI_BIOS_WARNING((AE_INFO,
-						   "32/64X address mismatch in FADT/%s: "
-						   "0x%8.8X/0x%8.8X%8.8X, using %u-bit address",
-						   name, address32,
-						   ACPI_FORMAT_UINT64
-						   (address64->address),
-						   acpi_gbl_use32_bit_fadt_addresses
-						   ? 32 : 64));
-
-				if (acpi_gbl_use32_bit_fadt_addresses) {
-
-					/* 32-bit address override */
-
-					acpi_tb_init_generic_address(address64,
-								     ACPI_ADR_SPACE_SYSTEM_IO,
-								     *ACPI_ADD_PTR
-								     (u8,
-								      &acpi_gbl_FADT,
-								      fadt_info_table
-								      [i].
-								      length),
-								     (u64)
-								     address32,
-								     name,
-								     flags);
-				}
 			}
 		}
 
-		/*
-		 * For each extended field, check for length mismatch between the
-		 * legacy length field and the corresponding 64-bit X length field.
-		 * Note: If the legacy length field is > 0xFF bits, ignore this
-		 * check. (GPE registers can be larger than the 64-bit GAS structure
-		 * can accomodate, 0xFF bits).
-		 */
-		if (address64->address &&
-		    (ACPI_MUL_8(length) <= ACPI_UINT8_MAX) &&
-		    (address64->bit_width != ACPI_MUL_8(length))) {
-			ACPI_BIOS_WARNING((AE_INFO,
-					   "32/64X length mismatch in FADT/%s: %u/%u",
-					   name, ACPI_MUL_8(length),
-					   address64->bit_width));
-		}
-
 		if (fadt_info_table[i].flags & ACPI_FADT_REQUIRED) {
 			/*
 			 * Field is required (Pm1a_event, Pm1a_control).
-- 
1.7.10

