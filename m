From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: Remove sysfs_create_link from video driver
Date: Mon, 28 Mar 2011 21:22:21 +0200
Message-ID: <201103282122.21175.rjw@sisk.pl>
References: <1301316362-2955-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49207 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530Ab1C1TWI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Mar 2011 15:22:08 -0400
In-Reply-To: <1301316362-2955-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jeff.chua.linux@gmail.com

On Monday, March 28, 2011, Matthew Garrett wrote:
> The acpi video driver attempts to explicitly create a sysfs link between
> the acpi device and the associated PCI device. However, we're now also
> doing this from the backlight core, which means that we get a backtrace
> caused by a duplicate file. Remove the code and leave it up to the
> backlight core.
> 
> Reported-by: Jeff Chua <jeff.chua.linux@gmail.com>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/acpi/video.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index a18e497..31e9e10 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -824,11 +824,6 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
>  		device->backlight->props.brightness =
>  				acpi_video_get_brightness(device->backlight);
>  
> -		result = sysfs_create_link(&device->backlight->dev.kobj,
> -					   &device->dev->dev.kobj, "device");
> -		if (result)
> -			printk(KERN_ERR PREFIX "Create sysfs link\n");
> -
>  		device->cooling_dev = thermal_cooling_device_register("LCD",
>  					device->dev, &video_cooling_ops);
>  		if (IS_ERR(device->cooling_dev)) {
> @@ -1381,7 +1376,6 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
>  		       "Cant remove video notify handler\n");
>  	}
>  	if (device->backlight) {
> -		sysfs_remove_link(&device->backlight->dev.kobj, "device");
>  		backlight_device_unregister(device->backlight);
>  		device->backlight = NULL;
>  	}
> 

