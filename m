From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: video - properly handle errors when registering proc elements
Date: Sat, 23 Feb 2008 01:18:20 -0500
Message-ID: <1203747502-4780-3-git-send-email-lenb@kernel.org>
References: <1203747502-4780-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:11600 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751607AbYBWGTF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Feb 2008 01:19:05 -0500
In-Reply-To: <1203747502-4780-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Have acpi_video_device_add_fs() and acpi_video_bus_add_fs()
properly unwind proc creation after error.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |  232 +++++++++++++++++++++++++-------------------------
 1 files changed, 116 insertions(+), 116 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 78f971f..bbde8e6 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -967,87 +967,90 @@ acpi_video_device_EDID_open_fs(struct inode *inode, struct file *file)
 
 static int acpi_video_device_add_fs(struct acpi_device *device)
 {
-	struct proc_dir_entry *entry = NULL;
+	struct proc_dir_entry *entry, *device_dir;
 	struct acpi_video_device *vid_dev;
 
-
-	if (!device)
-		return -ENODEV;
-
 	vid_dev = acpi_driver_data(device);
 	if (!vid_dev)
 		return -ENODEV;
 
-	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
-						     vid_dev->video->dir);
-		if (!acpi_device_dir(device))
-			return -ENODEV;
-		acpi_device_dir(device)->owner = THIS_MODULE;
-	}
+	device_dir = proc_mkdir(acpi_device_bid(device),
+				vid_dev->video->dir);
+	if (!device_dir)
+		return -ENOMEM;
+
+	device_dir->owner = THIS_MODULE;
 
 	/* 'info' [R] */
-	entry = create_proc_entry("info", S_IRUGO, acpi_device_dir(device));
+	entry = create_proc_entry("info", S_IRUGO, device_dir);
 	if (!entry)
-		return -ENODEV;
-	else {
-		entry->proc_fops = &acpi_video_device_info_fops;
-		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
-	}
+		goto err_remove_dir;
+
+	entry->proc_fops = &acpi_video_device_info_fops;
+	entry->data = acpi_driver_data(device);
+	entry->owner = THIS_MODULE;
 
 	/* 'state' [R/W] */
-	entry =
-	    create_proc_entry("state", S_IFREG | S_IRUGO | S_IWUSR,
-			      acpi_device_dir(device));
+	entry = create_proc_entry("state", S_IFREG | S_IRUGO | S_IWUSR,
+				  device_dir);
 	if (!entry)
-		return -ENODEV;
-	else {
-		acpi_video_device_state_fops.write = acpi_video_device_write_state;
-		entry->proc_fops = &acpi_video_device_state_fops;
-		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
-	}
+		goto err_remove_info;
+
+	acpi_video_device_state_fops.write = acpi_video_device_write_state;
+	entry->proc_fops = &acpi_video_device_state_fops;
+	entry->data = acpi_driver_data(device);
+	entry->owner = THIS_MODULE;
 
 	/* 'brightness' [R/W] */
-	entry =
-	    create_proc_entry("brightness", S_IFREG | S_IRUGO | S_IWUSR,
-			      acpi_device_dir(device));
+	entry = create_proc_entry("brightness", S_IFREG | S_IRUGO | S_IWUSR,
+				  device_dir);
 	if (!entry)
-		return -ENODEV;
-	else {
-		acpi_video_device_brightness_fops.write = acpi_video_device_write_brightness;
-		entry->proc_fops = &acpi_video_device_brightness_fops;
-		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
-	}
+		goto err_remove_state;
+
+	acpi_video_device_brightness_fops.write =
+			acpi_video_device_write_brightness;
+	entry->proc_fops = &acpi_video_device_brightness_fops;
+	entry->data = acpi_driver_data(device);
+	entry->owner = THIS_MODULE;
 
 	/* 'EDID' [R] */
-	entry = create_proc_entry("EDID", S_IRUGO, acpi_device_dir(device));
+	entry = create_proc_entry("EDID", S_IRUGO, device_dir);
 	if (!entry)
