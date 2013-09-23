From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 02/14] ACPICA: acpi_read: On error, do not modify the return value target location.
Date: Mon, 23 Sep 2013 09:51:22 +0800
Message-ID: <5110fa906b46769680580778c137399aded92a40.1379900697.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com> <cover.1379900697.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53191 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434Ab3IWBv3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Sep 2013 21:51:29 -0400
In-Reply-To: <cover.1379900697.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

If an error happens in the middle of a split 32/32 64-bit I/O
operation, do not modify the target of the return value pointer.
Makes the code consistent with the rest of ACPICA. Bjorn Helgaas.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwxface.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 5ee7a81..f81fb06 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -119,7 +119,8 @@ ACPI_EXPORT_SYMBOL(acpi_reset)
  ******************************************************************************/
 acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 {
-	u32 value;
+	u32 value_lo;
+	u32 value_hi;
 	u32 width;
 	u64 address;
 	acpi_status status;
@@ -137,13 +138,8 @@ acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 		return (status);
 	}
 
-	/* Initialize entire 64-bit return value to zero */
-
-	*return_value = 0;
-	value = 0;
-
 	/*
-	 * Two address spaces supported: Memory or IO. PCI_Config is
+	 * Two address spaces supported: Memory or I/O. PCI_Config is
 	 * not supported here because the GAS structure is insufficient
 	 */
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
@@ -155,29 +151,35 @@ acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 		}
 	} else {		/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
 
+		value_lo = 0;
+		value_hi = 0;
+
 		width = reg->bit_width;
 		if (width == 64) {
 			width = 32;	/* Break into two 32-bit transfers */
 		}
 
 		status = acpi_hw_read_port((acpi_io_address)
-					   address, &value, width);
+					   address, &value_lo, width);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
-		*return_value = value;
 
 		if (reg->bit_width == 64) {
 
 			/* Read the top 32 bits */
 
 			status = acpi_hw_read_port((acpi_io_address)
-						   (address + 4), &value, 32);
+						   (address + 4), &value_hi,
+						   32);
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
-			*return_value |= ((u64)value << 32);
 		}
+
+		/* Set the return value only if status is AE_OK */
+
+		*return_value = (value_lo | ((u64)value_hi << 32));
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_IO,
@@ -186,7 +188,7 @@ acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 			  ACPI_FORMAT_UINT64(address),
 			  acpi_ut_get_region_name(reg->space_id)));
 
-	return (status);
+	return (AE_OK);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_read)
-- 
1.7.10

