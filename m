From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/6] thinkpad-acpi: remove uneeded tp_features.hotkey tests in hotkey_exit
Date: Sun, 20 Sep 2009 14:09:23 -0300
Message-ID: <1253466567-4285-3-git-send-email-hmh@hmh.eng.br>
References: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36479 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754737AbZITRKP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Sep 2009 13:10:15 -0400
In-Reply-To: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

hotkey_exit() is only called if hotkey_init() finished sucessfully, or
by direct calls inside hotkey_init().  The tp_features.hotkey test is
always true, and just adds to the confusion, remove it.  Also, avoid
calling hotkey_mask_set() when it won't do anything useful.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index b789ee8..1b4d6f6 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2843,16 +2843,14 @@ static void hotkey_exit(void)
 
 	kfree(hotkey_keycode_map);
 
-	if (tp_features.hotkey) {
-		dbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_HKEY,
-			   "restoring original hot key mask\n");
-		/* no short-circuit boolean operator below! */
-		if ((hotkey_mask_set(hotkey_orig_mask) |
-		     hotkey_status_set(false)) != 0)
-			printk(TPACPI_ERR
-			       "failed to restore hot key mask "
-			       "to BIOS defaults\n");
-	}
+	dbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_HKEY,
+		   "restoring original hot key mask\n");
+	/* no short-circuit boolean operator below! */
+	if (((tp_features.hotkey_mask && hotkey_mask_set(hotkey_orig_mask))
+	     | hotkey_status_set(false)) != 0)
+		printk(TPACPI_ERR
+		       "failed to restore hot key mask "
+		       "to BIOS defaults\n");
 }
 
 static void __init hotkey_unmap(const unsigned int scancode)
-- 
1.6.3.3

