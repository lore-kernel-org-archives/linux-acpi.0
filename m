From: Danny Baumann <dannybaumann@web.de>
Subject: [PATCH v4 2/3] ACPI video: Make logic a little easier to understand.
Date: Tue, 19 Mar 2013 17:22:51 +0100
Message-ID: <1363710172-2906-2-git-send-email-dannybaumann@web.de>
References: <1363710172-2906-1-git-send-email-dannybaumann@web.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363710172-2906-1-git-send-email-dannybaumann@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Danny Baumann <dannybaumann@web.de>
List-Id: linux-acpi@vger.kernel.org

Make code paths a little easier to follow, and don't needlessly continue
list iteration.

Signed-off-by: Danny Baumann <dannybaumann@web.de>
---
 drivers/acpi/video.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 09e4722..89bf61e 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -737,16 +737,17 @@ acpi_video_init_brightness(struct acpi_video_device *device)
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
