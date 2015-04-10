From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [update][PATCH 4/4] ACPI / scan: Rework modalias creation when
 "compatible" is present
Date: Fri, 10 Apr 2015 11:12:24 +0300
Message-ID: <20150410081224.GO1734@lahna.fi.intel.com>
References: <4378053.gHTT51U7FJ@vostro.rjw.lan>
 <1630931.9AX0JeoSOf@vostro.rjw.lan>
 <1584233.lpv5odbKkI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12835 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754426AbbDJIMa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Apr 2015 04:12:30 -0400
Content-Disposition: inline
In-Reply-To: <1584233.lpv5odbKkI@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Darren Hart <dvhart@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Apr 09, 2015 at 11:13:56PM +0200, Rafael J. Wysocki wrote:
> @@ -236,61 +264,89 @@ static struct acpi_device *acpi_companio
>  	return adev;
>  }
>  
> -/*
> - * Creates uevent modalias field for ACPI enumerated devices.
> - * Because the other buses does not support ACPI HIDs & CIDs.
> - * e.g. for a device with hid:IBM0001 and cid:ACPI0001 you get:
> - * "acpi:IBM0001:ACPI0001"
> - */
> -int acpi_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
> +int __acpi_device_uevent_modalias(struct acpi_device *adev,
> +				  struct kobj_uevent_env *env)
>  {
>  	int len;
>  
> -	if (!acpi_companion_match(dev))
> +	if (!adev)
>  		return -ENODEV;
>  
>  	if (add_uevent_var(env, "MODALIAS="))
>  		return -ENOMEM;
> -	len = create_modalias(ACPI_COMPANION(dev), &env->buf[env->buflen - 1],
> -				sizeof(env->buf) - env->buflen);
> -	if (len <= 0)
> +
> +	len = create_pnp_modalias(adev, &env->buf[env->buflen - 1],
> +				  sizeof(env->buf) - env->buflen);
> +	if (len < 0) {
> +		return len;
> +	} else if (len > 0) {
> +		env->buflen += len;
> +
> +		if (add_uevent_var(env, "MODALIAS="))
> +			return -ENOMEM;

If the device does not have compatible property the below will result
an empty MODALIAS= line in the uevent file:

	# cat /sys/bus/i2c/devices/i2c-MSFT0002\:00/uevent
	MODALIAS=acpi:MSFT0002:PNP0C50:
	MODALIAS=

	# cat /sys/bus/platform/devices/80860F0E\:00/uevent
	DRIVER=pxa2xx-spi
	MODALIAS=acpi:80860F0E:80860F0E:
	MODALIAS=

> +	}
> +	len = create_of_modalias(adev, &env->buf[env->buflen - 1],
> +				 sizeof(env->buf) - env->buflen);
> +	if (len < 0)
>  		return len;
> +
>  	env->buflen += len;
> +
>  	return 0;
>  }

Following patch got rid of those. Not sure if that's the best place.
Perhaps we could move this to create_*_modalias() functions instead.

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 40b0a1b7f6f9..e0eb8161149c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -282,6 +282,9 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
 	} else if (len > 0) {
 		env->buflen += len;
 
+		if (!adev->data.of_compatible)
+			return 0;
+
 		if (add_uevent_var(env, "MODALIAS="))
 			return -ENOMEM;
 	}
