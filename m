From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 6/9] acpi: don't free non-existent backlight in acpi video
 module
Date: Thu, 27 Aug 2009 14:05:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908271405070.21742@localhost.localdomain>
References: <200908062257.n76Mvs1F024250@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:57662 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbZH0SFj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Aug 2009 14:05:39 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP1001WTRL1QLL0@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Aug 2009 13:05:31 -0500 (CDT)
In-reply-to: <200908062257.n76Mvs1F024250@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, keithp@keithp.com, rui.zhang@intel.com

Applied for 2.6.31

thanks,
Len Brown, Intel Open Source Technology Center

On Thu, 6 Aug 2009, akpm@linux-foundation.org wrote:

> From: Keith Packard <keithp@keithp.com>
> 
> acpi_video_put_one_device was attempting to remove sysfs entries and
> unregister a backlight device without first checking that said backlight
> device structure had been created.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/video.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/acpi/video.c~acpi-dont-free-non-existent-backlight-in-acpi-video-module drivers/acpi/video.c
> --- a/drivers/acpi/video.c~acpi-dont-free-non-existent-backlight-in-acpi-video-module
> +++ a/drivers/acpi/video.c
> @@ -2004,8 +2004,11 @@ static int acpi_video_bus_put_one_device
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
> _
> 
