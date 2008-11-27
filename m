From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] Video.ko vs toshiba.ko - more brightness levels win
Date: Thu, 27 Nov 2008 12:39:27 +0100
Message-ID: <1227785967-10548-3-git-send-email-trenn@suse.de>
References: <alpine.LFD.2.00.0811270010260.3895@localhost.localdomain>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:50157 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765AbYK0Lj3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Nov 2008 06:39:29 -0500
In-Reply-To: <alpine.LFD.2.00.0811270010260.3895@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: hmh@hmh.eng.br, mjg59@srcf.ucam.org, arvidjaar@mail.ru, rpurdie@rpsys.net, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/toshiba_acpi.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/toshiba_acpi.c b/drivers/acpi/toshiba_acpi.c
index 66aac06..843009e 100644
--- a/drivers/acpi/toshiba_acpi.c
+++ b/drivers/acpi/toshiba_acpi.c
@@ -780,19 +780,23 @@ static int __init toshiba_acpi_init(void)
 		}
 	}
 
-	toshiba_backlight_device = backlight_device_register("toshiba",
+        toshiba_backlight_device->props.max_brightness = HCI_LCD_BRIGHTNESS_LEVELS - 1;
+
+	if (acpi_video_backlight_support() <
+	    toshiba_backlight_device->props.max_brightness) {
+		toshiba_backlight_device = backlight_device_register("toshiba",
 						&toshiba_acpi.p_dev->dev,
 						NULL,
 						&toshiba_backlight_data);
-        if (IS_ERR(toshiba_backlight_device)) {
-		ret = PTR_ERR(toshiba_backlight_device);
+		if (IS_ERR(toshiba_backlight_device)) {
+			ret = PTR_ERR(toshiba_backlight_device);
 
-		printk(KERN_ERR "Could not register toshiba backlight device\n");
-		toshiba_backlight_device = NULL;
-		toshiba_acpi_exit();
-		return ret;
+			printk(KERN_ERR "Could not register toshiba backlight device\n");
+			toshiba_backlight_device = NULL;
+			toshiba_acpi_exit();
+			return ret;
+		}
 	}
-        toshiba_backlight_device->props.max_brightness = HCI_LCD_BRIGHTNESS_LEVELS - 1;
 
 	/* Register rfkill switch for Bluetooth */
 	if (hci_get_bt_present(&bt_present) == HCI_SUCCESS && bt_present) {
-- 
1.6.0.2

