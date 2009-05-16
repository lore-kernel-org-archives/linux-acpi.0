From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/19] ACPI: resume: re-enable SCI-enable workaround
Date: Sat, 16 May 2009 02:02:10 -0400
Message-ID: <975b3c474c13d29337eaf7da8f5f5c0299e4943f.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:33333 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbZEPGCa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:30 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ002633G2J07H@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:27 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

The BIOS bug workaround mistakenly got disabled
when we followed the ACPI specification more closely
by ignoring OS updates to that bit.

(The BIOS is supposed to update SCI_EN, not the OS)

http://bugzilla.kernel.org/show_bug.cgi?id=13289

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 772ee5c..2ec394a 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -787,7 +787,12 @@ struct acpi_bit_register_info {
 
 /* For control registers, both ignored and reserved bits must be preserved */
 
-#define ACPI_PM1_CONTROL_IGNORED_BITS           0x0201	/* Bits 9, 0(SCI_EN) */
+/*
+ * The ACPI spec says to ignore PM1_CTL.SCI_EN (bit 0)
+ * but we need to be able to write ACPI_BITREG_SCI_ENABLE directly
+ * as a BIOS workaround on some machines.
+ */
+#define ACPI_PM1_CONTROL_IGNORED_BITS           0x0200	/* Bits 9 */
 #define ACPI_PM1_CONTROL_RESERVED_BITS          0xC1F8	/* Bits 14-15, 3-8 */
 #define ACPI_PM1_CONTROL_PRESERVED_BITS \
 	       (ACPI_PM1_CONTROL_IGNORED_BITS | ACPI_PM1_CONTROL_RESERVED_BITS)
-- 
1.6.0.6

