From: Len Brown <lenb@kernel.org>
Subject: [PATCH 61/94] video: always update the brightness when poking
 "brightness"
Date: Fri, 09 Jan 2009 04:27:03 -0500
Message-ID: <9e6dada9d255497127251c03aaa59296d186f959.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56372 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbZAIJ2g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:36 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700HK068XWCC2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:26:58 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

always update props.brightness no matter the backlight is changed
via procfs, hotkeys or sysfs.

Sighed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index baa4419..66a610d 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -481,6 +481,7 @@ acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
 	int status = AE_OK;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
+	int state;
 
 
 	arg0.integer.value = level;
@@ -489,6 +490,10 @@ acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
 		status = acpi_evaluate_object(device->dev->handle, "_BCM",
 					      &args, NULL);
 	device->brightness->curr = level;
+	for (state = 2; state < device->brightness->count; state++)
+		if (level == device->brightness->levels[state])
+			device->backlight->props.brightness = state - 2;
+
 	return status;
 }
 
-- 
1.5.6.6

