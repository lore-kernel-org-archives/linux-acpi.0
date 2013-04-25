From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: video: correct acpi_video_bus_add error processing
Date: Thu, 25 Apr 2013 13:03:04 +0200
Message-ID: <2845639.6IhJslDaKz@vostro.rjw.lan>
References: <51789955.5050304@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43613 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455Ab3DYKy7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Apr 2013 06:54:59 -0400
In-Reply-To: <51789955.5050304@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: i-tek@web.de, Igor Murzov <intergalactic.anonymous@gmail.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Thursday, April 25, 2013 10:47:49 AM Aaron Lu wrote:
> acpi_video_bus_get_devices may fail due to some video output device
> doesn't have the _ADR method, and in this case, the error processing is
> to simply free the video structure in acpi_video_bus_add, while leaving
> those already registered video output devices in the wild, which means
> for some video output device, we have already registered a backlight
> interface and installed a notification handler for it. So it can happen
> when user is using this system, on hotkey pressing, the notification
> handler will send a keycode through a non-existing input device, causing
> kernel freeze.
> 
> To solve this problem, we free all those already registered video output
> devices once something goes wrong in acpi_video_bus_get_devices so that
> no wild backlight interfaces and notification handlers exist.
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=51731
> Reported-bisected-and-tested-by: <i-tek@web.de>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Applied.

Thanks,
Rafael


