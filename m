From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/3] ACPI: don't free non-existent backlight in acpi video
 module
Date: Fri, 28 Aug 2009 20:18:03 -0400
Message-ID: <e29b3ee3b005897fbdcfdd4b3190776e38739d70.1251505014.git.len.brown@intel.com>
References: <1251505083-24354-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33818 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbZH2ASZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 20:18:25 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP4005AT3IC6QE9@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 28 Aug 2009 19:18:18 -0500 (CDT)
In-reply-to: <1251505083-24354-1-git-send-email-lenb@kernel.org>
In-reply-to: <b0de22bdffa2e9a8e280d769c59f866605268484.1251505014.git.len.brown@intel.com>
References: <b0de22bdffa2e9a8e280d769c59f866605268484.1251505014.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Keith Packard <keithp@keithp.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Keith Packard <keithp@keithp.com>

acpi_video_put_one_device was attempting to remove sysfs entries and
unregister a backlight device without first checking that said backlight
device structure had been created.

Signed-off-by: Keith Packard <keithp@keithp.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 8851315..60ea984 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2004,8 +2004,11 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
 	status = acpi_remove_notify_handler(device->dev->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
-	sysfs_remove_link(&device->backlight->dev.kobj, "device");
-	backlight_device_unregister(device->backlight);
+	if (device->backlight) {
+		sysfs_remove_link(&device->backlight->dev.kobj, "device");
+		backlight_device_unregister(device->backlight);
+		device->backlight = NULL;
+	}
 	if (device->cdev) {
 		sysfs_remove_link(&device->dev->dev.kobj,
 				  "thermal_cooling");
-- 
1.6.0.6

