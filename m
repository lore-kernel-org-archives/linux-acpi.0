From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 8/8] thinkpad-acpi: report brightness events when required
Date: Sat, 12 Sep 2009 15:22:18 -0300
Message-ID: <1252779738-7459-9-git-send-email-hmh@hmh.eng.br>
References: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56873 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754691AbZILSW1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Sep 2009 14:22:27 -0400
In-Reply-To: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Report KEY_BRIGHTNESSUP and KEY_BRIGHTNESSDOWN input events when the
ThinkPad is in "passive brightness control" mode (because either we or
ACPI video touched _BCL), and ACPI video is not processing these
events by itself.

This happens only on Lenovo ThinkPads with ACPI video support, when
operating with the ACPI video driver in acpi_backlight=vendor mode.

Issuing these events is the right thing to do, and will work around
bugzilla #13368, if userspace is properly configured and actively
handles these events.

For other ThinkPads, and when ACPI video is handling brightness
changes, thinkpad-acpi will continue NOT sending KEY_BRIGHTNESS*
events by default.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 9c3bb0c..955adf6 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2854,6 +2854,15 @@ static void hotkey_exit(void)
 	}
 }
 
+static void __init hotkey_unmap(const unsigned int scancode)
+{
+	if (hotkey_keycode_map[scancode] != KEY_RESERVED) {
+		clear_bit(hotkey_keycode_map[scancode],
+			  tpacpi_inputdev->keybit);
+		hotkey_keycode_map[scancode] = KEY_RESERVED;
+	}
+}
+
 static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
 	/* Requirements for changing the default keymaps:
@@ -2932,11 +2941,11 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
 		KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
 
-		/* These either have to go through ACPI video, or
-		 * act like in the IBM ThinkPads, so don't ever
-		 * enable them by default */
-		KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
-		KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
+		/* These should be enabled --only-- when ACPI video
+		 * is disabled (i.e. in "vendor" mode), and are handled
+		 * in a special way by the init code */
+		KEY_BRIGHTNESSUP,	/* 0x0F: FN+HOME (brightness up) */
+		KEY_BRIGHTNESSDOWN,	/* 0x10: FN+END (brightness down) */
 
 		KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
 
@@ -3162,15 +3171,14 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		       "Disabling thinkpad-acpi brightness events "
 		       "by default...\n");
 
-		/* The hotkey_reserved_mask change below is not
-		 * necessary while the keys are at KEY_RESERVED in the
-		 * default map, but better safe than sorry, leave it
-		 * here as a marker of what we have to do, especially
-		 * when we finally become able to set this at runtime
-		 * on response to X.org requests */
+		/* Disable brightness up/down on Lenovo thinkpads when
+		 * ACPI is handling them, otherwise it is plain impossible
+		 * for userspace to do something even remotely sane */
 		hotkey_reserved_mask |=
 			(1 << TP_ACPI_HOTKEYSCAN_FNHOME)
 			| (1 << TP_ACPI_HOTKEYSCAN_FNEND);
+		hotkey_unmap(TP_ACPI_HOTKEYSCAN_FNHOME);
+		hotkey_unmap(TP_ACPI_HOTKEYSCAN_FNEND);
 	}
 
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
-- 
1.6.3.3

