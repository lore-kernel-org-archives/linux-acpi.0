From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/23] ACPI: thinkpad-acpi: clean up hotkey_notify()
Date: Fri, 16 Jan 2009 15:24:57 -0500
Message-ID: <3827e7a3fd03718d4d204c66d9e3ab9b125ae552.1232137452.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:50288 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758730AbZAPUZV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:21 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KDK0048RZE5G213@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:20 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Clean up the hotkey_notify() handler, which handles the HKEY notifications
from the ACPI firmware.  It was getting too long and deep.

No functional changes.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.6.6

