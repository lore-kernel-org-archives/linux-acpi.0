From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/37] ACPI: thinkpad-acpi: check version of hot key firmware
Date: Wed, 10 Oct 2007 01:06:21 -0400
Message-ID: <1191992804-14965-15-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:20396 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751212AbXJJFG5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:06:57 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <1b6521dc84f372dd92a96381fbeeebb01173d050.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Check the HKEY firmware version (HKEY.MHKV handler), and refuse to load if
it is unknown.  Use this instead of the presence of HKEY.DHKV to detect hot
key mask capability.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.3.4.206.g58ba4
