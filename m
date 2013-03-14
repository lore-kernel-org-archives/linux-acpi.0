From: Danny Baumann <dannybaumann@web.de>
Subject: [PATCH 3/3] ACPI video: Fix applying indexed initial brightness value.
Date: Thu, 14 Mar 2013 11:34:24 +0100
Message-ID: <1363257264-15984-4-git-send-email-dannybaumann@web.de>
References: <1363257264-15984-1-git-send-email-dannybaumann@web.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363257264-15984-1-git-send-email-dannybaumann@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Danny Baumann <dannybaumann@web.de>
List-Id: linux-acpi@vger.kernel.org

The value initially read via _BQC also needs to be offset by 2 to
compensate for the first 2 special items in _BCL. Introduce a helper
function to do the conversion in order to not needlessly duplicate code.
---
 drivers/acpi/video.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index d0fade7..562ccc3 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -450,6 +450,16 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 	{}
 };
 
+static unsigned long long
+acpi_video_index_to_level(struct acpi_video_device *device,
+			  unsigned long long index)
+{
+	if (device->brightness->flags._BCL_reversed)
+		index = device->brightness->count - 3 - index;
+
+	return device->brightness->levels[index + 2];
+}
+
 static int
 acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 					unsigned long long *level, int init)
@@ -472,13 +482,10 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 				return 0;
 			}
 
-			if (device->brightness->flags._BQC_use_index) {
-				if (device->brightness->flags._BCL_reversed)
-					*level = device->brightness->count
-								 - 3 - (*level);
-				*level = device->brightness->levels[*level + 2];
+			if (device->brightness->flags._BQC_use_index)
+				*level = acpi_video_index_to_level(device,
+								   *level);
 
-			}
 			*level += bqc_offset_aml_bug_workaround;
 			for (i = 2; i < device->brightness->count; i++)
 				if (device->brightness->levels[i] == *level) {
@@ -742,9 +749,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 				}
 		}
 	} else {
-		if (br->flags._BCL_reversed)
-			level_old = (br->count - 1) - level_old;
-		level = br->levels[level_old];
+		level = acpi_video_index_to_level(device, level_old);
 	}
 
 set_level:
-- 
1.8.1.4
