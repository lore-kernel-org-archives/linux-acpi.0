From: akpm@osdl.org
Subject: [patch 09/13] Implementation of acpi_video_get_next_level()
Date: Mon, 04 Dec 2006 14:49:42 -0800
Message-ID: <200612042250.kB4Mop63007379@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:50293 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967723AbWLDWvq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 17:51:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, linux-kernel@ttuttle.net, len.brown@intel.com

From: Thomas Tuttle <linux-kernel@ttuttle.net>

acpi_video_get_next_level was supposed to implement an algorithm to select
a new brightness level based on the old brightness level of an ACPI video
device, but it simply says "/* Fix me */" and returns the current
brightness.

This patch implements acpi_video_get_next_level properly.  It had to change
a few constants at the top of the file because they were (apparently)
wrong, but it appears to work on my Dell Inspiron e1405 (with BIOS A05
only--BIOS A04 doesn't seem to send ACPI video hotkey events).

[akpm@osdl.org: cleanups]
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Tuttle <linux-kernel@ttuttle.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/video.c |   41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff -puN drivers/acpi/video.c~implementation-of-acpi_video_get_next_level drivers/acpi/video.c
--- a/drivers/acpi/video.c~implementation-of-acpi_video_get_next_level
+++ a/drivers/acpi/video.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2004 Luming Yu <luming.yu@intel.com>
  *  Copyright (C) 2004 Bruno Ducrot <ducrot@poupinou.org>
+ *  Copyright (C) 2006 Thomas Tuttle <linux-kernel@ttuttle.net>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -47,11 +48,11 @@
 #define ACPI_VIDEO_NOTIFY_NEXT_OUTPUT	0x83
 #define ACPI_VIDEO_NOTIFY_PREV_OUTPUT	0x84
 
-#define ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS	0x82
-#define	ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS	0x83
-#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS	0x84
-#define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS	0x85
-#define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0x86
+#define ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS	0x85
+#define	ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS	0x86
+#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS	0x87
+#define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS	0x88
+#define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0x89
 
 #define ACPI_VIDEO_HEAD_INVALID		(~0u - 1)
 #define ACPI_VIDEO_HEAD_END		(~0u)
@@ -1502,8 +1503,34 @@ static int
 acpi_video_get_next_level(struct acpi_video_device *device,
 			  u32 level_current, u32 event)
 {
-	/*Fix me */
-	return level_current;
+	int min, max, min_above, max_below, i, l;
+	max = max_below = 0;
+	min = min_above = 255;
+	for (i = 0; i < device->brightness->count; i++) {
+		l = device->brightness->levels[i];
+		if (l < min)
+			min = l;
+		if (l > max)
+			max = l;
+		if (l < min_above && l > level_current)
+			min_above = l;
+		if (l > max_below && l < level_current)
+			max_below = l;
+	}
+
+	switch (event) {
+	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:
+		return (level_current < max) ? min_above : min;
+	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:
+		return (level_current < max) ? min_above : max;
+	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:
+		return (level_current > min) ? max_below : min;
+	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS:
+	case ACPI_VIDEO_NOTIFY_DISPLAY_OFF:
+		return 0;
+	default:
+		return level_current;
+	}
 }
 
 static void
_
