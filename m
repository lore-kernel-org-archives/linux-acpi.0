From: trenn@suse.de
Subject: [PATCH 7/9] sony-laptop: fingers off backlight if video.ko is serving this functionality
Date: Thu, 10 Jul 2008 16:31:03 +0200
Message-ID: <1215700265-24908-7-git-send-email-trenn@suse.de>
References: <1215700265-24908-1-git-send-email-trenn@suse.de>
 <1215700265-24908-2-git-send-email-trenn@suse.de>
 <1215700265-24908-3-git-send-email-trenn@suse.de>
 <1215700265-24908-4-git-send-email-trenn@suse.de>
 <1215700265-24908-5-git-send-email-trenn@suse.de>
 <1215700265-24908-6-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:57176 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754378AbYGJObK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jul 2008 10:31:10 -0400
In-Reply-To: <1215700265-24908-6-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andi@firstfloor.org
Cc: mjg59@srcf.ucam.org, rui.zhang@intel.com, jwoithe@physics.adelaide.edu.au, malattia@linux.it, corentincj@iksaif.net, mzxreary@0pointer.de, hmh@hmh.eng.br, carlos@strangeworlds.co.uk, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, Thomas Renninger <trenn@suse.de>

From: Thomas Renninger <trenn@suse.de>

---
 drivers/misc/sony-laptop.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 00e48e2..32675cb 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1037,7 +1037,11 @@ static int sony_nc_add(struct acpi_device *device)
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

