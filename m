From: akpm@linux-foundation.org
Subject: [patch 6/9] acpi: don't free non-existent backlight in acpi video module
Date: Thu, 06 Aug 2009 15:57:54 -0700
Message-ID: <200908062257.n76Mvs1F024250@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34026 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756455AbZHFW7O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2009 18:59:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, keithp@keithp.com, rui.zhang@intel.com

From: Keith Packard <keithp@keithp.com>

acpi_video_put_one_device was attempting to remove sysfs entries and
unregister a backlight device without first checking that said backlight
device structure had been created.

Signed-off-by: Keith Packard <keithp@keithp.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/video.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/video.c~acpi-dont-free-non-existent-backlight-in-acpi-video-module drivers/acpi/video.c
--- a/drivers/acpi/video.c~acpi-dont-free-non-existent-backlight-in-acpi-video-module
+++ a/drivers/acpi/video.c
@@ -2004,8 +2004,11 @@ static int acpi_video_bus_put_one_device
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
_
