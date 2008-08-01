From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 06/10] eeepc-laptop: fingers off backlight if video.ko is serving this functionality
Date: Fri,  1 Aug 2008 17:37:59 +0200
Message-ID: <1217605083-31003-7-git-send-email-trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59109 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbYHAPiI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Aug 2008 11:38:08 -0400
In-Reply-To: <1217605083-31003-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
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

