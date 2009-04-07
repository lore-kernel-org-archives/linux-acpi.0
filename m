From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/17] ACPI: video: use .notify method instead of installing
 handler directly
Date: Tue, 07 Apr 2009 19:04:16 -0400
Message-ID: <7015558fca5ee82fc17227b61d88ddaa02d82242.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:63930 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZDGXEg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:04:36 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR003V86RM3MWG@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:04:36 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   30 +++++-------------------------
 1 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index ab06143..cd4fb75 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -79,6 +79,7 @@ module_param(brightness_switch_enabled, bool, 0644);
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
 static int acpi_video_resume(struct acpi_device *device);
+static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id video_device_ids[] = {
 	{ACPI_VIDEO_HID, 0},
@@ -94,6 +95,7 @@ static struct acpi_driver acpi_video_bus = {
 		.add = acpi_video_bus_add,
 		.remove = acpi_video_bus_remove,
 		.resume = acpi_video_resume,
+		.notify = acpi_video_bus_notify,
 		},
 };
 
@@ -1986,17 +1988,15 @@ static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
 	return acpi_video_bus_DOS(video, 0, 1);
 }
 
-static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 {
-	struct acpi_video_bus *video = data;
-	struct acpi_device *device = NULL;
+	struct acpi_video_bus *video = acpi_driver_data(device);
 	struct input_dev *input;
 	int keycode;
 
 	if (!video)
 		return;
 
-	device = video->device;
 	input = video->input;
 
 	switch (event) {
@@ -2127,7 +2127,6 @@ static int acpi_video_resume(struct acpi_device *device)
 
 static int acpi_video_bus_add(struct acpi_device *device)
 {
-	acpi_status status;
 	struct acpi_video_bus *video;
 	struct input_dev *input;
 	int error;
@@ -2169,20 +2168,10 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	acpi_video_bus_get_devices(video, device);
 	acpi_video_bus_start_devices(video);
 
-	status = acpi_install_notify_handler(device->handle,
-					     ACPI_DEVICE_NOTIFY,
-					     acpi_video_bus_notify, video);
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX
-				  "Error installing notify handler\n");
-		error = -ENODEV;
-		goto err_stop_video;
-	}
-
 	video->input = input = input_allocate_device();
 	if (!input) {
 		error = -ENOMEM;
-		goto err_uninstall_notify;
+		goto err_stop_video;
 	}
 
 	snprintf(video->phys, sizeof(video->phys),
@@ -2218,9 +2207,6 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
  err_free_input_dev:
 	input_free_device(input);
- err_uninstall_notify:
-	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-				   acpi_video_bus_notify);
  err_stop_video:
 	acpi_video_bus_stop_devices(video);
 	acpi_video_bus_put_devices(video);
@@ -2235,7 +2221,6 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 static int acpi_video_bus_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
 	struct acpi_video_bus *video = NULL;
 
 
@@ -2245,11 +2230,6 @@ static int acpi_video_bus_remove(struct acpi_device *device, int type)
 	video = acpi_driver_data(device);
 
 	acpi_video_bus_stop_devices(video);
-
-	status = acpi_remove_notify_handler(video->device->handle,
-					    ACPI_DEVICE_NOTIFY,
-					    acpi_video_bus_notify);
-
 	acpi_video_bus_put_devices(video);
 	acpi_video_bus_remove_fs(device);
 
-- 
1.6.0.6

