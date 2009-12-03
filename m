From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 22/33] eeepc-laptop: move platform device initialisation to a separate function
Date: Thu,  3 Dec 2009 08:45:06 +0100
Message-ID: <1259826317-18809-23-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-10-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-11-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-12-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-13-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-14-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-15-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-16-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-17-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-18-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-19-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-20-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-21-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-22-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44230 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603AbZLCHog (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:36 -0500
In-Reply-To: <1259826317-18809-22-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

This moves the sysfs_create_group() call just after the declaration of
the platform device attributes.  It should make it easier to examine
the implementation of the platform device attributes in isolation
from the rest of the code.  (The next commit will apply this pattern
to all of the sub-devices as well).

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk
---
 drivers/platform/x86/eeepc-laptop.c |   64 +++++++++++++++++++++-------------
 1 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 3f9b286..f4f6796 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -509,6 +509,38 @@ static struct attribute_group platform_attribute_group = {
 	.attrs = platform_attributes
 };
 
+static int eeepc_platform_init(void)
+{
+	int result;
+
+	platform_device = platform_device_alloc(EEEPC_HOTK_FILE, -1);
+	if (!platform_device)
+		return -ENOMEM;
+
+	result = platform_device_add(platform_device);
+	if (result)
+		goto fail_platform_device;
+
+	result = sysfs_create_group(&platform_device->dev.kobj,
+				    &platform_attribute_group);
+	if (result)
+		goto fail_sysfs;
+	return 0;
+
+fail_sysfs:
+	platform_device_del(platform_device);
+fail_platform_device:
+	platform_device_put(platform_device);
+	return result;
+}
+
+static void eeepc_platform_exit(void)
+{
+	sysfs_remove_group(&platform_device->dev.kobj,
+			   &platform_attribute_group);
+	platform_device_unregister(platform_device);
+}
+
 /*
  * LEDs
  */
@@ -1276,22 +1308,12 @@ static int __devinit eeepc_hotk_add(struct acpi_device *device)
 
 	result = eeepc_hotk_init();
 	if (result)
-		goto fail_platform_device1;
+		goto fail_platform;
 	eeepc_enable_camera();
 
-	/* Register platform stuff */
-	platform_device = platform_device_alloc(EEEPC_HOTK_FILE, -1);
-	if (!platform_device) {
-		result = -ENOMEM;
-		goto fail_platform_device1;
-	}
-	result = platform_device_add(platform_device);
+	result = eeepc_platform_init();
 	if (result)
-		goto fail_platform_device2;
-	result = sysfs_create_group(&platform_device->dev.kobj,
-				    &platform_attribute_group);
-	if (result)
-		goto fail_sysfs;
+		goto fail_platform;
 
 	dev = &platform_device->dev;
 
@@ -1300,8 +1322,7 @@ static int __devinit eeepc_hotk_add(struct acpi_device *device)
 		if (result)
 			goto fail_backlight;
 	} else
-		pr_info("Backlight controlled by ACPI video "
-			"driver\n");
+		pr_info("Backlight controlled by ACPI video driver\n");
 
 	result = eeepc_input_init(dev);
 	if (result)
@@ -1330,13 +1351,8 @@ fail_hwmon:
 fail_input:
 	eeepc_backlight_exit();
 fail_backlight:
-	sysfs_remove_group(&platform_device->dev.kobj,
-			   &platform_attribute_group);
-fail_sysfs:
-	platform_device_del(platform_device);
-fail_platform_device2:
-	platform_device_put(platform_device);
-fail_platform_device1:
+	eeepc_platform_exit();
+fail_platform:
 	kfree(ehotk);
 
 	return result;
@@ -1349,9 +1365,7 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
 	eeepc_input_exit();
 	eeepc_hwmon_exit();
 	eeepc_led_exit();
-	sysfs_remove_group(&platform_device->dev.kobj,
-			   &platform_attribute_group);
-	platform_device_unregister(platform_device);
+	eeepc_platform_exit();
 
 	kfree(ehotk);
 	return 0;
-- 
1.6.5.3

