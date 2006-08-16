From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 06/14] acpi/scan: handle kset/kobject errors
Date: Tue, 15 Aug 2006 23:32:40 -0400
Message-ID: <200608152332.40706.len.brown@intel.com>
References: <200608150537.k7F5bOdJ011545@shell0.pdx.osdl.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45453 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750883AbWHPDbJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Aug 2006 23:31:09 -0400
In-Reply-To: <200608150537.k7F5bOdJ011545@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, rdunlap@xenotime.net

applied.

thanks,
-len

On Tuesday 15 August 2006 01:37, akpm@osdl.org wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Check and handle kset_register() and kobject_register() init errors.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/scan.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/acpi/scan.c~acpi-scan-handle-kset-kobject-errors drivers/acpi/scan.c
> --- a/drivers/acpi/scan.c~acpi-scan-handle-kset-kobject-errors
> +++ a/drivers/acpi/scan.c
> @@ -4,6 +4,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/kernel.h>
>  #include <linux/acpi.h>
>  
>  #include <acpi/acpi_drivers.h>
> @@ -113,6 +114,8 @@ static struct kset acpi_namespace_kset =
>  static void acpi_device_register(struct acpi_device *device,
>  				 struct acpi_device *parent)
>  {
> +	int err;
> +
>  	/*
>  	 * Linkage
>  	 * -------
> @@ -138,7 +141,10 @@ static void acpi_device_register(struct 
>  		device->kobj.parent = &parent->kobj;
>  	device->kobj.ktype = &ktype_acpi_ns;
>  	device->kobj.kset = &acpi_namespace_kset;
> -	kobject_register(&device->kobj);
> +	err = kobject_register(&device->kobj);
> +	if (err < 0)
> +		printk(KERN_WARNING "%s: kobject_register error: %d\n",
> +			__FUNCTION__, err);
>  	create_sysfs_device_files(device);
>  }
>  
> @@ -1450,7 +1456,9 @@ static int __init acpi_scan_init(void)
>  	if (acpi_disabled)
>  		return 0;
>  
> -	kset_register(&acpi_namespace_kset);
> +	result = kset_register(&acpi_namespace_kset);
> +	if (result < 0)
> +		printk(KERN_ERR PREFIX "kset_register error: %d\n", result);
>  
>  	result = bus_register(&acpi_bus_type);
>  	if (result) {
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
