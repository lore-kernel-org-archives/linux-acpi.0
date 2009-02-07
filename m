From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/30] asus-laptop: fix label indentation
Date: Sat, 07 Feb 2009 01:41:18 -0500
Message-ID: <ed6f44215374d94c35cbe98b582d004b9a3f5fbe.1233988824.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:44614 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbZBGGlv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:51 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00DUINPGPV22@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:36:53 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Fix the label indentation

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.6.6

