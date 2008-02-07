From: Len Brown <lenb@kernel.org>
Subject: [PATCH 047/112] ACPI: thinkpad-acpi: add X61t HKEY events
Date: Thu,  7 Feb 2008 04:34:09 -0500
Message-ID: <d1edb2b5f1d016d679600cccf2716e0134fff917.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:20777 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754051AbYBGJgT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:19 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Tomas Carnecky reports that events 0x5009 and 0x500a are swivel events, and
that 0x500b/0x500c are tablet pen storage bay events.

Document these events, and avoid nasty messages when they happen.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |    4 ++++
 drivers/misc/thinkpad_acpi.c    |    9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 9d08e47..e1c4550 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -499,6 +499,10 @@ The above events are never propagated by the driver.
 
 0x3003		Bay ejection (see 0x2x05) complete, can sleep again
 0x4003		Undocked (see 0x2x04), can sleep again
+0x5009		Tablet swivel: switched to tablet mode
+0x500A		Tablet swivel: switched to normal mode
+0x500B		Tablet pen insterted into its storage bay
+0x500C		Tablet pen removed from its storage bay
 0x5010		Brightness level changed (newer Lenovo BIOSes)
 
 The above events are propagated by the driver.
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 9b0235d..049ec42 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2127,10 +2127,13 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			}
 			break;
 		case 5:
-			/* 0x5000-0x5FFF: On screen display helpers */
+			/* 0x5000-0x5FFF: human interface helpers */
 			switch (hkey) {
-			case 0x5010:
-				/* Lenovo Vista BIOS: brightness changed */
+			case 0x5010: /* Lenovo new BIOS: brightness changed */
+			case 0x5009: /* X61t: swivel up (tablet mode) */
+			case 0x500a: /* X61t: swivel down (normal mode) */
+			case 0x500b: /* X61t: tablet pen inserted into bay */
+			case 0x500c: /* X61t: tablet pen removed from bay */
 				break;
 			case 0x5001:
 			case 0x5002:
-- 
1.5.4.23.gef5b9