-		return -ENODEV;
-	else {
-		entry->proc_fops = &acpi_video_device_EDID_fops;
-		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
-	}
+		goto err_remove_brightness;
+
+	entry->proc_fops = &acpi_video_device_EDID_fops;
+	entry->data = acpi_driver_data(device);
+	entry->owner = THIS_MODULE;
 
+	acpi_device_dir(device) = device_dir;
 	return 0;
+
+ err_remove_brightness:
+	remove_proc_entry("brightness", device_dir);
+ err_remove_state:
+	remove_proc_entry("state", device_dir);
+ err_remove_info:
+	remove_proc_entry("info", device_dir);
+ err_remove_dir:
+	remove_proc_entry(acpi_device_bid(device), vid_dev->video->dir);
+	return -ENOMEM;
 }
 
 static int acpi_video_device_remove_fs(struct acpi_device *device)
 {
 	struct acpi_video_device *vid_dev;
+	struct proc_dir_entry *device_dir;
 
 	vid_dev = acpi_driver_data(device);
 	if (!vid_dev || !vid_dev->video || !vid_dev->video->dir)
 		return -ENODEV;
 
-	if (acpi_device_dir(device)) {
-		remove_proc_entry("info", acpi_device_dir(device));
-		remove_proc_entry("state", acpi_device_dir(device));
-		remove_proc_entry("brightness", acpi_device_dir(device));
-		remove_proc_entry("EDID", acpi_device_dir(device));
+	device_dir = acpi_device_dir(device);
+	if (device_dir) {
+		remove_proc_entry("info", device_dir);
+		remove_proc_entry("state", device_dir);
+		remove_proc_entry("brightness", device_dir);
+		remove_proc_entry("EDID", device_dir);
 		remove_proc_entry(acpi_device_bid(device), vid_dev->video->dir);
 		acpi_device_dir(device) = NULL;
 	}
@@ -1254,94 +1257,91 @@ acpi_video_bus_write_DOS(struct file *file,
 
 static int acpi_video_bus_add_fs(struct acpi_device *device)
 {
-	struct proc_dir_entry *entry = NULL;
-	struct acpi_video_bus *video;
+	struct acpi_video_bus *video = acpi_driver_data(device);
+	struct proc_dir_entry *device_dir;
+	struct proc_dir_entry *entry;
 
+	device_dir = proc_mkdir(acpi_device_bid(device), acpi_video_dir);
+	if (!device_dir)
+		return -ENOMEM;
 
-	video = acpi_driver_data(device);
-
-	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
-						     acpi_video_dir);
-		if (!acpi_device_dir(device))
-			return -ENODEV;
-		video->dir = acpi_device_dir(device);
-		acpi_device_dir(device)->owner = THIS_MODULE;
-	}
+	device_dir->owner = THIS_MODULE;
 
 	/* 'info' [R] */
-	entry = create_proc_entry("info", S_IRUGO, acpi_device_dir(device));
+	entry = create_proc_entry("info", S_IRUGO, device_dir);
 	if (!entry)
-		return -ENODEV;
-	else {
-		entry->proc_fops = &acpi_video_bus_info_fops;
-		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
-	}
+		goto err_remove_dir;
+
+	entry->proc_fops = &acpi_video_bus_info_fops;
+	entry->data = acpi_driver_data(device);
+	entry->owner = THIS_MODULE;
 
 	/* 'ROM' [R] */
-	entry = create_proc_entry("ROM", S_IRUGO, acpi_device_dir(device));
+	entry = create_proc_entry("ROM", S_IRUGO, device_dir);
 	if (!entry)
-		return -ENODEV;
-	else {
-		entry->proc_fops = &acpi_video_bus_ROM_fops;
-		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
-	}
+		goto err_remove_info;
+
+	entry->proc_fops = &acpi_video_bus_ROM_fops;
+	entry->data = acpi_driver_data(device);
+	entry->owner = THIS_MODULE;
 
 	/* 'POST_info' [R] */
-	entry =
-	    create_proc_entry("POST_info", S_IRUGO, acpi_device_dir(device));
+	entry = create_proc_entry("POST_info", S_IRUGO, device_dir);
 	if (!entry)
-		return -ENODEV;
-	else {
-		entry->proc_fops = &acpi_video_bus_POST_info_fops;
-		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
-	}
+		goto err_remove_rom;
+
+	entry->proc_fops = &acpi_video_bus_POST_info_fops;
+	entry->data = acpi_driver_data(device);
+	entry->owner = THIS_MODULE;
 
 	/* 'POST' [R/W] */
-	entry =
-	    create_proc_entry("POST", S_IFREG | S_IRUGO | S_IRUSR,
-			      acpi_device_dir(device));
+	entry = create_proc_entry("POST", S_IFREG | S_IRUGO | S_IRUSR,
+				  device_dir);
 	if (!entry)
-		return -ENODEV;
-	else {
-		acpi_video_bus_POST_fops.write = acpi_video_bus_write_POST;
-		entry->proc_fops = &acpi_video_bus_POST_fops;
-		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
-	}
+		goto err_remove_post_info;
+
+	acpi_video_bus_POST_fops.write = acpi_video_bus_write_POST;
+	entry->proc_fops = &acpi_video_bus_POST_fops;
+	entry->data = acpi_driver_data(device);
+	entry->owner = THIS_MODULE;
 
 	/* 'DOS' [R/W] */
-	entry =
-	    create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IRUSR,
-			      acpi_device_dir(device));
+	entry = create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IRUSR,
+			      device_dir);
 	if (!entry)
