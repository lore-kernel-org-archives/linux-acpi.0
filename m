From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/10] compal: fingers off backlight if video.ko is serving
 this functionality
Date: Sat, 08 Nov 2008 01:14:24 -0500
Message-ID: <1226124869-1878-6-git-send-email-lenb@kernel.org>
References: <1226124869-1878-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50254 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbYKHGOr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 01:14:47 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA000N2M40E2ZF2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 08 Nov 2008 00:14:39 -0600 (CST)
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
 drivers/misc/compal-laptop.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/compal-laptop.c b/drivers/misc/compal-laptop.c
index 344b790..11003bb 100644
--- a/drivers/misc/compal-laptop.c
+++ b/drivers/misc/compal-laptop.c
@@ -326,12 +326,14 @@ static int __init compal_init(void)
 
 	/* Register backlight stuff */
 
-	compalbl_device = backlight_device_register("compal-laptop", NULL, NULL,
-						&compalbl_ops);
-	if (IS_ERR(compalbl_device))
-		return PTR_ERR(compalbl_device);
+	if (!acpi_video_backlight_support()) {
+		compalbl_device = backlight_device_register("compal-laptop", NULL, NULL,
+							    &compalbl_ops);
+		if (IS_ERR(compalbl_device))
+			return PTR_ERR(compalbl_device);
 
-	compalbl_device->props.max_brightness = COMPAL_LCD_LEVEL_MAX-1;
+		compalbl_device->props.max_brightness = COMPAL_LCD_LEVEL_MAX-1;
+	}
 
 	ret = platform_driver_register(&compal_driver);
 	if (ret)
-- 
1.6.0.3.640.g6331a

