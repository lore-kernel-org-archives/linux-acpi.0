From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 12/13] ACPI: thinkpad-acpi: handle HKEY event 6030
Date: Sun, 11 Jan 2009 03:01:09 -0200
Message-ID: <1231650070-21722-13-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43346 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751016AbZAKFBU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Jan 2009 00:01:20 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

HKEY event 0x6030 is a helper for Lenovo's Advanced Thermal Management
Windows driver, which is, of course, completely undocumented.

Silence any warnings about it being an unknown alarm, and report it
unmodified for userspace.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 213219d..886a430 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2702,6 +2702,12 @@ static bool hotkey_notify_thermal(const u32 hkey,
 			"a sensor reports something is extremely hot!\n");
 		/* recommended action: immediate sleep/hibernate */
 		return true;
+	case 0x6030:
+		printk(TPACPI_INFO
+			"EC reports that Thermal Table has changed\n");
+		/* recommended action: do nothing, we don't have
+		 * Lenovo ATM information */
+		return true;
 	default:
 		printk(TPACPI_ALERT
 			 "THERMAL ALERT: unknown thermal alarm received\n");
-- 
1.5.6.5

