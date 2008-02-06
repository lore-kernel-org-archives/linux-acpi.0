From: Alessandro Guido <alessandro.guido@gmail.com>
Subject: [PATCH][sony-laptop] Add a missing newline character
Date: Wed, 6 Feb 2008 20:34:41 +0100
Message-ID: <200802062034.42075.alessandro.guido@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:51429 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbYBFTfY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2008 14:35:24 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2456907fga.17
        for <linux-acpi@vger.kernel.org>; Wed, 06 Feb 2008 11:35:23 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: malattia@linux.it
Cc: linux-acpi@vger.kernel.org

Add a missing newline character at the end of the message string.

---
diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index b0f6803..0056b62 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -956,7 +956,7 @@ static int sony_nc_resume(struct acpi_device *device)
 	/* set the last requested brightness level */
 	if (sony_backlight_device &&
 			!sony_backlight_update_status(sony_backlight_device))
-		printk(KERN_WARNING DRV_PFX "unable to restore brightness level");
+		printk(KERN_WARNING DRV_PFX "unable to restore brightness level\n");
 
 	/* re-initialize models with specific requirements */
 	dmi_check_system(sony_nc_ids);
