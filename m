From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 10/13] ACPI: thinkpad-acpi: start the event hunt season
Date: Sun, 11 Jan 2009 03:01:07 -0200
Message-ID: <1231650070-21722-11-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33860 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751146AbZAKFBS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Jan 2009 00:01:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Ask users to tell us about any unhandled events they find.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c4e4b64..d7d41ae 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2801,6 +2801,9 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		if (!known_ev) {
 			printk(TPACPI_NOTICE
 			       "unhandled HKEY event 0x%04x\n", hkey);
+			printk(TPACPI_NOTICE
+			       "please report the conditions when this "
+			       "event happened to %s\n", TPACPI_MAIL);
 		}
 
 		/* Legacy events */
-- 
1.5.6.5

