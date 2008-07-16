From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 03/11] Acer-WMI: fingers off backlight if video.ko is serving this functionality
Date: Wed, 16 Jul 2008 12:52:25 +0200
Message-ID: <1216205553-8486-4-git-send-email-trenn@suse.de>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:42498 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbYGPKwg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 06:52:36 -0400
In-Reply-To: <1216205553-8486-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, Thomas Renninger <trenn@suse.de>Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <trenn@stravinsky.suse.de>
---
 drivers/misc/acer-wmi.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index e7a3fe5..a843ac2 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -1218,6 +1218,12 @@ static int __init acer_wmi_init(void)
 		return -ENODEV;
 	}
 
+	if (!acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
+		interface->capability &= ~ACER_CAP_BRIGHTNESS;
+		printk(ACER_INFO "Brightness must be controlled by "
+		       "generic video driver\n");
+	}
+
 	if (platform_driver_register(&acer_platform_driver)) {
 		printk(ACER_ERR "Unable to register platform driver.\n");
 		goto error_platform_register;
-- 
1.5.4.5

