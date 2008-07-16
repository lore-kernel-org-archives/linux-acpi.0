From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 06/11] fujitsu-laptop: fingers off backlight if video.ko is serving this functionality
Date: Wed, 16 Jul 2008 12:52:28 +0200
Message-ID: <1216205553-8486-7-git-send-email-trenn@suse.de>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42559 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754967AbYGPKwl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 06:52:41 -0400
In-Reply-To: <1216205553-8486-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, Thomas Renninger <trenn@suse.de>Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <trenn@stravinsky.suse.de>
---
 drivers/misc/fujitsu-laptop.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fujitsu-laptop.c b/drivers/misc/fujitsu-laptop.c
index 3601224..4f873cb 100644
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

