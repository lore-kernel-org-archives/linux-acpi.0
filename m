From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] ACPI: Ignore the upper bits of SystemIO addresses
Date: Tue, 18 May 2010 14:07:15 -0400
Message-ID: <1274206035-10571-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4610 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab0ERSZ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 May 2010 14:25:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: robert.moore@intel.com, lenb@kernel.org, Matthew Garrett <mjg@redhat.com>

Various machines (https://bugzilla.redhat.com/show_bug.cgi?id=585756 for
instance) contain SystemIO spaces with addresses > 16 bits. acpica throws
an error for this, while Windows silently ignores the upper 16 bits and
carries on happily. Implement the latter behaviour for bug compatibility.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/acpica/hwvalid.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index e26c17d..ddfb4f1 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -146,15 +146,6 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 								      last_address),
 			  byte_width));
 
-	/* Maximum 16-bit address in I/O space */
-
-	if (last_address > ACPI_UINT16_MAX) {
-		ACPI_ERROR((AE_INFO,
-			    "Illegal I/O port address/length above 64K: 0x%p/%X",
-			    ACPI_CAST_PTR(void, address), byte_width));
-		return_ACPI_STATUS(AE_LIMIT);
-	}
-
 	/* Exit if requested address is not within the protected port table */
 
 	if (address > acpi_protected_ports[ACPI_PORT_INFO_ENTRIES - 1].end) {
@@ -222,6 +213,10 @@ acpi_status acpi_hw_read_port(acpi_io_address address, u32 *value, u32 width)
 	u32 one_byte;
 	u32 i;
 
+	/* Windows only uses the lower 16 bits of an address. Emulate that */
+
+	address &= 0xffff;
+
 	/* Validate the entire request and perform the I/O */
 
 	status = acpi_hw_validate_io_request(address, width);
@@ -279,6 +274,10 @@ acpi_status acpi_hw_write_port(acpi_io_address address, u32 value, u32 width)
 	acpi_status status;
 	u32 i;
 
+	/* Windows only uses the lower 16 bits of an address. Emulate that */
+
+	address &= 0xffff;
+
 	/* Validate the entire request and perform the I/O */
 
 	status = acpi_hw_validate_io_request(address, width);
-- 
1.7.0.1

