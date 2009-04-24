From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: dmi check for broken _BQC on Acer Aspire 5720
Date: Fri, 24 Apr 2009 13:29:40 +0800
Message-ID: <1240550980.7661.544.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46361 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029AbZDXF32 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Apr 2009 01:29:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, maximlevitsky@gmail.com


On Acer Aspire 5720, _BQC always returns a value 9 smaller than
the actual brightness level.
Add dmi quirk for this laptop.
http://bugzilla.kernel.org/show_bug.cgi?id=13121

Tested-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -87,6 +87,8 @@ static const struct acpi_device_id video
 };
 MODULE_DEVICE_TABLE(acpi, video_device_ids);
 
+static int bqc_offset;
+
 static struct acpi_driver acpi_video_bus = {
 	.name = "video",
 	.class = ACPI_VIDEO_CLASS,
@@ -556,7 +558,8 @@ acpi_video_device_lcd_get_level_current(
 								 - 3 - (*level);
 				*level = device->brightness->levels[*level + 2];
 
-			}
+			} else if (bqc_offset)
+				*level += bqc_offset;
 			device->brightness->curr = *level;
 			return 0;
 		} else {
@@ -698,6 +701,29 @@ acpi_video_bus_DOS(struct acpi_video_bus
 	return status;
 }
 
+static int video_bqc_offset(const struct dmi_system_id *d)
+{
+	bqc_offset = 9;
+	return 0;
+}
+
+static struct dmi_system_id video_dmi_table[] __initdata = {
+	/*
+	 * Acer Aspire 5720 _BQC method is broken,
+	 * it always returns a value smaller than the actual brightness level
+	 * http://bugzilla.kernel.org/show_bug.cgi?id=13121
+	 */
+	{
+	 .callback = video_bqc_offset,
+	 .ident = "Acer Aspire 5720",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5720"),
+		},
+	},
+	{}
+};
+
 /*
  * Simple comparison function used to sort backlight levels.
  */
@@ -2287,6 +2313,8 @@ EXPORT_SYMBOL(acpi_video_register);
 
 static int __init acpi_video_init(void)
 {
+	dmi_check_system(video_dmi_table);
+
 	if (intel_opregion_present())
 		return 0;
 


