From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 4/4] ACPI: video - cleanup video device registration
Date: Mon, 10 Aug 2009 10:11:05 +0800
Message-ID: <1249870265.2670.537.camel@rzhang-dt>
References: <20090808072150.2980.3863.stgit@localhost.localdomain>
	 <20090808075647.90344526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46546 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814AbZHJCL7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Aug 2009 22:11:59 -0400
In-Reply-To: <20090808075647.90344526EC9@mailhub.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 2009-08-08 at 15:26 +0800, Dmitry Torokhov wrote:
> Split sub-device (backlight, cooling, video output) registration into
> separate functions, ensure that failure in one would not affect others,
> don't crash when backlight registration fails.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/acpi/video.c |  418 +++++++++++++++++++++++++++-----------------------
>  1 files changed, 224 insertions(+), 194 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 5407e0b..bc5082b 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c

> @@ -1705,86 +1775,85 @@ acpi_video_get_device_attr(struct acpi_video_bus *video, unsigned long device_id
>         return NULL;
>  }
> 
> -static int
> -acpi_video_bus_get_one_device(struct acpi_device *device,
> -                             struct acpi_video_bus *video)
> +static int acpi_video_bus_add_device(struct acpi_device *device,
> +                                    unsigned long long device_id,
> +                                    struct acpi_video_bus *video)
>  {
> -       unsigned long long device_id;
> -       int status;
>         struct acpi_video_device *data;
>         struct acpi_video_device_attrib* attribute;
> +       int status;
> 
> -       if (!device || !video)
> -               return -EINVAL;
> -
> -       status =
> -           acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
> -       if (ACPI_SUCCESS(status)) {
> -
> -               data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
> -               if (!data)
> -                       return -ENOMEM;
> +       data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> 
> -               strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
> -               strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> -               device->driver_data = data;
> +       strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
> +       strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> +       device->driver_data = data;
> 
> -               data->device_id = device_id;
> -               data->video = video;
> -               data->dev = device;
> +       data->device_id = device_id;
> +       data->video = video;
> +       data->dev = device;
> 
> -               attribute = acpi_video_get_device_attr(video, device_id);
> +       attribute = acpi_video_get_device_attr(video, device_id);
> 
> -               if((attribute != NULL) && attribute->device_id_scheme) {
> -                       switch (attribute->display_type) {
> -                       case ACPI_VIDEO_DISPLAY_CRT:
> -                               data->flags.crt = 1;
> -                               break;
> -                       case ACPI_VIDEO_DISPLAY_TV:
> -                               data->flags.tvout = 1;
> -                               break;
> -                       case ACPI_VIDEO_DISPLAY_DVI:
> -                               data->flags.dvi = 1;
> -                               break;
> -                       case ACPI_VIDEO_DISPLAY_LCD:
> -                               data->flags.lcd = 1;
> -                               break;
> -                       default:
> -                               data->flags.unknown = 1;
> -                               break;
> -                       }
> -                       if(attribute->bios_can_detect)
> -                               data->flags.bios = 1;
> -               } else
> +       if (attribute && attribute->device_id_scheme) {
> +               switch (attribute->display_type) {
> +               case ACPI_VIDEO_DISPLAY_CRT:
> +                       data->flags.crt = 1;
> +                       break;
> +               case ACPI_VIDEO_DISPLAY_TV:
> +                       data->flags.tvout = 1;
> +                       break;
> +               case ACPI_VIDEO_DISPLAY_DVI:
> +                       data->flags.dvi = 1;
> +                       break;
> +               case ACPI_VIDEO_DISPLAY_LCD:
> +                       data->flags.lcd = 1;
> +                       break;
> +               default:
>                         data->flags.unknown = 1;
> +                       break;
> +               }
> +               if(attribute->bios_can_detect)
> +                       data->flags.bios = 1;
> +       } else
> +               data->flags.unknown = 1;
> 
> -               acpi_video_device_bind(video, data);
> -               acpi_video_device_find_cap(data);
> +       acpi_video_device_bind(video, data);
> +       acpi_video_device_find_cap(data);
> 
> -               status = acpi_install_notify_handler(device->handle,
> -                                                    ACPI_DEVICE_NOTIFY,
> -                                                    acpi_video_device_notify,
> -                                                    data);
> -               if (ACPI_FAILURE(status)) {
> -                       printk(KERN_ERR PREFIX
> -                                         "Error installing notify handler\n");
> -                       if(data->brightness)
> -                               kfree(data->brightness->levels);
> -                       kfree(data->brightness);
> -                       kfree(data);
> -                       return -ENODEV;
> -               }
> +       if (acpi_video_backlight_support()) {
> +               acpi_video_init_brightness(data);
> +               acpi_video_device_add_backlight(data);
> +               acpi_video_device_add_cooling_dev(data);

we should check the return value of acpi_video_init_brightness first.
No backlight device or thermal cooling device if the video device
doesn't support backlight control well.

Both patch 02 and patch 04 look okay to me.

thanks,
rui

> +       }
> 
> -               mutex_lock(&video->device_list_lock);
> -               list_add_tail(&data->entry, &video->video_device_list);
> -               mutex_unlock(&video->device_list_lock);
> +       if (acpi_video_display_switch_support())
> +               acpi_video_device_add_output_dev(data);
> 
> -               acpi_video_device_add_fs(device);
> +       status = acpi_install_notify_handler(device->handle,
> +                                            ACPI_DEVICE_NOTIFY,
> +                                            acpi_video_device_notify,
> +                                            data);
> +       if (ACPI_FAILURE(status)) {
> +               printk(KERN_ERR PREFIX "Error installing notify handler\n");
> 
> -               return 0;
> +               acpi_video_device_remove_output_dev(data);
> +               acpi_video_device_remove_cooling_dev(data);
> +               acpi_video_device_remove_backlight(data);
> +               acpi_video_free_brightness_data(data);
> +               kfree(data);
> +               return -ENODEV;
>         }
> 
> -       return -ENOENT;
> +       acpi_video_device_add_fs(device);
> +
> +       mutex_lock(&video->device_list_lock);
> +       list_add_tail(&data->entry, &video->video_device_list);
> +       mutex_unlock(&video->device_list_lock);
> +
> +       return 0;
>  }
> 
>  /*
> @@ -1982,88 +2051,51 @@ out:
>         return result;
>  }
> 
> -static int
> +static void
>  acpi_video_bus_get_devices(struct acpi_video_bus *video,
>                            struct acpi_device *device)
>  {
> -       int status = 0;
>         struct acpi_device *dev;
> +       unsigned long long device_id;
> +       int status;
> 
>         acpi_video_device_enumerate(video);
> 
>         list_for_each_entry(dev, &device->children, node) {
> -
> -               status = acpi_video_bus_get_one_device(dev, video);
> -               if (ACPI_FAILURE(status)) {
> -                       printk(KERN_WARNING PREFIX
> -                                       "Cant attach device");
> -                       continue;
> -               }
> +               status = acpi_evaluate_integer(device->handle, "_ADR", NULL,
> +                                       &device_id);
> +               if (ACPI_SUCCESS(status))
> +                       acpi_video_bus_add_device(dev, device_id, video);
>         }
> -       return status;
>  }
> 
> -static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
> +static void acpi_video_bus_remove_device(struct acpi_video_device *device)
>  {
> -       acpi_status status;
> -       struct acpi_video_bus *video;
> -
> -
> -       if (!device || !device->video)
> -               return -ENOENT;
> -
> -       video = device->video;
> +       list_del(&device->entry);
> 
>         acpi_video_device_remove_fs(device->dev);
> 
> -       status = acpi_remove_notify_handler(device->dev->handle,
> -                                           ACPI_DEVICE_NOTIFY,
> -                                           acpi_video_device_notify);
> +       acpi_remove_notify_handler(device->dev->handle,
> +                               ACPI_DEVICE_NOTIFY, acpi_video_device_notify);
> 
> -       if (device->backlight) {
> -               sysfs_remove_link(&device->backlight->dev.kobj, "device");
> -               backlight_device_unregister(device->backlight);
> -       }
> +       acpi_video_device_remove_output_dev(device);
> +       acpi_video_device_remove_cooling_dev(device);
> +       acpi_video_device_remove_backlight(device);
> +       acpi_video_free_brightness_data(device);
> 
> -       if (device->cooling_dev) {
> -               sysfs_remove_link(&device->dev->dev.kobj,
> -                                 "thermal_cooling");
> -               sysfs_remove_link(&device->cooling_dev->device.kobj,
> -                                 "device");
> -               thermal_cooling_device_unregister(device->cooling_dev);
> -               device->cooling_dev = NULL;
> -       }
> -
> -       video_output_unregister(device->output_dev);
> -
> -       return 0;
> +       kfree(device);
>  }
> 
> -static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
> +static void acpi_video_bus_put_devices(struct acpi_video_bus *video)
>  {
> -       int status;
>         struct acpi_video_device *dev, *next;
> 
>         mutex_lock(&video->device_list_lock);
> 
> -       list_for_each_entry_safe(dev, next, &video->video_device_list, entry) {
> -
> -               status = acpi_video_bus_put_one_device(dev);
> -               if (ACPI_FAILURE(status))
> -                       printk(KERN_WARNING PREFIX
> -                              "hhuuhhuu bug in acpi video driver.\n");
> -
> -               if (dev->brightness) {
> -                       kfree(dev->brightness->levels);
> -                       kfree(dev->brightness);
> -               }
> -               list_del(&dev->entry);
> -               kfree(dev);
> -       }
> +       list_for_each_entry_safe(dev, next, &video->video_device_list, entry)
> +               acpi_video_bus_remove_device(dev);
> 
>         mutex_unlock(&video->device_list_lock);
> -
> -       return 0;
>  }
> 
>  /* acpi_video interface */
> @@ -2129,8 +2161,6 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
>         input_sync(input);
>         input_report_key(input, keycode, 0);
>         input_sync(input);
> -
> -       return;
>  }
> 
>  static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
> 

