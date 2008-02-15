From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch 4/6] ACPI processor: extract return values using PTR_ERR
Date: Fri, 15 Feb 2008 14:51:18 +0800
Message-ID: <1203058278.4013.4.camel@yakui_zhao.sh.intel.com>
References: <05B550FD4BD2014E841D83547B62600802AA6506@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35307 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756790AbYBOHKf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 02:10:35 -0500
In-Reply-To: <05B550FD4BD2014E841D83547B62600802AA6506@bgsmsx411.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Thomas, Sujith" <sujith.thomas@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

On Fri, 2008-02-15 at 10:54 +0530, Thomas, Sujith wrote:
> From: Thomas Sujith <sujith.thomas@intel.com>
> 
> Need to extract errors using PTR_ERR macro and
> process accordingly.thermal_cooling_device_register
> returning NULL means that CONFIG_THERMAL=n and in that
> case no need to create symbolic links.
> 
> Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
> ---
> 
>  drivers/acpi/processor_core.c |   27 ++++++++++++++++-----------
>  1 files changed, 16 insertions(+), 11 deletions(-)
> 
> Index: linux-2.6.24/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.24.orig/drivers/acpi/processor_core.c
> +++ linux-2.6.24/drivers/acpi/processor_core.c
> @@ -670,21 +670,26 @@ static int __cpuinit acpi_processor_star
>  
>  	pr->cdev = thermal_cooling_device_register("Processor", device,
>  						&processor_cooling_ops);
> -	if (pr->cdev)
> +	if (IS_ERR(pr->cdev)) {
> +		result = PTR_ERR(pr->cdev);
> +		goto end;
> +	}
> +	if (pr->cdev) {
>  		printk(KERN_INFO PREFIX
>  			"%s is registered as cooling_device%d\n",
>  			device->dev.bus_id, pr->cdev->id);
> -	else
> -		goto end;
>  
> -	result = sysfs_create_link(&device->dev.kobj,
> &pr->cdev->device.kobj,
> -					"thermal_cooling");
> -	if (result)
> -		return result;
> -	result = sysfs_create_link(&pr->cdev->device.kobj,
> &device->dev.kobj,
> -					"device");
> -	if (result)
> -		return result;
> +		result = sysfs_create_link(&device->dev.kobj,
> +					   &pr->cdev->device.kobj,
> +					   "thermal_cooling");
> +		if (result)
> +			return result;
> +		result = sysfs_create_link(&pr->cdev->device.kobj,
> +					   &device->dev.kobj,
> +					   "device");
> +		if (result)
> +			return result;
> +	}
Very good. But is it necessary to check whether the cooling device
exists before it is unregistered? 

>  
>  	if (pr->flags.throttling) {
>  		printk(KERN_INFO PREFIX "%s [%s] (supports",

