From: Danny Baumann <dannybaumann@web.de>
Subject: [PATCH 2/3] ACPI video: Make logic a little easier to understand.
Date: Thu, 14 Mar 2013 11:34:23 +0100
Message-ID: <1363257264-15984-3-git-send-email-dannybaumann@web.de>
References: <1363257264-15984-1-git-send-email-dannybaumann@web.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363257264-15984-1-git-send-email-dannybaumann@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Danny Baumann <dannybaumann@web.de>
List-Id: linux-acpi@vger.kernel.org

Make code paths a little easier to follow, and don't needlessly continue
list iteration.
---
 drivers/acpi/video.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index ef85574..d0fade7 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -736,16 +736,17 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 		 */
 		if (use_bios_initial_backlight) {
 			for (i = 2; i < br->count; i++)
-				if (level_old == br->levels[i])
+				if (level_old == br->levels[i]) {
 					level = level_old;
+					break;
+				}
 		}
-		goto set_level;
+	} else {
+		if (br->flags._BCL_reversed)
+			level_old = (br->count - 1) - level_old;
+		level = br->levels[level_old];
 	}
 
-	if (br->flags._BCL_reversed)
-		level_old = (br->count - 1) - level_old;
-	level = br->levels[level_old];
-
 set_level:
 	result = acpi_video_device_lcd_set_level(device, level);
 	if (result)
-- 
1.8.1.4
