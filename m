From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/18] ACPICA: Hardware: Add access_width/bit_offset support in acpi_hw_write()
Date: Wed, 28 Dec 2016 15:28:23 +0800
Message-ID: <eaf3db3bcaa065d385d93b0bf77f6458f0f67092.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57642 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbcL1H3P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Dec 2016 02:29:15 -0500
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 1ecab20bbe69a176dfb6da7210fe77aa6b3ad680

This patch adds access_width/bit_offset support in acpi_hw_write().
Lv Zheng.

Link: https://github.com/acpica/acpica/commit/1ecab20b
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwregs.c | 62 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 115c223..2bc3425 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -292,6 +292,12 @@ acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *reg)
 acpi_status acpi_hw_write(u32 value, struct acpi_generic_address *reg)
 {
 	u64 address;
+	u8 access_width;
+	u32 bit_width;
+	u8 bit_offset;
+	u64 value64;
+	u32 value32;
+	u8 index;
 	acpi_status status;
 
 	ACPI_FUNCTION_NAME(hw_write);
@@ -303,23 +309,61 @@ acpi_status acpi_hw_write(u32 value, struct acpi_generic_address *reg)
 		return (status);
 	}
 
+	/* Convert access_width into number of bits based */
+
+	access_width = acpi_hw_get_access_bit_width(reg, 32);
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
+		/*
+		 * Use offset style bit reads because "Index * AccessWidth" is
+		 * ensured to be less than 32-bits by acpi_hw_validate_register().
+		 */
+		value32 = ACPI_GET_BITS(&value, index * access_width,
+					ACPI_MASK_BITS_ABOVE_32(access_width));
+
+		if (bit_offset >= access_width) {
+			bit_offset -= access_width;
+		} else {
+			if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+				value64 = (u64)value32;
+				status =
+				    acpi_os_write_memory((acpi_physical_address)
+							 address +
+							 index *
+							 ACPI_DIV_8
+							 (access_width),
+							 value64, access_width);
+			} else {	/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
+
+				status = acpi_hw_write_port((acpi_io_address)
+							    address +
+							    index *
+							    ACPI_DIV_8
+							    (access_width),
+							    value32,
+							    access_width);
+			}
+		}
+
+		/*
+		 * Index * access_width is ensured to be less than 32-bits by
+		 * acpi_hw_validate_register().
+		 */
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
2.7.4

