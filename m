From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]  ACPI:  Check whether cooling device exists before unregistering it
Date: Fri, 15 Feb 2008 18:31:18 -0500
Message-ID: <200802151831.18533.lenb@kernel.org>
References: <1203035677.12873.1.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50439 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbYBOXgw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 18:36:52 -0500
In-Reply-To: <1203035677.12873.1.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

applied.

thanks,
-len

On Thursday 14 February 2008 19:34, Zhao Yakui wrote:
> Subject: ACPI:  Check whether cooling device exists before unregistering it
> >From : Zhao Yakui <yakui.zhao@intel.com>
> 
> OS should check whether the cooling device exists before it is unregistered.
> If it doesn't exists, it is unnecessary to remove the sysfs link
> and call the function of thermal_cooling_device_unregister.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=9982
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Tested-by    : Dhaval Giani <dhaval@linux.vnet.ibm.com>
>     
> ---
>  drivers/acpi/processor_core.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/processor_core.c
> +++ linux-2.6/drivers/acpi/processor_core.c
> @@ -809,10 +809,12 @@ static int acpi_processor_remove(struct 
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
> 
