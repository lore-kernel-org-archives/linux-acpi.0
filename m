From: trenn@suse.de
Subject: [PATCH 6/9] msi-laptop: fingers off backlight if video.ko is serving this functionality
Date: Thu, 10 Jul 2008 16:31:02 +0200
Message-ID: <1215700265-24908-6-git-send-email-trenn@suse.de>
References: <1215700265-24908-1-git-send-email-trenn@suse.de>
 <1215700265-24908-2-git-send-email-trenn@suse.de>
 <1215700265-24908-3-git-send-email-trenn@suse.de>
 <1215700265-24908-4-git-send-email-trenn@suse.de>
 <1215700265-24908-5-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51092 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659AbYGJObL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jul 2008 10:31:11 -0400
In-Reply-To: <1215700265-24908-5-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andi@firstfloor.org
Cc: mjg59@srcf.ucam.org, rui.zhang@intel.com, jwoithe@physics.adelaide.edu.au, malattia@linux.it, corentincj@iksaif.net, mzxreary@0pointer.de, hmh@hmh.eng.br, carlos@strangeworlds.co.uk, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, Thomas Renninger <trenn@suse.de>

From: Thomas Renninger <trenn@suse.de>

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

