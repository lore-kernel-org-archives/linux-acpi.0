From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/65] ACPICA: Disable preservation of SCI enable bit (SCI_EN)
Date: Fri, 29 May 2009 21:42:11 -0400
Message-ID: <b1cd843be74ba0dcc6c42db7b11b76d63be149f6.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:50006 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757483AbZE3BnK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:10 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF007BWORI7OX2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:55 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Preserving this bit breaks some machines. Not preserving this bit
seems to work OK in all cases, even though this goes against the
ACPI spec.

http://bugzilla.kernel.org/show_bug.cgi?id=13289

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 882b4b5..ee986ed 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -789,11 +789,14 @@ struct acpi_bit_register_info {
 /* For control registers, both ignored and reserved bits must be preserved */
 
 /*
- * The ACPI spec says to ignore PM1_CTL.SCI_EN (bit 0)
- * but we need to be able to write ACPI_BITREG_SCI_ENABLE directly
- * as a BIOS workaround on some machines.
+ * For PM1 control, the SCI enable bit (bit 0, SCI_EN) is defined by the
+ * ACPI specification to be a "preserved" bit - "OSPM always preserves this
+ * bit position", section 4.7.3.2.1. However, on some machines the OS must
+ * write a one to this bit after resume for the machine to work properly.
+ * To enable this, we no longer attempt to preserve this bit. No machines
+ * are known to fail if the bit is not preserved. (May 2009)
  */
-#define ACPI_PM1_CONTROL_IGNORED_BITS           0x0200	/* Bits 9 */
+#define ACPI_PM1_CONTROL_IGNORED_BITS           0x0200	/* Bit 9 */
 #define ACPI_PM1_CONTROL_RESERVED_BITS          0xC1F8	/* Bits 14-15, 3-8 */
 #define ACPI_PM1_CONTROL_PRESERVED_BITS \
 	       (ACPI_PM1_CONTROL_IGNORED_BITS | ACPI_PM1_CONTROL_RESERVED_BITS)
-- 
1.6.0.6

