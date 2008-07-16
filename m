From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 04/11] asus-acpi: fingers off backlight if video.ko is serving this functionality
Date: Wed, 16 Jul 2008 12:52:26 +0200
Message-ID: <1216205553-8486-5-git-send-email-trenn@suse.de>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:48160 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108AbYGPKwh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 06:52:37 -0400
In-Reply-To: <1216205553-8486-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, Thomas Renninger <trenn@suse.de>Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <trenn@stravinsky.suse.de>
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

