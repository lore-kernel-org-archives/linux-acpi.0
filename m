From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 10/10] thinkpad-acpi: sync input device EV_SW state directly
Date: Tue,  8 Dec 2009 23:36:30 -0200
Message-ID: <1260322590-5571-11-git-send-email-hmh@hmh.eng.br>
References: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41347 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967096AbZLIBgf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 20:36:35 -0500
In-Reply-To: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Johannes Berg <johannes@sipsolutions.net>, Dmitry Torokhov <dtor@mail.ru>

Before we register the input device, sync the input layer EV_SW state
directly by setting the bitmaps, to avoid issuing a gratuitous event
for the initial state of these switches.

I will propose a clean input layer API for this and change the driver
to use it later, but I'd rather get the driver fix in mainline ASAP.

This fixes some annoyances caused by the interaction with rfkill and
EV_SW SW_RFKILL_ALL events.

Reported-by: Kevin Locke <kevin@kevinlocke.name>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/platform/x86/thinkpad_acpi.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 53d6c33..e7ff6c7 100644
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
+		if (radiosw_state)
+			__set_bit(SW_RFKILL_ALL, tpacpi_inputdev->sw);
 	}
 	if (tp_features.hotkey_tablet) {
 		input_set_capability(tpacpi_inputdev, EV_SW, SW_TABLET_MODE);
+		if (tabletsw_state)
+			__set_bit(SW_TABLET_MODE, tpacpi_inputdev->sw);
 	}
 
 	/* Do not issue duplicate brightness change events to
@@ -3433,8 +3441,6 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	tpacpi_inputdev->close = &hotkey_inputdev_close;
 
 	hotkey_poll_setup_safe(true);
-	tpacpi_send_radiosw_update();
-	tpacpi_input_send_tabletsw();
 
 	return 0;
 
-- 
1.6.5.4

