From: Len Brown <len.brown@intel.com>
Subject: [PATCH 14/65] ACPICA: Fix for FADT conversion in 64-bit mode
Date: Fri, 24 Nov 2006 02:18:24 -0500
Message-ID: <11643527743390-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14089 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934464AbWKXHPg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:36 -0500
In-Reply-To: <11643527731111-git-send-email-len.brown@intel.com>
Message-Id: <7f4682ef0ee3349060e1d9c037d6c97d111c05b0.1164352291.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbutils.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index 2f4ab75..77c7e87 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -131,6 +131,8 @@ acpi_tb_print_table_header(acpi_physical
 			   ((struct acpi_table_rsdp *)header)->revision,
 			   ((struct acpi_table_rsdp *)header)->oem_id));
 	} else {
+		/* Standard ACPI table with full common header */
+
 		ACPI_INFO((AE_INFO,
 			   "%4.4s @ 0x%p/0x%04X (v%3.3d %6.6s %8.8s 0x%08X %4.4s 0x%08X)",
 			   header->signature, ACPI_CAST_PTR(void, address),
@@ -160,7 +162,7 @@ acpi_tb_init_generic_address(struct acpi
 			     u8 bit_width, u64 address)
 {
 
-	ACPI_STORE_ADDRESS(new_gas_struct->address, address);
+	ACPI_MOVE_64_TO_64(&new_gas_struct->address, &address);
 	new_gas_struct->space_id = ACPI_ADR_SPACE_SYSTEM_IO;
 	new_gas_struct->bit_width = bit_width;
 	new_gas_struct->bit_offset = 0;
@@ -284,13 +286,15 @@ static void acpi_tb_convert_fadt(void)
 		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
 				 fadt_conversion_table[i].target);
 
+		/* Expand only if the X target is null */
+
 		if (!target->address) {
 			acpi_tb_init_generic_address(target,
 						     *ACPI_ADD_PTR(u8,
 								   &acpi_gbl_FADT,
 								   fadt_conversion_table
 								   [i].length),
-						     *ACPI_ADD_PTR(u64,
+						     *ACPI_ADD_PTR(u32,
 								   &acpi_gbl_FADT,
 								   fadt_conversion_table
 								   [i].source));
@@ -301,6 +305,10 @@ static void acpi_tb_convert_fadt(void)
 	 * Calculate separate GAS structs for the PM1 Enable registers.
 	 * These addresses do not appear (directly) in the FADT, so it is
 	 * useful to calculate them once, here.
+	 *
+	 * The PM event blocks are split into two register blocks, first is the
+	 * PM Status Register block, followed immediately by the PM Enable Register
+	 * block. Each is of length (pm1_event_length/2)
 	 */
 	pm1_register_length = (u8) ACPI_DIV_2(acpi_gbl_FADT.pm1_event_length);
 
@@ -308,17 +316,16 @@ static void acpi_tb_convert_fadt(void)
 
 	acpi_tb_init_generic_address(&acpi_gbl_xpm1a_enable,
 				     pm1_register_length,
-				     (u64) (acpi_gbl_FADT.xpm1a_event_block.
-					    address + pm1_register_length));
+				     (acpi_gbl_FADT.xpm1a_event_block.address +
+				      pm1_register_length));
 
 	/* PM1B is optional; leave null if not present */
 
 	if (acpi_gbl_FADT.xpm1b_event_block.address) {
 		acpi_tb_init_generic_address(&acpi_gbl_xpm1b_enable,
 					     pm1_register_length,
-					     (u64) (acpi_gbl_FADT.
-						    xpm1b_event_block.address +
-						    pm1_register_length));
+					     (acpi_gbl_FADT.xpm1b_event_block.
+					      address + pm1_register_length));
 	}
 
 	/* Global FADT is the new common V2.0 FADT  */
-- 
1.4.4.1
