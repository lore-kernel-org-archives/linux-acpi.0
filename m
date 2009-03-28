From: Len Brown <lenb@kernel.org>
Subject: [PATCH 44/98] ACPICA: Preserve all PM control reserved and ignored bits
Date: Sat, 28 Mar 2009 00:31:19 -0400
Message-ID: <20869dcfde204e1c21b642608d708d82472fee2b.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:34767 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbZC1Ecu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:50 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700IM48MNP49F@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:48 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

As per the ACPI specification, preserve (read/modify/write) all
bits that are defined as either reserved or ignored (PM control
control registers only.)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h |   10 +++++++++-
 drivers/acpi/acpica/hwregs.c  |   15 +++++++++++++++
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 18a8d96..f01e155 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -780,7 +780,15 @@ struct acpi_bit_register_info {
  * must be preserved.
  */
 #define ACPI_PM1_STATUS_PRESERVED_BITS          0x0800	/* Bit 11 */
-#define ACPI_PM1_CONTROL_PRESERVED_BITS         0x0200	/* Bit 9 (whatever) */
+
+/* For control registers, both ignored and reserved bits must be preserved */
+
+#define ACPI_PM1_CONTROL_IGNORED_BITS           0x0201	/* Bits 9, 0(SCI_EN) */
+#define ACPI_PM1_CONTROL_RESERVED_BITS          0xC1F8	/* Bits 14-15, 3-8 */
+#define ACPI_PM1_CONTROL_PRESERVED_BITS \
+	       (ACPI_PM1_CONTROL_IGNORED_BITS | ACPI_PM1_CONTROL_RESERVED_BITS)
+
+#define ACPI_PM2_CONTROL_PRESERVED_BITS         0xFFFFFFFE	/* All except bit 0 */
 
 /*
  * Register IDs
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index fd7abe2..6117362 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -328,6 +328,21 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 
 	case ACPI_REGISTER_PM2_CONTROL:	/* 8-bit access */
 
+		/*
+		 * For control registers, all reserved bits must be preserved,
+		 * as per the ACPI spec.
+		 */
+		status =
+		    acpi_read(&read_value, &acpi_gbl_FADT.xpm2_control_block);
+		if (ACPI_FAILURE(status)) {
+			goto exit;
+		}
+
+		/* Insert the bits to be preserved */
+
+		ACPI_INSERT_BITS(value, ACPI_PM2_CONTROL_PRESERVED_BITS,
+				 read_value);
+
 		status = acpi_write(value, &acpi_gbl_FADT.xpm2_control_block);
 		break;
 
-- 
1.6.0.6

