From: Igor Murzov <intergalactic.anonymous@gmail.com>
Subject: [RESEND PATCH 1/2] ACPI video: Harden video bus adding.
Date: Fri, 30 Mar 2012 21:32:08 +0400
Message-ID: <1333128729-19844-1-git-send-email-e-mail@date.by>
References: <4F756512.8030902@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54801 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560Ab2C3RdQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Mar 2012 13:33:16 -0400
Received: by bkcik5 with SMTP id ik5so827144bkc.19
        for <linux-acpi@vger.kernel.org>; Fri, 30 Mar 2012 10:33:14 -0700 (PDT)
In-Reply-To: <4F756512.8030902@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Sergey V." <sftp.mtuci@gmail.com>, Igor Murzov <e-mail@date.by>

It is always better to check return values, so add some new checks and
correct existing ones.

v2: Be consistent and don't mix errors from -E* and AE_* namespaces.

Signed-off-by: Igor Murzov <e-mail@date.by>
---
 drivers/acpi/video.c |   41 ++++++++++++++++++++++++++---------------
 1 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index eaef02a..fdb4b7d 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -548,27 +548,27 @@ acpi_video_device_EDID(struct acpi_video_device *device,
  *		1. 	The system BIOS should NOT automatically control the brightness 
  *			level of the LCD when the power changes from AC to DC.
  * Return Value:
- * 		-1	wrong arg.
+ * 		-EINVAL	wrong arg.
  */
 
 static int
 acpi_video_bus_DOS(struct acpi_video_bus *video, int bios_flag, int lcd_flag)
 {
-	u64 status = 0;
+	acpi_status status;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
 
 
-	if (bios_flag < 0 || bios_flag > 3 || lcd_flag < 0 || lcd_flag > 1) {
-		status = -1;
-		goto Failed;
-	}
+	if (bios_flag < 0 || bios_flag > 3 || lcd_flag < 0 || lcd_flag > 1)
+		return -EINVAL;
 	arg0.integer.value = (lcd_flag << 2) | bios_flag;
 	video->dos_setting = arg0.integer.value;
-	acpi_evaluate_object(video->device->handle, "_DOS", &args, NULL);
+	status = acpi_evaluate_object(video->device->handle, "_DOS",
+	                              &args, NULL);
+	if (ACPI_FAILURE(status))
+		return -EIO;
 
-      Failed:
-	return status;
+	return 0;
 }
 
 /*
@@ -1343,15 +1343,17 @@ static int
 acpi_video_bus_get_devices(struct acpi_video_bus *video,
 			   struct acpi_device *device)
 {
-	int status = 0;
+	int status;
 	struct acpi_device *dev;
 
-	acpi_video_device_enumerate(video);
+	status = acpi_video_device_enumerate(video);
+	if (status)
+		return status;
 
 	list_for_each_entry(dev, &device->children, node) {
 
 		status = acpi_video_bus_get_one_device(dev, video);
-		if (ACPI_FAILURE(status)) {
+		if (status) {
 			printk(KERN_WARNING PREFIX
 					"Can't attach device\n");
 			continue;
@@ -1653,8 +1655,12 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	mutex_init(&video->device_list_lock);
 	INIT_LIST_HEAD(&video->video_device_list);
 
-	acpi_video_bus_get_devices(video, device);
-	acpi_video_bus_start_devices(video);
+	error = acpi_video_bus_get_devices(video, device);
+	if (error)
+		goto err_free_video;
+	error = acpi_video_bus_start_devices(video);
+	if (error)
+		goto err_put_video;
 
 	video->input = input = input_allocate_device();
 	if (!input) {
@@ -1692,14 +1698,19 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 	video->pm_nb.notifier_call = acpi_video_resume;
 	video->pm_nb.priority = 0;
-	register_pm_notifier(&video->pm_nb);
+	error = register_pm_notifier(&video->pm_nb);
+	if (error)
+		goto err_unregister_input_dev;
 
 	return 0;
 
+ err_unregister_input_dev:
+	input_unregister_device(input);
  err_free_input_dev:
 	input_free_device(input);
  err_stop_video:
 	acpi_video_bus_stop_devices(video);
+ err_put_video:
 	acpi_video_bus_put_devices(video);
 	kfree(video->attached_array);
  err_free_video:
-- 
1.7.5.1

