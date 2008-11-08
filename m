From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/10] sony-laptop: fingers off backlight if video.ko is
 serving this functionality
Date: Sat, 08 Nov 2008 01:14:28 -0500
Message-ID: <1226124869-1878-10-git-send-email-lenb@kernel.org>
References: <1226124869-1878-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36972 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbYKHGOn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 01:14:43 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA0009RO40INWF2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 08 Nov 2008 00:14:43 -0600 (CST)
In-reply-to: <1226124869-1878-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 06f07e1..7bcb810 100644
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
1.6.0.3.640.g6331a

