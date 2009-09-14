From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI fan: fix memleak on acpi_fan_add_fs() failure
Date: Mon, 14 Sep 2009 09:09:30 +0800
Message-ID: <1252890570.3609.229.camel@localhost.localdomain>
References: <4AACC94E.9040208@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34978 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbZINBJc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Sep 2009 21:09:32 -0400
In-Reply-To: <4AACC94E.9040208@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Sun, 2009-09-13 at 18:28 +0800, Alan Jenkins wrote:
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
It sounds reasonable although we don't fail in calling the function of
acpi_fan_add_fs.

> ---
>  drivers/acpi/fan.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index 947556e..eb1511e 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -283,13 +283,17 @@ static int acpi_fan_add(struct acpi_device *device)
>  
>  	result = acpi_fan_add_fs(device);
>  	if (result)
> -		goto end;
> +		goto unregister;
>  
>  	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
>  	       acpi_device_name(device), acpi_device_bid(device),
>  	       !device->power.state ? "on" : "off");

At the same time we should return directly if the result is zero. 
But in this patch it seems that it will also remove the sysfs I/F link
when the result is zero.

Thanks.
>  
> -      end:
> +unregister:
> +	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> +	sysfs_remove_link(&cdev->device.kobj, "device");
> +	thermal_cooling_device_unregister(cdev);
> +end:
>  	return result;
>  }
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

