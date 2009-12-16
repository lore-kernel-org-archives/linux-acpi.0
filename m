From: Len Brown <lenb@kernel.org>
Subject: [PATCH 017/103] thinkpad-acpi: use input_set_capability
Date: Wed, 16 Dec 2009 03:35:28 -0500
Message-ID: <792979c8032b8f5adb77ea986db7082fff04c8e7.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47226 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762008AbZLPLGH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:07 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:57 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Use input_set_capability() instead of set_bit.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

