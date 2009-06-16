From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 05/15] asus-laptop: platform dev as parent for led and backlight
Date: Tue, 16 Jun 2009 21:28:46 +0200
Message-ID: <1245180536-28009-6-git-send-email-corentincj@iksaif.net>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-2-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-3-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-4-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-5-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:60973 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444AbZFPTbY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 15:31:24 -0400
In-Reply-To: <1245180536-28009-5-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Makes asus-laptop platform device the parent device of
backlight and led classes.

With this patch, leds and backlight are also available in
/sys/devices/platform/asus-laptop/ like thinkpad_acpi.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |   40 +++++++++++++++++------------------
 1 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index bfc1a88..a033355 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1334,7 +1334,6 @@ out:
 
 static int __init asus_laptop_init(void)
 {
-	struct device *dev;
 	int result;
 
 	if (acpi_disabled)
@@ -1356,24 +1355,10 @@ static int __init asus_laptop_init(void)
 		return -ENODEV;
 	}
 
-	dev = acpi_get_physical_device(hotk->device->handle);
-
-	if (!acpi_video_backlight_support()) {
-		result = asus_backlight_init(dev);
-		if (result)
-			goto fail_backlight;
-	} else
-		printk(ASUS_INFO "Brightness ignored, must be controlled by "
-		       "ACPI video driver\n");
-
 	result = asus_input_init();
 	if (result)
 		goto fail_input;
 
-	result = asus_led_init(dev);
-	if (result)
-		goto fail_led;
-
 	/* Register platform stuff */
 	result = platform_driver_register(&asuspf_driver);
 	if (result)
@@ -1394,8 +1379,27 @@ static int __init asus_laptop_init(void)
 	if (result)
 		goto fail_sysfs;
 
+	result = asus_led_init(&asuspf_device->dev);
+	if (result)
+		goto fail_led;
+
+	if (!acpi_video_backlight_support()) {
+		result = asus_backlight_init(&asuspf_device->dev);
+		if (result)
+			goto fail_backlight;
+	} else
+		printk(ASUS_INFO "Brightness ignored, must be controlled by "
+		       "ACPI video driver\n");
+
 	return 0;
 
+fail_backlight:
+       asus_led_exit();
+
+fail_led:
+       sysfs_remove_group(&asuspf_device->dev.kobj,
+			  &asuspf_attribute_group);
+
 fail_sysfs:
 	platform_device_del(asuspf_device);
 
@@ -1406,15 +1410,9 @@ fail_platform_device1:
 	platform_driver_unregister(&asuspf_driver);
 
 fail_platform_driver:
-	asus_led_exit();
-
-fail_led:
 	asus_input_exit();
 
 fail_input:
-	asus_backlight_exit();
-
-fail_backlight:
 
 	return result;
 }
-- 
1.6.3.1

