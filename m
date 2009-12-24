From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/34] sony-laptop: add AVMode key mapping
Date: Thu, 24 Dec 2009 01:23:35 -0500
Message-ID: <4f924ba5b5aaf1477daafeae779495d39549186d.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:63913 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbZLXGYO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 01:24:14 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KV500GAP8GB9JX5@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 00:24:12 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, "Matthew W. S. Bell" <matthew@bells23.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Some models are equipped with an "AVMode" function key that sends
  sony-laptop: Unknown event: 0x100 0xa1
  sony-laptop: Unknown event: 0x100 0x21
for press and release respectively.

Cc: "Matthew W. S. Bell" <matthew@bells23.org.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

