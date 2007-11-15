From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 14/15] ACPI: thinkpad-acpi: cleanup hotkey_notify and HKEY log messages
Date: Thu, 15 Nov 2007 01:37:01 -0200
Message-ID: <1195097822-24738-15-git-send-email-hmh@hmh.eng.br>
References: <1195097822-24738-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59543 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755197AbXKODhT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 22:37:19 -0500
In-Reply-To: <1195097822-24738-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Use a generic message on hotkey_notify to log unknown and unhandled events,
and cleanup hotkey_notify a little.

Also, document event 0x5010 (brightness changed notification) and do not
log it as an unknown event (even if we do not use it for anything right
now).

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/thinkpad-acpi.txt |    4 ++++
 drivers/misc/thinkpad_acpi.c    |   35 ++++++++++++++++++++---------------
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index c03ed6d..a0d9433 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -469,6 +469,10 @@ Non hot-key ACPI HKEY event map:
 The above events are not propagated by the driver, except for legacy
 compatibility purposes when hotkey_report_mode is set to 1.
 
+0x5010		Brightness level changed (newer Lenovo BIOSes)
+
+The above events are propagated by the driver.
+
 Compatibility notes:
 
 ibm-acpi and thinkpad-acpi 0.15 (mainline kernels before 2.6.23) never
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index e799a74..c312470 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1917,6 +1917,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 	unsigned int scancode;
 	int send_acpi_ev;
 	int ignore_acpi_ev;
+	int unk_ev;
 
 	if (event != 0x80) {
 		printk(TPACPI_ERR
@@ -1940,8 +1941,9 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			return;
 		}
 
-		send_acpi_ev = 0;
+		send_acpi_ev = 1;
 		ignore_acpi_ev = 0;
+		unk_ev = 0;
 
 		switch (hkey >> 12) {
 		case 1:
@@ -1951,33 +1953,34 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				scancode--;
 				if (!(hotkey_source_mask & (1 << scancode))) {
 					tpacpi_input_send_key(scancode);
+					send_acpi_ev = 0;
 				} else {
 					ignore_acpi_ev = 1;
 				}
 			} else {
-				printk(TPACPI_ERR
-				       "hotkey 0x%04x out of range "
-				       "for keyboard map\n", hkey);
-				send_acpi_ev = 1;
+				unk_ev = 1;
 			}
 			break;
 		case 5:
-			/* 0x5000-0x5FFF: LID */
-			/* we don't handle it through this path, just
-			 * eat up known LID events */
-			if (hkey != 0x5001 && hkey != 0x5002) {
-				printk(TPACPI_ERR
-				       "unknown LID-related HKEY event: "
-				       "0x%04x\n", hkey);
-				send_acpi_ev = 1;
-			} else {
+			/* 0x5000-0x5FFF: On screen display helpers */
+			switch (hkey) {
+			case 0x5010:
+				/* Lenovo Vista BIOS: brightness changed */
+				break;
+			case 0x5001:
+			case 0x5002:
+				/* LID switch events.  Do not propagate */
 				ignore_acpi_ev = 1;
+				break;
+			default:
+				unk_ev = 1;
 			}
 			break;
 		case 7:
 			/* 0x7000-0x7FFF: misc */
 			if (tp_features.hotkey_wlsw && hkey == 0x7000) {
 				tpacpi_input_send_radiosw();
+				send_acpi_ev = 0;
 				break;
 			}
 			/* fallthrough to default */
@@ -1988,9 +1991,11 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			/* case 3: ultra-bay related. maybe bay in dock? */
 			/*	0x3003 - T43 after wake up by bay lever
 			 *	         eject (0x2305) */
+			unk_ev = 1;
+		}
+		if (unk_ev) {
 			printk(TPACPI_NOTICE
 			       "unhandled HKEY event 0x%04x\n", hkey);
-			send_acpi_ev = 1;
 		}
 
 		/* Legacy events */
-- 
1.5.3.4

