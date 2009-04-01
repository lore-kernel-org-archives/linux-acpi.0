From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 4/4] sony-laptop: fix event reporting for new style events
Date: Wed,  1 Apr 2009 22:10:47 +0900
Message-ID: <1238591447-13338-5-git-send-email-malattia@linux.it>
References: <1238591447-13338-1-git-send-email-malattia@linux.it>
 <1238591447-13338-2-git-send-email-malattia@linux.it>
 <1238591447-13338-3-git-send-email-malattia@linux.it>
 <1238591447-13338-4-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:56587
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760128AbZDANKu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 09:10:50 -0400
In-Reply-To: <1238591447-13338-4-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Matthias Welwarsky <matze@welwarsky.de>, Mattia Dongili <malattia@linux.it>

From: Matthias Welwarsky <matze@welwarsky.de>

In short Fn key events are always reported through acpi.
The input layer gets all the old style events and only those new style
events that, after being decoded, are mapped to an locally represented
events.
rfkill only update the rfkill device status.

Signed-off-by: Matthias Welwarsky <matze@welwarsky.de>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |   41 ++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 011c035..e02edf6 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -917,10 +917,10 @@ static struct sony_nc_event sony_127_events[] = {
 static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
 	u32 ev = event;
-	int result;
 
 	if (ev >= 0x90) {
 		/* New-style event */
+		int result;
 		int key_handle = 0;
 		ev -= 0x90;
 
@@ -932,38 +932,43 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 		if (key_handle) {
 			struct sony_nc_event *key_event;
 
-			if (sony_call_snc_handle(key_handle, 0x200, &result))
+			if (sony_call_snc_handle(key_handle, 0x200, &result)) {
 				dprintk("sony_acpi_notify, unable to decode"
 					" event 0x%.2x 0x%.2x\n", key_handle,
 					ev);
-			else
+				/* restore the original event */
+				ev = event;
+			} else {
 				ev = result & 0xFF;
 
-			if (key_handle == 0x100)
-				key_event = sony_100_events;
-			else
-				key_event = sony_127_events;
+				if (key_handle == 0x100)
+					key_event = sony_100_events;
+				else
+					key_event = sony_127_events;
 
-			for (; key_event->data; key_event++) {
-				if (key_event->data == ev) {
-					ev = key_event->event;
-					break;
+				for (; key_event->data; key_event++) {
+					if (key_event->data == ev) {
+						ev = key_event->event;
+						break;
+					}
 				}
-			}
 
-			if (!key_event->data) {
-				printk(KERN_INFO DRV_PFX
-				       "Unknown event: 0x%x 0x%x\n", key_handle,
-				       ev);
+				if (!key_event->data)
+					printk(KERN_INFO DRV_PFX
+							"Unknown event: 0x%x 0x%x\n",
+							key_handle,
+							ev);
+				else
+					sony_laptop_report_input_event(ev);
 			}
 		} else if (sony_find_snc_handle(0x124) == ev) {
 			sony_nc_rfkill_update();
 			return;
 		}
-	}
+	} else
+		sony_laptop_report_input_event(ev);
 
 	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
-	sony_laptop_report_input_event(ev);
 	acpi_bus_generate_proc_event(sony_nc_acpi_device, 1, ev);
 }
 
-- 
1.6.2.1

