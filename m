From: trenn@suse.de
Subject: [PATCH 9/9] compal: fingers off backlight if video.ko is serving this functionality
Date: Thu, 10 Jul 2008 16:31:05 +0200
Message-ID: <1215700265-24908-9-git-send-email-trenn@suse.de>
References: <1215700265-24908-1-git-send-email-trenn@suse.de>
 <1215700265-24908-2-git-send-email-trenn@suse.de>
 <1215700265-24908-3-git-send-email-trenn@suse.de>
 <1215700265-24908-4-git-send-email-trenn@suse.de>
 <1215700265-24908-5-git-send-email-trenn@suse.de>
 <1215700265-24908-6-git-send-email-trenn@suse.de>
 <1215700265-24908-7-git-send-email-trenn@suse.de>
 <1215700265-24908-8-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:57158 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450AbYGJObK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jul 2008 10:31:10 -0400
In-Reply-To: <1215700265-24908-8-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andi@firstfloor.org
Cc: mjg59@srcf.ucam.org, rui.zhang@intel.com, jwoithe@physics.adelaide.edu.au, malattia@linux.it, corentincj@iksaif.net, mzxreary@0pointer.de, hmh@hmh.eng.br, carlos@strangeworlds.co.uk, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, Thomas Renninger <trenn@suse.de>

From: Thomas Renninger <trenn@suse.de>

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

