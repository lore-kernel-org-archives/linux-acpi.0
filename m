From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: Adjust Kelvin offset to match local
	implementation
Date: Tue, 03 Mar 2009 16:44:14 +0800
Message-ID: <1236069854.32297.232.camel@rzhang-dt>
References: <20090301140318.5cf56287@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45443 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbZCCInv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Mar 2009 03:43:51 -0500
In-Reply-To: <20090301140318.5cf56287@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Sun, 2009-03-01 at 21:03 +0800, Jean Delvare wrote:
> The exact offset between Kelvin and degree Celsius is 273.15. However
> ACPI handles temperature values with a single decimal place. As a
> consequence, some implementations use an offset of 273.1 and others
> use an offset of 273.2. Try to find out which one is being used, to
> present the most accurate and visually appealing number.
> 
> Tested on a Sony Vaio PGC-GR214EP (which uses 273.1) and a Lenovo
> Thinkpad T60p (which uses 273.2).
Sounds reasonable.

Acked-by: Zhang Rui <rui.zhang@intel.com>

> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Zhang Rui<rui.zhang@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> ---
> Blame the mess on whoever decided that ACPI temperature would be
> expressed in the least adapted unit in the world :(
> 
> Without this patch, I have the following sensors output:
> 
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +44.9 C  (crit = +89.9 C)
> 
> With the patch I instead have:
> 
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +45.0 C  (crit = +90.0 C)
> 
> Which I think is much easier to read.
> 
>  drivers/acpi/thermal.c |   42 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
> 
> --- linux-2.6.29-rc6.orig/drivers/acpi/thermal.c	2009-01-17 09:06:19.000000000 +0100
> +++ linux-2.6.29-rc6/drivers/acpi/thermal.c	2009-03-01 13:51:45.000000000 +0100
> @@ -193,6 +193,7 @@ struct acpi_thermal {
>  	struct timer_list timer;
>  	struct thermal_zone_device *thermal_zone;
>  	int tz_enabled;
> +	int kelvin_offset;
>  	struct mutex lock;
>  };
>  
> @@ -952,7 +953,7 @@ static void acpi_thermal_check(void *dat
>  }
>  
>  /* sys I/F for generic thermal sysfs support */
> -#define KELVIN_TO_MILLICELSIUS(t) (t * 100 - 273200)
> +#define KELVIN_TO_MILLICELSIUS(t, off) (((t) - (off)) * 100)
>  
>  static int thermal_get_temp(struct thermal_zone_device *thermal, char *buf)
>  {
> @@ -966,7 +967,8 @@ static int thermal_get_temp(struct therm
>  	if (result)
>  		return result;
>  
> -	return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(tz->temperature));
> +	return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(tz->temperature,
> +							    tz->kelvin_offset));
>  }
>  
>  static const char enabled[] = "kernel";
> @@ -1061,21 +1063,24 @@ static int thermal_get_trip_temp(struct
>  	if (tz->trips.critical.flags.valid) {
>  		if (!trip)
>  			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
> -				tz->trips.critical.temperature));
> +				tz->trips.critical.temperature,
> +				tz->kelvin_offset));
>  		trip--;
>  	}
>  
>  	if (tz->trips.hot.flags.valid) {
>  		if (!trip)
>  			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
> -					tz->trips.hot.temperature));
> +					tz->trips.hot.temperature,
> +					tz->kelvin_offset));
>  		trip--;
>  	}
>  
>  	if (tz->trips.passive.flags.valid) {
>  		if (!trip)
>  			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
> -					tz->trips.passive.temperature));
> +					tz->trips.passive.temperature,
> +					tz->kelvin_offset));
>  		trip--;
>  	}
>  
> @@ -1083,7 +1088,8 @@ static int thermal_get_trip_temp(struct
>  		tz->trips.active[i].flags.valid; i++) {
>  		if (!trip)
>  			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
> -					tz->trips.active[i].temperature));
> +					tz->trips.active[i].temperature,
> +					tz->kelvin_offset));
>  		trip--;
>  	}
>  
> @@ -1096,7 +1102,8 @@ static int thermal_get_crit_temp(struct
>  
>  	if (tz->trips.critical.flags.valid) {
>  		*temperature = KELVIN_TO_MILLICELSIUS(
> -				tz->trips.critical.temperature);
> +				tz->trips.critical.temperature,
> +				tz->kelvin_offset);
>  		return 0;
>  	} else
>  		return -EINVAL;
> @@ -1649,6 +1656,25 @@ static int acpi_thermal_get_info(struct
>  	return 0;
>  }
>  
> +/*
> + * The exact offset between Kelvin and degree Celsius is 273.15. However ACPI
> + * handles temperature values with a single decimal place. As a consequence,
> + * some implementations use an offset of 273.1 and others use an offset of
> + * 273.2. Try to find out which one is being used, to present the most
> + * accurate and visually appealing number.
> + *
> + * The heuristic below should work for all ACPI thermal zones which have a
> + * critical trip point with a value being a multiple of 0.5 degree Celsius.
> + */
> +static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
> +{
> +	if (tz->trips.critical.flags.valid &&
> +	    (tz->trips.critical.temperature % 5) == 1)
> +		tz->kelvin_offset = 2731;
> +	else
> +		tz->kelvin_offset = 2732;
> +}
> +
>  static int acpi_thermal_add(struct acpi_device *device)
>  {
>  	int result = 0;
> @@ -1675,6 +1701,8 @@ static int acpi_thermal_add(struct acpi_
>  	if (result)
>  		goto free_memory;
>  
> +	acpi_thermal_guess_offset(tz);
> +
>  	result = acpi_thermal_register_thermal_zone(tz);
>  	if (result)
>  		goto free_memory;
> 
> 

