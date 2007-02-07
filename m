From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 08/13] sony_apci: add resume handling
Date: Wed, 7 Feb 2007 16:03:26 -0500
Message-ID: <200702071603.26997.lenb@kernel.org>
References: <200702060010.l160AI2m003742@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34778 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422695AbXBGVEs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Feb 2007 16:04:48 -0500
In-Reply-To: <200702060010.l160AI2m003742@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, stelian@popies.net

NAK
Andrew, please remove this patch from -mm, as it has been included
in the acpi-test tree in a different file, sony-laptop.c

thanks,
-Len

On Monday 05 February 2007 19:09, akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@osdl.org>
> 
> Avoid dimness on resume.
> 
> Cc: Stelian Pop <stelian@popies.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/sony_acpi.c |   49 +++++++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 15 deletions(-)
> 
> diff -puN drivers/acpi/sony_acpi.c~sony_apci-resume drivers/acpi/sony_acpi.c
> --- a/drivers/acpi/sony_acpi.c~sony_apci-resume
> +++ a/drivers/acpi/sony_acpi.c
> @@ -46,19 +46,6 @@ module_param(debug, int, 0);
>  MODULE_PARM_DESC(debug, "set this to 1 (and RTFM) if you want to help "
>  			"the development of this driver");
>  
> -static int sony_acpi_add (struct acpi_device *device);
> -static int sony_acpi_remove (struct acpi_device *device, int type);
> -
> -static struct acpi_driver sony_acpi_driver = {
> -	.name	= ACPI_SNC_DRIVER_NAME,
> -	.class	= ACPI_SNC_CLASS,
> -	.ids	= ACPI_SNC_HID,
> -	.ops	= {
> -			.add	= sony_acpi_add,
> -			.remove	= sony_acpi_remove,
> -		  },
> -};
> -
>  static acpi_handle sony_acpi_handle;
>  static struct proc_dir_entry *sony_acpi_dir;
>  
> @@ -69,6 +56,8 @@ static struct sony_acpi_value {
>  	char			*acpiset;/* name of the ACPI get function */
>  	int 			min;	 /* minimum allowed value or -1 */
>  	int			max;	 /* maximum allowed value or -1 */
> +	int			value;	 /* current setting */
> +	int			valid;	 /* Has ever been set */
>  	int			debug;	 /* active only in debug mode ? */
>  } sony_acpi_values[] = {
>  	{
> @@ -239,10 +228,30 @@ static int sony_acpi_write(struct file *
>  
>  	if (acpi_callsetfunc(sony_acpi_handle, item->acpiset, value, NULL) < 0)
>  		return -EIO;
> -
> +	item->value = value;
> +	item->valid = 1;
>  	return count;
>  }
>  
> +static int sony_acpi_resume(struct acpi_device *device)
> +{
> +	struct sony_acpi_value *item;
> +
> +	for (item = sony_acpi_values; item->name; item++) {
> +		int ret;
> +
> +		if (!item->valid)
> +			continue;
> +		ret = acpi_callsetfunc(sony_acpi_handle, item->acpiset,
> +					item->value, NULL);
> +		if (ret < 0) {
> +			printk("%s: %d\n", __FUNCTION__, ret);
> +			break;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
>  {
>  	printk(LOG_PFX "sony_acpi_notify\n");
> @@ -344,7 +353,6 @@ outwalk:
>  	return result;
>  }
>  
> -
>  static int sony_acpi_remove(struct acpi_device *device, int type)
>  {
>  	acpi_status status;
> @@ -367,6 +375,17 @@ static int sony_acpi_remove(struct acpi_
>  	return 0;
>  }
>  
> +static struct acpi_driver sony_acpi_driver = {
> +	.name	= ACPI_SNC_DRIVER_NAME,
> +	.class	= ACPI_SNC_CLASS,
> +	.ids	= ACPI_SNC_HID,
> +	.ops	= {
> +			.add	= sony_acpi_add,
> +			.remove	= sony_acpi_remove,
> +			.resume = sony_acpi_resume,
> +		  },
> +};
> +
>  static int __init sony_acpi_init(void)
>  {
>  	int result;
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
