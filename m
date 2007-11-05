From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [patch 4/8] ACPI: video - convert semaphore to a mutex
Date: Mon, 05 Nov 2007 11:43:32 -0500
Message-ID: <20071105165012.066394463@anvil.corenet.prv>
References: <20071105164328.982283020@anvil.corenet.prv>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:16271 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbXKEQwj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Nov 2007 11:52:39 -0500
Received: by an-out-0708.google.com with SMTP id b36so195171ana
        for <linux-acpi@vger.kernel.org>; Mon, 05 Nov 2007 08:52:37 -0800 (PST)
Content-Disposition: inline; filename=acpi-video-sem-to-mutex.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rui Zhang <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

ACPI: video - convert semaphore to a mutex

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/acpi/video.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

Index: work/drivers/acpi/video.c
===================================================================
--- work.orig/drivers/acpi/video.c
+++ work/drivers/acpi/video.c
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/input.h>
@@ -135,8 +136,8 @@ struct acpi_video_bus {
 	u8 attached_count;
 	struct acpi_video_bus_cap cap;
 	struct acpi_video_bus_flags flags;
-	struct semaphore sem;
 	struct list_head video_device_list;
+	struct mutex device_list_lock;	/* protects video_device_list */
 	struct proc_dir_entry *dir;
 	struct input_dev *input;
 	char phys[32];	/* for input device */
@@ -1436,9 +1437,9 @@ acpi_video_bus_get_one_device(struct acp
 			return -ENODEV;
 		}
 
-		down(&video->sem);
+		mutex_lock(&video->device_list_lock);
 		list_add_tail(&data->entry, &video->video_device_list);
-		up(&video->sem);
+		mutex_unlock(&video->device_list_lock);
 
 		acpi_video_device_add_fs(device);
 
@@ -1464,12 +1465,12 @@ static void acpi_video_device_rebind(str
 {
 	struct acpi_video_device *dev;
 
-	down(&video->sem);
+	mutex_lock(&video->device_list_lock);
 
 	list_for_each_entry(dev, &video->video_device_list, entry)
 		acpi_video_device_bind(video, dev);
 
-	up(&video->sem);
+	mutex_unlock(&video->device_list_lock);
 }
 
 /*
@@ -1601,7 +1602,7 @@ static int acpi_video_switch_output(stru
 	unsigned long state;
 	int status = 0;
 
-	down(&video->sem);
+	mutex_lock(&video->device_list_lock);
 
 	list_for_each(node, &video->video_device_list) {
 		dev = container_of(node, struct acpi_video_device, entry);
@@ -1619,7 +1620,7 @@ static int acpi_video_switch_output(stru
 	dev_prev = container_of(node->prev, struct acpi_video_device, entry);
 
  out:
-	up(&video->sem);
+	mutex_unlock(&video->device_list_lock);
 
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_CYCLE:
@@ -1738,7 +1739,7 @@ static int acpi_video_bus_put_devices(st
 	int status;
 	struct acpi_video_device *dev, *next;
 
-	down(&video->sem);
+	mutex_lock(&video->device_list_lock);
 
 	list_for_each_entry_safe(dev, next, &video->video_device_list, entry) {
 
@@ -1755,7 +1756,7 @@ static int acpi_video_bus_put_devices(st
 		kfree(dev);
 	}
 
-	up(&video->sem);
+	mutex_unlock(&video->device_list_lock);
 
 	return 0;
 }
@@ -1924,7 +1925,7 @@ static int acpi_video_bus_add(struct acp
 	if (error)
 		goto err_free_video;
 
-	init_MUTEX(&video->sem);
+	mutex_init(&video->device_list_lock);
 	INIT_LIST_HEAD(&video->video_device_list);
 
 	acpi_video_bus_get_devices(video, device);

-- 
Dmitry

