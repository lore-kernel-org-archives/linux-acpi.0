From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/4] ACPI: video - fix oops when unloading module
Date: Mon, 10 Aug 2009 09:31:15 +0800
Message-ID: <1249867875.2670.529.camel@rzhang-dt>
References: <20090808072150.2980.3863.stgit@localhost.localdomain>
	 <20090808075631.77F4F526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:16922 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754440AbZHJBcH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Aug 2009 21:32:07 -0400
In-Reply-To: <20090808075631.77F4F526EC9@mailhub.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 2009-08-08 at 15:26 +0800, Dmitry Torokhov wrote:
> Don't assume that backlight is always present.
> 
Patch is already available.
http://patchwork.kernel.org/patch/39704/

thanks,
rui

> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/acpi/video.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 8851315..d8e64cf 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -2004,8 +2004,12 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
>  	status = acpi_remove_notify_handler(device->dev->handle,
>  					    ACPI_DEVICE_NOTIFY,
>  					    acpi_video_device_notify);
> -	sysfs_remove_link(&device->backlight->dev.kobj, "device");
> -	backlight_device_unregister(device->backlight);
> +
> +	if (device->backlight) {
> +		sysfs_remove_link(&device->backlight->dev.kobj, "device");
> +		backlight_device_unregister(device->backlight);
> +	}
> +
>  	if (device->cdev) {
>  		sysfs_remove_link(&device->dev->dev.kobj,
>  				  "thermal_cooling");
> @@ -2014,6 +2018,7 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
>  		thermal_cooling_device_unregister(device->cdev);
>  		device->cdev = NULL;
>  	}
> +
>  	video_output_unregister(device->output_dev);
>  
>  	return 0;
> 

