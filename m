From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH v2] ACPI video: poke display on lid open
Date: Sun, 17 Jun 2007 01:03:20 +0100 (BST)
Message-ID: <20070617000321.37F407B409F@zog.reactivated.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:23625 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754364AbXFQADT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Jun 2007 20:03:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: dtor@insightbb.com, linux-acpi@vger.kernel.org

Many Dell laptops have the DSDT coded to power down the display when the lid
is closed, and leave it off when it is opened.

http://bugzilla.kernel.org/show_bug.cgi?id=5155

Based on ideas from Len Brown and Dmitry Torokhov, this patch creates an input
handler in the video driver which monitors for lid input events. When a lid
open event is detected, the video driver reactivates the LCD.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/drivers/acpi/button.c
===================================================================
--- linux.orig/drivers/acpi/button.c
+++ linux/drivers/acpi/button.c
@@ -56,8 +56,6 @@
 
 #define ACPI_BUTTON_SUBCLASS_LID	"lid"
 #define ACPI_BUTTON_HID_LID		"PNP0C0D"
-#define ACPI_BUTTON_DEVICE_NAME_LID	"Lid Switch"
-#define ACPI_BUTTON_TYPE_LID		0x05
 
 #define _COMPONENT		ACPI_BUTTON_COMPONENT
 ACPI_MODULE_NAME("button");
Index: linux/drivers/acpi/video.c
===================================================================
--- linux.orig/drivers/acpi/video.c
+++ linux/drivers/acpi/video.c
@@ -31,6 +31,7 @@
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/input.h>
 
 #include <linux/backlight.h>
 #include <asm/uaccess.h>
@@ -131,6 +132,8 @@ struct acpi_video_bus {
 	struct semaphore sem;
 	struct list_head video_device_list;
 	struct proc_dir_entry *dir;
+	struct input_handler lid_handler;
+	struct input_handle *lid_handle;
 };
 
 struct acpi_video_device_flags {
@@ -1718,6 +1721,88 @@ static int acpi_video_bus_put_devices(st
 	return 0;
 }
 
+/* lid input monitoring */
+
+static const struct input_device_id lid_ids[] = {
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+		         INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT(EV_SW) },
+		.swbit = { BIT(SW_LID) },
+	},
+	{ }, /* terminating entry */
+};
+
+static int lid_connect(struct input_handler *handler, struct input_dev *dev,
+		       const struct input_device_id *id)
+{
+	struct acpi_video_bus *video = handler->private;
+	int r;
+
+	if (dev->id.product != ACPI_BUTTON_TYPE_LID ||
+	    strcmp(dev->name, ACPI_BUTTON_DEVICE_NAME_LID) != 0)
+		return -ENODEV;
+
+	if (video->lid_handle != NULL) {
+		printk(KERN_ERR PREFIX "trying to bind to multiple lids?\n");
+		return -ENODEV;
+	}
+
+	video->lid_handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
+	if (!video->lid_handle)
+		return -ENOMEM;
+	video->lid_handle->dev = dev;
+	video->lid_handle->handler = handler;
+	video->lid_handle->private = video;
+
+	r = input_register_handle(video->lid_handle);
+	if (r)
+		goto err;
+
+	r = input_open_device(video->lid_handle);
+	if (r)
+		goto err_unregister;
+
+	printk(KERN_INFO PREFIX "connected %s to lid switch\n",
+	       acpi_device_bid(video->device));
+	return 0;
+
+err_unregister:
+	input_unregister_handle(video->lid_handle);
+err:
+	kfree(video->lid_handle);
+	return r;
+}
+
+static void lid_disconnect(struct input_handle *handle)
+{
+	struct acpi_video_bus *video = handle->private;
+	input_unregister_handle(handle);
+	input_close_device(handle);
+	kfree(video->lid_handle);
+	video->lid_handle = NULL;
+}
+
+static void lid_event(struct input_handle *handle, unsigned int type,
+		      unsigned int code, int value)
+{
+	struct acpi_video_device *dev, *tmp;
+	struct acpi_video_bus *video = handle->private;
+
+	if (type != EV_SW || value != 0)
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
 /* acpi_video interface */
 
 static int acpi_video_bus_start_devices(struct acpi_video_bus *video)
@@ -1808,7 +1893,9 @@ static int acpi_video_bus_add(struct acp
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_video_bus *video = NULL;
-
+	char *name;
+	char *bid = acpi_device_bid(device);
+	int namelen;
 
 	if (!device)
 		return -EINVAL;
@@ -1825,11 +1912,11 @@ static int acpi_video_bus_add(struct acp
 	acpi_video_bus_find_cap(video);
 	result = acpi_video_bus_check(video);
 	if (result)
-		goto end;
+		goto err;
 
 	result = acpi_video_bus_add_fs(device);
 	if (result)
-		goto end;
+		goto err;
 
 	init_MUTEX(&video->sem);
 	INIT_LIST_HEAD(&video->video_device_list);
@@ -1843,24 +1930,49 @@ static int acpi_video_bus_add(struct acp
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Error installing notify handler\n"));
-		acpi_video_bus_stop_devices(video);
-		acpi_video_bus_put_devices(video);
-		kfree(video->attached_array);
-		acpi_video_bus_remove_fs(device);
 		result = -ENODEV;
-		goto end;
+		goto err_stop;
+	}
+
+	namelen = 10 + strlen(bid);
+	name = kmalloc(namelen, GFP_KERNEL);
+	if (!name) {
+		result = -ENOMEM;
+		goto err_remove_notify;
+	}
+	snprintf(name, namelen, "ACPI-%s-LID", bid);
+
+	video->lid_handler.event = lid_event;
+	video->lid_handler.connect = lid_connect;
+	video->lid_handler.disconnect = lid_disconnect;
+	video->lid_handler.name = name;
+	video->lid_handler.id_table = lid_ids;
+	video->lid_handler.private = video;
+
+	result = input_register_handler(&video->lid_handler);
+	if (result) {
+		result = -ENODEV;
+		goto err_remove_notify;
 	}
 
 	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
-	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
+	       ACPI_VIDEO_DEVICE_NAME, bid,
 	       video->flags.multihead ? "yes" : "no",
 	       video->flags.rom ? "yes" : "no",
 	       video->flags.post ? "yes" : "no");
 
-      end:
-	if (result)
-		kfree(video);
+	return result;
 
+err_remove_notify:
+	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_video_bus_notify);
+err_stop:
+	acpi_video_bus_stop_devices(video);
+	acpi_video_bus_put_devices(video);
+	kfree(video->attached_array);
+	acpi_video_bus_remove_fs(device);
+err:
+	kfree(video);
 	return result;
 }
 
