From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 09/10] sony-laptop: fingers off backlight if video.ko is serving this functionality
Date: Fri,  1 Aug 2008 17:38:02 +0200
Message-ID: <1217605083-31003-10-git-send-email-trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59126 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbYHAPiR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Aug 2008 11:38:17 -0400
In-Reply-To: <1217605083-31003-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/misc/sony-laptop.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 60775be..3d178ab 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1038,7 +1038,11 @@ static int sony_nc_add(struct acpi_device *device)
 		goto outinput;
 	}
 
-	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT", &handle))) {
+	if (!acpi_video_backlight_support()) {
+		printk(KERN_INFO DRV_PFX "Sony: Brightness ignored, must be "
+		       "controlled by ACPI video driver\n");
+	} else if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT",
+						&handle))) {
 		sony_backlight_device = backlight_device_register("sony", NULL,
 								  NULL,
 								  &sony_backlight_ops);
-- 
1.5.4.5

