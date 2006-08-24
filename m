From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] ACPI: fix potential OOPS in power driver
Date: Thu, 24 Aug 2006 00:20:56 -0400
Message-ID: <200608240020.56742.len.brown@intel.com>
References: <200608232318.06863.dtor@insightbb.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44427 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030247AbWHXETb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Aug 2006 00:19:31 -0400
In-Reply-To: <200608232318.06863.dtor@insightbb.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Wednesday 23 August 2006 23:18, Dmitry Torokhov wrote:

> I am wondering what is the reason to have every local variable
> initialized, whether it is needed or not? Aside of increasing
> code size it also hides errors compiler would warn about otherwise.
>
> The patch below fixes potential OOPS, I have more patches that
> remove unnecessary initializations, checks. Would you be interested
> in these?

Style of the original author I guess.
If you'd like to send a patch to clean it up, I'm happy to accept it -- 
as long as cleanups are not mixed with functionality changes.

> ACPI: fix potential OOPS in power driver

Applied.

thanks,
-Len

> 
>  drivers/acpi/power.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> Index: work/drivers/acpi/power.c
> ===================================================================
> --- work.orig/drivers/acpi/power.c
> +++ work/drivers/acpi/power.c
> @@ -216,10 +216,8 @@ static int acpi_power_off_device(acpi_ha
>  {
>  	int result = 0;
>  	acpi_status status = AE_OK;
> -	struct acpi_device *device = NULL;
>  	struct acpi_power_resource *resource = NULL;
>  
> -
>  	result = acpi_power_get_context(handle, &resource);
>  	if (result)
>  		return result;
> @@ -230,13 +228,13 @@ static int acpi_power_off_device(acpi_ha
>  	if (resource->references) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Resource [%s] is still in use, dereferencing\n",
> -				  device->pnp.bus_id));
> +				  resource->device->pnp.bus_id));
>  		return 0;
>  	}
>  
>  	if (resource->state == ACPI_POWER_RESOURCE_STATE_OFF) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] already off\n",
> -				  device->pnp.bus_id));
> +				  resource->device->pnp.bus_id));
>  		return 0;
>  	}
>  
> @@ -251,8 +249,7 @@ static int acpi_power_off_device(acpi_ha
>  		return -ENOEXEC;
>  
>  	/* Update the power resource's _device_ power state */
> -	device = resource->device;
> -	device->power.state = ACPI_STATE_D3;
> +	resource->device->power.state = ACPI_STATE_D3;
>  
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] turned off\n",
>  			  resource->name));
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
