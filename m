From: Len Brown <lenb@kernel.org>
Subject: [PATCH 034/112] ACPI: thinkpad-acpi: prepare for NVRAM polling support
Date: Thu,  7 Feb 2008 04:33:56 -0500
Message-ID: <b7c8c200bfbf523ea0a72fd8a5e39089c74da371.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755883AbYBGJf7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:59 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Make some small internal thinkpad-acpi changes to the hotkey subdriver code
that will make it easier to add NVRAM polling support.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   82 +++++++++++++++++++++--------------------
 1 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 49d4f4a..e7ac1c8 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -852,6 +852,46 @@ static int hotkey_status_set(int status)
 	return 0;
 }
 
+static void tpacpi_input_send_radiosw(void)
+{
+	int wlsw;
+
+	mutex_lock(&tpacpi_inputdev_send_mutex);
+
+	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
+		input_report_switch(tpacpi_inputdev,
+				    SW_RADIO, !!wlsw);
+		input_sync(tpacpi_inputdev);
+	}
+
+	mutex_unlock(&tpacpi_inputdev_send_mutex);
+}
+
+static void tpacpi_input_send_key(unsigned int scancode)
+{
+	unsigned int keycode;
+
+	keycode = hotkey_keycode_map[scancode];
+
+	if (keycode != KEY_RESERVED) {
+		mutex_lock(&tpacpi_inputdev_send_mutex);
+
+		input_report_key(tpacpi_inputdev, keycode, 1);
+		if (keycode == KEY_UNKNOWN)
+			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
+				    scancode);
+		input_sync(tpacpi_inputdev);
+
+		input_report_key(tpacpi_inputdev, keycode, 0);
+		if (keycode == KEY_UNKNOWN)
+			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
+				    scancode);
+		input_sync(tpacpi_inputdev);
+
+		mutex_unlock(&tpacpi_inputdev_send_mutex);
+	}
+}
+
 /* sysfs hotkey enable ------------------------------------------------- */
 static ssize_t hotkey_enable_show(struct device *dev,
 			   struct device_attribute *attr,
@@ -1290,47 +1330,10 @@ static void hotkey_exit(void)
 	}
 }
 
-static void tpacpi_input_send_key(unsigned int scancode,
-				  unsigned int keycode)
-{
-	if (keycode != KEY_RESERVED) {
-		mutex_lock(&tpacpi_inputdev_send_mutex);
-
-		input_report_key(tpacpi_inputdev, keycode, 1);
-		if (keycode == KEY_UNKNOWN)
-			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
-				    scancode);
-		input_sync(tpacpi_inputdev);
-
-		input_report_key(tpacpi_inputdev, keycode, 0);
-		if (keycode == KEY_UNKNOWN)
-			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
-				    scancode);
-		input_sync(tpacpi_inputdev);
-
-		mutex_unlock(&tpacpi_inputdev_send_mutex);
-	}
-}
-
-static void tpacpi_input_send_radiosw(void)
-{
-	int wlsw;
-
-	mutex_lock(&tpacpi_inputdev_send_mutex);
-
-	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
-		input_report_switch(tpacpi_inputdev,
-				    SW_RADIO, !!wlsw);
-		input_sync(tpacpi_inputdev);
-	}
-
-	mutex_unlock(&tpacpi_inputdev_send_mutex);
-}
-
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	u32 hkey;
-	unsigned int keycode, scancode;
+	unsigned int scancode;
 	int send_acpi_ev;
 	int ignore_acpi_ev;
 
@@ -1363,8 +1366,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			scancode = hkey & 0xfff;
 			if (scancode > 0 && scancode < 0x21) {
 				scancode--;
-				keycode = hotkey_keycode_map[scancode];
-				tpacpi_input_send_key(scancode, keycode);
+				tpacpi_input_send_key(scancode);
 			} else {
 				printk(IBM_ERR
 				       "hotkey 0x%04x out of range for keyboard map\n",
-- 
1.5.4.23.gef5b9

