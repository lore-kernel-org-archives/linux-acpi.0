From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/10] eeepc-laptop: fingers off backlight if video.ko is
 serving this functionality
Date: Sat, 08 Nov 2008 01:14:25 -0500
Message-ID: <1226124869-1878-7-git-send-email-lenb@kernel.org>
References: <1226124869-1878-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:52777 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYKHGOk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 01:14:40 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KA000D2M40FG554@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 08 Nov 2008 00:14:40 -0600 (CST)
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
 drivers/misc/eeepc-laptop.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeepc-laptop.c b/drivers/misc/eeepc-laptop.c
index 9ef98b2..02fe2b8 100644
--- a/drivers/misc/eeepc-laptop.c
+++ b/drivers/misc/eeepc-laptop.c
@@ -825,9 +825,15 @@ static int __init eeepc_laptop_init(void)
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
1.6.0.3.640.g6331a

