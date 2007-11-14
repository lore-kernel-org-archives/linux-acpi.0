From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch 2/8] ACPI: video - add missing input_free_device()
Date: Wed, 14 Nov 2007 15:17:50 +0800
Message-ID: <1195024670.1262.43.camel@acpi-hp.sh.intel.com>
References: <20071105164328.982283020@anvil.corenet.prv>
	 <20071105165011.808572323@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26413 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757110AbXKNHIC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 02:08:02 -0500
In-Reply-To: <20071105165011.808572323@anvil.corenet.prv>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2007-11-06 at 00:43 +0800, Dmitry Torokhov wrote:
> ACPI: video - add missing input_free_device()
> 
> If input_register_device() fails input_free_device() must
> be called to release memory allocated for the device.
> Also consolidate error handling in acpi_bus_video_add()
> and handle input_allocate_device() failures.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |   71
> +++++++++++++++++++++++++--------------------------
>  1 file changed, 35 insertions(+), 36 deletions(-)
> 
> Index: work/drivers/acpi/video.c
> ===================================================================
> --- work.orig/drivers/acpi/video.c
> +++ work/drivers/acpi/video.c
> @@ -1897,14 +1897,10 @@ static void acpi_video_device_notify(acp
>  static int instance;
>  static int acpi_video_bus_add(struct acpi_device *device)
>  {
> -       int result = 0;
> -       acpi_status status = 0;
> -       struct acpi_video_bus *video = NULL;
> +       acpi_status status;
> +       struct acpi_video_bus *video;
>         struct input_dev *input;
> -
> -
> -       if (!device)
> -               return -EINVAL;
> +       int error;
> 
>         video = kzalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
>         if (!video)
> @@ -1923,13 +1919,13 @@ static int acpi_video_bus_add(struct acp
>         acpi_driver_data(device) = video;
> 
>         acpi_video_bus_find_cap(video);
> -       result = acpi_video_bus_check(video);
> -       if (result)
> -               goto end;
> -
> -       result = acpi_video_bus_add_fs(device);
> -       if (result)
> -               goto end;
> +       error = acpi_video_bus_check(video);
> +       if (error)
> +               goto err_free_video;
> +
> +       error = acpi_video_bus_add_fs(device);
> +       if (error)
> +               goto err_free_video;
> 
>         init_MUTEX(&video->sem);
>         INIT_LIST_HEAD(&video->video_device_list);
> @@ -1943,16 +1939,15 @@ static int acpi_video_bus_add(struct acp
>         if (ACPI_FAILURE(status)) {
>                 ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>                                   "Error installing notify handler
> \n"));
> -               acpi_video_bus_stop_devices(video);
> -               acpi_video_bus_put_devices(video);
> -               kfree(video->attached_array);
> -               acpi_video_bus_remove_fs(device);
> -               result = -ENODEV;
> -               goto end;
> +               error = -ENODEV;
> +               goto err_stop_video;
>         }
> 
> -
>         video->input = input = input_allocate_device();
> +       if (!input) {
> +               error = -ENOMEM;
> +               goto err_uninstall_notify;
> +       }
> 
>         snprintf(video->phys, sizeof(video->phys),
>                 "%s/video/input0", acpi_device_hid(video->device));
> @@ -1972,18 +1967,10 @@ static int acpi_video_bus_add(struct acp
>         set_bit(KEY_BRIGHTNESS_ZERO, input->keybit);
>         set_bit(KEY_DISPLAY_OFF, input->keybit);
>         set_bit(KEY_UNKNOWN, input->keybit);
> -       result = input_register_device(input);
> -       if (result) {
> -               acpi_remove_notify_handler(video->device->handle,
> -                                               ACPI_DEVICE_NOTIFY,
> -
> acpi_video_bus_notify);
> -               acpi_video_bus_stop_devices(video);
> -               acpi_video_bus_put_devices(video);
> -               kfree(video->attached_array);
> -               acpi_video_bus_remove_fs(device);
> -               goto end;
> -        }
> 
> +       error = input_register_device(input);
> +       if (error)
> +               goto err_free_input_dev;
> 
>         printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s
> post: %s)\n",
>                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
> @@ -1991,11 +1978,23 @@ static int acpi_video_bus_add(struct acp
>                video->flags.rom ? "yes" : "no",
>                video->flags.post ? "yes" : "no");
> 
> - end:
> -       if (result)
> -               kfree(video);
> +       return 0;
> +
> + err_free_input_dev:
> +       input_free_device(input);
> + err_uninstall_notify:
> +       acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
> +                                  acpi_video_bus_notify);
> + err_stop_video:
> +       acpi_video_bus_stop_devices(video);
> +       acpi_video_bus_put_devices(video);
> +       kfree(video->attached_array);
> +       acpi_video_bus_remove_fs(device);
> + err_free_video:
> +       kfree(video);
> +       acpi_driver_data(device) = NULL;
> 
> -       return result;
> +       return error;
>  }
> 
>  static int acpi_video_bus_remove(struct acpi_device *device, int
> type)
> 
> --
> Dmitry
> 
> 
