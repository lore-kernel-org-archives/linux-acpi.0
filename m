From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 01/10] eeepc-laptop: split eeepc_backlight_exit()
Date: Tue, 20 Jan 2009 16:17:40 +0100
Message-ID: <1232464669-29619-2-git-send-email-corentincj@iksaif.net>
References: <1232464669-29619-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:59550 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756960AbZATPRy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jan 2009 10:17:54 -0500
In-Reply-To: <1232464669-29619-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

eeepc_backlight_exit() was doing rfkill and input stuff, which
is a nonsense. This patch add two specific exit functions, one
for input and one for rfkill.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
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
1.6.1

