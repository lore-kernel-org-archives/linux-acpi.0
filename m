From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 12/13] sony_acpi: allow multiple sony_acpi_values for the same .name
Date: Wed, 7 Feb 2007 16:08:44 -0500
Message-ID: <200702071608.44347.lenb@kernel.org>
References: <200702060010.l160AMos003754@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37213 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422752AbXBGVJV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Feb 2007 16:09:21 -0500
In-Reply-To: <200702060010.l160AMos003754@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, malattia@linux.it

NAK,
included in sony-laptop.c series

thanks,
-Len

On Monday 05 February 2007 19:09, akpm@linux-foundation.org wrote:
> From: Mattia Dongili <malattia@linux.it>
> 
> The acpi handles are kept _only_ if both the requested .acpiget and .acpiset
> are available in the DSDT.  Currently only the SCDP/CDPW dualism is known.
> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/sony_acpi.c |   44 +++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
> 
> diff -puN drivers/acpi/sony_acpi.c~sony_acpi-allow-multiple-sony_acpi_values-for-the-same-name drivers/acpi/sony_acpi.c
> --- a/drivers/acpi/sony_acpi.c~sony_acpi-allow-multiple-sony_acpi_values-for-the-same-name
> +++ a/drivers/acpi/sony_acpi.c
> @@ -68,7 +68,7 @@ static struct backlight_properties sony_
>  
>  static struct sony_acpi_value {
>  	char			*name;	 /* name of the entry */
> -	struct proc_dir_entry 	*proc;	 /* /proc entry */
> +	struct proc_dir_entry	*proc;	 /* /proc entry */
>  	char			*acpiget;/* name of the ACPI get function */
>  	char			*acpiset;/* name of the ACPI get function */
>  	int 			min;	 /* minimum allowed value or -1 */
> @@ -78,6 +78,7 @@ static struct sony_acpi_value {
>  	int			debug;	 /* active only in debug mode ? */
>  } sony_acpi_values[] = {
>  	{
> +		/* for backward compatibility only */
>  		.name		= "brightness",
>  		.acpiget	= "GBRT",
>  		.acpiset	= "SBRT",
> @@ -107,6 +108,14 @@ static struct sony_acpi_value {
>  		.debug		= 0,
>  	},
>  	{
> +		.name		= "cdpower",
> +		.acpiget	= "GCDP",
> +		.acpiset	= "CDPW",
> +		.min		= 0,
> +		.max		= 1,
> +		.debug		= 0,
> +	},
> +	{
>  		.name           = "audiopower",
>  		.acpiget        = "GAZP",
>  		.acpiset        = "AZPW",
> @@ -356,27 +365,24 @@ static int sony_acpi_add(struct acpi_dev
>  		if (!debug && item->debug)
>  			continue;
>  
> -		if (item->acpiget &&
> -		    ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle,
> -		    		 item->acpiget, &handle)))
> -			proc_file_mode = S_IRUSR;
> -		else
> -			printk(LOG_PFX "unable to get ACPI handle for %s (get)\n",
> -					item->name);
> -
> -		if (item->acpiset &&
> -		    ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle,
> -		    		 item->acpiset, &handle)))
> -			proc_file_mode |= S_IWUSR;
> -		else
> -			printk(LOG_PFX "unable to get ACPI handle for %s (set)\n",
> -					item->name);
> +		if (item->acpiget) {
> +			if (ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
> +							item->acpiget, &handle)))
> +				continue;
>  
> -		if (proc_file_mode == 0)
> -			continue;
> +			proc_file_mode |= S_IRUSR;
> +		}
> +
> +		if (item->acpiset) {
> +			if (ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
> +							item->acpiset, &handle)))
> +				continue;
> +
> +			proc_file_mode |= S_IWUSR;
> +		}
>  
>  		item->proc = create_proc_entry(item->name, proc_file_mode,
> -					       acpi_device_dir(device));
> +				acpi_device_dir(device));
>  		if (!item->proc) {
>  			printk(LOG_PFX "unable to create proc entry\n");
>  			result = -EIO;
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
