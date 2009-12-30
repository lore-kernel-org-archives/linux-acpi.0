From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/14] ACPI video: correct error-handling code
Date: Wed, 30 Dec 2009 02:36:37 -0500
Message-ID: <e01ce79b7f6ebc5b57128ee058811aa8f9059319.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:64677 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbZL3X1J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 18:27:09 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVH007CENT0HQT5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 17:27:06 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

backlight_device_register may return an ERR_PTR
value rather than a valid pointer.

Problem found by Julia Lawall, properly fixed by Zhang Rui.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Julia Lawall <julia@diku.dk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 05dff63..3f685db 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -999,8 +999,10 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 		sprintf(name, "acpi_video%d", count++);
 		device->backlight = backlight_device_register(name,
 			NULL, device, &acpi_backlight_ops);
-		device->backlight->props.max_brightness = device->brightness->count-3;
 		kfree(name);
+		if (IS_ERR(device->backlight))
+			return;
+		device->backlight->props.max_brightness = device->brightness->count-3;
 
 		result = sysfs_create_link(&device->backlight->dev.kobj,
 					   &device->dev->dev.kobj, "device");
-- 
1.6.0.6

