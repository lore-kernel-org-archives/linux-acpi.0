From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 2/9] [sony-laptop] VGN-A317M hotkey support
Date: Sun,  1 Mar 2009 13:40:38 +0900
Message-ID: <1235882445-2404-3-git-send-email-malattia@linux.it>
References: <1235882445-2404-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48653
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756402AbZCAEuT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Feb 2009 23:50:19 -0500
In-Reply-To: <1235882445-2404-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Harald Jenny <harald@a-little-linux-box.at>, Mattia Dongili <malattia@linux.it>

From: Harald Jenny <harald@a-little-linux-box.at>

This laptop has 5 SPIC managed buttons above the keyboard:
sound + and - as well as brightness, zoom and S1.
Possibly the entire VGN-A serie behaves the same.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |   24 +++++++++++++++++++++++-
 include/linux/sonypi.h             |    3 +++
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 5e43d0a..c710840 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -211,6 +211,9 @@ static int sony_laptop_input_index[] = {
 	48,	/* 61 SONYPI_EVENT_WIRELESS_OFF */
 	49,	/* 62 SONYPI_EVENT_ZOOM_IN_PRESSED */
 	50,	/* 63 SONYPI_EVENT_ZOOM_OUT_PRESSED */
+	51,	/* 64 SONYPI_EVENT_VOLUME_INC_PRESSED */
+	52,	/* 65 SONYPI_EVENT_VOLUME_DEC_PRESSED */
+	-1,	/* 66 SONYPI_EVENT_BRIGHTNESS_PRESSED */
 };
 
 static int sony_laptop_input_keycode_map[] = {
@@ -264,7 +267,9 @@ static int sony_laptop_input_keycode_map[] = {
 	KEY_WLAN,	/* 47 SONYPI_EVENT_WIRELESS_ON */
 	KEY_WLAN,	/* 48 SONYPI_EVENT_WIRELESS_OFF */
 	KEY_ZOOMIN,	/* 49 SONYPI_EVENT_ZOOM_IN_PRESSED */
-	KEY_ZOOMOUT	/* 50 SONYPI_EVENT_ZOOM_OUT_PRESSED */
+	KEY_ZOOMOUT,	/* 50 SONYPI_EVENT_ZOOM_OUT_PRESSED */
+	KEY_VOLUMEUP,	/* 51 SONYPI_EVENT_VOLUME_INC_PRESSED */
+	KEY_VOLUMEDOWN,	/* 52 SONYPI_EVENT_VOLUME_DEC_PRESSED */
 };
 
 /* release buttons after a short delay if pressed */
@@ -1327,6 +1332,7 @@ static struct sonypi_event sonypi_pkeyev[] = {
 	{ 0x01, SONYPI_EVENT_PKEY_P1 },
 	{ 0x02, SONYPI_EVENT_PKEY_P2 },
 	{ 0x04, SONYPI_EVENT_PKEY_P3 },
+	{ 0x20, SONYPI_EVENT_PKEY_P1 },
 	{ 0, 0 }
 };
 
@@ -1370,6 +1376,7 @@ static struct sonypi_event sonypi_zoomev[] = {
 	{ 0x39, SONYPI_EVENT_ZOOM_PRESSED },
 	{ 0x10, SONYPI_EVENT_ZOOM_IN_PRESSED },
 	{ 0x20, SONYPI_EVENT_ZOOM_OUT_PRESSED },
+	{ 0x04, SONYPI_EVENT_ZOOM_PRESSED },
 	{ 0, 0 }
 };
 
@@ -1400,6 +1407,19 @@ static struct sonypi_event sonypi_batteryev[] = {
 	{ 0, 0 }
 };
 
+/* The set of possible volume events */
+static struct sonypi_event sonypi_volumeev[] = {
+	{ 0x01, SONYPI_EVENT_VOLUME_INC_PRESSED },
+	{ 0x02, SONYPI_EVENT_VOLUME_DEC_PRESSED },
+	{ 0, 0 }
+};
+
+/* The set of possible brightness events */
+static struct sonypi_event sonypi_brightnessev[] = {
+	{ 0x80, SONYPI_EVENT_BRIGHTNESS_PRESSED },
+	{ 0, 0 }
+};
+
 static struct sonypi_eventtypes type1_events[] = {
 	{ 0, 0xffffffff, sonypi_releaseev },
 	{ 0x70, SONYPI_MEYE_MASK, sonypi_meyeev },
@@ -1440,6 +1460,8 @@ static struct sonypi_eventtypes type3_events[] = {
 	{ 0x05, SONYPI_PKEY_MASK, sonypi_pkeyev },
 	{ 0x05, SONYPI_ZOOM_MASK, sonypi_zoomev },
 	{ 0x05, SONYPI_CAPTURE_MASK, sonypi_captureev },
+	{ 0x05, SONYPI_PKEY_MASK, sonypi_volumeev },
+	{ 0x05, SONYPI_PKEY_MASK, sonypi_brightnessev },
 	{ 0 },
 };
 
diff --git a/include/linux/sonypi.h b/include/linux/sonypi.h
index f41ffd7..ce0c80f 100644
--- a/include/linux/sonypi.h
+++ b/include/linux/sonypi.h
@@ -103,6 +103,9 @@
 #define SONYPI_EVENT_WIRELESS_OFF		61
 #define SONYPI_EVENT_ZOOM_IN_PRESSED		62
 #define SONYPI_EVENT_ZOOM_OUT_PRESSED		63
+#define SONYPI_EVENT_VOLUME_INC_PRESSED		64
+#define SONYPI_EVENT_VOLUME_DEC_PRESSED		65
+#define SONYPI_EVENT_BRIGHTNESS_PRESSED		66
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
-- 
1.6.1.3

