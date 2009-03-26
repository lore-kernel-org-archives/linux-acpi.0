From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 05/14] sony-laptop: Add support for extended hotkeys
Date: Thu, 26 Mar 2009 21:58:16 +0900
Message-ID: <1238072305-8085-6-git-send-email-malattia@linux.it>
References: <1238072305-8085-1-git-send-email-malattia@linux.it>
 <1238072305-8085-2-git-send-email-malattia@linux.it>
 <1238072305-8085-3-git-send-email-malattia@linux.it>
 <1238072305-8085-4-git-send-email-malattia@linux.it>
 <1238072305-8085-5-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:53420
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbZCZM6a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 08:58:30 -0400
In-Reply-To: <1238072305-8085-5-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Mattia Dongili <malattia@linux.it>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Recent Sony SR-series machines have an additional set of buttons accessed
via the 0x127 method rather than the 0x100 method. Add support for these.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |   65 +++++++++++++++++++++++++++++-------
 include/linux/sonypi.h             |    4 ++
 2 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index f458870..e000c9f 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -226,6 +226,10 @@ static int sony_laptop_input_index[] = {
 	49,	/* 62 SONYPI_EVENT_ZOOM_IN_PRESSED */
 	50,	/* 63 SONYPI_EVENT_ZOOM_OUT_PRESSED */
 	51,	/* 64 SONYPI_EVENT_CD_EJECT_PRESSED */
+	52,	/* 65 SONYPI_EVENT_MODEKEY_PRESSED */
+	53,	/* 66 SONYPI_EVENT_PKEY_P4 */
+	54,	/* 67 SONYPI_EVENT_PKEY_P5 */
+	55,	/* 68 SONYPI_EVENT_SETTINGKEY_PRESSED */
 };
 
 static int sony_laptop_input_keycode_map[] = {
@@ -280,7 +284,11 @@ static int sony_laptop_input_keycode_map[] = {
 	KEY_WLAN,	/* 48 SONYPI_EVENT_WIRELESS_OFF */
 	KEY_ZOOMIN,	/* 49 SONYPI_EVENT_ZOOM_IN_PRESSED */
 	KEY_ZOOMOUT,	/* 50 SONYPI_EVENT_ZOOM_OUT_PRESSED */
-	KEY_EJECTCD	/* 51 SONYPI_EVENT_CD_EJECT_PRESSED */
+	KEY_EJECTCD,	/* 51 SONYPI_EVENT_CD_EJECT_PRESSED */
+	KEY_F13,	/* 52 SONYPI_EVENT_MODEKEY_PRESSED */
+	KEY_PROG4,	/* 53 SONYPI_EVENT_PKEY_P4 */
+	KEY_F14,	/* 54 SONYPI_EVENT_PKEY_P5 */
+	KEY_F15,	/* 55 SONYPI_EVENT_SETTINGKEY_PRESSED */
 };
 
 /* release buttons after a short delay if pressed */
@@ -850,7 +858,7 @@ struct sony_nc_event {
 	u8	event;
 };
 
-static struct sony_nc_event sony_nc_events[] = {
+static struct sony_nc_event sony_100_events[] = {
 	{ 0x90, SONYPI_EVENT_PKEY_P1 },
 	{ 0x10, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0x91, SONYPI_EVENT_PKEY_P1 },
@@ -874,6 +882,25 @@ static struct sony_nc_event sony_nc_events[] = {
 	{ 0, 0 },
 };
 
+static struct sony_nc_event sony_127_events[] = {
+	{ 0x81, SONYPI_EVENT_MODEKEY_PRESSED },
+	{ 0x01, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x82, SONYPI_EVENT_PKEY_P1 },
+	{ 0x02, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x83, SONYPI_EVENT_PKEY_P2 },
+	{ 0x03, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x84, SONYPI_EVENT_PKEY_P3 },
+	{ 0x04, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x85, SONYPI_EVENT_PKEY_P4 },
+	{ 0x05, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x86, SONYPI_EVENT_PKEY_P5 },
+	{ 0x06, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x06, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x87, SONYPI_EVENT_SETTINGKEY_PRESSED },
+	{ 0x07, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0, 0 },
+};
+
 /*
  * ACPI callbacks
  */
@@ -884,27 +911,41 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 
 	if (ev >= 0x90) {
 		/* New-style event */
-		int origev = ev;
+		int key_handle = 0;
 		ev -= 0x90;
 
-		if (sony_find_snc_handle(0x100) == ev) {
-			int i;
+		if (sony_find_snc_handle(0x100) == ev)
+			key_handle = 0x100;
+		if (sony_find_snc_handle(0x127) == ev)
+			key_handle = 0x127;
+
+		if (handle) {
+			struct sony_nc_event *key_event;
 
-			if (sony_call_snc_handle(0x100, 0x200, &result))
-				dprintk("sony_acpi_notify, unable to decode event 0x%.2x\n", ev);
+			if (sony_call_snc_handle(key_handle, 0x200, &result))
+				dprintk("sony_acpi_notify, unable to decode"
+					" event 0x%.2x 0x%.2x\n", key_handle,
+					ev);
 			else
 				ev = result & 0xFF;
 
-			for (i = 0; sony_nc_events[i].event; i++) {
-				if (sony_nc_events[i].data == ev) {
-					ev = sony_nc_events[i].event;
+			if (key_handle == 0x100)
+				key_event = sony_100_events;
+			else
+				key_event = sony_127_events;
+
+			for (; key_event->data; key_event++) {
+				if (key_event->data == ev) {
+					ev = key_event->event;
 					break;
 				}
 			}
 
-			if (!sony_nc_events[i].data)
+			if (!key_event->data) {
 				printk(KERN_INFO DRV_PFX
-				       "Unknown event: %x %x\n", origev, ev);
+				       "Unknown event: 0x%x 0x%x\n", key_handle,
+				       ev);
+			}
 		} else if (sony_find_snc_handle(0x124) == ev) {
 			sony_nc_rfkill_update();
 			return;
diff --git a/include/linux/sonypi.h b/include/linux/sonypi.h
index 8458dbe..bb83501 100644
--- a/include/linux/sonypi.h
+++ b/include/linux/sonypi.h
@@ -104,6 +104,10 @@
 #define SONYPI_EVENT_ZOOM_IN_PRESSED		62
 #define SONYPI_EVENT_ZOOM_OUT_PRESSED		63
 #define SONYPI_EVENT_CD_EJECT_PRESSED		64
+#define SONYPI_EVENT_MODEKEY_PRESSED		65
+#define SONYPI_EVENT_PKEY_P4			66
+#define SONYPI_EVENT_PKEY_P5			67
+#define SONYPI_EVENT_SETTINGKEY_PRESSED		68
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
-- 
1.6.2

