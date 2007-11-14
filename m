From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch 6/8] ACPI: video - properly handle errors when
	registering proc elements
Date: Wed, 14 Nov 2007 15:18:04 +0800
Message-ID: <1195024684.1262.47.camel@acpi-hp.sh.intel.com>
References: <20071105164328.982283020@anvil.corenet.prv>
	 <20071105165012.564676221@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15364 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757110AbXKNHIQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 02:08:16 -0500
In-Reply-To: <20071105165012.564676221@anvil.corenet.prv>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2007-11-06 at 00:43 +0800, Dmitry Torokhov wrote:
> ACPI: video - properly handle errors when registering proc elements
> 
> Have acpi_video_device_add_fs() and acpi_video_bus_add_fs()
> properly unwind proc creation after error.
Hi, Dmitry,

The patch is good.
But I'm afraid we don't need this patch while we are trying to remove
the proc I/F for all ACPI device drivers.

Thanks,
Rui

> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>  drivers/acpi/video.c |  230
> +++++++++++++++++++++++++--------------------------
>  1 file changed, 115 insertions(+), 115 deletions(-)
> 
> Index: work/drivers/acpi/video.c
> ===================================================================
> --- work.orig/drivers/acpi/video.c
> +++ work/drivers/acpi/video.c
> @@ -967,87 +967,90 @@ acpi_video_device_EDID_open_fs(struct in
> 
>  static int acpi_video_device_add_fs(struct acpi_device *device)
>  {
> -       struct proc_dir_entry *entry = NULL;
> +       struct proc_dir_entry *entry, *device_dir;
>         struct acpi_video_device *vid_dev;
> 
> -
> -       if (!device)
> -               return -ENODEV;
> -
>         vid_dev = acpi_driver_data(device);
>         if (!vid_dev)
>                 return -ENODEV;
> 
> -       if (!acpi_device_dir(device)) {
> -               acpi_device_dir(device) =
> proc_mkdir(acpi_device_bid(device),
> -
> vid_dev->video->dir);
> -               if (!acpi_device_dir(device))
> -                       return -ENODEV;
> -               acpi_device_dir(device)->owner = THIS_MODULE;
> -       }
> +       device_dir = proc_mkdir(acpi_device_bid(device),
> +                               vid_dev->video->dir);
> +       if (!device_dir)
> +               return -ENOMEM;
> +
> +       device_dir->owner = THIS_MODULE;
> 
>         /* 'info' [R] */
> -       entry = create_proc_entry("info", S_IRUGO,
> acpi_device_dir(device));
> +       entry = create_proc_entry("info", S_IRUGO, device_dir);
>         if (!entry)
> -               return -ENODEV;
> -       else {
> -               entry->proc_fops = &acpi_video_device_info_fops;
> -               entry->data = acpi_driver_data(device);
> -               entry->owner = THIS_MODULE;
> -       }
> +               goto err_remove_dir;
> +
> +       entry->proc_fops = &acpi_video_device_info_fops;
> +       entry->data = acpi_driver_data(device);
> +       entry->owner = THIS_MODULE;
> 
>         /* 'state' [R/W] */
> -       entry =
> -           create_proc_entry("state", S_IFREG | S_IRUGO | S_IWUSR,
> -                             acpi_device_dir(device));
> +       entry = create_proc_entry("state", S_IFREG | S_IRUGO |
> S_IWUSR,
> +                                 device_dir);
>         if (!entry)
> -               return -ENODEV;
> -       else {
> -               acpi_video_device_state_fops.write =
> acpi_video_device_write_state;
> -               entry->proc_fops = &acpi_video_device_state_fops;
> -               entry->data = acpi_driver_data(device);
> -               entry->owner = THIS_MODULE;
> -       }
> +               goto err_remove_info;
> +
> +       acpi_video_device_state_fops.write =
> acpi_video_device_write_state;
> +       entry->proc_fops = &acpi_video_device_state_fops;
> +       entry->data = acpi_driver_data(device);
> +       entry->owner = THIS_MODULE;
> 
>         /* 'brightness' [R/W] */
> -       entry =
> -           create_proc_entry("brightness", S_IFREG | S_IRUGO |
> S_IWUSR,
> -                             acpi_device_dir(device));
> +       entry = create_proc_entry("brightness", S_IFREG | S_IRUGO |
> S_IWUSR,
> +                                 device_dir);
>         if (!entry)
> -               return -ENODEV;
> -       else {
> -               acpi_video_device_brightness_fops.write =
> acpi_video_device_write_brightness;
> -               entry->proc_fops = &acpi_video_device_brightness_fops;
> -               entry->data = acpi_driver_data(device);
> -               entry->owner = THIS_MODULE;
> -       }
> +               goto err_remove_state;
> +
> +       acpi_video_device_brightness_fops.write =
> +                       acpi_video_device_write_brightness;
> +       entry->proc_fops = &acpi_video_device_brightness_fops;
> +       entry->data = acpi_driver_data(device);
> +       entry->owner = THIS_MODULE;
> 
>         /* 'EDID' [R] */
> -       entry = create_proc_entry("EDID", S_IRUGO,
> acpi_device_dir(device));
> +       entry = create_proc_entry("EDID", S_IRUGO, device_dir);
>         if (!entry)
> -               return -ENODEV;
> -       else {
> -               entry->proc_fops = &acpi_video_device_EDID_fops;
> -               entry->data = acpi_driver_data(device);
> -               entry->owner = THIS_MODULE;
> -       }
> +               goto err_remove_brightness;
> 
> +       entry->proc_fops = &acpi_video_device_EDID_fops;
> +       entry->data = acpi_driver_data(device);
> +       entry->owner = THIS_MODULE;
> +
> +       acpi_device_dir(device) = device_dir;
>         return 0;
> +
> + err_remove_brightness:
> +       remove_proc_entry("brightness", device_dir);
> + err_remove_state:
> +       remove_proc_entry("state", device_dir);
> + err_remove_info:
> +       remove_proc_entry("info", device_dir);
> + err_remove_dir:
> +       remove_proc_entry(acpi_device_bid(device),
> vid_dev->video->dir);
> +       return -ENOMEM;
>  }
> 
>  static int acpi_video_device_remove_fs(struct acpi_device *device)
>  {
>         struct acpi_video_device *vid_dev;
> +       struct proc_dir_entry *device_dir;
> 
>         vid_dev = acpi_driver_data(device);
>         if (!vid_dev || !vid_dev->video || !vid_dev->video->dir)
>                 return -ENODEV;
> 
> -       if (acpi_device_dir(device)) {
> -               remove_proc_entry("info", acpi_device_dir(device));
> -               remove_proc_entry("state", acpi_device_dir(device));
> -               remove_proc_entry("brightness",
> acpi_device_dir(device));
> -               remove_proc_entry("EDID", acpi_device_dir(device));
> +       device_dir = acpi_device_dir(device);
> +       if (device_dir) {
> +               remove_proc_entry("info", device_dir);
> +               remove_proc_entry("state", device_dir);
> +               remove_proc_entry("brightness", device_dir);
> +               remove_proc_entry("EDID", device_dir);
>                 remove_proc_entry(acpi_device_bid(device),
> vid_dev->video->dir);
>                 acpi_device_dir(device) = NULL;
>         }
> @@ -1254,94 +1257,91 @@ acpi_video_bus_write_DOS(struct file *fi
> 
>  static int acpi_video_bus_add_fs(struct acpi_device *device)
>  {
> -       struct proc_dir_entry *entry = NULL;
> -       struct acpi_video_bus *video;
> +       struct acpi_video_bus *video = acpi_driver_data(device);
> +       struct proc_dir_entry *device_dir;
> +       struct proc_dir_entry *entry;
> 
> +       device_dir = proc_mkdir(acpi_device_bid(device),
> acpi_video_dir);
> +       if (!device_dir)
> +               return -ENOMEM;
> 
> -       video = acpi_driver_data(device);
> -
> -       if (!acpi_device_dir(device)) {
> -               acpi_device_dir(device) =
> proc_mkdir(acpi_device_bid(device),
> -                                                    acpi_video_dir);
> -               if (!acpi_device_dir(device))
> -                       return -ENODEV;
> -               video->dir = acpi_device_dir(device);
> -               acpi_device_dir(device)->owner = THIS_MODULE;
> -       }
> +       device_dir->owner = THIS_MODULE;
> 
>         /* 'info' [R] */
> -       entry = create_proc_entry("info", S_IRUGO,
> acpi_device_dir(device));
> +       entry = create_proc_entry("info", S_IRUGO, device_dir);
>         if (!entry)
> -               return -ENODEV;
> -       else {
> -               entry->proc_fops = &acpi_video_bus_info_fops;
> -               entry->data = acpi_driver_data(device);
> -               entry->owner = THIS_MODULE;
> -       }
> +               goto err_remove_dir;
> +
> +       entry->proc_fops = &acpi_video_bus_info_fops;
> +       entry->data = acpi_driver_data(device);
> +       entry->owner = THIS_MODULE;
> 
>         /* 'ROM' [R] */
> -       entry = create_proc_entry("ROM", S_IRUGO,
> acpi_device_dir(device));
> +       entry = create_proc_entry("ROM", S_IRUGO, device_dir);
>         if (!entry)
> -               return -ENODEV;
> -       else {
> -               entry->proc_fops = &acpi_video_bus_ROM_fops;
> -               entry->data = acpi_driver_data(device);
> -               entry->owner = THIS_MODULE;
> -       }
> +               goto err_remove_info;
> +
> +       entry->proc_fops = &acpi_video_bus_ROM_fops;
> +       entry->data = acpi_driver_data(device);
> +       entry->owner = THIS_MODULE;
> 
>         /* 'POST_info' [R] */
> -       entry =
> -           create_proc_entry("POST_info", S_IRUGO,
> acpi_device_dir(device));
> +       entry = create_proc_entry("POST_info", S_IRUGO, device_dir);
>         if (!entry)
> -               return -ENODEV;
> -       else {
> -               entry->proc_fops = &acpi_video_bus_POST_info_fops;
> -               entry->data = acpi_driver_data(device);
> -               entry->owner = THIS_MODULE;
> -       }
> +               goto err_remove_rom;
> +
> +       entry->proc_fops = &acpi_video_bus_POST_info_fops;
> +       entry->data = acpi_driver_data(device);
> +       entry->owner = THIS_MODULE;
> 
>         /* 'POST' [R/W] */
> -       entry =
> -           create_proc_entry("POST", S_IFREG | S_IRUGO | S_IRUSR,
> -                             acpi_device_dir(device));
> +       entry = create_proc_entry("POST", S_IFREG | S_IRUGO | S_IRUSR,
> +                                 device_dir);
>         if (!entry)
> -               return -ENODEV;
> -       else {
> -               acpi_video_bus_POST_fops.write =
> acpi_video_bus_write_POST;
> -               entry->proc_fops = &acpi_video_bus_POST_fops;
> -               entry->data = acpi_driver_data(device);
> -               entry->owner = THIS_MODULE;
> -       }
> +               goto err_remove_post_info;
> +
> +       acpi_video_bus_POST_fops.write = acpi_video_bus_write_POST;
> +       entry->proc_fops = &acpi_video_bus_POST_fops;
> +       entry->data = acpi_driver_data(device);
> +       entry->owner = THIS_MODULE;
> 
>         /* 'DOS' [R/W] */
> -       entry =
> -           create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IRUSR,
> -                             acpi_device_dir(device));
> +       entry = create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IRUSR,
> +                             device_dir);
>         if (!entry)
> -               return -ENODEV;
> -       else {
> -               acpi_video_bus_DOS_fops.write =
> acpi_video_bus_write_DOS;
> -               entry->proc_fops = &acpi_video_bus_DOS_fops;
> -               entry->data = acpi_driver_data(device);
> -               entry->owner = THIS_MODULE;
> -       }
> +               goto err_remove_post;
> +
> +       acpi_video_bus_DOS_fops.write = acpi_video_bus_write_DOS;
> +       entry->proc_fops = &acpi_video_bus_DOS_fops;
> +       entry->data = acpi_driver_data(device);
> +       entry->owner = THIS_MODULE;
> 
> +       video->dir = acpi_device_dir(device) = device_dir;
>         return 0;
> +
> + err_remove_post:
> +       remove_proc_entry("POST", device_dir);
> + err_remove_post_info:
> +       remove_proc_entry("POST_info", device_dir);
> + err_remove_rom:
> +       remove_proc_entry("ROM", device_dir);
> + err_remove_info:
> +       remove_proc_entry("info", device_dir);
> + err_remove_dir:
> +       remove_proc_entry(acpi_device_bid(device), acpi_video_dir);
> +       return -ENOMEM;
>  }
> 
>  static int acpi_video_bus_remove_fs(struct acpi_device *device)
>  {
> -       struct acpi_video_bus *video;
> -
> -
> -       video = acpi_driver_data(device);
> +       struct proc_dir_entry *device_dir = acpi_device_dir(device);
> 
> -       if (acpi_device_dir(device)) {
> -               remove_proc_entry("info", acpi_device_dir(device));
> -               remove_proc_entry("ROM", acpi_device_dir(device));
> -               remove_proc_entry("POST_info",
> acpi_device_dir(device));
> -               remove_proc_entry("POST", acpi_device_dir(device));
> -               remove_proc_entry("DOS", acpi_device_dir(device));
> +       if (device_dir) {
> +               remove_proc_entry("info", device_dir);
> +               remove_proc_entry("ROM", device_dir);
> +               remove_proc_entry("POST_info", device_dir);
> +               remove_proc_entry("POST", device_dir);
> +               remove_proc_entry("DOS", device_dir);
>                 remove_proc_entry(acpi_device_bid(device),
> acpi_video_dir);
>                 acpi_device_dir(device) = NULL;
>         }
> 
> --
> Dmitry
> 
> 