> ---
>  drivers/acpi/video.c | 143 ++++++++++++++++++++++++---------------------------
>  1 file changed, 66 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index ed192e5..c3932d0 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -167,7 +167,8 @@ struct acpi_video_device_flags {
>  	u8 dvi:1;
>  	u8 bios:1;
>  	u8 unknown:1;
> -	u8 reserved:2;
> +	u8 notify:1;
> +	u8 reserved:1;
>  };
>  
>  struct acpi_video_device_cap {
> @@ -1074,53 +1075,51 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
>  	struct acpi_video_device *data;
>  	struct acpi_video_device_attrib* attribute;
>  
> -	if (!device || !video)
> -		return -EINVAL;
> -
>  	status =
>  	    acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
> -	if (ACPI_SUCCESS(status)) {
> -
> -		data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
> -		if (!data)
> -			return -ENOMEM;
> -
> -		strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
> -		strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> -		device->driver_data = data;
> -
> -		data->device_id = device_id;
> -		data->video = video;
> -		data->dev = device;
> +	/* Some device omits _ADR, we skip them instead of fail */
> +	if (ACPI_FAILURE(status))
> +		return 0;
>  
> -		attribute = acpi_video_get_device_attr(video, device_id);
> +	data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
>  
> -		if((attribute != NULL) && attribute->device_id_scheme) {
> -			switch (attribute->display_type) {
> -			case ACPI_VIDEO_DISPLAY_CRT:
> -				data->flags.crt = 1;
> -				break;
> -			case ACPI_VIDEO_DISPLAY_TV:
> -				data->flags.tvout = 1;
> -				break;
> -			case ACPI_VIDEO_DISPLAY_DVI:
> -				data->flags.dvi = 1;
> -				break;
> -			case ACPI_VIDEO_DISPLAY_LCD:
> -				data->flags.lcd = 1;
> -				break;
> -			default:
> -				data->flags.unknown = 1;
> -				break;
> -			}
> -			if(attribute->bios_can_detect)
> -				data->flags.bios = 1;
> -		} else {
> -			/* Check for legacy IDs */
> -			device_type = acpi_video_get_device_type(video,
> -								 device_id);
> -			/* Ignore bits 16 and 18-20 */
> -			switch (device_type & 0xffe2ffff) {
> +	strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
> +	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> +	device->driver_data = data;
> +
> +	data->device_id = device_id;
> +	data->video = video;
> +	data->dev = device;
> +
> +	attribute = acpi_video_get_device_attr(video, device_id);
> +
> +	if((attribute != NULL) && attribute->device_id_scheme) {
> +		switch (attribute->display_type) {
> +		case ACPI_VIDEO_DISPLAY_CRT:
> +			data->flags.crt = 1;
> +			break;
> +		case ACPI_VIDEO_DISPLAY_TV:
> +			data->flags.tvout = 1;
> +			break;
> +		case ACPI_VIDEO_DISPLAY_DVI:
> +			data->flags.dvi = 1;
> +			break;
> +		case ACPI_VIDEO_DISPLAY_LCD:
> +			data->flags.lcd = 1;
> +			break;
> +		default:
> +			data->flags.unknown = 1;
> +			break;
> +		}
> +		if(attribute->bios_can_detect)
> +			data->flags.bios = 1;
> +	} else {
> +		/* Check for legacy IDs */
> +		device_type = acpi_video_get_device_type(video, device_id);
> +		/* Ignore bits 16 and 18-20 */
> +		switch (device_type & 0xffe2ffff) {
>  			case ACPI_VIDEO_DISPLAY_LEGACY_MONITOR:
>  				data->flags.crt = 1;
>  				break;
> @@ -1132,34 +1131,24 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
>  				break;
>  			default:
>  				data->flags.unknown = 1;
> -			}
>  		}
> +	}
>  
> -		acpi_video_device_bind(video, data);
> -		acpi_video_device_find_cap(data);
> -
> -		status = acpi_install_notify_handler(device->handle,
> -						     ACPI_DEVICE_NOTIFY,
> -						     acpi_video_device_notify,
> -						     data);
> -		if (ACPI_FAILURE(status)) {
> -			printk(KERN_ERR PREFIX
> -					  "Error installing notify handler\n");
> -			if(data->brightness)
> -				kfree(data->brightness->levels);
> -			kfree(data->brightness);
> -			kfree(data);
> -			return -ENODEV;
> -		}
> +	acpi_video_device_bind(video, data);
> +	acpi_video_device_find_cap(data);
>  
> -		mutex_lock(&video->device_list_lock);
> -		list_add_tail(&data->entry, &video->video_device_list);
> -		mutex_unlock(&video->device_list_lock);
> +	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
> +					     acpi_video_device_notify, data);
> +	if (ACPI_FAILURE(status))
> +		dev_err(&device->dev, "Error installing notify handler\n");
> +	else
> +		data->flags.notify = 1;
>  
> -		return 0;
> -	}
> +	mutex_lock(&video->device_list_lock);
> +	list_add_tail(&data->entry, &video->video_device_list);
> +	mutex_unlock(&video->device_list_lock);
>  
> -	return -ENOENT;
> +	return status;
>  }
>  
>  /*
> @@ -1452,9 +1441,8 @@ acpi_video_bus_get_devices(struct acpi_video_bus *video,
>  
>  		status = acpi_video_bus_get_one_device(dev, video);
>  		if (status) {
> -			printk(KERN_WARNING PREFIX
> -					"Can't attach device\n");
> -			continue;
> +			dev_err(&dev->dev, "Can't attach device\n");
> +			break;
>  		}
>  	}
>  	return status;
> @@ -1467,13 +1455,14 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
>  	if (!device || !device->video)
>  		return -ENOENT;
>  
> -	status = acpi_remove_notify_handler(device->dev->handle,
> -					    ACPI_DEVICE_NOTIFY,
> -					    acpi_video_device_notify);
> -	if (ACPI_FAILURE(status)) {
> -		printk(KERN_WARNING PREFIX
> -		       "Can't remove video notify handler\n");
> +	if (device->flags.notify) {
> +		status = acpi_remove_notify_handler(device->dev->handle,
> +				ACPI_DEVICE_NOTIFY, acpi_video_device_notify);
> +		if (ACPI_FAILURE(status))
> +			dev_err(&device->dev->dev,
> +					"Can't remove video notify handler\n");
>  	}
> +
>  	if (device->backlight) {
>  		backlight_device_unregister(device->backlight);
>  		device->backlight = NULL;
> @@ -1755,7 +1744,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
>  
>  	error = acpi_video_bus_get_devices(video, device);
>  	if (error)
> -		goto err_free_video;
> +		goto err_put_video;
>  
>  	video->input = input = input_allocate_device();
>  	if (!input) {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
