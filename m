From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/30] ACPI: Skip the first two elements in the _BCL package
Date: Sat, 07 Feb 2009 01:41:25 -0500
Message-ID: <0a3db1cec5d476804185114ff5d1845aed3936b3.1233988825.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:22488 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZBGGl7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:59 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00NP7NXW4W52@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:57 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

According to the Spec the first two elements in the _BCL package won't be

regarded as the available brightness level. The first is the brightness when
full power is connected to the box(It means that the AC adapter is plugged).
The second is the brightness level when the box is on battery.
    If the first two elements are still used while finding the next brightness
level, it will fall back to the lowest level when keeping on pressing
hotkey. (On some boxes the brightness will be changed twice when hotkey is
pressed once. One is in the ACPI video driver. The other is changed by sys I/F.
In the ACPI video driver the first two elements will be used while changing
the brightness. But the first two elements is skipped while using sys I/F.
In such case there exists the inconsistency).
    So he first two elements had better be skipped while showing the available
brightness or finding the next brightness level.

http://bugzilla.kernel.org/show_bug.cgi?id=12450

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index f261737..c9bfca0 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1020,7 +1020,7 @@ acpi_video_device_brightness_seq_show(struct seq_file *seq, void *offset)
 	}
 
 	seq_printf(seq, "levels: ");
-	for (i = 0; i < dev->brightness->count; i++)
+	for (i = 2; i < dev->brightness->count; i++)
 		seq_printf(seq, " %d", dev->brightness->levels[i]);
 	seq_printf(seq, "\ncurrent: %d\n", dev->brightness->curr);
 
@@ -1059,7 +1059,7 @@ acpi_video_device_write_brightness(struct file *file,
 		return -EFAULT;
 
 	/* validate through the list of available levels */
-	for (i = 0; i < dev->brightness->count; i++)
+	for (i = 2; i < dev->brightness->count; i++)
 		if (level == dev->brightness->levels[i]) {
 			if (ACPI_SUCCESS
 			    (acpi_video_device_lcd_set_level(dev, level)))
@@ -1712,7 +1712,7 @@ acpi_video_get_next_level(struct acpi_video_device *device,
 	max = max_below = 0;
 	min = min_above = 255;
 	/* Find closest level to level_current */
-	for (i = 0; i < device->brightness->count; i++) {
+	for (i = 2; i < device->brightness->count; i++) {
 		l = device->brightness->levels[i];
 		if (abs(l - level_current) < abs(delta)) {
 			delta = l - level_current;
@@ -1722,7 +1722,7 @@ acpi_video_get_next_level(struct acpi_video_device *device,
 	}
 	/* Ajust level_current to closest available level */
 	level_current += delta;
-	for (i = 0; i < device->brightness->count; i++) {
+	for (i = 2; i < device->brightness->count; i++) {
 		l = device->brightness->levels[i];
 		if (l < min)
 			min = l;
-- 
1.5.6.6

