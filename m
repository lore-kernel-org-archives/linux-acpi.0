From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 12/12] ACPI: Fan: Drop force_power_state acpi_device option
Date: Wed, 24 Oct 2007 23:51:30 +0200
Message-ID: <200710242351.31324.rjw@sisk.pl>
References: <20071022101535.2937.79385.stgit@samsung> <20071022101921.2937.66363.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43702 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684AbXJXV7K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 17:59:10 -0400
In-Reply-To: <20071022101921.2937.66363.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Monday, 22 October 2007 12:19, Alexey Starikovskiy wrote:
> force_power_state was used as a workaround for invalid cached 
> power state of the device. We do not cache power state, so no need for
> workaround.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

>  drivers/acpi/bus.c      |    2 +-
>  drivers/acpi/fan.c      |   40 ----------------------------------------
>  include/acpi/acpi_bus.h |    3 +--
>  3 files changed, 2 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index fdee82d..49d432d 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -201,7 +201,7 @@ int acpi_bus_set_power(acpi_handle handle, int state)
>  	 * Get device's current power state
>  	 */
>  	acpi_bus_get_power(device->handle, &device->power.state);
> -	if ((state == device->power.state) && !device->flags.force_power_state) {
> +	if (state == device->power.state) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
>  				  state));
>  		return 0;
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index a6e149d..a5a5532 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -47,8 +47,6 @@ MODULE_LICENSE("GPL");
>  
>  static int acpi_fan_add(struct acpi_device *device);
>  static int acpi_fan_remove(struct acpi_device *device, int type);
> -static int acpi_fan_suspend(struct acpi_device *device, pm_message_t state);
> -static int acpi_fan_resume(struct acpi_device *device);
>  
>  static const struct acpi_device_id fan_device_ids[] = {
>  	{"PNP0C0B", 0},
> @@ -63,8 +61,6 @@ static struct acpi_driver acpi_fan_driver = {
>  	.ops = {
>  		.add = acpi_fan_add,
>  		.remove = acpi_fan_remove,
> -		.suspend = acpi_fan_suspend,
> -		.resume = acpi_fan_resume,
>  		},
>  };
>  
> @@ -195,10 +191,6 @@ static int acpi_fan_add(struct acpi_device *device)
>  		goto end;
>  	}
>  
> -	device->flags.force_power_state = 1;
> -	acpi_bus_set_power(device->handle, state);
> -	device->flags.force_power_state = 0;
> -
>  	result = acpi_fan_add_fs(device);
>  	if (result)
>  		goto end;
> @@ -224,38 +216,6 @@ static int acpi_fan_remove(struct acpi_device *device, int type)
>  	return 0;
>  }
>  
> -static int acpi_fan_suspend(struct acpi_device *device, pm_message_t state)
> -{
> -	if (!device)
> -		return -EINVAL;
> -
> -	acpi_bus_set_power(device->handle, ACPI_STATE_D0);
> -
> -	return AE_OK;
> -}
> -
> -static int acpi_fan_resume(struct acpi_device *device)
> -{
> -	int result = 0;
> -	int power_state = 0;
> -
> -	if (!device)
> -		return -EINVAL;
> -
> -	result = acpi_bus_get_power(device->handle, &power_state);
> -	if (result) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> -				  "Error reading fan power state\n"));
> -		return result;
> -	}
> -
> -	device->flags.force_power_state = 1;
> -	acpi_bus_set_power(device->handle, power_state);
> -	device->flags.force_power_state = 0;
> -
> -	return result;
> -}
> -
>  static int __init acpi_fan_init(void)
>  {
>  	int result = 0;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 7b74b60..19c3ead 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -168,8 +168,7 @@ struct acpi_device_flags {
>  	u32 power_manageable:1;
>  	u32 performance_manageable:1;
>  	u32 wake_capable:1;	/* Wakeup(_PRW) supported? */
> -	u32 force_power_state:1;
> -	u32 reserved:19;
> +	u32 reserved:20;
>  };
>  
>  /* File System */
> 
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
