From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/32] ACPI: thinkpad-acpi: dequeue all pending hot key events at once
Date: Fri, 21 Sep 2007 23:46:35 -0400
Message-ID: <11904328221731-git-send-email-lenb@kernel.org>
References: <11904327981905-git-send-email-lenb@kernel.org>
 <11904327991059-git-send-email-lenb@kernel.org>
 <11904328003655-git-send-email-lenb@kernel.org>
 <11904328012791-git-send-email-lenb@kernel.org>
 <11904328011699-git-send-email-lenb@kernel.org>
 <1190432802575-git-send-email-lenb@kernel.org>
 <11904328031107-git-send-email-lenb@kernel.org>
 <11904328041498-git-send-email-lenb@kernel.org>
 <11904328052010-git-send-email-lenb@kernel.org>
 <11904328061489-git-send-email-lenb@kernel.org>
 <119043280633-git-send-email-lenb@kernel.org>
 <1190432807843-git-send-email-lenb@kernel.org>
 <1190432808586-git-send-email-lenb@kernel.org>
 <11904328092328-git-send-email-lenb@kernel.org>
 <11904328102889-git-send-email-lenb@kernel.org>
 <1190432811241-git-send-email-lenb@kernel.org>
 <11904328111749-git-send-email-lenb@kernel.org>
 <11904328122495-git-send-email-lenb@kernel.org>
 <1190432813700-git-send-email-lenb@kernel.org>
 <11904328141573-git-send-email-lenb@kernel.org>
 <11904328153830-git-send-email-lenb@kernel.org>
 <11904328151023-git-send-email-lenb@kernel.org>
 <1190432816575-git-send-email-lenb@kernel.org>
 <1190432817158-git-send-email-lenb@kernel.org>
 <1190432818954-git-send-email-lenb@kernel.org>
 <11904328193063-git-send-email-lenb@kernel.org>
 <11904328192862-git-send-email-lenb@kernel.org>
 <1190432820190-git-send-email-lenb@kernel.org>
 <1190432821532-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:17477 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757612AbXIVDrJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:47:09 -0400
In-Reply-To: <1190432821532-git-send-email-lenb@kernel.org>
Message-Id: <245cd52bc6364cd274901cd1fee1ecb36cec8c4f.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Receive all pending hot key events at once from a single notification, and
don't complain if the queue is empty.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   52 ++++++++++++++++++++++++++++-------------
 1 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 9a61140..de415fe 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1196,9 +1196,31 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	u32 hkey;
 	unsigned int keycode, scancode;
-	int send_acpi_ev = 0;
+	int send_acpi_ev;
+
+	if (event != 0x80) {
+		printk(IBM_ERR "unknown hotkey notification event %d\n", event);
+		/* forward it to userspace, maybe it knows how to handle it */
+		acpi_bus_generate_proc_event(ibm->acpi->device, event, 0);
+		acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
+						ibm->acpi->device->dev.bus_id,
+						event, 0);
+		return;
+	}
+
+	while (1) {
+		if (!acpi_evalf(hkey_handle, &hkey, "MHKP", "d")) {
+			printk(IBM_ERR "failed to retrieve hot key event\n");
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
@@ -1220,8 +1242,8 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			 * eat up known LID events */
 			if (hkey != 0x5001 && hkey != 0x5002) {
 				printk(IBM_ERR
-					"unknown LID-related hotkey event: 0x%04x\n",
-					hkey);
+				       "unknown LID-related hotkey event: 0x%04x\n",
+				       hkey);
 				send_acpi_ev = 1;
 			}
 			break;
@@ -1240,21 +1262,17 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
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
1.5.3.1.27.g57543
