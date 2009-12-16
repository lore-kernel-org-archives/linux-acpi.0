From: Len Brown <lenb@kernel.org>
Subject: [PATCH 039/103] eeepc-laptop: move platform device initialisation to a
 separate function
Date: Wed, 16 Dec 2009 03:35:50 -0500
Message-ID: <9db106be554288df5a0a7c56c20257a4391b9738.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761902AbZLPKGJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:09 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:58 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

This moves the sysfs_create_group() call just after the declaration of
the platform device attributes.  It should make it easier to examine
the implementation of the platform device attributes in isolation
from the rest of the code.  (The next commit will apply this pattern
to all of the sub-devices as well).

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

