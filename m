From: Danny Baumann <dannybaumann@web.de>
Subject: [PATCH 1/3] ACPI video: Fix brightness control initialization for some laptops.
Date: Thu, 14 Mar 2013 11:34:22 +0100
Message-ID: <1363257264-15984-2-git-send-email-dannybaumann@web.de>
References: <1363257264-15984-1-git-send-email-dannybaumann@web.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363257264-15984-1-git-send-email-dannybaumann@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Danny Baumann <dannybaumann@web.de>
List-Id: linux-acpi@vger.kernel.org

In particular, this fixes brightness control initialization for all
devices that return index values from _BQC and don't happen to have the
initial index set by the BIOS in their _BCL table. One example for that
is the Dell Inspiron 15R SE (model number 7520).

What happened for those devices is that acpi_init_brightness queried the
initial brightness by calling acpi_video_device_lcd_get_level_current.
This called _BQC, which returned e.g. 13. As _BQC_use_index isn't
determined at this point (and thus has its initial value of 0), the
index isn't converted into the actual level. As '13' isn't present in
the _BCL list, *level is later overwritten with brightness->curr, which
was initialized to max_level (100) before. Later in
acpi_init_brightness, level_old (with the value 100) is used as an index
into the _BCL table, which causes a value outside of the actual table to
be used as input into acpi_video_device_lcd_set_level(). Depending on
the (undefined) value of that location, this call will fail, causing the
brightness control for the device in question not to be enabled.

Fix that by returning the raw value returned by the _BQC call in the
initialization case.
---
 drivers/acpi/video.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 313f959..ef85574 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -463,6 +463,15 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 		status = acpi_evaluate_integer(device->dev->handle, buf,
 						NULL, level);
 		if (ACPI_SUCCESS(status)) {
+			if (init) {
+				/*
+				 * At init time we don't yet know whether the
+				 * value is indexed or not. Don't mess with it
+				 * until we have determined how to handle it.
+				 */
+				return 0;
+			}
+
 			if (device->brightness->flags._BQC_use_index) {
 				if (device->brightness->flags._BCL_reversed)
 					*level = device->brightness->count
@@ -476,16 +485,14 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 					device->brightness->curr = *level;
 					return 0;
 			}
-			if (!init) {
-				/*
-				 * BQC returned an invalid level.
-				 * Stop using it.
-				 */
-				ACPI_WARNING((AE_INFO,
-					      "%s returned an invalid level",
-					      buf));
-				device->cap._BQC = device->cap._BCQ = 0;
-			}
+			/*
+			 * BQC returned an invalid level.
+			 * Stop using it.
+			 */
+			ACPI_WARNING((AE_INFO,
+				      "%s returned an invalid level",
+				      buf));
+			device->cap._BQC = device->cap._BCQ = 0;
 		} else {
 			/* Fixme:
 			 * should we return an error or ignore this failure?
@@ -714,7 +721,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	if (result)
 		goto out_free_levels;
 
-	result = acpi_video_device_lcd_get_level_current(device, &level, 0);
+	result = acpi_video_device_lcd_get_level_current(device, &level, 1);
 	if (result)
 		goto out_free_levels;
 
-- 
1.8.1.4
