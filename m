From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 05/10] ACPI: video: use .notify method instead of installing
	handler directly
Date: Mon, 30 Mar 2009 11:48:34 -0600
Message-ID: <20090330174834.20905.78458.stgit@bob.kio>
References: <20090330174646.20905.18465.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:2893 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbZC3Rsk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2009 13:48:40 -0400
In-Reply-To: <20090330174646.20905.18465.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   30 +++++-------------------------
 1 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index bb5ed05..1bea502 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -77,6 +77,7 @@ module_param(brightness_switch_enabled, bool, 0644);
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
 static int acpi_video_resume(struct acpi_device *device);
+static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id video_device_ids[] = {
 	{ACPI_VIDEO_HID, 0},
@@ -92,6 +93,7 @@ static struct acpi_driver acpi_video_bus = {
 		.add = acpi_video_bus_add,
 		.remove = acpi_video_bus_remove,
 		.resume = acpi_video_resume,
+		.notify = acpi_video_bus_notify,
 		},
 };
 
@@ -1850,17 +1852,15 @@ static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
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
@@ -1991,7 +1991,6 @@ static int acpi_video_resume(struct acpi_device *device)
 
 static int acpi_video_bus_add(struct acpi_device *device)
 {
-	acpi_status status;
 	struct acpi_video_bus *video;
 	struct input_dev *input;
 	int error;
@@ -2033,20 +2032,10 @@ static int acpi_video_bus_add(struct acpi_device *device)
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
@@ -2082,9 +2071,6 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
  err_free_input_dev:
 	input_free_device(input);
- err_uninstall_notify:
-	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-				   acpi_video_bus_notify);
  err_stop_video:
 	acpi_video_bus_stop_devices(video);
 	acpi_video_bus_put_devices(video);
@@ -2099,7 +2085,6 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 static int acpi_video_bus_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
 	struct acpi_video_bus *video = NULL;
 
 
@@ -2109,11 +2094,6 @@ static int acpi_video_bus_remove(struct acpi_device *device, int type)
 	video = acpi_driver_data(device);
 
 	acpi_video_bus_stop_devices(video);
-
-	status = acpi_remove_notify_handler(video->device->handle,
-					    ACPI_DEVICE_NOTIFY,
-					    acpi_video_bus_notify);
-
 	acpi_video_bus_put_devices(video);
 	acpi_video_bus_remove_fs(device);
 

