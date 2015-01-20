From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: set first resuming device as a 'proxy'
Date: Tue, 20 Jan 2015 15:45:36 +0100
Message-ID: <6322489.a8QUfpK4WQ@vostro.rjw.lan>
References: <1421320244-3490-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50984 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750771AbbATOXA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jan 2015 09:23:00 -0500
In-Reply-To: <1421320244-3490-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

On Thursday, January 15, 2015 01:10:44 PM Andy Shevchenko wrote:
> We can't rely on the first enumerated device since it might be not probed yet
> when DMA driver wants to resume the device. This patch changes the place where
> we assign the 'proxy' device. From now on the first resumed device will be
> recognized as a 'proxy' because it is probed.

I was about to apply this, but I realized that we couldn't do it this way. ->

> Reported-by: Jerome Blin <jerome.blin@intel.com>
> Fixes: 6c17ee44d524 (ACPI / LPSS: introduce a 'proxy' device to power on LPSS for DMA)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 4f3febf..d851290 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -374,8 +374,6 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
>  	adev->driver_data = pdata;
>  	pdev = acpi_create_platform_device(adev);
>  	if (!IS_ERR_OR_NULL(pdev)) {
> -		if (!proxy_device && dev_desc->flags & LPSS_DEV_PROXY)
> -			proxy_device = &pdev->dev;
>  		return 1;
>  	}
>  
> @@ -615,10 +613,17 @@ static int acpi_lpss_runtime_resume(struct device *dev)
>  	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>  	int ret;
>  
> -	if (pdata->dev_desc->flags & LPSS_PROXY_REQ && proxy_device) {
> -		ret = pm_runtime_get_sync(proxy_device);
> -		if (ret)
> -			return ret;
> +	if (!proxy_device && pdata->dev_desc->flags & LPSS_DEV_PROXY)
> +		proxy_device = dev;

-> OK, so what if the driver of proxy_device is removed later?

> +
> +	if (pdata->dev_desc->flags & LPSS_PROXY_REQ) {
> +		if (proxy_device) {
> +			ret = pm_runtime_get_sync(proxy_device);
> +			if (ret)
> +				return ret;
> +		} else {
> +			return -EPROBE_DEFER;

The error code returned here will disable runtime PM for dev forever,
even if proxy_device becomes available at one point.  You could return
-EBUSY instead, but why don't we add BUS_NOTIFY_BOUND_DRIVER and
BUS_NOTIFY_UNBIND_DRIVER handling to acpi_lpss_platform_notify() and
set/unset proxy_device from there? 

> +		}
>  	}
>  
>  	ret = acpi_dev_runtime_resume(dev);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
