From: Len Brown <lenb@kernel.org>
Subject: [PATCH 054/103] dell-laptop: create a platform device as a parent for
 the rfkill devices etc.
Date: Wed, 16 Dec 2009 03:36:05 -0500
Message-ID: <ada3248a5d38654b33b0ae2eabe1d7e3d9a9ffce.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41634 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761921AbZLPKGK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:10 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:59 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

dell-laptop may not need to export any sysfs files, but it should still
create a platform device as a parent for the rfkill and backlight
devices.  Otherwise sysfs will display these as "virtual" devices,
with no connection to either physical hardware or the dell-laptop
module.

Apparently this is useful for hardware detection.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Acked-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/dell-laptop.c |   38 ++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 94139d5..a4ce642 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -58,6 +58,14 @@ static int da_command_code;
 static int da_num_tokens;
 static struct calling_interface_token *da_tokens;
 
+static struct platform_driver platform_driver = {
+	.driver = {
+		.name = "dell-laptop",
+		.owner = THIS_MODULE,
+	}
+};
+
+static struct platform_device *platform_device;
 static struct backlight_device *dell_backlight_device;
 static struct rfkill *wifi_rfkill;
 static struct rfkill *bluetooth_rfkill;
@@ -217,7 +225,8 @@ static int dell_setup_rfkill(void)
 	status = buffer.output[1];
 
 	if ((status & (1<<2|1<<8)) == (1<<2|1<<8)) {
-		wifi_rfkill = rfkill_alloc("dell-wifi", NULL, RFKILL_TYPE_WLAN,
+		wifi_rfkill = rfkill_alloc("dell-wifi", &platform_device->dev,
+					   RFKILL_TYPE_WLAN,
 					   &dell_rfkill_ops, (void *) 1);
 		if (!wifi_rfkill) {
 			ret = -ENOMEM;
@@ -229,7 +238,8 @@ static int dell_setup_rfkill(void)
 	}
 
 	if ((status & (1<<3|1<<9)) == (1<<3|1<<9)) {
-		bluetooth_rfkill = rfkill_alloc("dell-bluetooth", NULL,
+		bluetooth_rfkill = rfkill_alloc("dell-bluetooth",
+						&platform_device->dev,
 						RFKILL_TYPE_BLUETOOTH,
 						&dell_rfkill_ops, (void *) 2);
 		if (!bluetooth_rfkill) {
@@ -242,7 +252,9 @@ static int dell_setup_rfkill(void)
 	}
 
 	if ((status & (1<<4|1<<10)) == (1<<4|1<<10)) {
-		wwan_rfkill = rfkill_alloc("dell-wwan", NULL, RFKILL_TYPE_WWAN,
+		wwan_rfkill = rfkill_alloc("dell-wwan",
+					   &platform_device->dev,
+					   RFKILL_TYPE_WWAN,
 					   &dell_rfkill_ops, (void *) 3);
 		if (!wwan_rfkill) {
 			ret = -ENOMEM;
@@ -342,6 +354,18 @@ static int __init dell_init(void)
 		return -ENODEV;
 	}
 
+	ret = platform_driver_register(&platform_driver);
+	if (ret)
+		goto fail_platform_driver;
+	platform_device = platform_device_alloc("dell-laptop", -1);
+	if (!platform_device) {
+		ret = -ENOMEM;
+		goto fail_platform_device1;
+	}
+	ret = platform_device_add(platform_device);
+	if (ret)
+		goto fail_platform_device2;
+
 	ret = dell_setup_rfkill();
 
 	if (ret) {
@@ -368,7 +392,7 @@ static int __init dell_init(void)
 	if (max_intensity) {
 		dell_backlight_device = backlight_device_register(
 			"dell_backlight",
-			NULL, NULL,
+			&platform_device->dev, NULL,
 			&dell_ops);
 
 		if (IS_ERR(dell_backlight_device)) {
@@ -388,6 +412,12 @@ static int __init dell_init(void)
 fail_backlight:
 	dell_cleanup_rfkill();
 fail_rfkill:
+	platform_device_del(platform_device);
+fail_platform_device2:
+	platform_device_put(platform_device);
+fail_platform_device1:
+	platform_driver_unregister(&platform_driver);
+fail_platform_driver:
 	kfree(da_tokens);
 	return ret;
 }
-- 
1.6.0.6

