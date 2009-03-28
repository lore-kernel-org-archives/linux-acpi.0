From: Len Brown <lenb@kernel.org>
Subject: [PATCH 61/98] sony-laptop: VGN-A317M hotkey support
Date: Sat, 28 Mar 2009 00:31:36 -0400
Message-ID: <1cae71032183776e833036fe828315dcd3444df1.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22641 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbZC1EdY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:24 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700LBZ8NLSB5R@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:22 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Harald Jenny <harald@a-little-linux-box.at>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Harald Jenny <harald@a-little-linux-box.at>

This laptop has 5 SPIC managed buttons above the keyboard:
sound + and - as well as brightness, zoom and S1.
Possibly the entire VGN-A serie behaves the same.

Signed-off-by: Harald Jenny <harald@a-little-linux-box.at>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |   22 ++++++++++++++++++++++
 include/linux/sonypi.h             |    3 +++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 3e45c65..4f93288 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -230,6 +230,9 @@ static int sony_laptop_input_index[] = {
 	53,	/* 66 SONYPI_EVENT_PKEY_P4 */
 	54,	/* 67 SONYPI_EVENT_PKEY_P5 */
 	55,	/* 68 SONYPI_EVENT_SETTINGKEY_PRESSED */
+	56,	/* 69 SONYPI_EVENT_VOLUME_INC_PRESSED */
+	57,	/* 70 SONYPI_EVENT_VOLUME_DEC_PRESSED */
+	-1,	/* 71 SONYPI_EVENT_BRIGHTNESS_PRESSED */
 };
 
 static int sony_laptop_input_keycode_map[] = {
@@ -289,6 +292,8 @@ static int sony_laptop_input_keycode_map[] = {
 	KEY_PROG4,	/* 53 SONYPI_EVENT_PKEY_P4 */
 	KEY_F14,	/* 54 SONYPI_EVENT_PKEY_P5 */
 	KEY_F15,	/* 55 SONYPI_EVENT_SETTINGKEY_PRESSED */
+	KEY_VOLUMEUP,	/* 56 SONYPI_EVENT_VOLUME_INC_PRESSED */
+	KEY_VOLUMEDOWN,	/* 57 SONYPI_EVENT_VOLUME_DEC_PRESSED */
 };
 
 /* release buttons after a short delay if pressed */
@@ -1555,6 +1560,7 @@ static struct sonypi_event sonypi_pkeyev[] = {
 	{ 0x01, SONYPI_EVENT_PKEY_P1 },
 	{ 0x02, SONYPI_EVENT_PKEY_P2 },
 	{ 0x04, SONYPI_EVENT_PKEY_P3 },
+	{ 0x20, SONYPI_EVENT_PKEY_P1 },
 	{ 0, 0 }
 };
 
@@ -1598,6 +1604,7 @@ static struct sonypi_event sonypi_zoomev[] = {
 	{ 0x39, SONYPI_EVENT_ZOOM_PRESSED },
 	{ 0x10, SONYPI_EVENT_ZOOM_IN_PRESSED },
 	{ 0x20, SONYPI_EVENT_ZOOM_OUT_PRESSED },
+	{ 0x04, SONYPI_EVENT_ZOOM_PRESSED },
 	{ 0, 0 }
 };
 
@@ -1628,6 +1635,19 @@ static struct sonypi_event sonypi_batteryev[] = {
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
@@ -1668,6 +1688,8 @@ static struct sonypi_eventtypes type3_events[] = {
 	{ 0x05, SONYPI_PKEY_MASK, sonypi_pkeyev },
 	{ 0x05, SONYPI_ZOOM_MASK, sonypi_zoomev },
 	{ 0x05, SONYPI_CAPTURE_MASK, sonypi_captureev },
+	{ 0x05, SONYPI_PKEY_MASK, sonypi_volumeev },
+	{ 0x05, SONYPI_PKEY_MASK, sonypi_brightnessev },
 	{ 0 },
 };
 
diff --git a/include/linux/sonypi.h b/include/linux/sonypi.h
index bb83501..34c4475 100644
--- a/include/linux/sonypi.h
+++ b/include/linux/sonypi.h
@@ -108,6 +108,9 @@
 #define SONYPI_EVENT_PKEY_P4			66
 #define SONYPI_EVENT_PKEY_P5			67
 #define SONYPI_EVENT_SETTINGKEY_PRESSED		68
+#define SONYPI_EVENT_VOLUME_INC_PRESSED		69
+#define SONYPI_EVENT_VOLUME_DEC_PRESSED		70
+#define SONYPI_EVENT_BRIGHTNESS_PRESSED		71
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
-- 
1.6.0.6

