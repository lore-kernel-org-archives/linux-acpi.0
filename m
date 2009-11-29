From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 1/1 resend] sony-laptop: add AVMode key mapping
Date: Sun, 29 Nov 2009 12:37:07 +0900
Message-ID: <1259465827-4372-1-git-send-email-malattia@linux.it>
References: <1258869062-5501-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:34131
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbZK2DiM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Nov 2009 22:38:12 -0500
In-Reply-To: <1258869062-5501-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>, "Matthew W. S. Bell" <matthew@bells23.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Some models are equipped with an "AVMode" function key that sends
sony-laptop: Unknown event: 0x100 0xa1
sony-laptop: Unknown event: 0x100 0x21
for press and release respectively.

Cc: "Matthew W. S. Bell" <matthew@bells23.org.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---

Hi Len,
[resending because of the broken hyphens in the previous email]

I almost forgot to send this patch for 2.6.32, do you think there is
still room to push it?
Otherwise please consider for 2.6.33.

Thanks
mattia
--- 
 drivers/platform/x86/sony-laptop.c |    4 ++++
 include/linux/sonypi.h             |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index a2a742c..9710f70 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -232,6 +232,7 @@ static int sony_laptop_input_index[] = {
 	56,	/* 69 SONYPI_EVENT_VOLUME_INC_PRESSED */
 	57,	/* 70 SONYPI_EVENT_VOLUME_DEC_PRESSED */
 	-1,	/* 71 SONYPI_EVENT_BRIGHTNESS_PRESSED */
+	58,	/* 72 SONYPI_EVENT_MEDIA_PRESSED */
 };
 
 static int sony_laptop_input_keycode_map[] = {
@@ -293,6 +294,7 @@ static int sony_laptop_input_keycode_map[] = {
 	KEY_F15,	/* 55 SONYPI_EVENT_SETTINGKEY_PRESSED */
 	KEY_VOLUMEUP,	/* 56 SONYPI_EVENT_VOLUME_INC_PRESSED */
 	KEY_VOLUMEDOWN,	/* 57 SONYPI_EVENT_VOLUME_DEC_PRESSED */
+	KEY_MEDIA,	/* 58 SONYPI_EVENT_MEDIA_PRESSED */
 };
 
 /* release buttons after a short delay if pressed */
@@ -890,6 +892,8 @@ static struct sony_nc_event sony_100_events[] = {
 	{ 0x0C, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x9f, SONYPI_EVENT_CD_EJECT_PRESSED },
 	{ 0x1f, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0xa1, SONYPI_EVENT_MEDIA_PRESSED },
+	{ 0x21, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0, 0 },
 };
 
diff --git a/include/linux/sonypi.h b/include/linux/sonypi.h
index 34c4475..4f95c1a 100644
--- a/include/linux/sonypi.h
+++ b/include/linux/sonypi.h
@@ -111,6 +111,7 @@
 #define SONYPI_EVENT_VOLUME_INC_PRESSED		69
 #define SONYPI_EVENT_VOLUME_DEC_PRESSED		70
 #define SONYPI_EVENT_BRIGHTNESS_PRESSED		71
+#define SONYPI_EVENT_MEDIA_PRESSED		72
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
-- 
1.6.5.3

