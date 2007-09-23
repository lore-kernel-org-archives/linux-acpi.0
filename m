From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 5/9] ACPI: thinkpad-acpi: check version of hot key firmware
Date: Sun, 23 Sep 2007 11:39:03 -0300
Message-ID: <11905583482164-git-send-email-hmh@hmh.eng.br>
References: <11905583473293-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58977 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754115AbXIWOjM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Sep 2007 10:39:12 -0400
In-Reply-To: <11905583473293-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Check the HKEY firmware version (HKEY.MHKV handler), and refuse to load if
it is unknown.  Use this instead of the presence of HKEY.DHKV to detect hot
key mask capability.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 2155139..9a61140 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -999,6 +999,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 	int res, i;
 	int status;
+	int hkeyv;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
 
@@ -1024,18 +1025,35 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			return res;
 
 		/* mask not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
-		   A30, R30, R31, T20-22, X20-21, X22-24 */
-		tp_features.hotkey_mask =
-			acpi_evalf(hkey_handle, NULL, "DHKN", "qv");
+		   A30, R30, R31, T20-22, X20-21, X22-24.  Detected by checking
+		   for HKEY interface version 0x100 */
+		if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
+			if ((hkeyv >> 8) != 1) {
+				printk(IBM_ERR "unknown version of the "
+				       "HKEY interface: 0x%x\n", hkeyv);
+				printk(IBM_ERR "please report this to %s\n",
+				       IBM_MAIL);
+			} else {
+				/*
+				 * MHKV 0x100 in A31, R40, R40e,
+				 * T4x, X31, and later
+				 * */
+				tp_features.hotkey_mask = 1;
+			}
+		}
 
 		vdbg_printk(TPACPI_DBG_INIT, "hotkey masks are %s\n",
 			str_supported(tp_features.hotkey_mask));
 
 		if (tp_features.hotkey_mask) {
-			/* MHKA available in A31, R40, R40e, T4x, X31, and later */
 			if (!acpi_evalf(hkey_handle, &hotkey_all_mask,
-					"MHKA", "qd"))
+					"MHKA", "qd")) {
+				printk(IBM_ERR
+				       "missing MHKA handler, "
+				       "please report this to %s\n",
+				       IBM_MAIL);
 				hotkey_all_mask = 0x080cU; /* FN+F12, FN+F4, FN+F3 */
+			}
 		}
 
 		res = hotkey_get(&hotkey_orig_status, &hotkey_orig_mask);
-- 
1.5.3.1

