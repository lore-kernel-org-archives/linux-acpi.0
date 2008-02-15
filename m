From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 4/6] ACPI processor: extract return values using PTR_ERR
Date: Fri, 15 Feb 2008 18:30:58 -0500
Message-ID: <200802151830.58871.lenb@kernel.org>
References: <05B550FD4BD2014E841D83547B62600802AA6506@bgsmsx411.gar.corp.intel.com> <1203058278.4013.4.camel@yakui_zhao.sh.intel.com> <05B550FD4BD2014E841D83547B62600802AA6942@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50413 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755078AbYBOXet (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 18:34:49 -0500
In-Reply-To: <05B550FD4BD2014E841D83547B62600802AA6942@bgsmsx411.gar.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Thomas, Sujith" <sujith.thomas@intel.com>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

refreshed in acpi-test branch.

thanks,
-len

On Friday 15 February 2008 05:46, Thomas, Sujith wrote:
> 
> > -----Original Message-----
> > From: Zhao, Yakui 
> > Sent: Friday, February 15, 2008 12:21 PM
> > To: Thomas, Sujith
> > Cc: lenb@kernel.org; linux-acpi@vger.kernel.org; Zhang, Rui
> > Subject: Re: [patch 4/6] ACPI processor: extract return 
> > values using PTR_ERR
> > 
> > On Fri, 2008-02-15 at 10:54 +0530, Thomas, Sujith wrote:
> > > From: Thomas Sujith <sujith.thomas@intel.com>
> > > 
> > > Need to extract errors using PTR_ERR macro and
> > > process accordingly.thermal_cooling_device_register
> > > returning NULL means that CONFIG_THERMAL=n and in that
> > > case no need to create symbolic links.
> 
> > Very good. But is it necessary to check whether the cooling device
> > exists before it is unregistered? 
> 
> I agree; resending the patch
> 
> Subject: ACPI processor : extract return values using PTR_ERR
> From: Thomas Sujith <sujith.thomas@intel.com>
> 
> Need to extract errors using PTR_ERR macro and
> process accordingly.thermal_cooling_device_register
> returning NULL means that CONFIG_THERMAL=n and in that
> case no need to create symbolic links.
> 
> Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
>  drivers/acpi/processor_core.c |   37
> ++++++++++++++++++++++---------------
>  1 files changed, 22 insertions(+), 15 deletions(-)
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
>  
>  	if (pr->flags.throttling) {
>  		printk(KERN_INFO PREFIX "%s [%s] (supports",
> @@ -809,10 +814,12 @@ static int acpi_processor_remove(struct 
>  
>  	acpi_processor_remove_fs(device);
>  
> -	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> -	sysfs_remove_link(&pr->cdev->device.kobj, "device");
> -	thermal_cooling_device_unregister(pr->cdev);
> -	pr->cdev = NULL;
> +	if (pr->cdev) {
> +		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> +		sysfs_remove_link(&pr->cdev->device.kobj, "device");
> +		thermal_cooling_device_unregister(pr->cdev);
> +		pr->cdev = NULL;
> +	}
>  
>  	processors[pr->id] = NULL;
>  
> 
