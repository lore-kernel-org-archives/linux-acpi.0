From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/4] ACPI: video - fix oops when unloading module
Date: Sat, 08 Aug 2009 00:26:20 -0700
Message-ID: <20090808075631.77F4F526EC9@mailhub.coreip.homeip.net>
References: <20090808072150.2980.3863.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:39667 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbZHHH0X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Aug 2009 03:26:23 -0400
Received: by rv-out-0506.google.com with SMTP id f6so594921rvb.1
        for <linux-acpi@vger.kernel.org>; Sat, 08 Aug 2009 00:26:24 -0700 (PDT)
In-Reply-To: <20090808072150.2980.3863.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

Don't assume that backlight is always present.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/video.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 8851315..d8e64cf 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2004,8 +2004,12 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
 	status = acpi_remove_notify_handler(device->dev->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
-	sysfs_remove_link(&device->backlight->dev.kobj, "device");
-	backlight_device_unregister(device->backlight);
+
+	if (device->backlight) {
+		sysfs_remove_link(&device->backlight->dev.kobj, "device");
+		backlight_device_unregister(device->backlight);
+	}
+
 	if (device->cdev) {
 		sysfs_remove_link(&device->dev->dev.kobj,
 				  "thermal_cooling");
@@ -2014,6 +2018,7 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
 		thermal_cooling_device_unregister(device->cdev);
 		device->cdev = NULL;
 	}
+
 	video_output_unregister(device->output_dev);
 
 	return 0;

