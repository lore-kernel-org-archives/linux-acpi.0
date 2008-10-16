From: Adam Jackson <ajax@redhat.com>
Subject: [PATCH] sony-laptop: newline-terminate the printk for backlight change failure
Date: Thu, 16 Oct 2008 15:15:35 -0400
Message-ID: <1224184535-30764-1-git-send-email-ajax@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52598 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755369AbYJPTPi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Oct 2008 15:15:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Adam Jackson <ajax@redhat.com>

---
 drivers/misc/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 60775be..5a97d3a 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -970,7 +970,7 @@ static int sony_nc_resume(struct acpi_device *device)
 	/* set the last requested brightness level */
 	if (sony_backlight_device &&
 			!sony_backlight_update_status(sony_backlight_device))
-		printk(KERN_WARNING DRV_PFX "unable to restore brightness level");
+		printk(KERN_WARNING DRV_PFX "unable to restore brightness level\n");
 
 	/* re-initialize models with specific requirements */
 	dmi_check_system(sony_nc_ids);
-- 
1.6.0.1

