From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch 3/8] ACPI: video - remove unsafe uses of
	list_for_each_safe()
Date: Wed, 14 Nov 2007 15:17:53 +0800
Message-ID: <1195024673.1262.44.camel@acpi-hp.sh.intel.com>
References: <20071105164328.982283020@anvil.corenet.prv>
	 <20071105165011.953107289@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26413 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757110AbXKNHIF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 02:08:05 -0500
In-Reply-To: <20071105165011.953107289@anvil.corenet.prv>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2007-11-06 at 00:43 +0800, Dmitry Torokhov wrote:
> ACPI: video - remove unsafe uses of list_for_each_safe()
> 
> list_for_each_safe() only protects list from list alterations
> performed by the same thread. One still needs to implement
> proper locking when list is being accessed from several threads.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |   71
> ++++++++++++++++++++++++---------------------------
>  1 file changed, 34 insertions(+), 37 deletions(-)
> 
> Index: work/drivers/acpi/video.c
> ===================================================================
> --- work.orig/drivers/acpi/video.c
> +++ work/drivers/acpi/video.c
> @@ -1462,12 +1462,14 @@ acpi_video_bus_get_one_device(struct acp
> 
>  static void acpi_video_device_rebind(struct acpi_video_bus *video)
>  {
> -       struct list_head *node, *next;
> -       list_for_each_safe(node, next, &video->video_device_list) {
> -               struct acpi_video_device *dev =
> -                   container_of(node, struct acpi_video_device,
> entry);
> +       struct acpi_video_device *dev;
> +
> +       down(&video->sem);
> +
> +       list_for_each_entry(dev, &video->video_device_list, entry)
>                 acpi_video_device_bind(video, dev);
> -       }
> +
> +       up(&video->sem);
>  }
> 
>  /*
> @@ -1592,30 +1594,33 @@ static int acpi_video_device_enumerate(s
> 
>  static int acpi_video_switch_output(struct acpi_video_bus *video, int
> event)
>  {
> -       struct list_head *node, *next;
> +       struct list_head *node;
>         struct acpi_video_device *dev = NULL;
>         struct acpi_video_device *dev_next = NULL;
>         struct acpi_video_device *dev_prev = NULL;
>         unsigned long state;
>         int status = 0;
> 
> +       down(&video->sem);
> 
> -       list_for_each_safe(node, next, &video->video_device_list) {
> +       list_for_each(node, &video->video_device_list) {
>                 dev = container_of(node, struct acpi_video_device,
> entry);
>                 status = acpi_video_device_get_state(dev, &state);
>                 if (state & 0x2) {
> -                       dev_next =
> -                           container_of(node->next, struct
> acpi_video_device,
> -                                        entry);
> -                       dev_prev =
> -                           container_of(node->prev, struct
> acpi_video_device,
> -                                        entry);
> +                       dev_next = container_of(node->next,
> +                                       struct acpi_video_device,
> entry);
> +                       dev_prev = container_of(node->prev,
> +                                       struct acpi_video_device,
> entry);
>                         goto out;
>                 }
>         }
> +
>         dev_next = container_of(node->next, struct acpi_video_device,
> entry);
>         dev_prev = container_of(node->prev, struct acpi_video_device,
> entry);
> -      out:
> +
> + out:
> +       up(&video->sem);
> +
>         switch (event) {
>         case ACPI_VIDEO_NOTIFY_CYCLE:
>         case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:
> @@ -1691,24 +1696,17 @@ acpi_video_bus_get_devices(struct acpi_v
>                            struct acpi_device *device)
>  {
>         int status = 0;
> -       struct list_head *node, *next;
> -
> +       struct acpi_device *dev;
> 
>         acpi_video_device_enumerate(video);
> 
> -       list_for_each_safe(node, next, &device->children) {
> -               struct acpi_device *dev =
> -                   list_entry(node, struct acpi_device, node);
> -
> -               if (!dev)
> -                       continue;
> +       list_for_each_entry(dev, &device->children, node) {
> 
>                 status = acpi_video_bus_get_one_device(dev, video);
>                 if (ACPI_FAILURE(status)) {
>                         ACPI_EXCEPTION((AE_INFO, status, "Cant attach
> device"));
>                         continue;
>                 }
> -
>         }
>         return status;
>  }
> @@ -1724,9 +1722,6 @@ static int acpi_video_bus_put_one_device
> 
>         video = device->video;
> 
> -       down(&video->sem);
> -       list_del(&device->entry);
> -       up(&video->sem);
>         acpi_video_device_remove_fs(device->dev);
> 
>         status = acpi_remove_notify_handler(device->dev->handle,
> @@ -1734,32 +1729,34 @@ static int acpi_video_bus_put_one_device
>                                             acpi_video_device_notify);
>         backlight_device_unregister(device->backlight);
>         video_output_unregister(device->output_dev);
> +
>         return 0;
>  }
> 
>  static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
>  {
>         int status;
> -       struct list_head *node, *next;
> +       struct acpi_video_device *dev, *next;
> 
> +       down(&video->sem);
> 
> -       list_for_each_safe(node, next, &video->video_device_list) {
> -               struct acpi_video_device *data =
> -                   list_entry(node, struct acpi_video_device, entry);
> -               if (!data)
> -                       continue;
> +       list_for_each_entry_safe(dev, next, &video->video_device_list,
> entry) {
> 
> -               status = acpi_video_bus_put_one_device(data);
> +               status = acpi_video_bus_put_one_device(dev);
>                 if (ACPI_FAILURE(status))
>                         printk(KERN_WARNING PREFIX
>                                "hhuuhhuu bug in acpi video
> driver.\n");
> 
> -               if (data->brightness)
> -                       kfree(data->brightness->levels);
> -               kfree(data->brightness);
> -               kfree(data);
> +               if (dev->brightness) {
> +                       kfree(dev->brightness->levels);
> +                       kfree(dev->brightness);
> +               }
> +               list_del(&dev->entry);
> +               kfree(dev);
>         }
> 
> +       up(&video->sem);
> +
>         return 0;
>  }
> 
> 
> --
> Dmitry
> 
> 