-		return -ENODEV;
-	else {
-		acpi_video_bus_DOS_fops.write = acpi_video_bus_write_DOS;
-		entry->proc_fops = &acpi_video_bus_DOS_fops;
-		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
-	}
+		goto err_remove_post;
 
+	acpi_video_bus_DOS_fops.write = acpi_video_bus_write_DOS;
+	entry->proc_fops = &acpi_video_bus_DOS_fops;
+	entry->data = acpi_driver_data(device);
+	entry->owner = THIS_MODULE;
+
+	video->dir = acpi_device_dir(device) = device_dir;
 	return 0;
+
+ err_remove_post:
+	remove_proc_entry("POST", device_dir);
+ err_remove_post_info:
+	remove_proc_entry("POST_info", device_dir);
+ err_remove_rom:
+	remove_proc_entry("ROM", device_dir);
+ err_remove_info:
+	remove_proc_entry("info", device_dir);
+ err_remove_dir:
+	remove_proc_entry(acpi_device_bid(device), acpi_video_dir);
+	return -ENOMEM;
 }
 
 static int acpi_video_bus_remove_fs(struct acpi_device *device)
 {
-	struct acpi_video_bus *video;
-
-
-	video = acpi_driver_data(device);
-
-	if (acpi_device_dir(device)) {
-		remove_proc_entry("info", acpi_device_dir(device));
-		remove_proc_entry("ROM", acpi_device_dir(device));
-		remove_proc_entry("POST_info", acpi_device_dir(device));
-		remove_proc_entry("POST", acpi_device_dir(device));
-		remove_proc_entry("DOS", acpi_device_dir(device));
+	struct proc_dir_entry *device_dir = acpi_device_dir(device);
+
+	if (device_dir) {
+		remove_proc_entry("info", device_dir);
+		remove_proc_entry("ROM", device_dir);
+		remove_proc_entry("POST_info", device_dir);
+		remove_proc_entry("POST", device_dir);
+		remove_proc_entry("DOS", device_dir);
 		remove_proc_entry(acpi_device_bid(device), acpi_video_dir);
 		acpi_device_dir(device) = NULL;
 	}
-- 
1.5.4.2.184.gb23b

