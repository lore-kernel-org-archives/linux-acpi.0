From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/7] ACPI: thinkpad-acpi: revert keymap changes
Date: Tue, 30 Oct 2007 17:46:19 -0200
Message-ID: <1193773585-17202-2-git-send-email-hmh@hmh.eng.br>
References: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59691 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756683AbXJ3Tqe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2007 15:46:34 -0400
In-Reply-To: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jeremy Katz <katzj@redhat.com>

Revert commit fba956c46a72f9e7503fd464ffee43c632307e31, "Map volume and
brightness events on thinkpads".

That commit made some modifications to the default keymaps that cause bad
behaviour on all IBM ThinkPads if HAL doesn't know to change them into
passive (on-screen-display only) events.

The proper solution for IBM ThinkPads is to use the _NOTIFY version of the
key codes for the IBM default map (which are not available in mainline
yet), and for the Lenovo keymap, it will take some studying of the various
DSDTs and testing to know the best path (which I will do shortly).

For more data, refer to:
http://thread.gmane.org/gmane.linux.kernel/591037/focus=591045

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Jeremy Katz <katzj@redhat.com>
---
 drivers/misc/thinkpad_acpi.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index e953276..63b1e26 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -964,15 +964,15 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
 		KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
 		KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
-		KEY_BRIGHTNESSUP,	/* 0x0F: FN+HOME (brightness up) */
+		KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
 		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
-		KEY_BRIGHTNESSDOWN,	/* 0x10: FN+END (brightness down) */
+		KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
 		KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
 		KEY_UNKNOWN,	/* 0x12: FN+PGDOWN */
 		KEY_ZOOM,	/* 0x13: FN+SPACE (zoom) */
-		KEY_VOLUMEUP,	/* 0x14: VOLUME UP */
-		KEY_VOLUMEDOWN,	/* 0x15: VOLUME DOWN */
-		KEY_MUTE,	/* 0x16: MUTE */
+		KEY_RESERVED,	/* 0x14: VOLUME UP */
+		KEY_RESERVED,	/* 0x15: VOLUME DOWN */
+		KEY_RESERVED,	/* 0x16: MUTE */
 		KEY_VENDOR,	/* 0x17: Thinkpad/AccessIBM/Lenovo */
 		/* (assignments unknown, please report if found) */
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
@@ -993,9 +993,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
 		KEY_UNKNOWN,	/* 0x12: FN+PGDOWN */
 		KEY_ZOOM,	/* 0x13: FN+SPACE (zoom) */
-		KEY_VOLUMEUP,	/* 0x14: VOLUME UP */
-		KEY_VOLUMEDOWN,	/* 0x15: VOLUME DOWN */
-		KEY_MUTE,	/* 0x16: MUTE */
+		KEY_RESERVED,	/* 0x14: VOLUME UP */
+		KEY_RESERVED,	/* 0x15: VOLUME DOWN */
+		KEY_RESERVED,	/* 0x16: MUTE */
 		KEY_VENDOR,	/* 0x17: Thinkpad/AccessIBM/Lenovo */
 		/* (assignments unknown, please report if found) */
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
-- 
1.5.3.4

