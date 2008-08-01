From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 04/10] asus-acpi: fingers off backlight if video.ko is serving this functionality
Date: Fri,  1 Aug 2008 17:37:57 +0200
Message-ID: <1217605083-31003-5-git-send-email-trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59111 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbYHAPiI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Aug 2008 11:38:08 -0400
In-Reply-To: <1217605083-31003-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Thomas Renninger <trenn@suse.de>

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

