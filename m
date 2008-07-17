From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 04/11] asus-acpi: fingers off backlight if video.ko is serving this functionality
Date: Thu, 17 Jul 2008 19:32:08 +0200
Message-ID: <1216315935-20998-5-git-send-email-trenn@suse.de>
References: <1216315935-20998-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:58566 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756927AbYGQRcR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 13:32:17 -0400
In-Reply-To: <1216315935-20998-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/misc/asus-laptop.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 7c6dfd0..a9a823b 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -1207,9 +1207,13 @@ static int __init asus_laptop_init(void)
 
 	dev = acpi_get_physical_device(hotk->device->handle);
 
-	result = asus_backlight_init(dev);
-	if (result)
-		goto fail_backlight;
+	if (!acpi_video_backlight_support()) {
+		result = asus_backlight_init(dev);
+		if (result)
+			goto fail_backlight;
+	} else
+		printk(ASUS_INFO "Brightness ignored, must be controlled by "
+		       "ACPI video driver\n");
 
 	result = asus_led_init(dev);
 	if (result)
-- 
1.5.4.5

