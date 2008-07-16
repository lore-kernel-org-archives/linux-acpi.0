From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 05/11] eeepc-laptop: fingers off backlight if video.ko is serving this functionality
Date: Wed, 16 Jul 2008 12:52:27 +0200
Message-ID: <1216205553-8486-6-git-send-email-trenn@suse.de>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42506 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbYGPKwg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 06:52:36 -0400
In-Reply-To: <1216205553-8486-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, Thomas Renninger <trenn@suse.de>Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <trenn@stravinsky.suse.de>
---
 drivers/misc/eeepc-laptop.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeepc-laptop.c b/drivers/misc/eeepc-laptop.c
index 9e8d79e..0d891a6 100644
--- a/drivers/misc/eeepc-laptop.c
+++ b/drivers/misc/eeepc-laptop.c
@@ -625,9 +625,15 @@ static int __init eeepc_laptop_init(void)
 		return -ENODEV;
 	}
 	dev = acpi_get_physical_device(ehotk->device->handle);
-	result = eeepc_backlight_init(dev);
-	if (result)
-		goto fail_backlight;
+
+	if (!acpi_video_backlight_support()) {
+		result = eeepc_backlight_init(dev);
+		if (result)
+			goto fail_backlight;
+	} else
+		printk(EEEPC_INFO "Backlight controlled by ACPI video "
+		       "driver\n");
+
 	result = eeepc_hwmon_init(dev);
 	if (result)
 		goto fail_hwmon;
-- 
1.5.4.5

