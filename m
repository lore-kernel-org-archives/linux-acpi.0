From: Alessandro Guido <ag@alessandroguido.name>
Subject: [sony-laptop][trivial] No need to print "Sony" after "sony-laptop"
Date: Wed, 12 Nov 2008 23:13:35 +0100
Message-ID: <200811122313.35779.ag@alessandroguido.name>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:49922 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbYKLWNk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 17:13:40 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1182574ugf.37
        for <linux-acpi@vger.kernel.org>; Wed, 12 Nov 2008 14:13:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: trenn@suse.de, linux-acpi@vger.kernel.org

There's no need to print "Sony: " just after "sony-laptop: " (DRV_PFX).

Signed-off-by: Alessandro Guido <ag@alessandroguido.name>
---
diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 2a613d4..571b211 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1039,7 +1039,7 @@ static int sony_nc_add(struct acpi_device *device)
 	}
 
 	if (acpi_video_backlight_support()) {
-		printk(KERN_INFO DRV_PFX "Sony: Brightness ignored, must be "
+		printk(KERN_INFO DRV_PFX "brightness ignored, must be "
 		       "controlled by ACPI video driver\n");
 	} else if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT",
 						&handle))) {

