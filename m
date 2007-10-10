From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/37] ACPI: thinkpad-acpi: fix regression on HKEY LID event handling
Date: Wed, 10 Oct 2007 01:06:23 -0400
Message-ID: <1191992804-14965-17-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:57218 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751262AbXJJFG6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:06:58 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <3e5ce914bd17335ca74a7c7b06a776c6be6ca434.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
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
1.5.3.4.206.g58ba4
