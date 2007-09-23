From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 6/9] ACPI: thinkpad-acpi: dequeue all pending hot key events at once (v2.2)
Date: Sun, 23 Sep 2007 11:39:04 -0300
Message-ID: <11905583483625-git-send-email-hmh@hmh.eng.br>
References: <11905583473293-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41452 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754180AbXIWOjN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Sep 2007 10:39:13 -0400
In-Reply-To: <11905583473293-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Receive all pending HKEY events at once from a single notification, and don't
complain if the queue is empty.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   51 ++++++++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 9a61140..3efe81b 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1196,9 +1196,30 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	u32 hkey;
 	unsigned int keycode, scancode;
-	int send_acpi_ev = 0;
+	int send_acpi_ev;
+
+	if (event != 0x80) {
+		printk(IBM_ERR "unknown HKEY notification event %d\n", event);
+		/* forward it to userspace, maybe it knows how to handle it */
+		acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
+						ibm->acpi->device->dev.bus_id,
+						event, 0);
+		return;
+	}
+
+	while (1) {
+		if (!acpi_evalf(hkey_handle, &hkey, "MHKP", "d")) {
+			printk(IBM_ERR "failed to retrieve HKEY event\n");
+			return;
+		}
+
+		if (hkey == 0) {
+			/* queue empty */
+			return;
+		}
+
+		send_acpi_ev = 0;
 
-	if (event == 0x80 && acpi_evalf(hkey_handle, &hkey, "MHKP", "d")) {
 		switch (hkey >> 12) {
 		case 1:
 			/* 0x1000-0x1FFF: key presses */
@@ -1220,8 +1241,8 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			 * eat up known LID events */
 			if (hkey != 0x5001 && hkey != 0x5002) {
 				printk(IBM_ERR
-					"unknown LID-related hotkey event: 0x%04x\n",
-					hkey);
+				       "unknown LID-related HKEY event: 0x%04x\n",
+				       hkey);
 				send_acpi_ev = 1;
 			}
 			break;
@@ -1240,21 +1261,17 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			printk(IBM_NOTICE "unhandled HKEY event 0x%04x\n", hkey);
 			send_acpi_ev = 1;
 		}
-	} else {
-		printk(IBM_ERR "unknown hotkey notification event %d\n", event);
-		hkey = 0;
-		send_acpi_ev = 1;
-	}
 
-	/* Legacy events */
-	if (send_acpi_ev || hotkey_report_mode < 2)
-		acpi_bus_generate_proc_event(ibm->acpi->device, event, hkey);
+		/* Legacy events */
+		if (send_acpi_ev || hotkey_report_mode < 2)
+			acpi_bus_generate_proc_event(ibm->acpi->device, event, hkey);
 
-	/* netlink events */
-	if (send_acpi_ev) {
-		acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
-						ibm->acpi->device->dev.bus_id,
-						event, hkey);
+		/* netlink events */
+		if (send_acpi_ev) {
+			acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
+							ibm->acpi->device->dev.bus_id,
+							event, hkey);
+		}
 	}
 }
 
-- 
1.5.3.1

