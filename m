From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 3/4] sony-laptop: rfkill support for newer models
Date: Thu, 17 Dec 2009 00:08:35 +0900
Message-ID: <1260976116-6369-4-git-send-email-malattia@linux.it>
References: <1260976116-6369-1-git-send-email-malattia@linux.it>
 <1260976116-6369-2-git-send-email-malattia@linux.it>
 <1260976116-6369-3-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:38833
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762194AbZLPPIz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 10:08:55 -0500
In-Reply-To: <1260976116-6369-3-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Vaio Type X and possibly other new models use F135 as the radio
frequency controlling function attached to the SNC device. In the
indexed table this corresponds to 0x0135 (surpise!).

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index b2dccf4..cc7d30d 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -131,6 +131,7 @@ enum sony_nc_rfkill {
 	N_SONY_RFKILL,
 };
 
+static int sony_rfkill_handle;
 static struct rfkill *sony_rfkill_devices[N_SONY_RFKILL];
 static int sony_rfkill_address[N_SONY_RFKILL] = {0x300, 0x500, 0x700, 0x900};
 static void sony_nc_rfkill_update(void);
@@ -970,7 +971,7 @@ static void sony_nc_notify(struct acpi_device *device, u32 event)
 				else
 					sony_laptop_report_input_event(ev);
 			}
-		} else if (sony_find_snc_handle(0x124) == ev) {
+		} else if (sony_find_snc_handle(sony_rfkill_handle) == ev) {
 			sony_nc_rfkill_update();
 			return;
 		}
@@ -1076,7 +1077,7 @@ static int sony_nc_rfkill_set(void *data, bool blocked)
 	if (!blocked)
 		argument |= 0xff0000;
 
-	return sony_call_snc_handle(0x124, argument, &result);
+	return sony_call_snc_handle(sony_rfkill_handle, argument, &result);
 }
 
 static const struct rfkill_ops sony_rfkill_ops = {
@@ -1119,7 +1120,7 @@ static int sony_nc_setup_rfkill(struct acpi_device *device,
 	if (!rfk)
 		return -ENOMEM;
 
-	sony_call_snc_handle(0x124, 0x200, &result);
+	sony_call_snc_handle(sony_rfkill_handle, 0x200, &result);
 	hwblock = !(result & 0x1);
 	rfkill_set_hw_state(rfk, hwblock);
 
@@ -1138,7 +1139,7 @@ static void sony_nc_rfkill_update()
 	int result;
 	bool hwblock;
 
-	sony_call_snc_handle(0x124, 0x200, &result);
+	sony_call_snc_handle(sony_rfkill_handle, 0x200, &result);
 	hwblock = !(result & 0x1);
 
 	for (i = 0; i < N_SONY_RFKILL; i++) {
@@ -1154,7 +1155,7 @@ static void sony_nc_rfkill_update()
 			continue;
 		}
 
-		sony_call_snc_handle(0x124, argument, &result);
+		sony_call_snc_handle(sony_rfkill_handle, argument, &result);
 		rfkill_set_states(sony_rfkill_devices[i],
 				  !(result & 0xf), false);
 	}
@@ -1164,10 +1165,15 @@ static int sony_nc_rfkill_setup(struct acpi_device *device)
 {
 	int result, ret;
 
-	if (sony_find_snc_handle(0x124) == -1)
-		return -1;
+	if (sony_find_snc_handle(0x124) == -1) {
+		if (sony_find_snc_handle(0x135) == -1)
+			return -1;
+		else
+			sony_rfkill_handle = 0x135;
+	} else
+		sony_rfkill_handle = 0x124;
 
-	ret = sony_call_snc_handle(0x124, 0xb00, &result);
+	ret = sony_call_snc_handle(sony_rfkill_handle, 0xb00, &result);
 	if (ret) {
 		printk(KERN_INFO DRV_PFX
 		       "Unable to enumerate rfkill devices: %x\n", ret);
-- 
1.6.5.4

