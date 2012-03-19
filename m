From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH] video: add quirk table for video backlight vendor mode
Date: Mon, 19 Mar 2012 14:03:47 +0800
Message-ID: <1332137027-28327-1-git-send-email-jlee@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37514 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031025Ab2CSGFb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2012 02:05:31 -0400
Received: by obbeh20 with SMTP id eh20so819085obb.19
        for <linux-acpi@vger.kernel.org>; Sun, 18 Mar 2012 23:05:31 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg@redhat.com>

There have some acer laptop have broken _BCM implemenation, the AML code write value
to EC register but firmware didn't change brighenss.

But, the brightness control works on those machines with vendor mode. So, add quirk
table for video backlight vendor mode.

Tested on Acer Aspire 4736
Tested on Acer TravelMate 4750

Cc: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg@redhat.com>
Tested-by: Pradeep Subrahmanion <subrahmanion.pradeep@gmail.com>
Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
---
 drivers/acpi/video_detect.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index f3f0fe7..acb15d6 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -132,6 +132,32 @@ find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
 	return AE_OK;
 }
 
+static int video_set_backlight_vendor(const struct dmi_system_id *d)
+{
+	acpi_video_support |= ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
+	return 0;
+}
+
+static const struct dmi_system_id video_vendor_dmi_table[] = {
+	{
+	 .callback = video_set_backlight_vendor,
+	 .ident = "Acer Aspire 4736",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 4736"),
+		},
+	},
+	{
+	 .callback = video_set_backlight_vendor,
+	 .ident = "Acer TravelMate 4750",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 4750"),
+		},
+	},
+	{}
+};
+
 /*
  * Returns the video capabilities of a specific ACPI graphics device
  *
@@ -164,6 +190,7 @@ long acpi_video_get_capabilities(acpi_handle graphics_handle)
 		 *		ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
 		 *}
 		 */
+		dmi_check_system(video_vendor_dmi_table);
 	} else {
 		status = acpi_bus_get_device(graphics_handle, &tmp_dev);
 		if (ACPI_FAILURE(status)) {
-- 
1.7.7

