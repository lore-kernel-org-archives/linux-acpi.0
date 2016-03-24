From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 25/30] ACPICA: Hardware: Add access_width/bit_offset support for acpi_hw_write()
Date: Thu, 24 Mar 2016 09:41:24 +0800
Message-ID: <de10649cbcc16e3bdab9bd8c4ddaf12047f63b06.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 48eea5e7993ccb7189bd63cd726e02adafee6057

This patch adds access_width/bit_offset support in acpi_hw_write().
Lv Zheng.

Link: https://github.com/acpica/acpica/commit/48eea5e7
Link: https://bugs.acpica.org/show_bug.cgi?id=1240
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwregs.c |  124 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 12fed0c..29ca75d 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -257,6 +257,12 @@ acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address * reg)
 acpi_status acpi_hw_write(u32 value, struct acpi_generic_address *reg)
 {
 	u64 address;
+	u8 access_width;
+	u32 bit_width;
+	u8 bit_offset;
+	u64 value64;
+	u32 new_value32, old_value32;
+	u8 index;
 	acpi_status status;
 
 	ACPI_FUNCTION_NAME(hw_write);
@@ -268,23 +274,123 @@ acpi_status acpi_hw_write(u32 value, struct acpi_generic_address *reg)
 		return (status);
 	}
 
+	/* Convert access_width into number of bits based */
+
+	access_width = reg->access_width ? reg->access_width : 1;
+	access_width = 1 << (access_width + 2);
+	bit_width = reg->bit_offset + reg->bit_width;
+	bit_offset = reg->bit_offset;
+
 	/*
 	 * Two address spaces supported: Memory or IO. PCI_Config is
 	 * not supported here because the GAS structure is insufficient
 	 */
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
-		status = acpi_os_write_memory((acpi_physical_address)
-					      address, (u64)value,
-					      reg->bit_width);
-	} else {		/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
-
-		status = acpi_hw_write_port((acpi_io_address)
-					    address, value, reg->bit_width);
+	index = 0;
+	while (bit_width) {
+		new_value32 = ACPI_GET_BITS(&value, index * access_width,
+					    (1 << access_width) - 1);
+
+		if (bit_offset > access_width) {
+			bit_offset -= access_width;
+		} else {
+			if (bit_offset) {
+				new_value32 &= ACPI_MASK_BITS_BELOW(bit_offset);
+			}
+
+			if (bit_width < access_width) {
+				new_value32 &= ACPI_MASK_BITS_ABOVE(bit_width);
+			}
+
+			if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+				if (bit_offset || bit_width < access_width) {
+					/*
+					 * Read old values in order not to modify the bits that
+					 * are beyond the register bit_width/bit_offset setting.
+					 */
+					status =
+					    acpi_os_read_memory((acpi_physical_address)
+								address +
+								index *
+								ACPI_DIV_8
+								(access_width),
+								&value64,
+								access_width);
+					old_value32 = (u32)value64;
+
+					if (bit_offset) {
+						old_value32 &=
+						    ACPI_MASK_BITS_ABOVE
+						    (bit_offset + 1);
+						bit_offset = 0;
+					}
+
+					if (bit_width < access_width) {
+						old_value32 &=
+						    ACPI_MASK_BITS_BELOW
+						    (bit_width - 1);
+					}
+
+					new_value32 |= old_value32;
+				}
+
+				value64 = (u64)new_value32;
+				status =
+				    acpi_os_write_memory((acpi_physical_address)
+							 address +
+							 index *
+							 ACPI_DIV_8
+							 (access_width),
+							 value64, access_width);
+			} else {	/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
+
+				if (bit_offset || bit_width < access_width) {
+					/*
+					 * Read old values in order not to modify the bits that
+					 * are beyond the register bit_width/bit_offset setting.
+					 */
+					status =
+					    acpi_hw_read_port((acpi_io_address)
+							      address +
+							      index *
+							      ACPI_DIV_8
+							      (access_width),
+							      &old_value32,
+							      access_width);
+
+					if (bit_offset) {
+						old_value32 &=
+						    ACPI_MASK_BITS_ABOVE
+						    (bit_offset + 1);
+						bit_offset = 0;
+					}
+
+					if (bit_width < access_width) {
+						old_value32 &=
+						    ACPI_MASK_BITS_BELOW
+						    (bit_width - 1);
+					}
+
+					new_value32 |= old_value32;
+				}
+
+				status = acpi_hw_write_port((acpi_io_address)
+							    address +
+							    index *
+							    ACPI_DIV_8
+							    (access_width),
+							    new_value32,
+							    access_width);
+			}
+		}
+
+		bit_width -=
+		    bit_width > access_width ? access_width : bit_width;
+		index++;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_IO,
 			  "Wrote: %8.8X width %2d   to %8.8X%8.8X (%s)\n",
-			  value, reg->bit_width, ACPI_FORMAT_UINT64(address),
+			  value, access_width, ACPI_FORMAT_UINT64(address),
 			  acpi_ut_get_region_name(reg->space_id)));
 
 	return (status);
-- 
1.7.10
