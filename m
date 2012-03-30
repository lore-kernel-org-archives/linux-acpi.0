From: Igor Murzov <intergalactic.anonymous@gmail.com>
Subject: [RESEND PATCH 2/2] ACPI video: Don't start video device until its associated input device has been allocated
Date: Fri, 30 Mar 2012 21:32:09 +0400
Message-ID: <1333128729-19844-2-git-send-email-e-mail@date.by>
References: <4F756512.8030902@kernel.org>
 <1333128729-19844-1-git-send-email-e-mail@date.by>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54801 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560Ab2C3RdV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Mar 2012 13:33:21 -0400
Received: by mail-bk0-f46.google.com with SMTP id ik5so827144bkc.19
        for <linux-acpi@vger.kernel.org>; Fri, 30 Mar 2012 10:33:21 -0700 (PDT)
In-Reply-To: <1333128729-19844-1-git-send-email-e-mail@date.by>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Sergey V." <sftp.mtuci@gmail.com>, Igor Murzov <e-mail@date.by>

Quoth Dmitry Torokhov:
In addition to bus notifier we do install device notifier explicitly
so it might fire up early. The easiest fox would be to move
acpi_video_bus_start_devices() after input_allocate_device() but
before input_register_device() - unregistered input devices can handle
input_event() calls just fine.

May fix crashes reported in:
https://bugzilla.kernel.org/show_bug.cgi?id=40672

Signed-off-by: Igor Murzov <e-mail@date.by>
---
 drivers/acpi/video.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index fdb4b7d..e70036c 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1658,16 +1658,17 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	error = acpi_video_bus_get_devices(video, device);
 	if (error)
 		goto err_free_video;
-	error = acpi_video_bus_start_devices(video);
-	if (error)
-		goto err_put_video;
 
 	video->input = input = input_allocate_device();
 	if (!input) {
 		error = -ENOMEM;
-		goto err_stop_video;
+		goto err_put_video;
 	}
 
+	error = acpi_video_bus_start_devices(video);
+	if (error)
+		goto err_free_input_dev;
+
 	snprintf(video->phys, sizeof(video->phys),
 		"%s/video/input0", acpi_device_hid(video->device));
 
@@ -1688,7 +1689,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 	error = input_register_device(input);
 	if (error)
-		goto err_free_input_dev;
+		goto err_stop_video;
 
 	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
@@ -1706,10 +1707,10 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
  err_unregister_input_dev:
 	input_unregister_device(input);
- err_free_input_dev:
-	input_free_device(input);
  err_stop_video:
 	acpi_video_bus_stop_devices(video);
+ err_free_input_dev:
+	input_free_device(input);
  err_put_video:
 	acpi_video_bus_put_devices(video);
 	kfree(video->attached_array);
-- 
1.7.5.1

