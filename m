From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/21] Revert
 "ACPI: Ingore the RESET_REG_SUP bit when using ACPI reset mechanism"
Date: Thu, 06 Nov 2008 23:39:19 -0500
Message-ID: <d17cb18a07c587b8f9ff174a1bf6d03413eabe64.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36457 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbYKGEjh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:37 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y006184XV8E41@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:32 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This reverts commit 8fd145917fb62368a9b80db59562c20576238f5a.

http://bugzilla.kernel.org/show_bug.cgi?id=11942

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/reboot.c |   25 +++----------------------
 1 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index 755baf2..a6b662c 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -15,28 +15,9 @@ void acpi_reboot(void)
 
 	rr = &acpi_gbl_FADT.reset_register;
 
-	/*
-	 * Is the ACPI reset register supported?
-	 *
-	 * According to ACPI 3.0, FADT.flags.RESET_REG_SUP indicates
-	 * whether the ACPI reset mechanism is supported.
-	 *
-	 * However, some boxes have this bit clear, yet a valid
-	 * ACPI_RESET_REG & RESET_VALUE, and ACPI reboot is the only
-	 * mechanism that works for them after S3.
-	 *
-	 * This suggests that other operating systems may not be checking
-	 * the RESET_REG_SUP bit, and are using other means to decide
-	 * whether to use the ACPI reboot mechanism or not.
-	 *
-	 * So when acpi reboot is requested,
-	 * only the reset_register is checked. If the following
-	 * conditions are met, it indicates that the reset register is supported.
-	 * 	a. reset_register is not zero
-	 * 	b. the access width is eight
-	 * 	c. the bit_offset is zero
-	 */
-	if (!(rr->address) || rr->bit_width != 8 || rr->bit_offset != 0)
+	/* Is the reset register supported? */
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) ||
+	    rr->bit_width != 8 || rr->bit_offset != 0)
 		return;
 
 	reset_value = acpi_gbl_FADT.reset_value;
-- 
1.5.6.5

