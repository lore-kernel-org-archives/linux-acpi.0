From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 09/10] thinkpad-acpi: use input_set_capability
Date: Tue,  8 Dec 2009 23:36:29 -0200
Message-ID: <1260322590-5571-10-git-send-email-hmh@hmh.eng.br>
References: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59393 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967105AbZLIBge (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 20:36:34 -0500
In-Reply-To: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Dmitry Torokhov <dtor@mail.ru>

Use input_set_capability() instead of set_bit.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/platform/x86/thinkpad_acpi.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index b3e256b..53d6c33 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3348,16 +3348,14 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			TPACPI_HOTKEY_MAP_SIZE);
 	}
 
-	set_bit(EV_KEY, tpacpi_inputdev->evbit);
-	set_bit(EV_MSC, tpacpi_inputdev->evbit);
-	set_bit(MSC_SCAN, tpacpi_inputdev->mscbit);
+	input_set_capability(tpacpi_inputdev, EV_MSC, MSC_SCAN);
 	tpacpi_inputdev->keycodesize = TPACPI_HOTKEY_MAP_TYPESIZE;
 	tpacpi_inputdev->keycodemax = TPACPI_HOTKEY_MAP_LEN;
 	tpacpi_inputdev->keycode = hotkey_keycode_map;
 	for (i = 0; i < TPACPI_HOTKEY_MAP_LEN; i++) {
 		if (hotkey_keycode_map[i] != KEY_RESERVED) {
-			set_bit(hotkey_keycode_map[i],
-				tpacpi_inputdev->keybit);
+			input_set_capability(tpacpi_inputdev, EV_KEY,
+						hotkey_keycode_map[i]);
 		} else {
 			if (i < sizeof(hotkey_reserved_mask)*8)
 				hotkey_reserved_mask |= 1 << i;
@@ -3365,12 +3363,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	}
 
 	if (tp_features.hotkey_wlsw) {
-		set_bit(EV_SW, tpacpi_inputdev->evbit);
-		set_bit(SW_RFKILL_ALL, tpacpi_inputdev->swbit);
+		input_set_capability(tpacpi_inputdev, EV_SW, SW_RFKILL_ALL);
 	}
 	if (tp_features.hotkey_tablet) {
-		set_bit(EV_SW, tpacpi_inputdev->evbit);
-		set_bit(SW_TABLET_MODE, tpacpi_inputdev->swbit);
+		input_set_capability(tpacpi_inputdev, EV_SW, SW_TABLET_MODE);
 	}
 
 	/* Do not issue duplicate brightness change events to
-- 
1.6.5.4

