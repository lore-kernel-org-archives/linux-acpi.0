From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] acpi: don't free non-existant backlight in acpi
	video module
Date: Mon, 13 Jul 2009 09:37:34 +0800
Message-ID: <1247449054.15520.195.camel@rzhang-dt>
References: <1247381251-27031-1-git-send-email-keithp@keithp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47223 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbZGMBgp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Jul 2009 21:36:45 -0400
In-Reply-To: <1247381251-27031-1-git-send-email-keithp@keithp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "keithp@keithp.com" <keithp@keithp.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, 2009-07-12 at 14:47 +0800, keithp@keithp.com wrote:
> From: Keith Packard <keithp@keithp.com>
> 
> acpi_video_put_one_device was attempting to remove sysfs entries and
> unregister a backlight device without first checking that said backlight
> device structure had been created.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

> ---
>  drivers/acpi/video.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 8851315..60ea984 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -2004,8 +2004,11 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
>  	status = acpi_remove_notify_handler(device->dev->handle,
>  					    ACPI_DEVICE_NOTIFY,
>  					    acpi_video_device_notify);
> -	sysfs_remove_link(&device->backlight->dev.kobj, "device");
> -	backlight_device_unregister(device->backlight);
> +	if (device->backlight) {
> +		sysfs_remove_link(&device->backlight->dev.kobj, "device");
> +		backlight_device_unregister(device->backlight);
> +		device->backlight = NULL;
> +	}
>  	if (device->cdev) {
>  		sysfs_remove_link(&device->dev->dev.kobj,
>  				  "thermal_cooling");

