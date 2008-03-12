From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: show temperature in millidegree Celsius
Date: Wed, 12 Mar 2008 00:28:50 -0400
Message-ID: <200803120028.50457.lenb@kernel.org>
References: <1204072678.10256.112.camel@acpi-hp-zz.sh.intel.com> <47C537E1.5090103@gmail.com> <1204156290.10256.132.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48940 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbYCLE3k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 00:29:40 -0400
In-Reply-To: <1204156290.10256.132.camel@acpi-hp-zz.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Applied.

thanks,
-Len

On Wednesday 27 February 2008, Zhang, Rui wrote:
> 
> On Wed, 2008-02-27 at 18:13 +0800, Alexey Starikovskiy wrote:
> > Rui,
> > 
> > As I remember, ACPI returns temperature in 10ths of degree. If you are
> > going to report it in 1000ths of degree,
> > there is no reason to round them to degree.
> > 
> 
> Show the temperature in Millidegree Celsius.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/thermal.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/thermal.c
> +++ linux-2.6/drivers/acpi/thermal.c
> @@ -879,6 +879,8 @@ static void acpi_thermal_check(void *dat
>  }
>  
>  /* sys I/F for generic thermal sysfs support */
> +#define KELVIN_TO_MILLICELSIUS(t) (t * 100 - 273200)
> +
>  static int thermal_get_temp(struct thermal_zone_device *thermal, char *buf)
>  {
>  	struct acpi_thermal *tz = thermal->devdata;
> @@ -886,7 +888,7 @@ static int thermal_get_temp(struct therm
>  	if (!tz)
>  		return -EINVAL;
>  
> -	return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(tz->temperature));
> +	return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(tz->temperature));
>  }
>  
>  static const char enabled[] = "kernel";
> @@ -980,21 +982,21 @@ static int thermal_get_trip_temp(struct 
>  
>  	if (tz->trips.critical.flags.valid) {
>  		if (!trip)
> -			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
> +			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
>  				tz->trips.critical.temperature));
>  		trip--;
>  	}
>  
>  	if (tz->trips.hot.flags.valid) {
>  		if (!trip)
> -			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
> +			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
>  					tz->trips.hot.temperature));
>  		trip--;
>  	}
>  
>  	if (tz->trips.passive.flags.valid) {
>  		if (!trip)
> -			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
> +			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
>  					tz->trips.passive.temperature));
>  		trip--;
>  	}
> @@ -1002,7 +1004,7 @@ static int thermal_get_trip_temp(struct 
>  	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
>  		tz->trips.active[i].flags.valid; i++) {
>  		if (!trip)
> -			return sprintf(buf, "%ld\n", KELVIN_TO_CELSIUS(
> +			return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(
>  					tz->trips.active[i].temperature));
>  		trip--;
>  	}
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


