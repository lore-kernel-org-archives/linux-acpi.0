From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 07/10] fujitsu-laptop: fingers off backlight if video.ko is serving this functionality
Date: Fri,  1 Aug 2008 17:38:00 +0200
Message-ID: <1217605083-31003-8-git-send-email-trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:33161 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014AbYHAPiJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Aug 2008 11:38:09 -0400
In-Reply-To: <1217605083-31003-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/misc/fujitsu-laptop.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fujitsu-laptop.c b/drivers/misc/fujitsu-laptop.c
index 7a1ef6c..e72a9ac 100644
--- a/drivers/misc/fujitsu-laptop.c
+++ b/drivers/misc/fujitsu-laptop.c
@@ -963,16 +963,16 @@ static int __init fujitsu_init(void)
 
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
@@ -1008,7 +1008,8 @@ fail_hotkey:
 
 fail_backlight:
 
-	backlight_device_unregister(fujitsu->bl_device);
+	if (fujitsu->bl_device)
+		backlight_device_unregister(fujitsu->bl_device);
 
 fail_platform_device2:
 
@@ -1035,7 +1036,8 @@ static void __exit fujitsu_cleanup(void)
 			   &fujitsupf_attribute_group);
 	platform_device_unregister(fujitsu->pf_device);
 	platform_driver_unregister(&fujitsupf_driver);
-	backlight_device_unregister(fujitsu->bl_device);
+	if (fujitsu->bl_device)
+		backlight_device_unregister(fujitsu->bl_device);
 
 	acpi_bus_unregister_driver(&acpi_fujitsu_driver);
 
-- 
1.5.4.5

