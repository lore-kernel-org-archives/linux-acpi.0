From: trenn@suse.de
Subject: [PATCH 3/9] asus-acpi: fingers off backlight if video.ko is serving this functionality
Date: Thu, 10 Jul 2008 16:30:59 +0200
Message-ID: <1215700265-24908-3-git-send-email-trenn@suse.de>
References: <1215700265-24908-1-git-send-email-trenn@suse.de>
 <1215700265-24908-2-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:57139 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334AbYGJObK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jul 2008 10:31:10 -0400
In-Reply-To: <1215700265-24908-2-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andi@firstfloor.org
Cc: mjg59@srcf.ucam.org, rui.zhang@intel.com, jwoithe@physics.adelaide.edu.au, malattia@linux.it, corentincj@iksaif.net, mzxreary@0pointer.de, hmh@hmh.eng.br, carlos@strangeworlds.co.uk, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, Thomas Renninger <trenn@suse.de>

From: Thomas Renninger <trenn@suse.de>

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