@@ -1875,6 +1987,9 @@ static int acpi_video_bus_remove(struct 
 
 	video = acpi_driver_data(device);
 
+	input_unregister_handler(&video->lid_handler);
+	kfree(video->lid_handler.name);
+
 	acpi_video_bus_stop_devices(video);
 
 	status = acpi_remove_notify_handler(video->device->handle,
Index: linux/include/acpi/acpi_drivers.h
===================================================================
--- linux.orig/include/acpi/acpi_drivers.h
+++ linux/include/acpi/acpi_drivers.h
@@ -140,6 +140,14 @@ static inline void unregister_hotplug_do
 #endif
 
 /*--------------------------------------------------------------------------
+                                  Button
+  -------------------------------------------------------------------------- */
+
+/* definitions shared between button and video drivers */
+#define ACPI_BUTTON_DEVICE_NAME_LID	"Lid Switch"
+#define ACPI_BUTTON_TYPE_LID		0x05
+
+/*--------------------------------------------------------------------------
                                   Suspend/Resume
   -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_SLEEP
Index: linux/drivers/acpi/Kconfig
===================================================================
--- linux.orig/drivers/acpi/Kconfig
+++ linux/drivers/acpi/Kconfig
@@ -124,13 +124,13 @@ config ACPI_BUTTON
 
 config ACPI_VIDEO
 	tristate "Video"
-	depends on X86 && BACKLIGHT_CLASS_DEVICE
+	depends on X86 && BACKLIGHT_CLASS_DEVICE && INPUT
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
 	  ACPI 2.0 Specification, Appendix B, allowing to perform some basic
-	  control like defining the video POST device, retrieving EDID information
-	  or to setup a video output, etc.
+	  control like defining the video POST device, retrieving EDID
+	  information or to setup a video output, etc.
 	  Note that this is an ref. implementation only.  It may or may not work
 	  for your integrated video device.
 
