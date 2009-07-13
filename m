From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] acpi: don't free non-existant backlight in acpi
 video module
Date: Mon, 13 Jul 2009 16:41:43 -0700
Message-ID: <20090713164143.035152be.akpm@linux-foundation.org>
References: <1247381251-27031-1-git-send-email-keithp@keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37284 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754533AbZGMXlr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Jul 2009 19:41:47 -0400
In-Reply-To: <1247381251-27031-1-git-send-email-keithp@keithp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, keithp@keithp.com


> acpi: don't free non-existant backlight in acpi video module

"existent" :)

On Sat, 11 Jul 2009 23:47:31 -0700
keithp@keithp.com wrote:

> From: Keith Packard <keithp@keithp.com>
> 
> acpi_video_put_one_device was attempting to remove sysfs entries and
> unregister a backlight device without first checking that said backlight
> device structure had been created.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>
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

um, OK.

Under which circumstances was this observed?

For symmetry we could instead test acpi_video_backlight_support() here.

The patch assumes that someone initially zeroed device->backlight.  Is
that true and reliable?  If so, is the 

	memset(&device->cap, 0, sizeof(device->cap));

in acpi_video_device_find_cap() needed?


Where's [patch 2/2], btw?
