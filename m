From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH] asus-laptop: fix label indentation
Date: Sun, 18 Jan 2009 19:01:55 +0100
Message-ID: <1232301715-20292-7-git-send-email-corentincj@iksaif.net>
References: <1232301715-20292-1-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-2-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-3-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-4-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-5-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-6-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:58975 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933848AbZARSRP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jan 2009 13:17:15 -0500
In-Reply-To: <1232301715-20292-6-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Corentin Chary <corentincj@iksaif.net>

Fix the label indentation

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 53dbfb4..56af6cf 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1184,7 +1184,7 @@ static int asus_hotk_add(struct acpi_device *device)
 	/* GPS is on by default */
 	write_status(NULL, 1, GPS_ON);
 
-      end:
+end:
 	if (result) {
 		kfree(hotk->name);
 		kfree(hotk);
@@ -1393,25 +1393,25 @@ static int __init asus_laptop_init(void)
 
 	return 0;
 
-      fail_sysfs:
+fail_sysfs:
 	platform_device_del(asuspf_device);
 
-      fail_platform_device2:
+fail_platform_device2:
 	platform_device_put(asuspf_device);
 
-      fail_platform_device1:
+fail_platform_device1:
 	platform_driver_unregister(&asuspf_driver);
 
-      fail_platform_driver:
+fail_platform_driver:
 	asus_led_exit();
 
-      fail_led:
+fail_led:
 	asus_input_exit();
 
-      fail_input:
+fail_input:
 	asus_backlight_exit();
 
-      fail_backlight:
+fail_backlight:
 
 	return result;
 }
-- 
1.6.0.6

