From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 7/9] ACPI: thinkpad-acpi: fix regression on HKEY LID event handling
Date: Sun, 23 Sep 2007 11:39:05 -0300
Message-ID: <1190558348771-git-send-email-hmh@hmh.eng.br>
References: <11905583473293-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58703 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754205AbXIWOjN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Sep 2007 10:39:13 -0400
In-Reply-To: <11905583473293-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

We were letting ThinkPad-specific LID events through to userspace again,
instead of dropping them.  Fix it.  We don't want to give userspace the
option of not using generic LID handling.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 3efe81b..0a33c6e 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1197,6 +1197,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 	u32 hkey;
 	unsigned int keycode, scancode;
 	int send_acpi_ev;
+	int ignore_acpi_ev;
 
 	if (event != 0x80) {
 		printk(IBM_ERR "unknown HKEY notification event %d\n", event);
@@ -1219,6 +1220,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		}
 
 		send_acpi_ev = 0;
+		ignore_acpi_ev = 0;
 
 		switch (hkey >> 12) {
 		case 1:
@@ -1244,6 +1246,8 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				       "unknown LID-related HKEY event: 0x%04x\n",
 				       hkey);
 				send_acpi_ev = 1;
+			} else {
+				ignore_acpi_ev = 1;
 			}
 			break;
 		case 7:
@@ -1263,11 +1267,12 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		}
 
 		/* Legacy events */
-		if (send_acpi_ev || hotkey_report_mode < 2)
+		if (!ignore_acpi_ev && (send_acpi_ev || hotkey_report_mode < 2)) {
 			acpi_bus_generate_proc_event(ibm->acpi->device, event, hkey);
+		}
 
 		/* netlink events */
-		if (send_acpi_ev) {
+		if (!ignore_acpi_ev && send_acpi_ev) {
 			acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
 							ibm->acpi->device->dev.bus_id,
 							event, hkey);
-- 
1.5.3.1

