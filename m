From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 08/10] ACPI: thinkpad-acpi: prepare for NVRAM polling support
Date: Sat, 13 Oct 2007 17:22:57 -0300
Message-ID: <1192306979-26886-9-git-send-email-hmh@hmh.eng.br>
References: <1192306979-26886-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59136 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753169AbXJMUXK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Oct 2007 16:23:10 -0400
In-Reply-To: <1192306979-26886-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Make some small internal thinkpad-acpi changes to the hotkey subdriver code
that will make it easier to add NVRAM polling support.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   82 +++++++++++++++++++++--------------------
 1 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 6c560c4..c30af65 100644
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
@@ -1232,47 +1272,10 @@ static void hotkey_exit(void)
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
 
@@ -1305,8 +1308,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
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
1.5.3.2

