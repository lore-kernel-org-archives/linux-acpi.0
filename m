From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 4/5] acpi_video: Disable use of _BQC when value doesn't match those set through _BCM
Date: Thu,  7 Mar 2013 13:39:39 -0600
Message-ID: <1362685180-7768-4-git-send-email-seth.forshee@canonical.com>
References: <20130307193812.GD24233@thinkpad-t410>
 <1362685180-7768-1-git-send-email-seth.forshee@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49297 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336Ab3CGTjw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Mar 2013 14:39:52 -0500
In-Reply-To: <1362685180-7768-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>, Seth Forshee <seth.forshee@canonical.com>

Check the value returned by _BQC after each brightness change, and if it
doesn't match the value written disable use of _BQC. This works around
problems on some Lenovos when valid brightness values are ignored by
_BCM.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/acpi/video.c |   59 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b83fbbd..6a19bf7 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -230,6 +230,8 @@ static int acpi_video_device_lcd_set_state(struct acpi_video_device *device,
 					   int state);
 static int acpi_video_device_lcd_set_level(struct acpi_video_device *device,
 			int level);
+static int acpi_video_device_get_bqc_level(struct acpi_video_device *device,
+					   unsigned long long *level);
 static int acpi_video_device_lcd_get_level_current(
 			struct acpi_video_device *device,
 			unsigned long long *level, int init);
@@ -395,6 +397,20 @@ acpi_video_device_lcd_set_state(struct acpi_video_device *device, int state)
 			result = -EIO;
 			break;
 		}
+
+		if (device->cap._BQC || device->cap._BCQ) {
+			int bqc_result;
+			unsigned long long level;
+			bqc_result = acpi_video_device_get_bqc_level(device,
+								     &level);
+			if (!bqc_result &&
+			    level != device->brightness->levels[curr_state]) {
+				printk(KERN_WARNING FW_BUG
+				       "%s level does not match level set; disabling\n",
+				       device->cap._BQC ? "_BQC" : "_BCQ");
+				device->cap._BQC = device->cap._BCQ = 0;
+			}
+		}
 	} while (curr_state != state);
 
 	device->brightness->curr_state = curr_state;
@@ -495,26 +511,36 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 };
 
 static int
+acpi_video_device_get_bqc_level(struct acpi_video_device *device,
+				      unsigned long long *level)
+{
+	acpi_status status;
+	char *buf = device->cap._BQC ? "_BQC" : "_BCQ";
+
+	status = acpi_evaluate_integer(device->dev->handle, buf, NULL, level);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if (device->brightness->flags._BQC_use_index) {
+		if (device->brightness->flags._BCL_reversed)
+			*level = device->brightness->count - 3 - *level;
+		*level = device->brightness->levels[*level + 2];
+	}
+
+	*level += bqc_offset_aml_bug_workaround;
+	return 0;
+}
+
+static int
 acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 					unsigned long long *level, int init)
 {
-	acpi_status status = AE_OK;
+	int result;
 	int i;
 
 	if (device->cap._BQC || device->cap._BCQ) {
-		char *buf = device->cap._BQC ? "_BQC" : "_BCQ";
-
-		status = acpi_evaluate_integer(device->dev->handle, buf,
-						NULL, level);
-		if (ACPI_SUCCESS(status)) {
-			if (device->brightness->flags._BQC_use_index) {
-				if (device->brightness->flags._BCL_reversed)
-					*level = device->brightness->count
-								 - 3 - (*level);
-				*level = device->brightness->levels[*level + 2];
-
-			}
-			*level += bqc_offset_aml_bug_workaround;
+		result = acpi_video_device_get_bqc_level(device, level);
+		if (!result) {
 			for (i = 2; i < device->brightness->count; i++)
 				if (device->brightness->levels[i] == *level) {
 					device->brightness->curr_state = i;
@@ -527,7 +553,7 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 				 */
 				ACPI_WARNING((AE_INFO,
 					      "%s returned an invalid level",
-					      buf));
+					      device->cap._BQC ? "_BQC" : "_BCQ"));
 				device->cap._BQC = device->cap._BCQ = 0;
 			}
 		} else {
@@ -539,7 +565,8 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 			 * buggy _BQC.
 			 * http://bugzilla.kernel.org/show_bug.cgi?id=12233
 			 */
-			ACPI_WARNING((AE_INFO, "Evaluating %s failed", buf));
+			ACPI_WARNING((AE_INFO, "Evaluating %s failed",
+				      device->cap._BQC ? "_BQC" : "_BCQ"));
 			device->cap._BQC = device->cap._BCQ = 0;
 		}
 	}
-- 
1.7.9.5

