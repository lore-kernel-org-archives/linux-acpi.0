From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/10] msi-laptop: fingers off backlight if video.ko is serving
 this functionality
Date: Sat, 08 Nov 2008 01:14:27 -0500
Message-ID: <1226124869-1878-9-git-send-email-lenb@kernel.org>
References: <1226124869-1878-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36963 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbYKHGOm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 01:14:42 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA0006ML40HHVI5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 08 Nov 2008 00:14:42 -0600 (CST)
In-reply-to: <1226124869-1878-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.3.640.g6331a

