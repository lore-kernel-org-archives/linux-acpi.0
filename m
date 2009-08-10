From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/4] ACPI: video - fix potential crash when unloading
Date: Mon, 10 Aug 2009 10:11:34 +0800
Message-ID: <1249870294.2670.539.camel@rzhang-dt>
References: <20090808072150.2980.3863.stgit@localhost.localdomain>
	 <20090808075636.C8B31526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3967 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754837AbZHJCMh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Aug 2009 22:12:37 -0400
In-Reply-To: <20090808075636.C8B31526EC9@mailhub.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 2009-08-08 at 15:26 +0800, Dmitry Torokhov wrote:
> thermal_cooling_device_register() returns error encoded in a pointer
> when it fails in which case we need to explictly set device->cdev
> to NULL so we don't try to unregister it when unloading.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Acked-by: Zhang Rui <rui.zhang@intel.com>

> ---
> 
>  drivers/acpi/video.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index d8e64cf..98ade4e 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -992,8 +992,18 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
>  
>  		device->cdev = thermal_cooling_device_register("LCD",
>  					device->dev, &video_cooling_ops);
> -		if (IS_ERR(device->cdev))
> +		if (IS_ERR(device->cdev)) {
> +			/*
> +			 * Set cdev to NULL so we don't crash trying to
> +			 * free it.
> +			 * Also, why the hell we are returnign early and
> +			 * not attempt to register video output if cooling
> +			 * device registration failed?
> +			 * -- dtor
> +			 */
> +			device->cdev = NULL;
>  			return;
> +		}
>  
>  		dev_info(&device->dev->dev, "registered as cooling_device%d\n",
>  			 device->cdev->id);
> 

