From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 11/11] compal: fingers off backlight if video.ko is serving this functionality
Date: Thu, 17 Jul 2008 19:32:15 +0200
Message-ID: <1216315935-20998-12-git-send-email-trenn@suse.de>
References: <1216315935-20998-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:58581 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757897AbYGQRcS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 13:32:18 -0400
In-Reply-To: <1216315935-20998-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/misc/compal-laptop.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/compal-laptop.c b/drivers/misc/compal-laptop.c
index 971e59a..f03cfbf 100644
--- a/drivers/misc/compal-laptop.c
+++ b/drivers/misc/compal-laptop.c
@@ -326,12 +326,14 @@ static int __init compal_init(void)
 
 	/* Register backlight stuff */
 
-	compalbl_device = backlight_device_register("compal-laptop", NULL, NULL,
-						&compalbl_ops);
-	if (IS_ERR(compalbl_device))
-		return PTR_ERR(compalbl_device);
-
-	compalbl_device->props.max_brightness = COMPAL_LCD_LEVEL_MAX-1;
+	if (!acpi_video_backlight_support()) {
+		compalbl_device = backlight_device_register("compal-laptop", NULL, NULL,
+							    &compalbl_ops);
+		if (IS_ERR(compalbl_device))
+			return PTR_ERR(compalbl_device);
+		
+		compalbl_device->props.max_brightness = COMPAL_LCD_LEVEL_MAX-1;
+	}
 
 	ret = platform_driver_register(&compal_driver);
 	if (ret)
-- 
1.5.4.5

