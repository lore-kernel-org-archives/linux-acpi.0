From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/18] ACPICA: Hardware: Sort access bit width algorithm
Date: Wed, 28 Dec 2016 15:28:36 +0800
Message-ID: <ff53ee54e599d65b32c9e566b8f0682180402e51.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47429 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750912AbcL1H3P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Dec 2016 02:29:15 -0500
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 365b321a31cb701957c055cae2d2161577147252

GAS can be in register or register region format, so we need to improve our
"register" format detection code in order not to regress.

Such detection may be still experimental, and is generated according to the
current known facts. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/365b321a
Link: https://bugzilla.kernel.org/show_bug.cgi?id=151501
Reported-and-tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwregs.c | 79 ++++++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 2bc3425..50b9070 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -52,7 +52,8 @@ ACPI_MODULE_NAME("hwregs")
 #if (!ACPI_REDUCED_HARDWARE)
 /* Local Prototypes */
 static u8
-acpi_hw_get_access_bit_width(struct acpi_generic_address *reg,
+acpi_hw_get_access_bit_width(u64 address,
+			     struct acpi_generic_address *reg,
 			     u8 max_bit_width);
 
 static acpi_status
@@ -71,7 +72,8 @@ acpi_hw_write_multiple(u32 value,
  *
  * FUNCTION:    acpi_hw_get_access_bit_width
  *
- * PARAMETERS:  reg                 - GAS register structure
+ * PARAMETERS:  address             - GAS register address
+ *              reg                 - GAS register structure
  *              max_bit_width       - Max bit_width supported (32 or 64)
  *
  * RETURN:      Status
@@ -81,27 +83,59 @@ acpi_hw_write_multiple(u32 value,
  ******************************************************************************/
 
 static u8
-acpi_hw_get_access_bit_width(struct acpi_generic_address *reg, u8 max_bit_width)
+acpi_hw_get_access_bit_width(u64 address,
+			     struct acpi_generic_address *reg, u8 max_bit_width)
 {
-	if (!reg->access_width) {
-		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-			max_bit_width = 32;
-		}
+	u8 access_bit_width;
 
-		/*
-		 * Detect old register descriptors where only the bit_width field
-		 * makes senses.
-		 */
-		if (reg->bit_width < max_bit_width &&
-		    !reg->bit_offset && reg->bit_width &&
-		    ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
-		    ACPI_IS_ALIGNED(reg->bit_width, 8)) {
-			return (reg->bit_width);
-		}
-		return (max_bit_width);
+	/*
+	 * GAS format "register", used by FADT:
+	 *  1. Detected if bit_offset is 0 and bit_width is 8/16/32/64;
+	 *  2. access_size field is ignored and bit_width field is used for
+	 *     determining the boundary of the IO accesses.
+	 * GAS format "region", used by APEI registers:
+	 *  1. Detected if bit_offset is not 0 or bit_width is not 8/16/32/64;
+	 *  2. access_size field is used for determining the boundary of the
+	 *     IO accesses;
+	 *  3. bit_offset/bit_width fields are used to describe the "region".
+	 *
+	 * Note: This algorithm assumes that the "Address" fields should always
+	 *       contain aligned values.
+	 */
+	if (!reg->bit_offset && reg->bit_width &&
+	    ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
+	    ACPI_IS_ALIGNED(reg->bit_width, 8)) {
+		access_bit_width = reg->bit_width;
+	} else if (reg->access_width) {
+		access_bit_width = (1 << (reg->access_width + 2));
 	} else {
-		return (1 << (reg->access_width + 2));
+		access_bit_width =
+		    ACPI_ROUND_UP_POWER_OF_TWO_8(reg->bit_offset +
+						 reg->bit_width);
+		if (access_bit_width <= 8) {
+			access_bit_width = 8;
+		} else {
+			while (!ACPI_IS_ALIGNED(address, access_bit_width >> 3)) {
+				access_bit_width >>= 1;
+			}
+		}
+	}
+
+	/* Maximum IO port access bit width is 32 */
+
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+		max_bit_width = 32;
+	}
+
+	/*
+	 * Return access width according to the requested maximum access bit width,
+	 * as the caller should know the format of the register and may enforce
+	 * a 32-bit accesses.
+	 */
+	if (access_bit_width < max_bit_width) {
+		return (access_bit_width);
 	}
+	return (max_bit_width);
 }
 
 /******************************************************************************
@@ -163,7 +197,8 @@ acpi_hw_validate_register(struct acpi_generic_address *reg,
 
 	/* Validate the bit_width, convert access_width into number of bits */
 
-	access_width = acpi_hw_get_access_bit_width(reg, max_bit_width);
+	access_width =
+	    acpi_hw_get_access_bit_width(*address, reg, max_bit_width);
 	bit_width =
 	    ACPI_ROUND_UP(reg->bit_offset + reg->bit_width, access_width);
 	if (max_bit_width < bit_width) {
@@ -219,7 +254,7 @@ acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *reg)
 	 * into number of bits based
 	 */
 	*value = 0;
-	access_width = acpi_hw_get_access_bit_width(reg, 32);
+	access_width = acpi_hw_get_access_bit_width(address, reg, 32);
 	bit_width = reg->bit_offset + reg->bit_width;
 	bit_offset = reg->bit_offset;
 
@@ -311,7 +346,7 @@ acpi_status acpi_hw_write(u32 value, struct acpi_generic_address *reg)
 
 	/* Convert access_width into number of bits based */
 
-	access_width = acpi_hw_get_access_bit_width(reg, 32);
+	access_width = acpi_hw_get_access_bit_width(address, reg, 32);
 	bit_width = reg->bit_offset + reg->bit_width;
 	bit_offset = reg->bit_offset;
 
-- 
2.7.4

