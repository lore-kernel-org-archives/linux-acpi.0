From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 03/10] Acer-WMI: fingers off backlight if video.ko is serving this functionality
Date: Fri,  1 Aug 2008 17:37:56 +0200
Message-ID: <1217605083-31003-4-git-send-email-trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:59190 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048AbYHAPj5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Aug 2008 11:39:57 -0400
In-Reply-To: <1217605083-31003-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
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

