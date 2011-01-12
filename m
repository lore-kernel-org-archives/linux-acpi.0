From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/48] ACPI video: introduce module parameter
 video.use_bios_initial_backlight
Date: Wed, 12 Jan 2011 05:19:04 -0500
Message-ID: <99fd1895ef603f1a0fa9af478c96c637a7b4529d.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330Ab1ALRAf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:35 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:30 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Introduce module parameter video.use_bios_initial_backlight.

Some BIOSes claim they use the minimum backlight at boot,
and this may bring dimming screen after boot.
https://bugzilla.kernel.org/show_bug.cgi?id=21212

use video.use_bios_initl_backlight=0 to use
the maximum backlight level after boot.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 5cd0228..89f19a8 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -81,6 +81,13 @@ module_param(brightness_switch_enabled, bool, 0644);
 static int allow_duplicates;
 module_param(allow_duplicates, bool, 0644);
 
+/*
+ * Some BIOSes claim they use minimum backlight at boot,
+ * and this may bring dimming screen after boot
+ */
+static int use_bios_initial_backlight = 1;
+module_param(use_bios_initial_backlight, bool, 0644);
+
 static int register_count = 0;
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
@@ -766,9 +773,11 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 		 * when invoked for the first time, i.e. level_old is invalid.
 		 * set the backlight to max_level in this case
 		 */
-		for (i = 2; i < br->count; i++)
-			if (level_old == br->levels[i])
-				level = level_old;
+		if (use_bios_initial_backlight) {
+			for (i = 2; i < br->count; i++)
+				if (level_old == br->levels[i])
+					level = level_old;
+		}
 		goto set_level;
 	}
 
-- 
1.7.4.rc1.7.g2cf08

