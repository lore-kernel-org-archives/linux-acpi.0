From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/15] ACPICA: Hardware: Add access_width/bit_offset support in acpi_hw_read()
Date: Wed,  4 May 2016 13:49:23 +0800
Message-ID: <f8624091d2840e1586db07c9b6dacdecf3c9ffcb.1462331121.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462331120.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 96ece052d4d073aae4f935f0ff0746646aea1174
ACPICA commit 3d8583a054e410f2ea4d73b48986facad9cfc0d4

This patch adds access_width/bit_offset support in acpi_hw_read().
This also enables GAS definition where bit_width is not a power of
two. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/96ece052
Link: https://github.com/acpica/acpica/commit/3d8583a0
Link: https://bugs.acpica.org/show_bug.cgi?id=1240
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwregs.c |   75 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 892e677..6eee012 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -195,17 +195,19 @@ acpi_hw_validate_register(struct acpi_generic_address *reg,
  *              64-bit values is not needed.
  *
  * LIMITATIONS: <These limitations also apply to acpi_hw_write>
- *      bit_width must be exactly 8, 16, or 32.
  *      space_ID must be system_memory or system_IO.
- *      bit_offset and access_width are currently ignored, as there has
- *          not been a need to implement these.
  *
  ******************************************************************************/
 
 acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *reg)
 {
 	u64 address;
+	u8 access_width;
+	u32 bit_width;
+	u8 bit_offset;
 	u64 value64;
+	u32 value32;
+	u8 index;
 	acpi_status status;
 
 	ACPI_FUNCTION_NAME(hw_read);
@@ -217,28 +219,75 @@ acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *reg)
 		return (status);
 	}
 
-	/* Initialize entire 32-bit return value to zero */
-
+	/*
+	 * Initialize entire 32-bit return value to zero, convert access_width
+	 * into number of bits based
+	 */
 	*value = 0;
+	access_width = acpi_hw_get_access_bit_width(reg, 32);
+	bit_width = reg->bit_offset + reg->bit_width;
+	bit_offset = reg->bit_offset;
 
 	/*
 	 * Two address spaces supported: Memory or IO. PCI_Config is
 	 * not supported here because the GAS structure is insufficient
 	 */
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
-		status = acpi_os_read_memory((acpi_physical_address)
-					     address, &value64, reg->bit_width);
+	index = 0;
+	while (bit_width) {
+		if (bit_offset >= access_width) {
+			value32 = 0;
+			bit_offset -= access_width;
+		} else {
+			if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+				status =
+				    acpi_os_read_memory((acpi_physical_address)
+							address +
+							index *
+							ACPI_DIV_8
+							(access_width),
+							&value64, access_width);
+				value32 = (u32)value64;
+			} else {	/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
+
+				status = acpi_hw_read_port((acpi_io_address)
+							   address +
+							   index *
+							   ACPI_DIV_8
+							   (access_width),
+							   &value32,
+							   access_width);
+			}
 
-		*value = (u32)value64;
-	} else {		/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
+			/*
+			 * Use offset style bit masks because:
+			 * bit_offset < access_width/bit_width < access_width, and
+			 * access_width is ensured to be less than 32-bits by
+			 * acpi_hw_validate_register().
+			 */
+			if (bit_offset) {
+				value32 &= ACPI_MASK_BITS_BELOW(bit_offset);
+				bit_offset = 0;
+			}
+			if (bit_width < access_width) {
+				value32 &= ACPI_MASK_BITS_ABOVE(bit_width);
+			}
+		}
+
+		/*
+		 * Use offset style bit writes because "Index * AccessWidth" is
+		 * ensured to be less than 32-bits by acpi_hw_validate_register().
+		 */
+		ACPI_SET_BITS(value, index * access_width,
+			      ACPI_MASK_BITS_ABOVE_32(access_width), value32);
 
-		status = acpi_hw_read_port((acpi_io_address)
-					   address, value, reg->bit_width);
+		bit_width -=
+		    bit_width > access_width ? access_width : bit_width;
+		index++;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_IO,
 			  "Read:  %8.8X width %2d from %8.8X%8.8X (%s)\n",
-			  *value, reg->bit_width, ACPI_FORMAT_UINT64(address),
+			  *value, access_width, ACPI_FORMAT_UINT64(address),
 			  acpi_ut_get_region_name(reg->space_id)));
 
 	return (status);
-- 
1.7.10
