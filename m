From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 08/13] ACPI: thinkpad-acpi: clean up hotkey_notify()
Date: Sun, 11 Jan 2009 03:01:05 -0200
Message-ID: <1231650070-21722-9-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42945 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751046AbZAKFBS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Jan 2009 00:01:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Clean up the hotkey_notify() handler, which handles the HKEY notifications
from the ACPI firmware.  It was getting too long and deep.

No functional changes.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |  174 +++++++++++++++++++++-------------
 1 files changed, 109 insertions(+), 65 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 7670c8e..d833ee6 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2571,13 +2571,100 @@ err_exit:
 	return (res < 0)? res : 1;
 }
 
+static bool hotkey_notify_hotkey(const u32 hkey,
+				 bool *send_acpi_ev,
+				 bool *ignore_acpi_ev)
+{
+	/* 0x1000-0x1FFF: key presses */
+	unsigned int scancode = hkey & 0xfff;
+	*send_acpi_ev = true;
+	*ignore_acpi_ev = false;
+
+	if (scancode > 0 && scancode < 0x21) {
+		scancode--;
+		if (!(hotkey_source_mask & (1 << scancode))) {
+			tpacpi_input_send_key(scancode);
+			*send_acpi_ev = false;
+		} else {
+			*ignore_acpi_ev = true;
+		}
+		return true;
+	}
+	return false;
+}
+
+static bool hotkey_notify_wakeup(const u32 hkey,
+				 bool *send_acpi_ev,
+				 bool *ignore_acpi_ev)
+{
+	/* 0x2000-0x2FFF: Wakeup reason */
+	*send_acpi_ev = true;
+	*ignore_acpi_ev = false;
+
+	switch (hkey) {
+	case 0x2304: /* suspend, undock */
+	case 0x2404: /* hibernation, undock */
+		hotkey_wakeup_reason = TP_ACPI_WAKEUP_UNDOCK;
+		*ignore_acpi_ev = true;
+		break;
+
+	case 0x2305: /* suspend, bay eject */
+	case 0x2405: /* hibernation, bay eject */
+		hotkey_wakeup_reason = TP_ACPI_WAKEUP_BAYEJ;
+		*ignore_acpi_ev = true;
+		break;
+
+	default:
+		return false;
+	}
+
+	if (hotkey_wakeup_reason != TP_ACPI_WAKEUP_NONE) {
+		printk(TPACPI_INFO
+		       "woke up due to a hot-unplug "
+		       "request...\n");
+		hotkey_wakeup_reason_notify_change();
+	}
+	return true;
+}
+
+static bool hotkey_notify_usrevent(const u32 hkey,
+				 bool *send_acpi_ev,
+				 bool *ignore_acpi_ev)
+{
+	/* 0x5000-0x5FFF: human interface helpers */
+	*send_acpi_ev = true;
+	*ignore_acpi_ev = false;
+
+	switch (hkey) {
+	case 0x5010: /* Lenovo new BIOS: brightness changed */
+	case 0x500b: /* X61t: tablet pen inserted into bay */
+	case 0x500c: /* X61t: tablet pen removed from bay */
+		return true;
+
+	case 0x5009: /* X41t-X61t: swivel up (tablet mode) */
+	case 0x500a: /* X41t-X61t: swivel down (normal mode) */
+		tpacpi_input_send_tabletsw();
+		hotkey_tablet_mode_notify_change();
+		*send_acpi_ev = false;
+		return true;
+
+	case 0x5001:
+	case 0x5002:
+		/* LID switch events.  Do not propagate */
+		*ignore_acpi_ev = true;
+		return true;
+
+	default:
+		return false;
+	}
+}
+
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	u32 hkey;
-	unsigned int scancode;
-	int send_acpi_ev;
-	int ignore_acpi_ev;
-	int unk_ev;
+	bool send_acpi_ev;
+	bool ignore_acpi_ev;
+	bool known_ev;
 
 	if (event != 0x80) {
 		printk(TPACPI_ERR
@@ -2601,105 +2688,62 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			return;
 		}
 
-		send_acpi_ev = 1;
-		ignore_acpi_ev = 0;
-		unk_ev = 0;
+		send_acpi_ev = true;
+		ignore_acpi_ev = false;
 
 		switch (hkey >> 12) {
 		case 1:
 			/* 0x1000-0x1FFF: key presses */
-			scancode = hkey & 0xfff;
-			if (scancode > 0 && scancode < 0x21) {
-				scancode--;
-				if (!(hotkey_source_mask & (1 << scancode))) {
-					tpacpi_input_send_key(scancode);
-					send_acpi_ev = 0;
-				} else {
-					ignore_acpi_ev = 1;
-				}
-			} else {
-				unk_ev = 1;
-			}
+			known_ev = hotkey_notify_hotkey(hkey, &send_acpi_ev,
+						 &ignore_acpi_ev);
 			break;
 		case 2:
-			/* Wakeup reason */
-			switch (hkey) {
-			case 0x2304: /* suspend, undock */
-			case 0x2404: /* hibernation, undock */
-				hotkey_wakeup_reason = TP_ACPI_WAKEUP_UNDOCK;
-				ignore_acpi_ev = 1;
-				break;
-			case 0x2305: /* suspend, bay eject */
-			case 0x2405: /* hibernation, bay eject */
-				hotkey_wakeup_reason = TP_ACPI_WAKEUP_BAYEJ;
-				ignore_acpi_ev = 1;
-				break;
-			default:
-				unk_ev = 1;
-			}
-			if (hotkey_wakeup_reason != TP_ACPI_WAKEUP_NONE) {
-				printk(TPACPI_INFO
-				       "woke up due to a hot-unplug "
-				       "request...\n");
-				hotkey_wakeup_reason_notify_change();
-			}
+			/* 0x2000-0x2FFF: Wakeup reason */
+			known_ev = hotkey_notify_wakeup(hkey, &send_acpi_ev,
+						 &ignore_acpi_ev);
 			break;
 		case 3:
-			/* bay-related wakeups */
+			/* 0x3000-0x3FFF: bay-related wakeups */
 			if (hkey == 0x3003) {
 				hotkey_autosleep_ack = 1;
 				printk(TPACPI_INFO
 				       "bay ejected\n");
 				hotkey_wakeup_hotunplug_complete_notify_change();
+				known_ev = true;
 			} else {
-				unk_ev = 1;
+				known_ev = false;
 			}
 			break;
 		case 4:
-			/* dock-related wakeups */
+			/* 0x4000-0x4FFF: dock-related wakeups */
 			if (hkey == 0x4003) {
 				hotkey_autosleep_ack = 1;
 				printk(TPACPI_INFO
 				       "undocked\n");
 				hotkey_wakeup_hotunplug_complete_notify_change();
+				known_ev = true;
 			} else {
-				unk_ev = 1;
+				known_ev = false;
 			}
 			break;
 		case 5:
 			/* 0x5000-0x5FFF: human interface helpers */
-			switch (hkey) {
-			case 0x5010: /* Lenovo new BIOS: brightness changed */
-			case 0x500b: /* X61t: tablet pen inserted into bay */
-			case 0x500c: /* X61t: tablet pen removed from bay */
-				break;
-			case 0x5009: /* X41t-X61t: swivel up (tablet mode) */
-			case 0x500a: /* X41t-X61t: swivel down (normal mode) */
-				tpacpi_input_send_tabletsw();
-				hotkey_tablet_mode_notify_change();
-				send_acpi_ev = 0;
-				break;
-			case 0x5001:
-			case 0x5002:
-				/* LID switch events.  Do not propagate */
-				ignore_acpi_ev = 1;
-				break;
-			default:
-				unk_ev = 1;
-			}
+			known_ev = hotkey_notify_usrevent(hkey, &send_acpi_ev,
+						 &ignore_acpi_ev);
 			break;
 		case 7:
 			/* 0x7000-0x7FFF: misc */
 			if (tp_features.hotkey_wlsw && hkey == 0x7000) {
 				tpacpi_send_radiosw_update();
 				send_acpi_ev = 0;
+				known_ev = true;
 				break;
 			}
 			/* fallthrough to default */
 		default:
-			unk_ev = 1;
+			known_ev = false;
 		}
-		if (unk_ev) {
+		if (!known_ev) {
 			printk(TPACPI_NOTICE
 			       "unhandled HKEY event 0x%04x\n", hkey);
 		}
-- 
1.5.6.5

