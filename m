From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/94] ACPI: video: Fix reversed brightness behavior on
 ThinkPad SL series
Date: Fri, 09 Jan 2009 04:26:06 -0500
Message-ID: <935e5f290ec1eb0f1c15004421f5fd3154380fd5.1231492607.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40893 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbZAIJ1o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:27:44 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700L3O6A6LJF7@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:43 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Section B.6.2 of ACPI 3.0b specification that defines _BCL method
doesn't require the brightness levels returned to be sorted.
At least ThinkPad SL300 (and probably all IdeaPads) returns the
array reversed (i.e. bightest levels have lowest indexes), which
causes the brightness management behave in completely reversed
manner on these machines (brightness increases when the laptop is
idle, while the display dims when used).

Sorting the array by brightness level values after reading the list
fixes the issue.

http://bugzilla.kernel.org/show_bug.cgi?id=12037

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index baa4419..38bf8b4 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -36,6 +36,7 @@
 #include <linux/backlight.h>
 #include <linux/thermal.h>
 #include <linux/video_output.h>
+#include <linux/sort.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
@@ -626,6 +627,16 @@ acpi_video_bus_DOS(struct acpi_video_bus *video, int bios_flag, int lcd_flag)
 }
 
 /*
+ * Simple comparison function used to sort backlight levels.
+ */
+
+static int
+acpi_video_cmp_level(const void *a, const void *b)
+{
+	return *(int *)a - *(int *)b;
+}
+
+/*
  *  Arg:	
  *  	device	: video output device (LCD, CRT, ..)
  *
@@ -676,6 +687,10 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 		count++;
 	}
 
+	/* don't sort the first two brightness levels */
+	sort(&br->levels[2], count - 2, sizeof(br->levels[2]),
+		acpi_video_cmp_level, NULL);
+
 	if (count < 2)
 		goto out_free_levels;
 
-- 
1.5.6.6

