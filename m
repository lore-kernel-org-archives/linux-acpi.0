From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] ACPI: poke display on lid open
Date: Fri,  1 Jun 2007 04:06:56 +0100 (BST)
Message-ID: <20070601030657.2E9F37B409F@zog.reactivated.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from queue04-winn.ispmail.ntl.com ([81.103.221.58]:54171 "EHLO
	queue04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752742AbXFADZf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 May 2007 23:25:35 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20070601030658.OSCO4.mtaout02-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>
          for <linux-acpi@vger.kernel.org>; Fri, 1 Jun 2007 04:06:58 +0100
Received: from zog.reactivated.net ([86.14.211.88])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20070601030658.BCFG219.aamtaout01-winn.ispmail.ntl.com@zog.reactivated.net>
          for <linux-acpi@vger.kernel.org>; Fri, 1 Jun 2007 04:06:58 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Many Dell laptops have the DSDT coded to power down the display when the lid
is closed, and leave it off when it is opened.

http://bugzilla.kernel.org/show_bug.cgi?id=5155

Based on ideas from Len Brown, this patch creates an internal event so
that the button driver can notify the video driver when the lid has been
opened. The video driver then reactivates the LCD.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

---

After all 3 of these patches, my Dell laptop display is correctly powered back
up when I open the lid, without any userspace or DSDT hacks. Is the ievent
idea acceptable or does it clutter things too much?

Index: linux/drivers/acpi/button.c
===================================================================
--- linux.orig/drivers/acpi/button.c
+++ linux/drivers/acpi/button.c
@@ -259,10 +259,15 @@ static void acpi_button_notify(acpi_hand
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
 			struct acpi_handle *handle = button->device->handle;
 			unsigned long state;
+			acpi_status status;
 
-			if (!ACPI_FAILURE(acpi_evaluate_integer(handle, "_LID",
-								NULL, &state)))
+			status = acpi_evaluate_integer(handle, "_LID", NULL,
+						       &state);
+
+			if (!ACPI_FAILURE(status)) {
+				acpi_ievent_notify(ACPI_IEVENT_LID, &state);
 				input_report_switch(input, SW_LID, !state);
+			}
 
 		} else {
 			int keycode = test_bit(KEY_SLEEP, input->keybit) ?
Index: linux/drivers/acpi/video.c
===================================================================
--- linux.orig/drivers/acpi/video.c
+++ linux/drivers/acpi/video.c
@@ -131,6 +131,7 @@ struct acpi_video_bus {
 	struct semaphore sem;
 	struct list_head video_device_list;
 	struct proc_dir_entry *dir;
+	struct acpi_ievent_handle *lid_event;
 };
 
 struct acpi_video_device_flags {
@@ -1730,6 +1731,29 @@ static int acpi_video_bus_stop_devices(s
 	return acpi_video_bus_DOS(video, 0, 1);
 }
 
+/* Upon lid open event, poke DSS to wake up display. Needed for many Dell
+ * laptops. */
+static void acpi_video_lid_event(enum acpi_ievent_code event, void *event_data,
+				 void *user_data)
+{
+	struct acpi_video_bus *video = user_data;
+	struct acpi_video_device *dev, *tmp;
+	unsigned long state = *((unsigned long *) event_data);
+
+	if (!state)
+		return;
+
+	list_for_each_entry_safe(dev, tmp, &video->video_device_list, entry) {
+		if (!dev->flags.lcd)
+			continue;
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Waking up %s.%s on lid event\n",
+				  acpi_device_bid(video->device),
+				  acpi_device_bid(dev->dev)));
+		acpi_video_device_set_state(dev, 0x80000001);
+	}
+}
+
 static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_video_bus *video = data;
@@ -1825,11 +1849,11 @@ static int acpi_video_bus_add(struct acp
 	acpi_video_bus_find_cap(video);
 	result = acpi_video_bus_check(video);
 	if (result)
-		goto end;
+		goto out;
 
 	result = acpi_video_bus_add_fs(device);
 	if (result)
-		goto end;
+		goto out;
 
 	init_MUTEX(&video->sem);
 	INIT_LIST_HEAD(&video->video_device_list);
@@ -1843,12 +1867,17 @@ static int acpi_video_bus_add(struct acp
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Error installing notify handler\n"));
-		acpi_video_bus_stop_devices(video);
-		acpi_video_bus_put_devices(video);
-		kfree(video->attached_array);
-		acpi_video_bus_remove_fs(device);
 		result = -ENODEV;
-		goto end;
+		goto out_stop;
+	}
+
+	video->lid_event = acpi_install_ievent_handler(ACPI_IEVENT_LID,
+		acpi_video_lid_event, video);
+	if (!video->lid_event) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error installing lid handler\n"));
+		result = -ENODEV;
+		goto out_remove_notify;
 	}
 
 	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
@@ -1856,11 +1885,19 @@ static int acpi_video_bus_add(struct acp
 	       video->flags.multihead ? "yes" : "no",
 	       video->flags.rom ? "yes" : "no",
 	       video->flags.post ? "yes" : "no");
+	return result;
 
-      end:
+out_remove_notify:
+	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_video_bus_notify);
+out_stop:
+	acpi_video_bus_stop_devices(video);
+	acpi_video_bus_put_devices(video);
+	kfree(video->attached_array);
+	acpi_video_bus_remove_fs(device);
+out:
 	if (result)
 		kfree(video);
-
 	return result;
 }
 
@@ -1877,6 +1914,7 @@ static int acpi_video_bus_remove(struct 
 
 	acpi_video_bus_stop_devices(video);
 
+	acpi_remove_ievent_handler(video->lid_event);
 	status = acpi_remove_notify_handler(video->device->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_bus_notify);
