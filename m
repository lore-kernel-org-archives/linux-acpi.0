From: Len Brown <lenb@kernel.org>
Subject: [PATCH 43/98] ACPICA: Change handling of PM1 Status register ignored
 bit
Date: Sat, 28 Mar 2009 00:31:18 -0400
Message-ID: <8636f8d257b3edf5a1529df93119cdc630ed85c7.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64533 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbZC1Ecz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:55 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700MWF8MMTPCX@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:47 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Ignored bits must be preserved according to the ACPI spec.
Usually this means a read/modify/write when writing to the
register.  However, for status registers, writing a one means
clear the event.  Writing a zero means preserve the event (do not
clear.) This behavior is clarified in the ACPI 4.0 spec, and the
ACPICA code now simply always writes a zero to the ignored bit.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwregs.c |   27 +++++++++++----------------
 1 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index edc627c..fd7abe2 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -273,22 +273,17 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 
 	switch (register_id) {
 	case ACPI_REGISTER_PM1_STATUS:	/* PM1 A/B: 16-bit access each */
-
-		/* Perform a read first to preserve certain bits (per ACPI spec) */
-
-		status = acpi_hw_read_multiple(&read_value,
-					       &acpi_gbl_xpm1a_status,
-					       &acpi_gbl_xpm1b_status);
-		if (ACPI_FAILURE(status)) {
-			goto exit;
-		}
-
-		/* Insert the bits to be preserved */
-
-		ACPI_INSERT_BITS(value, ACPI_PM1_STATUS_PRESERVED_BITS,
-				 read_value);
-
-		/* Now we can write the data */
+		/*
+		 * Handle the "ignored" bit in PM1 Status. According to the ACPI
+		 * specification, ignored bits are to be preserved when writing.
+		 * Normally, this would mean a read/modify/write sequence. However,
+		 * preserving a bit in the status register is different. Writing a
+		 * one clears the status, and writing a zero preserves the status.
+		 * Therefore, we must always write zero to the ignored bit.
+		 *
+		 * This behavior is clarified in the ACPI 4.0 specification.
+		 */
+		value &= ~ACPI_PM1_STATUS_PRESERVED_BITS;
 
 		status = acpi_hw_write_multiple(value,
 						&acpi_gbl_xpm1a_status,
-- 
1.6.0.6

