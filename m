From: Len Brown <lenb@kernel.org>
Subject: [PATCH 083/103] thinkpad-acpi: sync input device EV_SW initial state
Date: Wed, 16 Dec 2009 03:36:34 -0500
Message-ID: <d89a727aff649f6768f7a34ee57f031ebf8bab4c.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61822 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761808AbZLPMGS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:06:18 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:06:01 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Johannes Berg <johannes@sipsolutions.net>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Before we register the input device, sync the input layer EV_SW state
through a call to input_report_switch(), to avoid issuing a gratuitous
event for the initial state of these switches.

This fixes some annoyances caused by the interaction with rfkill and
EV_SW SW_RFKILL_ALL events.

Reported-by: Kevin Locke <kevin@kevinlocke.name>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 53d6c33..3daf349 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3186,6 +3186,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	int res, i;
 	int status;
 	int hkeyv;
+	bool radiosw_state  = false;
+	bool tabletsw_state = false;
 
 	unsigned long quirks;
 
@@ -3291,6 +3293,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
 	if (dbg_wlswemul) {
 		tp_features.hotkey_wlsw = 1;
+		radiosw_state = !!tpacpi_wlsw_emulstate;
 		printk(TPACPI_INFO
 			"radio switch emulation enabled\n");
 	} else
@@ -3298,6 +3301,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	/* Not all thinkpads have a hardware radio switch */
 	if (acpi_evalf(hkey_handle, &status, "WLSW", "qd")) {
 		tp_features.hotkey_wlsw = 1;
+		radiosw_state = !!status;
 		printk(TPACPI_INFO
 			"radio switch found; radios are %s\n",
 			enabled(status, 0));
@@ -3309,11 +3313,11 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	/* For X41t, X60t, X61t Tablets... */
 	if (!res && acpi_evalf(hkey_handle, &status, "MHKG", "qd")) {
 		tp_features.hotkey_tablet = 1;
+		tabletsw_state = !!(status & TP_HOTKEY_TABLET_MASK);
 		printk(TPACPI_INFO
 			"possible tablet mode switch found; "
 			"ThinkPad in %s mode\n",
-			(status & TP_HOTKEY_TABLET_MASK)?
-				"tablet" : "laptop");
+			(tabletsw_state) ? "tablet" : "laptop");
 		res = add_to_attr_set(hotkey_dev_attributes,
 				&dev_attr_hotkey_tablet_mode.attr);
 	}
@@ -3364,9 +3368,13 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 	if (tp_features.hotkey_wlsw) {
 		input_set_capability(tpacpi_inputdev, EV_SW, SW_RFKILL_ALL);
+		input_report_switch(tpacpi_inputdev,
+				    SW_RFKILL_ALL, radiosw_state);
 	}
 	if (tp_features.hotkey_tablet) {
 		input_set_capability(tpacpi_inputdev, EV_SW, SW_TABLET_MODE);
+		input_report_switch(tpacpi_inputdev,
+				    SW_TABLET_MODE, tabletsw_state);
 	}
 
 	/* Do not issue duplicate brightness change events to
@@ -3433,8 +3441,6 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	tpacpi_inputdev->close = &hotkey_inputdev_close;
 
 	hotkey_poll_setup_safe(true);
-	tpacpi_send_radiosw_update();
-	tpacpi_input_send_tabletsw();
 
 	return 0;
 
-- 
1.6.0.6

