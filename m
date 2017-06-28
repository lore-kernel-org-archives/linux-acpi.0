From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: thermal: honor "mode" sysfs file setting
Date: Thu, 29 Jun 2017 00:14:35 +0200
Message-ID: <3358778.pxacZRAVRa@aspire.rjw.lan>
References: <20170622124542.12063-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53060 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751888AbdF1WWC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Jun 2017 18:22:02 -0400
In-Reply-To: <20170622124542.12063-1-enric.balletbo@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Sameer Nanda <snanda@chromium.org>

On Thursday, June 22, 2017 02:45:42 PM Enric Balletbo i Serra wrote:
> From: Sameer Nanda <snanda@chromium.org>
> 
> Under each thermal zone there is a file called "mode". Writing enabled
> or disabled to this file allows a given thermal zone to be enabled or
> disabled. Honor writes to this file by enabling or disabling the
> polling timers.
> 
> With this change, in the acpi_thermal_add path, acpi_thermal_get_info
> gets called before acpi_thermal_register_thermal_zone. Since tz_enabled
> was getting set to 1 only in acpi_thermal_register_thermal_zone,
> acpi_thermal_get_info ended up disabling thermal polling so moved the
> setting of tz_enabled to 1 into acpi_thermal_add itself.
> 
> After this patch echoing enabled|disabled to "mode" sysfs will start/stop
> the polling of the temperature.
> 
> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Rui, Srinivas, can you please have a look at this one and let me know what you
think?

> ---
>  drivers/acpi/thermal.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 1d0417b..68ad9fe 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -223,6 +223,17 @@ static int acpi_thermal_get_polling_frequency(struct acpi_thermal *tz)
>  	if (!tz)
>  		return -EINVAL;
>  
> +	if (tz->tz_enabled == THERMAL_DEVICE_DISABLED) {
> +		tz->polling_frequency = 0;
> +		return 0;
> +	}
> +
> +	/* Get default polling frequency [_TZP] (optional) */
> +	if (tzp) {
> +		tz->polling_frequency = tzp;
> +		return 0;
> +	}
> +
>  	status = acpi_evaluate_integer(tz->device->handle, "_TZP", NULL, &tmp);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
> @@ -582,6 +593,14 @@ static int thermal_set_mode(struct thermal_zone_device *thermal,
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  			"%s kernel ACPI thermal control\n",
>  			tz->tz_enabled ? "Enable" : "Disable"));
> +
> +		acpi_thermal_get_polling_frequency(tz);
> +
> +		mutex_lock(&tz->thermal_zone->lock);
> +		tz->thermal_zone->polling_delay = tz->polling_frequency * 100;
> +		tz->thermal_zone->passive_delay = tz->polling_frequency * 100;
> +		mutex_unlock(&tz->thermal_zone->lock);
> +
>  		acpi_thermal_check(tz);
>  	}
>  	return 0;
> @@ -930,8 +949,6 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> -	tz->tz_enabled = 1;
> -
>  	dev_info(&tz->device->dev, "registered as thermal_zone%d\n",
>  		 tz->thermal_zone->id);
>  	return 0;
> @@ -1039,11 +1056,7 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
>  	if (!result)
>  		tz->flags.cooling_mode = 1;
>  
> -	/* Get default polling frequency [_TZP] (optional) */
> -	if (tzp)
> -		tz->polling_frequency = tzp;
> -	else
> -		acpi_thermal_get_polling_frequency(tz);
> +	acpi_thermal_get_polling_frequency(tz);
>  
>  	return 0;
>  }
> @@ -1088,6 +1101,7 @@ static int acpi_thermal_add(struct acpi_device *device)
>  		return -ENOMEM;
>  
>  	tz->device = device;
> +	tz->tz_enabled = 1;
>  	strcpy(tz->name, device->pnp.bus_id);
>  	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
>  	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
> 

