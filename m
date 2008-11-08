From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/10] fujitsu-laptop: fingers off backlight if video.ko is
 serving this functionality
Date: Sat, 08 Nov 2008 01:14:26 -0500
Message-ID: <1226124869-1878-8-git-send-email-lenb@kernel.org>
References: <1226124869-1878-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50254 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbYKHGOs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 01:14:48 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA000J4340GI7X2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 08 Nov 2008 00:14:41 -0600 (CST)
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
 drivers/misc/fujitsu-laptop.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fujitsu-laptop.c b/drivers/misc/fujitsu-laptop.c
index d2cf0bf..1070dc1 100644
--- a/drivers/misc/fujitsu-laptop.c
+++ b/drivers/misc/fujitsu-laptop.c
@@ -990,16 +990,16 @@ static int __init fujitsu_init(void)
 
 	/* Register backlight stuff */
 
-	fujitsu->bl_device =
-	    backlight_device_register("fujitsu-laptop", NULL, NULL,
-				      &fujitsubl_ops);
-	if (IS_ERR(fujitsu->bl_device))
-		return PTR_ERR(fujitsu->bl_device);
-
-	max_brightness = fujitsu->max_brightness;
-
-	fujitsu->bl_device->props.max_brightness = max_brightness - 1;
-	fujitsu->bl_device->props.brightness = fujitsu->brightness_level;
+	if (!acpi_video_backlight_support()) {
+		fujitsu->bl_device =
+			backlight_device_register("fujitsu-laptop", NULL, NULL,
+						  &fujitsubl_ops);
+		if (IS_ERR(fujitsu->bl_device))
+			return PTR_ERR(fujitsu->bl_device);
+		max_brightness = fujitsu->max_brightness;
+		fujitsu->bl_device->props.max_brightness = max_brightness - 1;
+		fujitsu->bl_device->props.brightness = fujitsu->brightness_level;
+	}
 
 	ret = platform_driver_register(&fujitsupf_driver);
 	if (ret)
@@ -1035,7 +1035,8 @@ fail_hotkey:
 
 fail_backlight:
 
-	backlight_device_unregister(fujitsu->bl_device);
+	if (fujitsu->bl_device)
+		backlight_device_unregister(fujitsu->bl_device);
 
 fail_platform_device2:
 
@@ -1062,7 +1063,8 @@ static void __exit fujitsu_cleanup(void)
 			   &fujitsupf_attribute_group);
 	platform_device_unregister(fujitsu->pf_device);
 	platform_driver_unregister(&fujitsupf_driver);
-	backlight_device_unregister(fujitsu->bl_device);
+	if (fujitsu->bl_device)
+		backlight_device_unregister(fujitsu->bl_device);
 
 	acpi_bus_unregister_driver(&acpi_fujitsu_driver);
 
-- 
1.6.0.3.640.g6331a

