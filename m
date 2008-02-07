From: Len Brown <lenb@kernel.org>
Subject: [PATCH 045/112] ACPI: thinkpad-acpi: cleanup hotkey_notify and HKEY log messages
Date: Thu,  7 Feb 2008 04:34:07 -0500
Message-ID: <3b64b51d20d9b633bb2efe63af785a49f8092898.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756169AbYBGJgN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:13 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Use a generic message on hotkey_notify to log unknown and unhandled events,
and cleanup hotkey_notify a little.

Also, document event 0x5010 (brightness changed notification) and do not
log it as an unknown event (even if we do not use it for anything right
now).

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |    4 ++++
 drivers/misc/thinkpad_acpi.c    |   35 ++++++++++++++++++++---------------
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 7c7bd47..3fb8647 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -475,6 +475,10 @@ Non hot-key ACPI HKEY event map:
 The above events are not propagated by the driver, except for legacy
 compatibility purposes when hotkey_report_mode is set to 1.
 
+0x5010		Brightness level changed (newer Lenovo BIOSes)
+
+The above events are propagated by the driver.
+
 Compatibility notes:
 
 ibm-acpi and thinkpad-acpi 0.15 (mainline kernels before 2.6.23) never
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c6c25a4..f5f306a 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2007,6 +2007,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 	unsigned int scancode;
 	int send_acpi_ev;
 	int ignore_acpi_ev;
+	int unk_ev;
 
 	if (event != 0x80) {
 		printk(TPACPI_ERR
@@ -2030,8 +2031,9 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			return;
 		}
 
-		send_acpi_ev = 0;
+		send_acpi_ev = 1;
 		ignore_acpi_ev = 0;
+		unk_ev = 0;
 
 		switch (hkey >> 12) {
 		case 1:
@@ -2041,33 +2043,34 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
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
@@ -2078,9 +2081,11 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
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
1.5.4.23.gef5b9

