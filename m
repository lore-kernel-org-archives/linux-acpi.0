From: Danny Baumann <dannybaumann@web.de>
Subject: [PATCH v2 3/3] ACPI video: Fix applying indexed initial brightness value.
Date: Fri, 15 Mar 2013 11:10:48 +0100
Message-ID: <1363342248-6496-3-git-send-email-dannybaumann@web.de>
References: <1363342248-6496-1-git-send-email-dannybaumann@web.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363342248-6496-1-git-send-email-dannybaumann@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Danny Baumann <dannybaumann@web.de>
List-Id: linux-acpi@vger.kernel.org

The value initially read via _BQC also needs to be offset by 2 to
compensate for the first 2 special items in _BCL. Introduce a helper
function that does the BQC-value-to-level conversion in order to not
needlessly duplicate code.

Signed-off-by: Danny Baumann <dannybaumann@web.de>
---
 drivers/acpi/video.c | 52 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 5ef329a..8faea35 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -450,6 +450,26 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 	{}
 };
 
+static unsigned long long
+acpi_video_bqc_value_to_level(struct acpi_video_device *device,
+			      unsigned long long bqc_value)
+{
+	unsigned long long level;
+
+	if (device->brightness->flags._BQC_use_index) {
+		if (device->brightness->flags._BCL_reversed)
+			bqc_value = device->brightness->count - 3 - bqc_value;
+
+		level = device->brightness->levels[bqc_value + 2];
+	} else {
+		level = bqc_value;
+	}
+
+	level += bqc_offset_aml_bug_workaround;
+
+	return level;
+}
+
 static int
 acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 					unsigned long long *level, int raw)
@@ -472,14 +492,8 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 				return 0;
 			}
 
-			if (device->brightness->flags._BQC_use_index) {
-				if (device->brightness->flags._BCL_reversed)
-					*level = device->brightness->count
-								 - 3 - (*level);
-				*level = device->brightness->levels[*level + 2];
+			*level = acpi_video_bqc_value_to_level(device, *level);
 
-			}
-			*level += bqc_offset_aml_bug_workaround;
 			for (i = 2; i < device->brightness->count; i++)
 				if (device->brightness->levels[i] == *level) {
 					device->brightness->curr = *level;
@@ -727,24 +741,24 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 
 	br->flags._BQC_use_index = (level == max_level ? 0 : 1);
 
-	if (!br->flags._BQC_use_index) {
-		/*
-		 * Set the backlight to the initial state.
-		 * On some buggy laptops, _BQC returns an uninitialized value
-		 * when invoked for the first time, i.e. level_old is invalid.
-		 * set the backlight to max_level in this case
-		 */
-		if (use_bios_initial_backlight) {
+	if (use_bios_initial_backlight) {
+		if (!br->flags._BQC_use_index) {
+			/*
+			 * Set the backlight to the initial state.
+			 * On some buggy laptops, _BQC returns an uninitialized
+			 * value when invoked for the first time, i.e.
+			 * level_old is invalid. Set the backlight to max_level
+			 * in this case.
+			 */
 			for (i = 2; i < br->count; i++)
 				if (level_old == br->levels[i]) {
 					level = level_old;
 					break;
 				}
+		} else {
+			level = acpi_video_bqc_value_to_level(device,
+							      level_old);
 		}
-	} else {
-		if (br->flags._BCL_reversed)
-			level_old = (br->count - 1) - level_old;
-		level = br->levels[level_old];
 	}
 
 set_level:
-- 
1.8.1.4
