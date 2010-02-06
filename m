From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/4] thinkpad-acpi: document HKEY event 3006
Date: Sat,  6 Feb 2010 13:30:27 -0200
Message-ID: <1265470230-30797-2-git-send-email-hmh@hmh.eng.br>
References: <1265470230-30797-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39998 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752880Ab0BFPah (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Feb 2010 10:30:37 -0500
In-Reply-To: <1265470230-30797-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Event 0x3006 is used to help power management of the ODD in the
UltraBay.  The EC generates this event when the ODD eject button is
pressed (even if the bay is powered down).

Normally, Linux doesn't need this as we keep the SATA link powered
up (which wastes power).  The EC powers up the bay by itself when the
ODD eject button is pressed, and the SATA PHY reports the hotplug.

However, we could also power that SATA link down (and for that matter,
also power down the Ultrabay) if the ODD is left idle for a while with
no disk inside, and use event 0x3006 to know when we need that SATA link
powered back up.

For now, just stop asking for more information when event 0x3006 is
seen.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index e67e4fe..a923132 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3655,13 +3655,19 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			break;
 		case 3:
 			/* 0x3000-0x3FFF: bay-related wakeups */
-			if (hkey == TP_HKEY_EV_BAYEJ_ACK) {
+			switch (hkey) {
+			case TP_HKEY_EV_BAYEJ_ACK:
 				hotkey_autosleep_ack = 1;
 				printk(TPACPI_INFO
 				       "bay ejected\n");
 				hotkey_wakeup_hotunplug_complete_notify_change();
 				known_ev = true;
-			} else {
+				break;
+			case TP_HKEY_EV_OPTDRV_EJ:
+				/* FIXME: kick libata if SATA link offline */
+				known_ev = true;
+				break;
+			default:
 				known_ev = false;
 			}
 			break;
-- 
1.6.5.7

