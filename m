From: keithp@keithp.com
Subject: [PATCH 1/2] acpi: don't free non-existant backlight in acpi video module
Date: Sat, 11 Jul 2009 23:47:31 -0700
Message-ID: <1247381251-27031-1-git-send-email-keithp@keithp.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753395AbZGLGsH@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, keithp@keithp.com
List-Id: linux-acpi@vger.kernel.org

From: Keith Packard <keithp@keithp.com>

acpi_video_put_one_device was attempting to remove sysfs entries and
unregister a backlight device without first checking that said backlight
device structure had been created.

Signed-off-by: Keith Packard <keithp@keithp.com>
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
1.6.3.3
