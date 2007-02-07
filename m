From: Len Brown <lenb@kernel.org>
Subject: [PATCH 55/140] ACPICA: Fix for FADT conversion in 64-bit mode
Date: Wed,  7 Feb 2007 13:51:09 -0500
Message-ID: <11708744522444-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:15056 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422769AbXBGSyO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:14 -0500
In-Reply-To: <11708744513541-git-send-email-lenb@kernel.org>
Message-Id: <4bf273939c99fae5bae399f51c417a552d74b97f.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbutils.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index 2f4ab75..77c7e87 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -131,6 +131,8 @@ acpi_tb_print_table_header(acpi_physical_address address,
 			   ((struct acpi_table_rsdp *)header)->revision,
 			   ((struct acpi_table_rsdp *)header)->oem_id));
 	} else {
+		/* Standard ACPI table with full common header */
+
 		ACPI_INFO((AE_INFO,
 			   "%4.4s @ 0x%p/0x%04X (v%3.3d %6.6s %8.8s 0x%08X %4.4s 0x%08X)",
 			   header->signature, ACPI_CAST_PTR(void, address),
@@ -160,7 +162,7 @@ acpi_tb_init_generic_address(struct acpi_generic_address *new_gas_struct,
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
1.5.0.rc3.39.gec804
