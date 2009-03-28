From: Len Brown <lenb@kernel.org>
Subject: [PATCH 47/98] ACPICA: Clear PM register write-only bits on reading
Date: Sat, 28 Mar 2009 00:31:22 -0400
Message-ID: <c3dd25f4c1ca84baa170c0a3a15a884f4f06297e.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22353 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbZC1Ecv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:51 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700LJU8MPO6UF@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:50 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Affects PM1 Control register only. When reading the register, zero
the write-only bits as per the ACPI spec.  ACPICA BZ 443. Lin Ming.

http://www.acpica.org/bugzilla/show_bug.cgi?id=443

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    4 ++++
 drivers/acpi/acpica/hwregs.c  |    7 +++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 42ef0cb..772ee5c 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -781,6 +781,10 @@ struct acpi_bit_register_info {
  */
 #define ACPI_PM1_STATUS_PRESERVED_BITS          0x0800	/* Bit 11 */
 
+/* Write-only bits must be zeroed by software */
+
+#define ACPI_PM1_CONTROL_WRITEONLY_BITS         0x2004	/* Bits 13, 2 */
+
 /* For control registers, both ignored and reserved bits must be preserved */
 
 #define ACPI_PM1_CONTROL_IGNORED_BITS           0x0201	/* Bits 9, 0(SCI_EN) */
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index f8ee0a7..7b2fb60 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -207,6 +207,13 @@ acpi_hw_register_read(u32 register_id, u32 * return_value)
 					       xpm1a_control_block,
 					       &acpi_gbl_FADT.
 					       xpm1b_control_block);
+
+		/*
+		 * Zero the write-only bits. From the ACPI specification, "Hardware
+		 * Write-Only Bits": "Upon reads to registers with write-only bits,
+		 * software masks out all write-only bits."
+		 */
+		value &= ~ACPI_PM1_CONTROL_WRITEONLY_BITS;
 		break;
 
 	case ACPI_REGISTER_PM2_CONTROL:	/* 8-bit access */
-- 
1.6.0.6

