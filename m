From: Alessandro Guido <ag@alessandroguido.name>
Subject: [sony-laptop] Fix regression caused by "sony-laptop: fingers off backlight if video.ko is serving this functionality"
Date: Wed, 12 Nov 2008 23:03:28 +0100
Message-ID: <200811122303.29372.ag@alessandroguido.name>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:39934 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbYKLWDm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 17:03:42 -0500
Received: by fk-out-0910.google.com with SMTP id 18so619001fkq.5
        for <linux-acpi@vger.kernel.org>; Wed, 12 Nov 2008 14:03:32 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: trenn@suse.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

After commit 540b8bb9c33935183ceb5bed466a42ad72b2af56:

  sony-laptop: fingers off backlight if video.ko is serving this functionality

I can't set brightness on my sony laptop (nothing in /sys/class/backlight).
dmesg says "sony-laptop: Sony: Brightness ignored, must be controlled by ACPI
video driver".
The function acpi_video_backlight_support returns 0 if we should use the
vendor-specific backlight support, while non-0 if the ACPI generic should
be used. Because of this, the check introduced by the said commit appears
reversed.

Signed-off-by: Alessandro Guido <ag@alessandroguido.name>
---
diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 7bcb810..2a613d4 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1038,7 +1038,7 @@ static int sony_nc_add(struct acpi_device *device)
 		goto outinput;
 	}
 
-	if (!acpi_video_backlight_support()) {
+	if (acpi_video_backlight_support()) {
 		printk(KERN_INFO DRV_PFX "Sony: Brightness ignored, must be "
 		       "controlled by ACPI video driver\n");
 	} else if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT",

