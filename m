From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] ACPICA: Use hweight8() and hweight16()
Date: Sat, 17 Nov 2012 18:33:03 +0900
Message-ID: <1353144784-6717-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62111 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab2KQJde (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Nov 2012 04:33:34 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2449506pbc.19
        for <linux-acpi@vger.kernel.org>; Sat, 17 Nov 2012 01:33:34 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Replace homemade hamming weight function with hweight8() and hweight16().

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/acpica/rscalc.c | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index de12469..bdddb7d 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -49,9 +49,6 @@
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rscalc")
 
-/* Local prototypes */
-static u8 acpi_rs_count_set_bits(u16 bit_field);
-
 static acpi_rs_length
 acpi_rs_struct_option_length(struct acpi_resource_source *resource_source);
 
@@ -60,35 +57,6 @@ acpi_rs_stream_option_length(u32 resource_length, u32 minimum_total_length);
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_rs_count_set_bits
- *
- * PARAMETERS:  bit_field       - Field in which to count bits
- *
- * RETURN:      Number of bits set within the field
- *
- * DESCRIPTION: Count the number of bits set in a resource field. Used for
- *              (Short descriptor) interrupt and DMA lists.
- *
- ******************************************************************************/
-
-static u8 acpi_rs_count_set_bits(u16 bit_field)
-{
-	u8 bits_set;
-
-	ACPI_FUNCTION_ENTRY();
-
-	for (bits_set = 0; bit_field; bits_set++) {
-
-		/* Zero the least significant bit that is set */
-
-		bit_field &= (u16) (bit_field - 1);
-	}
-
-	return bits_set;
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_rs_struct_option_length
  *
  * PARAMETERS:  resource_source     - Pointer to optional descriptor field
@@ -439,7 +407,7 @@ acpi_rs_get_list_length(u8 * aml_buffer,
 			 * Get the number of bits set in the 16-bit IRQ mask
 			 */
 			ACPI_MOVE_16_TO_16(&temp16, buffer);
-			extra_struct_bytes = acpi_rs_count_set_bits(temp16);
+			extra_struct_bytes = hweight16(temp16);
 			break;
 
 		case ACPI_RESOURCE_NAME_DMA:
@@ -447,7 +415,7 @@ acpi_rs_get_list_length(u8 * aml_buffer,
 			 * DMA Resource:
 			 * Get the number of bits set in the 8-bit DMA mask
 			 */
-			extra_struct_bytes = acpi_rs_count_set_bits(*buffer);
+			extra_struct_bytes = hweight8(*buffer);
 			break;
 
 		case ACPI_RESOURCE_NAME_VENDOR_SMALL:
-- 
1.7.11.7

