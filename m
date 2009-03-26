From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 03/14] sony-laptop: Add support for extra keyboard events
Date: Thu, 26 Mar 2009 21:58:14 +0900
Message-ID: <1238072305-8085-4-git-send-email-malattia@linux.it>
References: <1238072305-8085-1-git-send-email-malattia@linux.it>
 <1238072305-8085-2-git-send-email-malattia@linux.it>
 <1238072305-8085-3-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:53400
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbZCZM62 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 08:58:28 -0400
In-Reply-To: <1238072305-8085-3-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Mattia Dongili <malattia@linux.it>

From: Matthew Garrett <mjg59@srcf.ucam.org>

The current sony-laptop code assumes that the keyboard event method is
always located at slot 2 in the platform code. Remove this assumption and
add support for some additional hotkeys.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |   61 +++++++++++++++++++----------------
 include/linux/sonypi.h             |    1 +
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 04deed8..f6cdc89 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -211,6 +211,7 @@ static int sony_laptop_input_index[] = {
 	48,	/* 61 SONYPI_EVENT_WIRELESS_OFF */
 	49,	/* 62 SONYPI_EVENT_ZOOM_IN_PRESSED */
 	50,	/* 63 SONYPI_EVENT_ZOOM_OUT_PRESSED */
+	51,	/* 64 SONYPI_EVENT_CD_EJECT_PRESSED */
 };
 
 static int sony_laptop_input_keycode_map[] = {
@@ -264,7 +265,8 @@ static int sony_laptop_input_keycode_map[] = {
 	KEY_WLAN,	/* 47 SONYPI_EVENT_WIRELESS_ON */
 	KEY_WLAN,	/* 48 SONYPI_EVENT_WIRELESS_OFF */
 	KEY_ZOOMIN,	/* 49 SONYPI_EVENT_ZOOM_IN_PRESSED */
-	KEY_ZOOMOUT	/* 50 SONYPI_EVENT_ZOOM_OUT_PRESSED */
+	KEY_ZOOMOUT,	/* 50 SONYPI_EVENT_ZOOM_OUT_PRESSED */
+	KEY_EJECTCD	/* 51 SONYPI_EVENT_CD_EJECT_PRESSED */
 };
 
 /* release buttons after a short delay if pressed */
@@ -834,7 +836,11 @@ struct sony_nc_event {
 	u8	event;
 };
 
-static struct sony_nc_event sony_C_events[] = {
+static struct sony_nc_event sony_nc_events[] = {
+	{ 0x90, SONYPI_EVENT_PKEY_P1 },
+	{ 0x10, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0x91, SONYPI_EVENT_PKEY_P1 },
+	{ 0x11, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
 	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x85, SONYPI_EVENT_FNKEY_F5 },
@@ -843,10 +849,14 @@ static struct sony_nc_event sony_C_events[] = {
 	{ 0x06, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x87, SONYPI_EVENT_FNKEY_F7 },
 	{ 0x07, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x89, SONYPI_EVENT_FNKEY_F9 },
+	{ 0x09, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x8A, SONYPI_EVENT_FNKEY_F10 },
 	{ 0x0A, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x8C, SONYPI_EVENT_FNKEY_F12 },
 	{ 0x0C, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x9f, SONYPI_EVENT_CD_EJECT_PRESSED },
+	{ 0x1f, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0, 0 },
 };
 
@@ -855,38 +865,33 @@ static struct sony_nc_event sony_C_events[] = {
  */
 static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	int i;
 	u32 ev = event;
 	int result;
 
-	if (ev == 0x92 || ev == 0x90) {
+	if (ev >= 0x90) {
+		/* New-style event */
 		int origev = ev;
-		/* read the key pressed from EC.GECR
-		 * A call to SN07 with 0x0202 will do it as well respecting
-		 * the current protocol on different OSes
-		 *
-		 * Note: the path for GECR may be
-		 *   \_SB.PCI0.LPCB.EC (C, FE, AR, N and friends)
-		 *   \_SB.PCI0.PIB.EC0 (VGN-FR notifications are sent directly, no GECR)
-		 *
-		 * TODO: we may want to do the same for the older GHKE -need
-		 *       dmi list- so this snippet may become one more callback.
-		 */
-		if (sony_call_snc_handle(0x100, 0x200, &result))
-			dprintk("sony_acpi_notify, unable to decode event 0x%.2x\n", ev);
-		else
-			ev = result & 0xFF;
+		ev -= 0x90;
 
-		for (i = 0; sony_C_events[i].data; i++) {
-			if (sony_C_events[i].data == ev) {
-				ev = sony_C_events[i].event;
-				break;
+		if (sony_find_snc_handle(0x100) == ev) {
+			int i;
+
+			if (sony_call_snc_handle(0x100, 0x200, &result))
+				dprintk("sony_acpi_notify, unable to decode event 0x%.2x\n", ev);
+			else
+				ev = result & 0xFF;
+
+			for (i = 0; sony_nc_events[i].event; i++) {
+				if (sony_nc_events[i].data == ev) {
+					ev = sony_nc_events[i].event;
+					break;
+				}
 			}
-		}
 
-		if (!sony_C_events[i].data)
-			printk(KERN_INFO DRV_PFX "Unknown event: %x %x\n",
-			       origev, ev);
+			if (!sony_nc_events[i].data)
+				printk(KERN_INFO DRV_PFX
+				       "Unknown event: %x %x\n", origev, ev);
+		}
 	}
 
 	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
diff --git a/include/linux/sonypi.h b/include/linux/sonypi.h
index f41ffd7..8458dbe 100644
--- a/include/linux/sonypi.h
+++ b/include/linux/sonypi.h
@@ -103,6 +103,7 @@
 #define SONYPI_EVENT_WIRELESS_OFF		61
 #define SONYPI_EVENT_ZOOM_IN_PRESSED		62
 #define SONYPI_EVENT_ZOOM_OUT_PRESSED		63
+#define SONYPI_EVENT_CD_EJECT_PRESSED		64
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
-- 
1.6.2

