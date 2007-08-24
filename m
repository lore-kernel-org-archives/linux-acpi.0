From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: EC: revert fix for 8709 bug
Date: Fri, 24 Aug 2007 00:33:17 -0400
Message-ID: <200708240033.17413.lenb@kernel.org>
References: <46CE5A23.3070905@novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49152 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560AbXHXEdV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 00:33:21 -0400
In-Reply-To: <46CE5A23.3070905@novell.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@novell.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Friday 24 August 2007 00:10, Alexey Starikovskiy wrote:
> This fix breaks another ASUS in 8909 and 8919. Revert it for now.

thanks Alexey.
Being -rc3, I agree it is prudent for now to apply this
and go back to the situation we had in 2.6.22
while a fix that doesn't cause other regressions develops.

applied.
-Len

> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> ---
> 
>  drivers/acpi/ec.c |   47 +++++++++++++++++++++++++++++++----------------
>  1 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 56bee9e..43749c8 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -696,14 +696,6 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
>  	return AE_CTRL_TERMINATE;
>  }
>  
> -static void ec_remove_handlers(struct acpi_ec *ec)
> -{
> -	acpi_remove_address_space_handler(ec->handle,
> -					  ACPI_ADR_SPACE_EC,
> -					  &acpi_ec_space_handler);
> -	acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
> -}
> -
>  static int acpi_ec_add(struct acpi_device *device)
>  {
>  	struct acpi_ec *ec = NULL;
> @@ -727,13 +719,16 @@ static int acpi_ec_add(struct acpi_device *device)
>  	/* Check if we found the boot EC */
>  	if (boot_ec) {
>  		if (boot_ec->gpe == ec->gpe) {
> -			ec_remove_handlers(boot_ec);
> -			mutex_destroy(&boot_ec->lock);
> -			kfree(boot_ec);
> -			first_ec = boot_ec = NULL;
> +			/* We might have incorrect info for GL at boot time */
> +			mutex_lock(&boot_ec->lock);
> +			boot_ec->global_lock = ec->global_lock;
> +			/* Copy handlers from new ec into boot ec */
> +			list_splice(&ec->list, &boot_ec->list);
> +			mutex_unlock(&boot_ec->lock);
> +			kfree(ec);
> +			ec = boot_ec;
>  		}
> -	}
> -	if (!first_ec)
> +	} else
>  		first_ec = ec;
>  	ec->handle = device->handle;
>  	acpi_driver_data(device) = ec;
> @@ -762,6 +757,9 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
>  	if (ec == first_ec)
>  		first_ec = NULL;
>  
> +	/* Don't touch boot EC */
> +	if (boot_ec != ec)
> +		kfree(ec);
>  	return 0;
>  }
>  
> @@ -825,7 +823,9 @@ static int acpi_ec_start(struct acpi_device *device)
>  	if (!ec)
>  		return -EINVAL;
>  
> -	ret = ec_install_handlers(ec);
> +	/* Boot EC is already working */
> +	if (ec != boot_ec)
> +		ret = ec_install_handlers(ec);
>  
>  	/* EC is fully operational, allow queries */
>  	atomic_set(&ec->query_pending, 0);
> @@ -835,6 +835,7 @@ static int acpi_ec_start(struct acpi_device *device)
>  
>  static int acpi_ec_stop(struct acpi_device *device, int type)
>  {
> +	acpi_status status;
>  	struct acpi_ec *ec;
>  
>  	if (!device)
> @@ -843,7 +844,21 @@ static int acpi_ec_stop(struct acpi_device *device, int type)
>  	ec = acpi_driver_data(device);
>  	if (!ec)
>  		return -EINVAL;
> -	ec_remove_handlers(ec);
> +
> +	/* Don't touch boot EC */
> +	if (ec == boot_ec)
> +		return 0;
> +
> +	status = acpi_remove_address_space_handler(ec->handle,
> +						   ACPI_ADR_SPACE_EC,
> +						   &acpi_ec_space_handler);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	status = acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
>  	return 0;
>  }
>  
> 
