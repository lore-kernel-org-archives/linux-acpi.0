From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/11] sony-laptop: printk tweak
Date: Thu, 27 Nov 2008 02:25:12 -0500
Message-ID: <3fedd90fdf17643df1da473c5da983137d51bbdb.1227770639.git.len.brown@intel.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:43800 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbYK0HZ1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 02:25:27 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KAZ00082DYCM4S1@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Nov 2008 01:25:25 -0600 (CST)
In-reply-to: <1227770716-26525-1-git-send-email-lenb@kernel.org>
In-reply-to: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
References: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alessandro Guido <ag@alessandroguido.name>, Len Brown <len.brown@intel.com>

From: Alessandro Guido <ag@alessandroguido.name>

There's no need to print "Sony: " just after "sony-laptop: " (DRV_PFX).

Signed-off-by: Alessandro Guido <ag@alessandroguido.name>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 2a613d4..571b211 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1039,7 +1039,7 @@ static int sony_nc_add(struct acpi_device *device)
 	}
 
 	if (acpi_video_backlight_support()) {
-		printk(KERN_INFO DRV_PFX "Sony: Brightness ignored, must be "
+		printk(KERN_INFO DRV_PFX "brightness ignored, must be "
 		       "controlled by ACPI video driver\n");
 	} else if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT",
 						&handle))) {
-- 
1.5.6.5

