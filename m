From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH v2] ACPI video: poke display on lid open
Date: Sun, 17 Jun 2007 00:08:33 -0400
Message-ID: <200706170008.34157.dtor@insightbb.com>
References: <20070617000321.37F407B409F@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:31602 "EHLO
	asav14.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbXFQEIg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Jun 2007 00:08:36 -0400
In-Reply-To: <20070617000321.37F407B409F@zog.reactivated.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

Hi Daniel,

On Saturday 16 June 2007 20:03, Daniel Drake wrote:
> Many Dell laptops have the DSDT coded to power down the display when the lid
> is closed, and leave it off when it is opened.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=5155
> 
> Based on ideas from Len Brown and Dmitry Torokhov, this patch creates an input
> handler in the video driver which monitors for lid input events. When a lid
> open event is detected, the video driver reactivates the LCD.
> 

Appears to be working on my Inspiron 8100. Couple of comments:

> +
> +static int lid_connect(struct input_handler *handler, struct input_dev *dev,
> +		       const struct input_device_id *id)
> +{
> +	struct acpi_video_bus *video = handler->private;
> +	int r;
> +
> +	if (dev->id.product != ACPI_BUTTON_TYPE_LID ||
> +	    strcmp(dev->name, ACPI_BUTTON_DEVICE_NAME_LID) != 0)
> +		return -ENODEV;
> +
> +	if (video->lid_handle != NULL) {
> +		printk(KERN_ERR PREFIX "trying to bind to multiple lids?\n");
> +		return -ENODEV;

If we do not support multiple LIDs -EBUSY would be a better error code.

> +	}
> +
> +	video->lid_handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
> +	if (!video->lid_handle)
> +		return -ENOMEM;
> +	video->lid_handle->dev = dev;
> +	video->lid_handle->handler = handler;
> +	video->lid_handle->private = video;

Need to setup handler->name, otherwise "cat /proc/bus/input/devices" looks
"interesting".

> +
> +static void lid_event(struct input_handle *handle, unsigned int type,
> +		      unsigned int code, int value)
> +{
> +	struct acpi_video_device *dev, *tmp;
> +	struct acpi_video_bus *video = handle->private;
> +
> +	if (type != EV_SW || value != 0)
> +		return;
> +
> +	list_for_each_entry_safe(dev, tmp, &video->video_device_list, entry) {

Safe from what? I don't see anything altering list state in the body
of this loop. Where's list locking? Also, once input core locking is
in place handler_>event will be called under a spinlock with interrupts
off. Can acpi_video_device_set_state be used in this case? 

Below is a small cleanup patch you may want to fold into yours.

But I guess more important question if this is a good solution overall.
My box already generates video bus events when I close and open the lid
so maybe video.c should just call acpi_video__device_set_state() from
acpi_video_bus_notify()?

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/video.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

Index: work/drivers/acpi/video.c
===================================================================
--- work.orig/drivers/acpi/video.c
+++ work/drivers/acpi/video.c
@@ -1737,6 +1737,7 @@ static int lid_connect(struct input_hand
 		       const struct input_device_id *id)
 {
 	struct acpi_video_bus *video = handler->private;
+	struct input_handle *lid_handle;
 	int r;
 
 	if (dev->id.product != ACPI_BUTTON_TYPE_LID ||
@@ -1748,18 +1749,22 @@ static int lid_connect(struct input_hand
 		return -ENODEV;
 	}
 
-	video->lid_handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
-	if (!video->lid_handle)
+	lid_handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
+	if (!lid_handle)
 		return -ENOMEM;
-	video->lid_handle->dev = dev;
-	video->lid_handle->handler = handler;
-	video->lid_handle->private = video;
 
-	r = input_register_handle(video->lid_handle);
+	video->lid_handle = lid_handle;
+
+	lid_handle->dev = dev;
+	lid_handle->handler = handler;
+	lid_handle->name = "acpi-video";
+	lid_handle->private = video;
+
+	r = input_register_handle(lid_handle);
 	if (r)
 		goto err;
 
-	r = input_open_device(video->lid_handle);
+	r = input_open_device(lid_handle);
 	if (r)
 		goto err_unregister;
 
@@ -1777,9 +1782,10 @@ err:
 static void lid_disconnect(struct input_handle *handle)
 {
 	struct acpi_video_bus *video = handle->private;
-	input_unregister_handle(handle);
+
 	input_close_device(handle);
-	kfree(video->lid_handle);
+	input_unregister_handle(handle);
+	kfree(handle);
 	video->lid_handle = NULL;
 }
 
