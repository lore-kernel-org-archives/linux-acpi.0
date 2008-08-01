From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 08/10] msi-laptop: fingers off backlight if video.ko is serving this functionality
Date: Fri,  1 Aug 2008 17:38:01 +0200
Message-ID: <1217605083-31003-9-git-send-email-trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59132 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003AbYHAPiS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Aug 2008 11:38:18 -0400
In-Reply-To: <1217605083-31003-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/misc/msi-laptop.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/msi-laptop.c b/drivers/misc/msi-laptop.c
index de898c6..759763d 100644
--- a/drivers/misc/msi-laptop.c
+++ b/drivers/misc/msi-laptop.c
@@ -347,12 +347,16 @@ static int __init msi_init(void)
 
 	/* Register backlight stuff */
 
-	msibl_device = backlight_device_register("msi-laptop-bl", NULL, NULL,
-						&msibl_ops);
-	if (IS_ERR(msibl_device))
-		return PTR_ERR(msibl_device);
-
-	msibl_device->props.max_brightness = MSI_LCD_LEVEL_MAX-1;
+	if (acpi_video_backlight_support()) {
+		printk(KERN_INFO "MSI: Brightness ignored, must be controlled "
+		       "by ACPI video driver\n");
+	} else {
+		msibl_device = backlight_device_register("msi-laptop-bl", NULL,
+							 NULL, &msibl_ops);
+		if (IS_ERR(msibl_device))
+			return PTR_ERR(msibl_device);
+		msibl_device->props.max_brightness = MSI_LCD_LEVEL_MAX-1;
+	}
 
 	ret = platform_driver_register(&msipf_driver);
 	if (ret)
-- 
1.5.4.5

