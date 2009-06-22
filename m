From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/5] Show the physical device node of backlight class device.
Date: Mon, 22 Jun 2009 11:31:14 +0800
Message-ID: <1245641478-31805-1-git-send-email-rui.zhang@intel.com>
References: <n>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56781 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbZFVDac (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jun 2009 23:30:32 -0400
In-Reply-To: <n>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

Create symbol link from backlight class device to ACPI video device.

More and more laptops are shipped with multiple ACPI
video devices, while we export only one of them to userspace.

With this patch applied, we can know which ACPI video device
is used by "cat /sys/class/backlight/acpi_video0/device/path".

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1bdfb37..9de143a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -976,6 +976,11 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 		device->backlight->props.max_brightness = device->brightness->count-3;
 		kfree(name);
 
+		result = sysfs_create_link(&device->backlight->dev.kobj,
+					   &device->dev->dev.kobj, "device");
+		if (result)
+			printk(KERN_ERR PREFIX "Create sysfs link\n");
+
 		device->cdev = thermal_cooling_device_register("LCD",
 					device->dev, &video_cooling_ops);
 		if (IS_ERR(device->cdev))
@@ -1990,6 +1995,7 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
 	status = acpi_remove_notify_handler(device->dev->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
+	sysfs_remove_link(&device->backlight->dev.kobj, "device");
 	backlight_device_unregister(device->backlight);
 	if (device->cdev) {
 		sysfs_remove_link(&device->dev->dev.kobj,
-- 
1.5.4.4

