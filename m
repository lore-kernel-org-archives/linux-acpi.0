From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] ACPICA: acpi_read: update return_value atomically
Date: Tue, 02 Jul 2013 18:30:05 -0600
Message-ID: <20130703003005.27281.39531.stgit@bhelgaas-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34911 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab3GCAaI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Jul 2013 20:30:08 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so14225893ied.0
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jul 2013 17:30:07 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>

Accumulate the entire 64-bit value before updating the return_value.
Previously, it was possible to update the low 32 bits, then return
failure if reading the upper 32 bits failed, leaving a half-updated
return_value.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/acpica/hwxface.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 04c2e16..2d64972 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -119,9 +119,10 @@ ACPI_EXPORT_SYMBOL(acpi_reset)
  ******************************************************************************/
 acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 {
-	u32 value;
+	u32 word;
 	u32 width;
 	u64 address;
+	u64 value;
 	acpi_status status;
 
 	ACPI_FUNCTION_NAME(acpi_read);
@@ -141,6 +142,7 @@ acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 
 	*return_value = 0;
 	value = 0;
+	word = 0;
 
 	/*
 	 * Two address spaces supported: Memory or IO. PCI_Config is
@@ -161,28 +163,29 @@ acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 		}
 
 		status = acpi_hw_read_port((acpi_io_address)
-					   address, &value, width);
+					   address, &word, width);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
-		*return_value = value;
+		value = word;
 
 		if (reg->bit_width == 64) {
 
 			/* Read the top 32 bits */
 
 			status = acpi_hw_read_port((acpi_io_address)
-						   (address + 4), &value, 32);
+						   (address + 4), &word, 32);
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
-			*return_value |= ((u64)value << 32);
+			value |= ((u64)word << 32);
 		}
 	}
 
+	*return_value = value;
 	ACPI_DEBUG_PRINT((ACPI_DB_IO,
 			  "Read:  %8.8X%8.8X width %2d from %8.8X%8.8X (%s)\n",
-			  ACPI_FORMAT_UINT64(*return_value), reg->bit_width,
+			  ACPI_FORMAT_UINT64(value), reg->bit_width,
 			  ACPI_FORMAT_UINT64(address),
 			  acpi_ut_get_region_name(reg->space_id)));
 

