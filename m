From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 13/13] sony_acpi: fix sony_acpi backlight registration and unregistration
Date: Wed, 7 Feb 2007 16:11:05 -0500
Message-ID: <200702071611.05457.lenb@kernel.org>
References: <200702060010.l160AMUf003757@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56313 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422763AbXBGVM1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Feb 2007 16:12:27 -0500
In-Reply-To: <200702060010.l160AMUf003757@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, malattia@linux.it

NAK, included in sony-laptop series.

AFAICT, Mattia applied all the various sony fixes floating about to sony_acpi.c
before re-naming it to sony-laptop.c, where it lives in the acpi-test tree today.

thanks,
-Len

On Monday 05 February 2007 19:09, akpm@linux-foundation.org wrote:
> From: Mattia Dongili <malattia@linux.it>
> 
> Initialize the current brightness if the driver registration was successful
> and unregister the driver in the error exit path.
> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/sony_acpi.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff -puN drivers/acpi/sony_acpi.c~sony_acpi-fix-sony_acpi-backlight-registration-and-unregistration drivers/acpi/sony_acpi.c
> --- a/drivers/acpi/sony_acpi.c~sony_acpi-fix-sony_acpi-backlight-registration-and-unregistration
> +++ a/drivers/acpi/sony_acpi.c
> @@ -354,9 +354,14 @@ static int sony_acpi_add(struct acpi_dev
>  	if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle, "GBRT", &handle))) {
>  		sony_backlight_device = backlight_device_register("sony", NULL,
>  					NULL, &sony_backlight_properties);
> +
>  	        if (IS_ERR(sony_backlight_device)) {
>          	        printk(LOG_PFX "unable to register backlight device\n");
> +			sony_backlight_device = NULL;
>  		}
> +		else
> +			sony_backlight_properties.brightness =
> +				sony_backlight_get_brightness(sony_backlight_device);
>  	}
>  
>  	for (item = sony_acpi_values; item->name; ++item) {
> @@ -400,6 +405,9 @@ static int sony_acpi_add(struct acpi_dev
>  	return 0;
>  
>  outproc:
> +	if (sony_backlight_device)
> +		backlight_device_unregister(sony_backlight_device);
> +
>  	for (item = sony_acpi_values; item->name; ++item)
>  		if (item->proc)
>  			remove_proc_entry(item->name, acpi_device_dir(device));
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
