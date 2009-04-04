From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 10/12] thinkpad-acpi: enhanced debugging messages for the hotkey subdriver
Date: Sat,  4 Apr 2009 01:25:51 -0300
Message-ID: <1238819153-16004-11-git-send-email-hmh@hmh.eng.br>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34008 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751456AbZDDE0D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 00:26:03 -0400
In-Reply-To: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Enhance debugging messages for the hotkey subdriver.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    1 +
 drivers/platform/x86/thinkpad_acpi.c    |   39 +++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 7daca05..abbbe78 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1496,6 +1496,7 @@ to enable more than one output class, just add their values.
 	0x0002			Removal
 	0x0004			RF Transmitter control (RFKILL)
 				(bluetooth, WWAN, UWB...)
+	0x0008			HKEY event interface, hotkeys
 
 There is also a kernel build option to enable more debugging
 information, which may be necessary to debug driver problems.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 92fff8d..c8bd563 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -190,6 +190,7 @@ enum {
 #define TPACPI_DBG_INIT		0x0001
 #define TPACPI_DBG_EXIT		0x0002
 #define TPACPI_DBG_RFKILL	0x0004
+#define TPACPI_DBG_HKEY		0x0008
 
 #define onoff(status, bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status, bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
@@ -1961,6 +1962,8 @@ static ssize_t hotkey_mask_store(struct device *dev,
 
 	mutex_unlock(&hotkey_mutex);
 
+	tpacpi_disclose_usertask("hotkey_mask", "set to 0x%08lx\n", t);
+
 	return (res) ? res : count;
 }
 
@@ -2047,6 +2050,8 @@ static ssize_t hotkey_source_mask_store(struct device *dev,
 
 	mutex_unlock(&hotkey_mutex);
 
+	tpacpi_disclose_usertask("hotkey_source_mask", "set to 0x%08lx\n", t);
+
 	return count;
 }
 
@@ -2079,6 +2084,8 @@ static ssize_t hotkey_poll_freq_store(struct device *dev,
 	hotkey_poll_setup(1);
 	mutex_unlock(&hotkey_mutex);
 
+	tpacpi_disclose_usertask("hotkey_poll_freq", "set to %lu\n", t);
+
 	return count;
 }
 
@@ -2248,7 +2255,7 @@ static void hotkey_exit(void)
 	kfree(hotkey_keycode_map);
 
 	if (tp_features.hotkey) {
-		dbg_printk(TPACPI_DBG_EXIT,
+		dbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_HKEY,
 			   "restoring original hot key mask\n");
 		/* no short-circuit boolean operator below! */
 		if ((hotkey_mask_set(hotkey_orig_mask) |
@@ -2378,7 +2385,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	int status;
 	int hkeyv;
 
-	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
+			"initializing hotkey subdriver\n");
 
 	BUG_ON(!tpacpi_inputdev);
 	BUG_ON(tpacpi_inputdev->open != NULL ||
@@ -2395,7 +2403,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	/* hotkey not supported on 570 */
 	tp_features.hotkey = hkey_handle != NULL;
 
-	vdbg_printk(TPACPI_DBG_INIT, "hotkeys are %s\n",
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
+		"hotkeys are %s\n",
 		str_supported(tp_features.hotkey));
 
 	if (!tp_features.hotkey)
@@ -2427,10 +2436,14 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			 * T4x, X31, and later
 			 */
 			tp_features.hotkey_mask = 1;
+			vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
+				"firmware HKEY interface version: 0x%x\n",
+				hkeyv);
 		}
 	}
 
-	vdbg_printk(TPACPI_DBG_INIT, "hotkey masks are %s\n",
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
+		"hotkey masks are %s\n",
 		str_supported(tp_features.hotkey_mask));
 
 	if (tp_features.hotkey_mask) {
@@ -2469,7 +2482,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		hotkey_source_mask = TPACPI_HKEY_NVRAM_GOOD_MASK;
 	}
 
-	vdbg_printk(TPACPI_DBG_INIT,
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
 		    "hotkey source mask 0x%08x, polling freq %d\n",
 		    hotkey_source_mask, hotkey_poll_freq);
 #endif
@@ -2523,12 +2536,12 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	}
 
 	if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO) {
-		dbg_printk(TPACPI_DBG_INIT,
+		dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
 			   "using Lenovo default hot key map\n");
 		memcpy(hotkey_keycode_map, &lenovo_keycode_map,
 			TPACPI_HOTKEY_MAP_SIZE);
 	} else {
-		dbg_printk(TPACPI_DBG_INIT,
+		dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
 			   "using IBM default hot key map\n");
 		memcpy(hotkey_keycode_map, &ibm_keycode_map,
 			TPACPI_HOTKEY_MAP_SIZE);
@@ -2585,7 +2598,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			| (1 << TP_ACPI_HOTKEYSCAN_FNEND);
 	}
 
-	dbg_printk(TPACPI_DBG_INIT, "enabling hot key handling\n");
+	dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
+			"enabling firmware HKEY event interface...\n");
 	res = hotkey_status_set(true);
 	if (res) {
 		hotkey_exit();
@@ -2599,8 +2613,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		return res;
 	}
 
-	dbg_printk(TPACPI_DBG_INIT,
-			"legacy hot key reporting over procfs %s\n",
+	dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
+			"legacy ibm/hotkey event reporting over procfs %s\n",
 			(hotkey_report_mode < 2) ?
 				"enabled" : "disabled");
 
@@ -2971,6 +2985,11 @@ static int hotkey_write(char *buf)
 			goto errexit;
 		}
 	}
+
+	if (!res)
+		tpacpi_disclose_usertask("procfs hotkey",
+			"set mask to 0x%08x\n", mask);
+
 	if (!res && mask != hotkey_mask)
 		res = hotkey_mask_set(mask);
 
-- 
1.6.2.1

