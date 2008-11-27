From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/11] sony-laptop: brightness regression fix
Date: Thu, 27 Nov 2008 02:25:11 -0500
Message-ID: <38cfc148e1bc470175b3ad131db7dd7bdcff37ee.1227770639.git.len.brown@intel.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbYK0HZe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 02:25:34 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAZ004EIDYBA1N3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Nov 2008 01:25:24 -0600 (CST)
In-reply-to: <1227770716-26525-1-git-send-email-lenb@kernel.org>
In-reply-to: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
References: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alessandro Guido <ag@alessandroguido.name>, Len Brown <len.brown@intel.com>

From: Alessandro Guido <ag@alessandroguido.name>

After commit 540b8bb9c33935183ceb5bed466a42ad72b2af56:

  sony-laptop: fingers off backlight if video.ko is serving this functionality

I can't set brightness on my sony laptop (nothing in /sys/class/backlight).
dmesg says "sony-laptop: Sony: Brightness ignored, must be controlled by ACPI
video driver".

The function acpi_video_backlight_support returns 0 if we should use the
vendor-specific backlight support, while non-0 if the ACPI generic should
be used. Because of this, the check introduced by the said commit appears
reversed.

Signed-off-by: Alessandro Guido <ag@alessandroguido.name>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 7bcb810..2a613d4 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1038,7 +1038,7 @@ static int sony_nc_add(struct acpi_device *device)
 		goto outinput;
 	}
 
-	if (!acpi_video_backlight_support()) {
+	if (acpi_video_backlight_support()) {
 		printk(KERN_INFO DRV_PFX "Sony: Brightness ignored, must be "
 		       "controlled by ACPI video driver\n");
 	} else if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT",
-- 
1.5.6.5

