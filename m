From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/32] ACPI: thinkpad-acpi: fix regression on HKEY LID event handling
Date: Fri, 21 Sep 2007 23:46:36 -0400
Message-ID: <1190432823640-git-send-email-lenb@kernel.org>
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
 <11904328221731-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:53613 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756510AbXIVDrJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:47:09 -0400
In-Reply-To: <11904328221731-git-send-email-lenb@kernel.org>
Message-Id: <f46d7bb7d0f22efe5de65cce4c5fbd6fe01239c2.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

We were letting ThinkPad-specific LID events through to userspace again,
instead of dropping them.  Fix it.  We don't want to give userspace the
option of not using generic LID handling.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index de415fe..24503cc 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1197,6 +1197,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 	u32 hkey;
 	unsigned int keycode, scancode;
 	int send_acpi_ev;
+	int ignore_acpi_ev;
 
 	if (event != 0x80) {
 		printk(IBM_ERR "unknown hotkey notification event %d\n", event);
@@ -1220,6 +1221,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		}
 
 		send_acpi_ev = 0;
+		ignore_acpi_ev = 0;
 
 		switch (hkey >> 12) {
 		case 1:
@@ -1245,6 +1247,8 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				       "unknown LID-related hotkey event: 0x%04x\n",
 				       hkey);
 				send_acpi_ev = 1;
+			} else {
+				ignore_acpi_ev = 1;
 			}
 			break;
 		case 7:
@@ -1264,11 +1268,12 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
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
1.5.3.1.27.g57543
