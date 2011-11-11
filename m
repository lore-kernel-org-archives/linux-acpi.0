From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] ACPICA: support Generic Address Structure bit_offset in
	acpi_read/write
Date: Fri, 11 Nov 2011 16:05:13 -0700
Message-ID: <20111111230513.20897.36014.stgit@bhelgaas.mtv.corp.google.com>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f74.google.com ([209.85.213.74]:43865 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab1KKXKv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Nov 2011 18:10:51 -0500
Received: by ywb5 with SMTP id 5so394871ywb.1
        for <linux-acpi@vger.kernel.org>; Fri, 11 Nov 2011 15:10:50 -0800 (PST)
In-Reply-To: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, bondd@us.ibm.com, Huang Ying <ying.huang@intel.com>, Myron Stowe <myron.stowe@redhat.com>, Thomas Renninger <trenn@suse.de>

acpi_read(), acpi_write(), acpi_hw_read(), and acpi_hw_write() currently
ignore the GAS bit_offset field (but they do warn if it is non-zero).

APEI tables are starting to use non-zero bit_offsets.  APEI uses
special-purpose apei_exec_read_register() and apei_exec_write_register()
interfaces that apply the bit_offset.

This patch adds bit_offset support to the generic interfaces, which is
one small step toward using them instead of the special-purpose APEI ones.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/acpica/hwregs.c  |   32 ++++++++++++++++++++------------
 drivers/acpi/acpica/hwxface.c |    8 +++++---
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index cc70f3f..2b50800 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -82,6 +82,7 @@ acpi_status
 acpi_hw_validate_register(struct acpi_generic_address *reg,
 			  u8 max_bit_width, u64 *address)
 {
+	static u8 width[] = {64, 8, 16, 32, 64};
 
 	/* Must have a valid pointer to a GAS structure */
 
@@ -119,12 +120,14 @@ acpi_hw_validate_register(struct acpi_generic_address *reg,
 		return (AE_SUPPORT);
 	}
 
-	/* Validate the bit_offset. Just a warning for now. */
+	/* Validate the bit_offset */
 
-	if (reg->bit_offset != 0) {
-		ACPI_WARNING((AE_INFO,
-			      "Unsupported register bit offset: 0x%X",
-			      reg->bit_offset));
+	if (reg->bit_offset > width[reg->access_width] - 1) {
+		ACPI_ERROR((AE_INFO,
+			   "Unsupported register bit offset: 0x%X access size: 0x%X (%d bits)",
+			   reg->bit_offset, reg->access_width,
+			   width[reg->access_width]));
+		return (AE_BAD_ADDRESS);
 	}
 
 	return (AE_OK);
@@ -146,14 +149,15 @@ acpi_hw_validate_register(struct acpi_generic_address *reg,
  * LIMITATIONS: <These limitations also apply to acpi_hw_write>
  *      bit_width must be exactly 8, 16, or 32.
  *      space_iD must be system_memory or system_iO.
- *      bit_offset and access_width are currently ignored, as there has
- *          not been a need to implement these.
+ *      access_width is currently ignored, as there has
+ *          not been a need to implement it.
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *reg)
+acpi_status acpi_hw_read(u32 *return_value, struct acpi_generic_address *reg)
 {
 	u64 address;
+	u32 value;
 	acpi_status status;
 
 	ACPI_FUNCTION_NAME(hw_read);
@@ -167,7 +171,7 @@ acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *reg)
 
 	/* Initialize entire 32-bit return value to zero */
 
-	*value = 0;
+	*return_value = 0;
 
 	/*
 	 * Two address spaces supported: Memory or IO. PCI_Config is
@@ -175,16 +179,18 @@ acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *reg)
 	 */
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 		status = acpi_os_read_memory((acpi_physical_address)
-					     address, value, reg->bit_width);
+					     address, &value, reg->bit_width);
 	} else {		/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
 
 		status = acpi_hw_read_port((acpi_io_address)
-					   address, value, reg->bit_width);
+					   address, &value, reg->bit_width);
 	}
 
+	*return_value = value >> reg->bit_offset;
 	ACPI_DEBUG_PRINT((ACPI_DB_IO,
 			  "Read:  %8.8X width %2d from %8.8X%8.8X (%s)\n",
-			  *value, reg->bit_width, ACPI_FORMAT_UINT64(address),
+			  *return_value, reg->bit_width,
+			  ACPI_FORMAT_UINT64(address),
 			  acpi_ut_get_region_name(reg->space_id)));
 
 	return (status);
@@ -219,6 +225,8 @@ acpi_status acpi_hw_write(u32 value, struct acpi_generic_address *reg)
 		return (status);
 	}
 
+	value = value << reg->bit_offset;
+
 	/*
 	 * Two address spaces supported: Memory or IO. PCI_Config is
 	 * not supported here because the GAS structure is insufficient
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 12b5c57..a0526fe 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -114,8 +114,8 @@ ACPI_EXPORT_SYMBOL(acpi_reset)
  * LIMITATIONS: <These limitations also apply to acpi_write>
  *      bit_width must be exactly 8, 16, 32, or 64.
  *      space_iD must be system_memory or system_iO.
- *      bit_offset and access_width are currently ignored, as there has
- *          not been a need to implement these.
+ *      access_width is currently ignored, as there has
+ *          not been a need to implement it.
  *
  ******************************************************************************/
 acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
@@ -195,7 +195,7 @@ acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 		}
 	}
 
-	*return_value = complete_value;
+	*return_value = complete_value >> reg->bit_offset;
 	ACPI_DEBUG_PRINT((ACPI_DB_IO,
 			  "Read:  %8.8X%8.8X width %2d from %8.8X%8.8X (%s)\n",
 			  ACPI_FORMAT_UINT64(*return_value), reg->bit_width,
@@ -239,6 +239,8 @@ acpi_status acpi_write(u64 value, struct acpi_generic_address *reg)
 		width = 32;	/* Break into two 32-bit transfers */
 	}
 
+	value = value << reg->bit_offset;
+
 	/*
 	 * Two address spaces supported: Memory or IO. PCI_Config is
 	 * not supported here because the GAS structure is insufficient

