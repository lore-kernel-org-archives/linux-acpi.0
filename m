From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/7] ACPI: thinkpad-acpi: consolidate wlsw notification function
Date: Mon, 21 Jul 2008 09:42:15 -0300
Message-ID: <1216644140-13284-2-git-send-email-hmh@hmh.eng.br>
References: <20080721122935.GA12972@khazad-dum.debian.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48816 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751011AbYGUMm0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jul 2008 08:42:26 -0400
In-Reply-To: <20080721122935.GA12972@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Rename tpacpi_input_send_radiosw() to tpacpi_send_radiosw_update(), and
make it a central point to issue "radio switch changed state" notifications
by consolidating also the poll() notification in the same function.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   39 +++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c800855..9179f23 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1285,21 +1285,6 @@ static int hotkey_status_set(int status)
 	return 0;
 }
 
-static void tpacpi_input_send_radiosw(void)
-{
-	int wlsw;
-
-	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
-		mutex_lock(&tpacpi_inputdev_send_mutex);
-
-		input_report_switch(tpacpi_inputdev,
-				    SW_RFKILL_ALL, !!wlsw);
-		input_sync(tpacpi_inputdev);
-
-		mutex_unlock(&tpacpi_inputdev_send_mutex);
-	}
-}
-
 static void tpacpi_input_send_tabletsw(void)
 {
 	int state;
@@ -1921,6 +1906,22 @@ static struct attribute *hotkey_mask_attributes[] __initdata = {
 	&dev_attr_hotkey_wakeup_hotunplug_complete.attr,
 };
 
+static void tpacpi_send_radiosw_update(void)
+{
+	int wlsw;
+
+	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
+		mutex_lock(&tpacpi_inputdev_send_mutex);
+
+		input_report_switch(tpacpi_inputdev,
+				    SW_RFKILL_ALL, !!wlsw);
+		input_sync(tpacpi_inputdev);
+
+		mutex_unlock(&tpacpi_inputdev_send_mutex);
+	}
+	hotkey_radio_sw_notify_change();
+}
+
 static void hotkey_exit(void)
 {
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
@@ -2288,7 +2289,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	tpacpi_inputdev->close = &hotkey_inputdev_close;
 
 	hotkey_poll_setup_safe(1);
-	tpacpi_input_send_radiosw();
+	tpacpi_send_radiosw_update();
 	tpacpi_input_send_tabletsw();
 
 	return 0;
@@ -2420,8 +2421,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		case 7:
 			/* 0x7000-0x7FFF: misc */
 			if (tp_features.hotkey_wlsw && hkey == 0x7000) {
-				tpacpi_input_send_radiosw();
-				hotkey_radio_sw_notify_change();
+				tpacpi_send_radiosw_update();
 				send_acpi_ev = 0;
 				break;
 			}
@@ -2464,8 +2464,7 @@ static void hotkey_resume(void)
 		printk(TPACPI_ERR
 		       "error while trying to read hot key mask "
 		       "from firmware\n");
-	tpacpi_input_send_radiosw();
-	hotkey_radio_sw_notify_change();
+	tpacpi_send_radiosw_update();
 	hotkey_tablet_mode_notify_change();
 	hotkey_wakeup_reason_notify_change();
 	hotkey_wakeup_hotunplug_complete_notify_change();
-- 
1.5.6.2

