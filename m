From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/30] eeepc-laptop: split eeepc_backlight_exit()
Date: Sat, 07 Feb 2009 01:41:13 -0500
Message-ID: <a9df80c5094ed2bac94f4a0d085651f44d549854.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:22397 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbZBGGlr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:47 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00EK9NXLGHP2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:46 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

eeepc_backlight_exit() was doing rfkill and input stuff, which
is a nonsense. This patch add two specific exit functions, one
for input and one for rfkill.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 9d93cb9..66d611b 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -737,13 +737,21 @@ static void eeepc_backlight_exit(void)
 {
 	if (eeepc_backlight_device)
 		backlight_device_unregister(eeepc_backlight_device);
-	if (ehotk->inputdev)
-		input_unregister_device(ehotk->inputdev);
+	eeepc_backlight_device = NULL;
+}
+
+static void eeepc_rfkill_exit(void)
+{
 	if (ehotk->eeepc_wlan_rfkill)
 		rfkill_unregister(ehotk->eeepc_wlan_rfkill);
 	if (ehotk->eeepc_bluetooth_rfkill)
 		rfkill_unregister(ehotk->eeepc_bluetooth_rfkill);
-	eeepc_backlight_device = NULL;
+}
+
+static void eeepc_input_exit(void)
+{
+	if (ehotk->inputdev)
+		input_unregister_device(ehotk->inputdev);
 }
 
 static void eeepc_hwmon_exit(void)
@@ -762,6 +770,8 @@ static void eeepc_hwmon_exit(void)
 static void __exit eeepc_laptop_exit(void)
 {
 	eeepc_backlight_exit();
+	eeepc_rfkill_exit();
+	eeepc_input_exit();
 	eeepc_hwmon_exit();
 	acpi_bus_unregister_driver(&eeepc_hotk_driver);
 	sysfs_remove_group(&platform_device->dev.kobj,
@@ -865,6 +875,8 @@ fail_platform_driver:
 fail_hwmon:
 	eeepc_backlight_exit();
 fail_backlight:
+	eeepc_input_exit();
+	eeepc_rfkill_exit();
 	return result;
 }
 
-- 
1.5.6.6

