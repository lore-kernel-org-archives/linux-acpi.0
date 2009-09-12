From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 7/8] thinkpad-acpi: don't poll by default any of the reserved hotkeys
Date: Sat, 12 Sep 2009 15:22:17 -0300
Message-ID: <1252779738-7459-8-git-send-email-hmh@hmh.eng.br>
References: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:32899 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754558AbZILSWX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Sep 2009 14:22:23 -0400
In-Reply-To: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Init hotkey_source_mask late, so that we can make use of
hotkey_reserved_mask to avoid polling any of the reserved
hotkeys by default.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index dd779e5..9c3bb0c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3062,19 +3062,6 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			goto err_exit;
 	}
 
-#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
-	if (tp_features.hotkey_mask) {
-		hotkey_source_mask = TPACPI_HKEY_NVRAM_GOOD_MASK
-					& ~hotkey_all_mask;
-	} else {
-		hotkey_source_mask = TPACPI_HKEY_NVRAM_GOOD_MASK;
-	}
-
-	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
-		    "hotkey source mask 0x%08x, polling freq %u\n",
-		    hotkey_source_mask, hotkey_poll_freq);
-#endif
-
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
 	if (dbg_wlswemul) {
 		tp_features.hotkey_wlsw = 1;
@@ -3186,6 +3173,21 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			| (1 << TP_ACPI_HOTKEYSCAN_FNEND);
 	}
 
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+	if (tp_features.hotkey_mask) {
+		hotkey_source_mask = TPACPI_HKEY_NVRAM_GOOD_MASK
+					& ~hotkey_all_mask
+					& ~hotkey_reserved_mask;
+	} else {
+		hotkey_source_mask = TPACPI_HKEY_NVRAM_GOOD_MASK
+					& ~hotkey_reserved_mask;
+	}
+
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
+		    "hotkey source mask 0x%08x, polling freq %u\n",
+		    hotkey_source_mask, hotkey_poll_freq);
+#endif
+
 	dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
 			"enabling firmware HKEY event interface...\n");
 	res = hotkey_status_set(true);
-- 
1.6.3.3

