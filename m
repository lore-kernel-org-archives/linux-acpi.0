From: Len Brown <lenb@kernel.org>
Subject: [PATCH 063/122] ACPI: Ingore the RESET_REG_SUP bit when using ACPI
 reset mechanism
Date: Thu, 23 Oct 2008 02:38:37 -0400
Message-ID: <8fd145917fb62368a9b80db59562c20576238f5a.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51267 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755447AbYJWGk2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:28 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600GVDIIT6L15@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:06 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

According to ACPI 3.0, FADT.flags.RESET_REG_SUP indicates
whether the ACPI reboot mechanism is supported.

However, some boxes have this bit clear, have a valid
ACPI_RESET_REG & RESET_VALUE, and ACPI reboot is the only
mechanism that works for them after S3.

This suggests that other operating systems may not be checking
the RESET_REG_SUP bit, and are using other means to decide
whether to use the ACPI reboot mechanism or not.

Here we stop checking RESET_REG_SUP.
Instead, When acpi reboot is requested,
only the reset_register is checked. If the following
conditions are met, it indicates that the reset register is supported.
	a. reset_register is not zero
	b. the access width is eight
	c. the bit_offset is zero

http://bugzilla.kernel.org/show_bug.cgi?id=7299
http://bugzilla.kernel.org/show_bug.cgi?id=1148

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/reboot.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index a6b662c..755baf2 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -15,9 +15,28 @@ void acpi_reboot(void)
 
 	rr = &acpi_gbl_FADT.reset_register;
 
-	/* Is the reset register supported? */
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) ||
-	    rr->bit_width != 8 || rr->bit_offset != 0)
+	/*
+	 * Is the ACPI reset register supported?
+	 *
+	 * According to ACPI 3.0, FADT.flags.RESET_REG_SUP indicates
+	 * whether the ACPI reset mechanism is supported.
+	 *
+	 * However, some boxes have this bit clear, yet a valid
+	 * ACPI_RESET_REG & RESET_VALUE, and ACPI reboot is the only
+	 * mechanism that works for them after S3.
+	 *
+	 * This suggests that other operating systems may not be checking
+	 * the RESET_REG_SUP bit, and are using other means to decide
+	 * whether to use the ACPI reboot mechanism or not.
+	 *
+	 * So when acpi reboot is requested,
+	 * only the reset_register is checked. If the following
+	 * conditions are met, it indicates that the reset register is supported.
+	 * 	a. reset_register is not zero
+	 * 	b. the access width is eight
+	 * 	c. the bit_offset is zero
+	 */
+	if (!(rr->address) || rr->bit_width != 8 || rr->bit_offset != 0)
 		return;
 
 	reset_value = acpi_gbl_FADT.reset_value;
-- 
1.5.5.1

